return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          enable = false,
          patterns = {
            clojure = {
              "list_lit",
              "vec_lit",
              "map_lit",
              "set_lit",
            },
          },
          max_lines = 2,
          separator = "_",
        },
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        ensure_installed = {
          "authzed",
          "bash",
          "html",
          "javascript",
          "http",
          "hurl",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "mermaid",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "graphql",
          "fennel",
          "clojure",
          "commonlisp",
          "rust",
          "go",
        },
        autotag = {
          enable = true,
          filetypes = { "html", "xml", "typescriptreact" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  {
    "https://github.com/windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
}
