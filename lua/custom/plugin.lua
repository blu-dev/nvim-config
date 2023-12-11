local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "wgsl"
      }
    }
  },
  {
    "hrsh7th/nvim-cmp",
    opts = 
      { 
        enabled = function()
          local context = require("cmp.config.context")
          local disabled = false
          disabled = disabled or (vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt')
          disabled = disabled or (vim.fn.reg_recording() ~= '')
          disabled = disabled or (vim.fn.reg_executing() ~= '')
          disabled = disabled or context.in_treesitter_capture("comment")
          disabled = disabled or context.in_syntax_group("Comment")
          return not disabled
        end
      }
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        custom = { ".*.DS_Store" }
      }
    }
  }
}
return plugins
