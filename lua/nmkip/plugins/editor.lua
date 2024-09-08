return {
  {
    "folke/which-key.nvim",
    tag = "v2.1.0",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>r"] = { name = "+find and replace" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+toggles" },
        ["<leader>tc"] = { "<cmd>TSContextToggle<cr>", "Treesitter Context" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+window" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>L"] = { name = "+lazy" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  { "echasnovski/mini.bufremove", event = "BufReadPost" },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<localleader>D", "<cmd>Trouble<cr>", desc = "Open Trouble Diagnostics" },
    },
    opts = {
      use_diagnostic_signs = true,
      mode = "document_diagnostics",
    },
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    opts = {
      keymaps = {
        visual = "gS",
        visual_line = "gS",
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      {
        "<leader>u",
        function()
          vim.cmd.UndotreeToggle()
        end,
        desc = "Toggle UndoTree",
      },
      {
        "<leader>tu",
        function()
          vim.cmd.UndotreeToggle()
        end,
        desc = "UndoTree",
      },
    },
    init = function()
      vim.g["undotree_WindowLayout"] = 3
      vim.g["undotree_SplitWidth"] = 60
      vim.g["undotree_SetFocusWhenToggle"] = 1
    end,
  },
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>rr", '<cmd>lua require("spectre").toggle()<CR>', desc = "Find and replace" },
      { "<leader>rR", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Find and replace (select word)" },
      { "<leader>rf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Find and replace in file (select word)"},
      { "<leader>rF", '<cmd>lua require("spectre").open_file_search()<CR>', desc = "Find and replace in file" },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup({})
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {

      config_internal_pairs = {
        { "'", "'", suround = true, alpha = true, nft = { "tex", "clojure" }, multiline = false },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>/", "<cmd>FzfLua grep<cr><cr>", desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><leader>", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      -- files
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Open Recent" },
      -- search
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
      { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>FzfLua manpages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
      { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Goto Symbol (Workspace)" },
    },
    config = function()
      -- calling `setup` is optional for customization
      require("nmkip.config.fzf-lua")
    end,
  },
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("nmkip.config.window-picker")
    end,
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "folke/trouble.nvim" },
    config = function()
      local todo = require("todo-comments")

      todo.setup({
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
      })
    end,
    keys = {
      { "<leader>st", "<cmd>TodoTrouble<cr>", desc = "Open TodoTrouble" }
    },
  },
}
