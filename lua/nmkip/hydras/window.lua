return {
  create = function()
    local Hydra = require("hydra")
    Hydra({
      name = "Resize",
      mode = "n",
      config = {
        invoke_on_body = true,
        hint = {
          type = "window",
          border = "double",
        },
      },
      body = "<leader>w.",
      heads = {
        { "=", "<C-W>=", { desc = "Equalize windows" } },

        { "h", "5<C-w><", { desc = "resize ←" } },
        { "l", "5<C-w>>", { desc = "resize →" } },
        { "k", "5<C-W>+", { desc = "resize ↑" } },
        { "j", "5<C-W>-", { desc = "resize ↓" } },

        { "<Esc>", nil, { desc = "Exit", exit = true } },
        { "q", nil, { desc = "Exit", exit = true } },
      },
    })
  end,
}
