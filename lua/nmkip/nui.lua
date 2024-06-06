local NuiLayout = require("nui.layout")
local NuiSplit = require("nui.split")
local NuiPopup = require("nui.popup")

local win_options = {
  size = "25%",
  buf_options = {
    buftype = "nofile",
    modifiable = false,
    swapfile = false,
    filetype = "clojure-test",
    undolevels = -1,
  },
  win_options = {
    number = false,
    relativenumber = false,
    colorcolumn = "",
    signcolumn = "no",
  },
}

-- We can change the filetype depending on the result.
local clj_win_options = vim.tbl_deep_extend("force", win_options, { buf_options = { filetype = "clojure" } })

local report_tree = NuiSplit(win_options)
local left_panel = NuiSplit(clj_win_options)
local right_panel = NuiSplit(clj_win_options)

local layout = NuiLayout(
  win_options,
  NuiLayout.Box({
    NuiLayout.Box(report_tree, { grow = 1 }),
    NuiLayout.Box(left_panel, { grow = 1 }),
    NuiLayout.Box(right_panel, { grow = 1 }),
  }, { dir = "row" })
)

layout:mount()
