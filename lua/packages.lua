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
  require'lazy'.setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  {
    'Shatur/neovim-ayu',
    init = function()
      local ayu = require'ayu'
      ayu.setup({
        mirage = false,
        override = {},
      })
      ayu.colorscheme()
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { 
          "cpp", "lua", "vim", "vimdoc", "query", 'bibtex',
          'latex', 'fish', 'bash', 'gitcommit', 'gitignore',
          'json', 'yaml', 'ledger', 'make', 'cmake', 'python',
          'rust', 'toml'
        },
        sync_install = true,
        auto_install = false,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim'
    },
    init = function()
      vim.keymap.set('n', '<leader>e', '<cmd>Neotree source=filesystem position=left reveal=true toggle<cr>')
      vim.keymap.set('n', '<leader>b', '<cmd>Neotree source=buffers position=float toggle<cr>')

      require'neo-tree'.setup({
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
        },
        filesystem = {
          hijack_netrw_behavior = 'open_default',
        }
      })
    end,
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function() 
      require'barbar'.setup {
        animation = false,
        auto_hide = true,
        tabpages = true
      }

      vim.keymap.set('n', '<A-h>', '<cmd>BufferPrevious<cr>')
      vim.keymap.set('n', '<A-l>', '<cmd>BufferNext<cr>')
    end,
  },

  {
    'chentoast/marks.nvim',
    init = function()
      require'marks'.setup {
        default_appings = true,
        builtin_marks = { '.', '<', '>', '^' }
      }
    end,
  },
})

