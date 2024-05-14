require'window-picker'.setup({
  autoselect_one = true,
  highlights = {
    statusline = {
      focused = {
        fg = '#ededed',
        bg = '#e35e4f',
        bold = true,
      },
      unfocused = {
        bg = "#000000",
        fg = "#FFE209",
        bold = true,
      },
    },
    winbar = {
      focused = {
        fg = '#ededed',
        bg = '#e35e4f',
        bold = true,
      },
      unfocused = {
        fg = '#ededed',
        bg = '#44cc41',
        bold = true,
      },
    },
  },
  filter_rules = {
    bo = {
      filetype = { "neo-tree", "neo-tree-popup", "notify" },
      buftype = { "terminal", "quickfix" },
    },
    file_name_contains = { "conjure-log-*" },
  },
  include_current = false,
})
