return {
  {
    dependencies = {
      { "nvim-neotest/nvim-nio" },
      { "MunifTanjim/nui.nvim" },
    },
    dir = "~/projects/oss/clojure-test.nvim",
    config = function()
      require("clojure-test").setup({
        -- layout = {
        --   --style = "horizontal-split",
        --   style = "float"
        -- },
        hooks = {
          before_run = function(tests)
            require("nmkip.modules.core.auto-save").write_all_buffers()
            local eval = require("nmkip.lang.clojure.eval").eval
            eval("user", "(reload-namespaces)")
          end,
        },
      })
    end,
  },
}
