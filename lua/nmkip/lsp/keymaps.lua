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
set("n", "<leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

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
