local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      path,
    })
  end
end

function lazy.setup(plugins)
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require 'lazy'.setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  {
    -- LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      {'folke/neodev.nvim', opts = {} },
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snipet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim', opts = {} },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'lualine'.setup {
        options = {
          icons_enabled = false,
          theme = 'ayu',
          component_separators = '|',
          section_separators = '',
        }
      }
    end
  },
  {
    'Shatur/neovim-ayu',
    priority = 1000,
    lazy = false,
    config = function()
      require 'ayu'.setup({
        mirage = false,
        override = {},
      })
    end,
    init = function()
      require 'ayu'.colorscheme()
    end
  },

  {
    'nvim-tree/nvim-web-devicons',
    priority = 1000,
    lazy = false,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "cpp", "lua", "vim", "vimdoc", "query", 'bibtex',
          'latex', 'fish', 'bash', 'gitcommit', 'gitignore',
          'json', 'yaml', 'ledger', 'make', 'cmake', 'python',
          'rust', 'toml', 'markdown', 'markdown_inline', 'regex'
        },
        sync_install = true,
        auto_install = false,

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = '<C-s>',
            node_decremental = '<C-backspace>',
          },
        },
      }
    end
  },


  {
    'nvim-neo-tree/neo-tree.nvim',
    priority = 1,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      'Shatur/neovim-ayu',
    },
    init = function()
      vim.keymap.set('n', '<leader>e', '<cmd>Neotree source=filesystem position=float reveal=true toggle<cr>')
      vim.keymap.set('n', '<leader>r', '<cmd>Neotree source=filesystem position=left reveal=true toggle<cr>')
      vim.keymap.set('n', '<leader>b', '<cmd>Neotree source=buffers position=float toggle<cr>')
    end,
    config = function()
      require 'neo-tree'.setup({
        filesystem = {
          hijack_netrw_behavior = 'open_default',
        }
      })
    end,
  },

  {
    'chentoast/marks.nvim',
    init = function()
      require 'marks'.setup {
        default_appings = true,
        --        builtin_marks = { '.', '<', '>', '^' }
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'sharkdp/fd',
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'telescope'.setup({
        pickers = {
          fd = { theme = 'dropdown' },
          treesitter = { theme = 'dropdown' },
        },
      })
    end,
    init = function()
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.fd, {})
      vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {})
    end,
  },

  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require 'telescope'.load_extension 'zoxide'
    end,
    init = function()
      vim.keymap.set('n', '<leader>cd', require 'telescope'.extensions.zoxide.list)
    end
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim'
    },
    config = function()
      require 'noice'.setup {
        popupmenu = {
          enable = true,
          backend = 'nui'
        },
      }
    end
  },
})

