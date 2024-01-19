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
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^3",
  --   ft = { "rust" },
  --   opts = {
  --     server = {
  --       on_attach = function(client, bufnr)
  --         client.server_capabilities.documentFormattingProvider = false
  --         client.server_capabilities.documentRangeFormattingProvider = false
  --
  --         if client.server_capabilities.signatureHelpProvider then
  --           require("nvchad.signature").setup(client)
  --         end
  --
  --         vim.g.inlay_hints_visible = true
  --         vim.lsp.inlay_hint.enable(bufnr, true)
  --         -- local wk = require "which-key"
  --         -- wk.register({
  --         --   ["<leader>ca"] = {
  --         --     function()
  --         --       vim.cmd.RustLsp "codeAction"
  --         --     end,
  --         --     "Code Action",
  --         --   }
  --         -- }, { mode = "n", buffer = bufnr })
  --       end
  --     },
  --     settings = {
  --       ["rust-analyzer"] = {
  --         cargo = {
  --           allFeatures = true,
  --           loadOutDirsFromCheck = true,
  --           runBuildScripts = true,
  --         },
  --         checkOnSave = {
  --           allFeatures = true,
  --           command = "clippy",
  --           extraArgs = { "--no-deps" },
  --         },
  --         procMacro = {
  --           enable = true,
  --           ignored = {
  --             ["async-trait"] = { "async_trait" },
  --             ["napi-derive"] = { "napi" },
  --             ["async-recursion"] = { "async_recursion" },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
  --   end,
  -- },
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
  },
  { 'RaafatTurki/hex.nvim' },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp"
    },
    event = "BufEnter",
    config = function()
      require("codeium").setup({})
    end
  },
  -- {
  --   "elentok/format-on-save.nvim",
  --   config = function()
  --     local format_on_save = require("format-on-save")
  --     local formatters = require("format-on-save.formatters")
  --     format_on_save.setup({
  --       formatters_by_ft = {
  --         lua = formatters.lsp
  --       }
  --     })
  --  end
  -- },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
    end
  }
  -- {
  --   "kevinhwang91/promise-async"
  -- },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   config = function()
  --     -- vim.o.foldcolumn = '1' -- '0' is not bad
  --     -- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  --     -- vim.o.foldlevelstart = 99
  --     -- vim.o.foldenable = true
  --     --
  --     -- -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  --     -- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  --     -- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  --     --
  --     -- -- Option 3: treesitter as a main provider instead
  --     -- -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
  --     -- -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
  --     -- require('ufo').setup({
  --     --     provider_selector = function(bufnr, filetype, buftype)
  --     --         return {'treesitter', 'indent'}
  --     --     end
  --     -- })
  --   end
  -- }
}
return plugins
