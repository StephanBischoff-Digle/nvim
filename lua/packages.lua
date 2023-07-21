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
    priority = 100,
    lazy = false,
    config = function()
      require'ayu'.setup({
        mirage = false,
        override = {},
      })
    end,
    init = function()
      require'ayu'.colorscheme()
    end
  },

  {
    'nvim-tree/nvim-web-devicons',
    priority = 100,
    lazy = false,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
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
      require'neo-tree'.setup({
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
    config = function() 
      require'barbar'.setup {
        animation = false,
        auto_hide = true,
        tabpages = true
      }
    end,
    init = function() 
      vim.keymap.set('n', '<A-h>', '<cmd>BufferPrevious<cr>')
      vim.keymap.set('n', '<A-l>', '<cmd>BufferNext<cr>')
    end,
  },

  {
    'chentoast/marks.nvim',
    init = function()
      require'marks'.setup {
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
      require'telescope'.setup({
        pickers = {
          fd = {theme = 'dropdown'},
          treesitter = {theme = 'dropdown'},
        },
      })
    end,
    init = function()
      local builtin = require'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.fd, {})
      vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
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
      require'telescope'.load_extension'zoxide'
    end,
    init = function()
      vim.keymap.set('n', '<leader>cd', require'telescope'.extensions.zoxide.list)
    end
  }
})

