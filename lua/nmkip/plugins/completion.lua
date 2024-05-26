return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.0.*",
    event = "BufReadPost",
    config = function()
      local luasnip = require("luasnip")

      luasnip.setup()
      luasnip.filetype_extend("typescript", { "javascript" })

      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "petertriho/cmp-git",
    },
    config = function()
      require("nmkip.config.completion")
    end,
  },
}
