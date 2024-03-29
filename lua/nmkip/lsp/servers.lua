local utils = require("nmkip.lsp.utils")

return {
  clojure_lsp = {
    commands = {
      OrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "clean-ns",
            arguments = { "file://" .. vim.api.nvim_buf_get_name(0), 0, 0 },
            title = "",
          })
        end,
        description = "Clean Namespace",
      },
    },
    root_dir = utils.find_furthest_root({ "deps.edn", "bb.edn", "project.clj", "shadow-cljs.edn" }),
    single_file_support = true,
    init_options = {
      codeLens = true,
    },

    before_init = function(params)
      params.workDoneToken = "enable-progress"
    end,
  },
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          "https://json.schemastore.org/github-workflow.json",
          ".github/workflows/*",
        },
      },
    },
  },
  tsserver = {},
  jdtls = {
    single_file_support = true,
    settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
      },
    },
  },
  jsonls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        files = {
          excludeDirs = { ".embuild", "target", ".git" },
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        format = {
          enable = false,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
}
