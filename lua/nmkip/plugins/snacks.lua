local smart_picker = function()
  local opts = {
    filter = { cwd = true }
  }
  Snacks.picker.smart(opts)
end

local buffer_picker = function()
  local opts = {
    finder = "buffers",
    format = "buffer",
    hidden = false,
    unloaded = true,
    current = false,
    sort_lastused = true,
    on_show = function() vim.cmd.stopinsert() end,
    win = {
      input = {
        keys = {
          ["<TAB>"] = "list_down",
          ["<S-TAB>"] = "list_up",

          ["<space>"] = "select_and_next",
          ["<S-space>"] = "select_and_next",

          ["dd"] = "bufdelete",
          ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
        },
      },
      list = { keys = { ["dd"] = "bufdelete" } },
    },
  }
  Snacks.picker.buffers(opts)
end

local workspace_symbol_picker = function()
  ---@class snacks.picker.lsp.symbols.Config: snacks.picker.Config
  ---@field tree? boolean show symbol tree
  ---@field filter table<string, string[]|boolean>? symbol kind filter
  ---@field workspace? boolean show workspace symbols
  local opts = {
    finder = "lsp_symbols",
    format = "lsp_symbol",
    tree = true,
    workspace = true,
    supports_live = true,
    live = true,
    filter = {
      default = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
      },
      clojure = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
--        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
      },
      -- set to `true` to include all symbols
      markdown = true,
      help = true,
      -- you can specify a different filter for each filetype
      lua = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        -- "Package", -- remove package since luals uses it for control flow structures
        "Property",
        "Struct",
        "Trait",
      },
    },
  }
  Snacks.picker.lsp_symbols(opts)
end

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    -- Pickers
    { "<leader><leader>", smart_picker, desc = "Smart" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<TAB>", buffer_picker, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    -- find
    { "<leader>fb", buffer_picker, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", workspace_symbol_picker, desc = "LSP Workspace Symbols" },
  },
  ---@type snacks.Config
  opts = {
    scratch = {
      -- your scratch configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
       -- matcher = {
       --   fuzzy = true, -- use fuzzy matching
       --   smartcase = true, -- use smartcase
       --   ignorecase = true, -- use ignorecase
       --   sort_empty = false, -- sort results when the search string is empty
       --   filename_bonus = true, -- give bonus for matching file names (last part of the path)
       --   file_pos = true, -- support patterns like `file:line:col` and `file:line`
       --   -- the bonusses below, possibly require string concatenation and path normalization,
       --   -- so this can have a performance impact for large lists and increase memory usage
       --   cwd_bonus = false, -- give bonus for matching files in the cwd
       --   frecency = true, -- frecency bonus
       -- },
    },
    input = {}
  },
}
