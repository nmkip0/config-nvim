local clojure = require("nmkip.lang.clojure.eval")

local function eval(code, opts)
  clojure.eval(
    "user",
    code,
    vim.tbl_extend("force", {
      ["passive?"] = true,
      ["on-result"] = function() end,
    }, opts or {})
  )
end

local function pcmd(command)
  return function()
    return eval('(portal.api/eval-str "' .. command .. '")')
  end
end

local function open_portal()
  eval([[
    (do (ns user)
        ((requiring-resolve 'portal.api/close))
        (def *portal* ((requiring-resolve 'portal.api/open)
                       {:theme :portal.colors/gruvbox}))
        (add-tap (requiring-resolve 'portal.api/submit))
        nil)
  ]])
end

local function clear_portal()
  eval("(portal.api/clear)")
end

local stdout_to_clipboard = function(_, data)
  local result = ""
  for _, value in ipairs(data) do
    result = result .. value .. "\n"
  end
  vim.fn.setreg('"', result)
  vim.fn.setreg("0", result)
  vim.fn.setreg("+", result)
end

local portal_copy = function(parse_cmd)
  eval("@user/*portal*", {
    ["on-result"] = function(r)
      vim.fn.jobstart(parse_cmd(r), {
        stdout_buffered = true,
        on_stdout = stdout_to_clipboard,
      })
    end,
  })
end

local portal_copy_edn = function()
  portal_copy(function(result)
    return "echo '" .. result .. "' | jet  --edn-reader-opts '{:default tagged-literal}'"
  end)
end

local portal_copy_json = function()
  portal_copy(function(result)
    return "echo '" .. result .. "' | jet --to json --pretty --edn-reader-opts '{:default tagged-literal}'"
  end)
end

return {
  create = function()
    local Hydra = require("hydra")

    local portal_cmds = {
      open = open_portal,
      clear = clear_portal,

      next_viewer = pcmd("(portal.ui.commands/select-next-viewer portal.ui.state/state)"),
      prev_viewer = pcmd("(portal.ui.commands/select-prev-viewer portal.ui.state/state)"),

      select_root = pcmd("(portal.ui.commands/select-root portal.ui.state/state)"),

      select_next = pcmd("(portal.ui.commands/select-next portal.ui.state/state)"),
      select_prev = pcmd("(portal.ui.commands/select-prev portal.ui.state/state)"),
      select_parent = pcmd("(portal.ui.commands/select-parent portal.ui.state/state)"),
      select_child = pcmd("(portal.ui.commands/select-child portal.ui.state/state)"),

      history_back = pcmd("(portal.ui.commands/history-back portal.ui.state/state)"),
      history_forward = pcmd("(portal.ui.commands/history-forward portal.ui.state/state)"),

      focus_selected = pcmd("(portal.ui.commands/focus-selected portal.ui.state/state)"),
      toggle_expand = pcmd("(portal.ui.commands/toggle-expand portal.ui.state/state)"),

      copy_json = portal_copy_json,
      copy_edn = portal_copy_edn,
    }

    local hint = [[                                      Portal Manager

   _o_: Open   _c_: Clear                                  _y_: Copy EDN   _<C-y>_: Copy JSON

   _h_: Select Parent   _l_: Select Child   _r_: Select Root   _e_: Expand
   _k_: Select Prev     _j_: Select Next    _<CR>_: Focus      _<Backspace>_: Back

   _<C-k>_: Prev viewer     _<C-j>_: Next viewer
   _<C-h>_: Back            _<C-l>_: Forward

                                  _q_: Quit   _<Esc>_: Exit
]]

    Hydra({
      name = "Portal Manager",
      mode = "n",
      hint = hint,
      config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
          type = "window",
          border = "double",
        },
      },
      body = "<leader>p",
      heads = {
        { "o", portal_cmds.open, { desc = "Clear" } },
        { "c", portal_cmds.clear, { desc = "Clear" } },

        { "e", portal_cmds.toggle_expand, { desc = "Toggle expand" } },

        { "y", portal_cmds.copy_edn, { desc = "Copy EDN", exit = true } },
        { "<C-y>", portal_cmds.copy_json, { desc = "Copy JSON", exit = true } },

        { "h", portal_cmds.select_parent, { desc = "Select parent" } },
        { "j", portal_cmds.select_next, { desc = "Select next" } },
        { "k", portal_cmds.select_prev, { desc = "Select next" } },
        { "l", portal_cmds.select_child, { desc = "Select child" } },

        { "r", portal_cmds.select_root, { desc = "Select root" } },

        { "<C-j>", portal_cmds.next_viewer, { desc = "Next viewer" } },
        { "<C-k>", portal_cmds.prev_viewer, { desc = "Previous viewer" } },
        { "<C-h>", portal_cmds.history_back, { desc = "History back" } },
        { "<C-l>", portal_cmds.history_forward, { desc = "History forward" } },

        { "<Backspace>", portal_cmds.history_back, { desc = "History back" } },

        { "<CR>", portal_cmds.focus_selected, { desc = "Focus selected" } },

        { "<Esc>", nil, { desc = "Exit", exit = true } },
        { "q", nil, { desc = "Exit", exit = true } },
      },
    })

    require("which-key").register({
      p = {
        name = "Portal",
      },
    }, { prefix = "<localleader>" })
  end,
}
