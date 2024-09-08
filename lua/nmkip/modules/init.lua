local function mod(name)
  return require("nmkip.modules." .. name)
end

local modules = {
  mod("core.highlights"),
  mod("core.auto-commands"),
  mod("core.keymaps"),
  mod("core.term-title"),

  mod("core.yank-to-clipboard"),

  mod("core.auto-save"),

  mod("lang.authzed"),
  mod("lang.babashka"),

  mod("clojure.format"),
}

local M = {}

function M.setup()
  for _, module in pairs(modules) do
    module.setup()
  end
end

return M
