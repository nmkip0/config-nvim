local lualine = require("lualine")

local function get_lsp_client_status()
  for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if client.initialized then
      return ""
    else
      return ""
    end
  end
end

local function get_nrepl_status()
  if vim.bo.filetype == "clojure" then
    local nrepl = require("nmkip.lang.clojure.nrepl")
    return nrepl.get_repl_status("Not Connected")
  end
  return ""
end

local function show_recording()
  local reg = vim.fn.reg_recording()

  if reg == "" then
    return ""
  end

  return "RECORDING @" .. reg
end

local setup = {
  options = {
    icons_enabled = true,
    globalstatus = true,
    theme = "auto",
  },
  sections = {
    lualine_a = {
      "mode",
      { show_recording, color = { bg = "#d79921" } },
    },
    lualine_b = {
      "branch",
      "diff",
      "diagnostics",
    },
    lualine_c = {
      {
        path = 1,
        "filename",

        -- Small attempt to workaround https://github.com/nvim-lualine/lualine.nvim/issues/872
        -- Upstream issue: https://github.com/neovim/neovim/issues/19464
        fmt = function(filename)
          if #filename > 80 then
            filename = vim.fs.basename(filename)
          end
          return filename
        end,
      },
    },

    lualine_x = {
      {
        "lsp_client_status",
        fmt = get_lsp_client_status,
        color = {
          fg = "#b0b846",
        },
      },
    },
    lualine_y = {
      {
        fmt = get_nrepl_status,
        "repl_status",
      },
    },
    lualine_z = {
      "filetype",
    },
  },
}

lualine.setup(setup)
