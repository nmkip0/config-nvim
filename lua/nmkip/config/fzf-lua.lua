local setup = {
  winopts = {
    preview = {
      layout = "vertical",
      vertical = "up",
    },
  },
  fzf_opts = {
    ["--layout"] = "reverse-list",
    ["--cycle"] = true
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
