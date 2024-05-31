local setup = {
  winopts = {
    preview = {
      layout = "vertical",
      vertical = "up",
    },
  },
  keymap = {
    fzf = {
      ["tab"] = "down",
      ["btab"] = "up",
      ["ctrl-space"] = "toggle",
      -- ["ctrl-m"] = "toggle",
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
    },
  },
  fzf_opts = {
    ["--layout"] = "reverse-list",
    ["--cycle"] = true,
  },
}

-- https://vi.stackexchange.com/questions/37287/in-nvim-can-i-map-tab-without-removing-c-i-as-jump-forward
vim.keymap.set("n", "<C-I>", "<C-I>")
vim.keymap.set("n", "<Tab>", "<cmd>FzfLua buffers<cr>", {
  noremap = true,
  silent = true,
  desc = "Buffer quick-switch",
})

require("fzf-lua").setup(setup)
