local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

capabilities.textDocument.rangeFormatting = { dynamicRegistration = true }

for k, v in pairs(capabilities.textDocument) do
  nvimide.log(tostring(k) .. ":" .. tostring(v))
end

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          autoReload = true,
          features = "all",
          extraEnv = {
            LUADOC_SKIP = "1"
          }
        },
        check = {
          extraEnv = {
            LUADOC_SKIP = "1"
          }
        },
        server = {
          extraEnv = {
            LUADOC_SKIP = "1"
          }
        },
        rustfmt = {
          rangeFormatting = {
            enable = true
          }
        }
      }
    }
  }
}

return options
