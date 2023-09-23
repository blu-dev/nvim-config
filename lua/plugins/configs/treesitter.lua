vim.filetype.add({extension = {wgsl = "wgsl"}})

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_tresitter#foldexpr()"
vim.o.foldlevelstart = 99

local options = {
  ensure_installed = { "lua", "wgsl" },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  }
}

return options
