local M = {}

M.setup = function()
  local map = require("nmkip.helpers.keys").map
  local saving = require("nmkip.modules.core.auto-save")

  map("n", "<leader>qq", function()
    saving.write_all_buffers()
    vim.api.nvim_command("qa")
  end, "Save and quit")

  map("n", "<leader>fs", "<Cmd>w<Cr>", "Save buffer")
  map("n", "<leader>fS", saving.write_all_buffers, "Save all buffers")

  map("n", "<leader>wd", "<cmd>close<cr>", "Delete window")
  map("n", "<leader>wh", "<C-w>h", "Window left")
  map("n", "<leader>wj", "<C-w>j", "Window down")
  map("n", "<leader>wk", "<C-w>k", "Window up")
  map("n", "<leader>wl", "<C-w>l", "Window right")
  map("n", "<leader>ws", "<cmd>split<cr>", "Split horizontal")
  map("n", "<leader>wv", "<cmd>vsplit<cr>", "Split vertical")

  map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")

  map("n", "<leader>`", "<C-^>", "Toggle previous buffer")

  -- tabs
  map("n", "<leader><tab>l", "<cmd>tabnext<cr>", "Next Tab")
  map("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
  map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", "Previous Tab")
  map("n", "<leader><tab>n", "<cmd>tabnew<cr>", "New Tab")

  vim.api.nvim_set_keymap("n", "<S-Down>", "<Nop>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<S-Up>", "<Nop>", { noremap = true, silent = true })
end

return M
