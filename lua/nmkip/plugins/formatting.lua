return {
  {
    "stevearc/conform.nvim",
    event = "BufReadPost",
    config = function()
      local conform = require("conform")
      local util = require("conform.util")

      local js_formatter = { "biome", "prettierd", "prettier" }

      conform.setup({
        formatters_by_ft = {
          javascript = js_formatter,
          typescript = js_formatter,
          typescriptreact = js_formatter,

          json = { "prettierd" },
          lua = { "stylua" },
          just = { "just" },
          markdown = function()
            return { "prettier", "injected" }
          end,
          mdx = function()
            return { "prettier", "injected" }
          end,
          hurl = function()
            return { "injected" }
          end,
          http = function()
            return { "injected" }
          end,
        },

        formatters = {
          biome = {
            command = "biome",
            stdin = true,
            args = { "check", "--write", "--unsafe", "--stdin-file-path", "$FILENAME" },
            cwd = util.root_file({
              "biome.json",
              "package.json",
            }),
          },
          just = {
            command = "just",
            args = {
              "--fmt",
              "--unstable",
              "-f",
              "$FILENAME",
            },
            stdin = false,
          },
        },
      })

      conform.formatters.injected = {
        options = {
          ignore_errors = true,
          lang_to_formatters = {
            clojure = { "cljfmt" },
            json = { "prettierd"  },
          },
        },
      }

      local function format()
        conform.format({
          lsp_fallback = true,
        })
      end

      vim.keymap.set("n", "<leader>cf", format, {
        desc = "Format current buffer",
      })

      vim.keymap.set("n", "<localleader>Lf", format, {
        desc = "Format current buffer",
      })
    end,
  },
}
