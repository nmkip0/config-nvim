return {
  {
    "folke/which-key.nvim",
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
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    -- version = false, -- telescope did only one release, so use HEAD for now
    -- keys = {
    --   {
    --     "<leader>,",
    --     "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
    --     desc = "Switch Buffer",
    --   },
    --   { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
    --   { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --   -- buffers
    --   { "<leader>bb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    --   -- files
    --   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    --   { "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Open Recent" },
    --   -- git
    --   { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
    --   { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
    --   { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    --   -- search
    --   { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    --   { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    --   { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    --   { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --   { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    --   { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    --   { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    --   { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    --   { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    --   { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    --   { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    --   { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    --   { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    --   { "<leader><leader>", "<cmd>Telescope resume<cr>", desc = "Resume" },
    --   {
    --     "<leader>ss",
    --     "<cmd>FzfLua lsp_document_symbols<cr>",
    --     -- function()
    --     --   require("telescope.builtin").lsp_document_symbols()
    --     -- end,
    --     desc = "Goto Symbol",
    --   },
    --   {
    --     "<leader>sS",
    --     "<cmd>FzfLua lsp_workspace_symbols<cr>",
    --     -- function()
    --     --   require("telescope.builtin").lsp_dynamic_workspace_symbols()
    --     -- end,
    --     desc = "Goto Symbol (Workspace)",
    --   },
    -- },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end

      vim.api.nvim_create_autocmd("WinLeave", {
        callback = function()
          if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
          end
        end,
      })

      return {
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--ignore",
              "-u",
              "--trim",
              "--smart-case",
              "--max-columns=150",

              "--glob=!**/.git/*",
              "--glob=!**/node_modules/*",
              "--glob=!**/.next/*",
              "--glob=!**/target/*",
              "--glob=!**/.shadow-cljs/*",
              "--glob=!**/.cpcache/*",
              "--glob=!**/.cache/*",
              "--glob=!*-lock.*",
              "--glob=!*.log",
            },
          },
        },
        defaults = {
          dynamic_preview_title = true,
          layout_config = {
            vertical = { width = 0.9 },
          },
          layout_strategy = "vertical",
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,

              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },
            n = {
              ["q"] = actions.close,
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,

              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,

              ["?"] = actions.which_key,
            },
          },
        },
      }
    end,
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
  -- A telescope.nvim extension designed to provide the best possible suggestions for quickly opening files in Neovim.
  -- smart-open will improve its suggestions over time, adapting to your usage.
  {
    "danielfalk/smart-open.nvim",
    -- branch = "0.2.x",
    branch = "main",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope").extensions.smart_open.smart_open({
            cwd_only = true,
            match_algorithm = "fzy",
            filename_first = false,
          })
        end,
        desc = "Find files",
      },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
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
      { "<leader>st", "<cmd>TodoTrouble<cr>", desc = "Open TodoTrouble" },
      { "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Open TodoTelescope" },
    },
  },
}
