local win_opts = { float_opts = { border = "rounded" } }

local function diag_next()
  vim.diagnostic.goto_next(win_opts)
end

local function diag_prev()
  vim.diagnostic.goto_prev(win_opts)
end

local function diag_float()
  vim.diagnostic.open_float(win_opts.float_opts)
end

local set = vim.keymap.set

local is_rtp_added = false  -- Flag to track if cwd has been added

local function clear_module_cache_for_cwd()
 local cwd_tail = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
 local project_prefix = cwd_tail:gsub("%.nvim$", "")

 for module_name, _ in pairs(package.loaded) do
   if module_name:find("^" .. project_prefix .. "%.") then
     print("Clearing module:", module_name)
     package.loaded[module_name] = nil
   end
 end
end

---@diagnostic disable-next-line: unused-function
local function add_cwd_to_rtp()
  if is_rtp_added then
    return
  end

  local cwd = vim.fn.getcwd()

  -- Check if the cwd is already in the runtimepath
  local rtp = vim.opt.rtp:get()
  local already_in_rtp = false

  for _, path in ipairs(rtp) do
    if path == cwd then
      already_in_rtp = true
      break  -- Exit loop if cwd is already in the runtimepath
    end
  end

  -- Add cwd to runtimepath if not already present
  if not already_in_rtp then
    vim.opt.rtp:prepend(cwd)
    is_rtp_added = true  -- Mark as added
    print("Added to RTP:", cwd)
  else
    print("CWD already in RTP:", cwd)
  end
end

local function prepare_source()
  clear_module_cache_for_cwd()
  add_cwd_to_rtp()
end

vim.g.prepare_source = prepare_source

-- Lua keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    set("n", "<leader><leader>x", ":lua vim.g.prepare_source()<CR><cmd>source %<CR>", { buffer = true, noremap = true, silent = true, desc = "Execute the current file" })
    set("n", "<leader>x", ":lua vim.g.prepare_source()<CR>:.lua<CR>", { buffer = true, noremap = true, silent = true, desc = "Execute the current line" })
    set("v", "<leader>x", ":lua vim.g.prepare_source()<CR>:lua<CR>", { buffer = true, noremap = true, silent = true, desc = "Execute the selected lines" })
  end,
})

return {
  g = {
    d = {
      function()
        require("fzf-lua").lsp_definitions({
          jump_to_single_result = true,
        })
      end,
      "Go to Definition",
    },
    i = { ":FzfLua lsp_implementations<cr>", "Go to Impementations" },
    r = {
      function()
        require("fzf-lua").lsp_references({
          ignore_current_line = true,
          includeDeclaration = true,
        })
      end,
      "Symbol References",
    },
    t = { ":FzfLua lsp_type_defs<cr>", "Type Definitions" },
  },
  ["<leader>"] = {
    c = {
      name = "+code",
      a = { vim.lsp.buf.code_action, "Code actions" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
      D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
      j = { diag_next, "Next Diagnostic" },
      k = { diag_prev, "Prev Diagnostic" },
      l = { diag_float, "Line diagnostic" },
      o = { "<cmd>OrganizeImports<cr>", "Organize Imports" },
      r = { vim.lsp.buf.rename, "Rename" },
      s = { "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols" },
      I = { ":LspInfo<cr>", "Lsp Info" },
      R = { ":LspRestart<cr>", "Lsp Restart" },
      S = { "<cmd>FzfLua lsp_workspace_symbols<cr>", "Workspace symbols" },
    },
  },
  K = { vim.lsp.buf.hover, "Hover doc" },
}
