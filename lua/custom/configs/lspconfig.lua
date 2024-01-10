local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"c", "h", "cpp", "hpp"}
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"lua"}
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

lspconfig.wgsl_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"wgsl"}
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end
})


-- lspconfig.rust_analyzer.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"rust"},
--   root_dir = util.root_pattern("Cargo.toml"),
--   settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         allFeatures = true,
--         extraEnv = {
--           ["LUA_DOCGEN_DIR"] = "/Users/blujay/dev/sentinels/lua_docs"
--         }
--       },
--     },
--   },
-- })
