return {
  {
    "julienvincent/nvim-paredit",
    -- dir = "~/code/nvim-paredit",
    ft = { "clojure" },
    config = function()
      local paredit = require("nvim-paredit")
      local wrap = require("nvim-paredit.api.wrap")
      local ts_forms = require("nvim-paredit.treesitter.forms")
      local ts_context = require("nvim-paredit.treesitter.context")

      local function wrap_nearest_form(prefix, suffix)
        local buf = vim.api.nvim_get_current_buf()
        local context = ts_context.create_context()

        if not context then
          return
        end

        local form = ts_forms.find_nearest_form(context.node, context)

        if not form then
          return
        end

        return wrap.wrap_element(buf, form, prefix, suffix)
      end
      paredit.setup({
        indent = {
          enabled = true,
        },

        keys = {
          [">)"] = false,
          [">("] = false,
          ["<)"] = false,
          ["<("] = false,
          [">e"] = false,
          ["<e"] = false,
          [">f"] = false,
          ["<f"] = false,
          ["<localleader>o"] = false,
          ["<localleader>O"] = false,

          ["<S-L>"] = { paredit.api.slurp_forwards, "Slurp" },
          ["<S-H>"] = { paredit.api.barf_forwards, "Barf" },

          ["<C-H>"] = { paredit.api.slurp_backwards, "Slurp backwards" },
          ["<C-L>"] = { paredit.api.barf_backwards, "Barf backwards" },

          ["<M-h>"] = { paredit.api.drag_element_backwards, "Drag element left" },
          ["<M-l>"] = { paredit.api.drag_element_forwards, "Drag element right" },

          ["<M-S-h>"] = { paredit.api.drag_form_backwards, "Drag form left" },
          ["<M-S-l>"] = { paredit.api.drag_form_forwards, "Drag form right" },

          ["<localleader>r"] = { paredit.api.raise_element, "Raise element" },
          ["<localleader>R"] = { paredit.api.raise_form, "Raise form" },

          ["<localleader>ws"] = {
            function()
              wrap_nearest_form("(sc.api/spy ", ")")
            end,
            "Wrap with sc.api/spy",
          },

          ["<localleader>wt"] = {
            function()
              -- paredit.wrap.wrap_element_under_cursor("(doto ", " tap>)")
              wrap_nearest_form("(doto ", " tap>)")
            end,
            "Wrap with doto tap>",
          },
        },
      })
    end,
  },
  {
    "julienvincent/nvim-paredit-fennel",
    -- dir = "~/code/nvim-paredit-fennel",
    dependencies = { "julienvincent/nvim-paredit" },
    ft = { "fennel" },
    config = function()
      require("nvim-paredit-fennel").setup()
    end,
  },
}
