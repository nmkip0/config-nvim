return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  ---@type snacks.Config
  opts = {
    scratch = {
      -- your scratch configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}
