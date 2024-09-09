return {
  {
    dependencies = {
      { "nvim-neotest/nvim-nio" },
      { "MunifTanjim/nui.nvim" },
    },
    dir = "~/projects/oss/clojure-test.nvim",
    config = function()
      local clojure_test = require("clojure-test")
      local api = require("clojure-test.api")

      clojure_test.setup({
        layout = {
          --style = "horizontal-split",
          style = "float",
        },
        hooks = {
          before_run = function()
            require("nmkip.modules.core.auto-save").write_all_buffers()
            local eval = require("nmkip.lang.clojure.eval").eval
            eval("user", "(reload-namespaces)")
          end,
        },
      })

      vim.keymap.set("n", "<localleader>tl", api.load_tests, { desc = "Find and load test namespaces in classpath" })

      vim.keymap.set("n", "<localleader>ta", api.run_all_tests, { desc = "Run all tests" })
      vim.keymap.set("n", "<localleader>tr", api.run_tests, { desc = "Run tests" })
      vim.keymap.set("n", "<localleader>tn", api.run_tests_in_ns, { desc = "Run tests in a namespace" })
      vim.keymap.set("n", "<localleader>tp", api.rerun_previous, { desc = "Rerun the most recently run tests" })

      vim.keymap.set("n", "<localleader>*", function()
        api.analyze_exception("*e")
      end, { desc = "Inspect the most recent exception" })
    end,
  },
}
