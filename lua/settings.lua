vim.opt.number = true      -- display line numbers in gutter
vim.opt.relativenumber = false
vim.opt.ignorecase = true  -- ignore uppercase when searching
vim.opt.smartcase = true   -- ignore uppercase in search unless uppercase is part of search term
vim.opt.hlsearch = false   -- don't highlight the search
vim.opt.wrap = true        -- wrap long lines
vim.opt.breakindent = true -- preserve indentation of wrapped lines
vim.opt.tabstop = 2        -- tab width
vim.opt.shiftwidth = 2     -- indendt width
vim.opt.expandtab = true   -- transform tab into spaces

vim.opt.termguicolors = true
vim.cmd.colorscheme('default')

vim.opt.cursorline = true

vim.opt.completeopt = 'menuone,noselect'

vim.opt.list = false
vim.opt.listchars = {
  eol = '↵',
  tab = '>-/',
  trail = '_',
  extends = '»',
  precedes = '«'
}

vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

-- User commands

local augroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({ higroup = 'LeapLabelSecondary', timeout = 200 })
  end
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  command = 'lua vim.lsp.buf.format()',
  desc = 'Format on Save',
})

vim.opt.numberwidth = 4
vim.opt.statuscolumn = "%= %{v:virtnum < 1 ? v:lnum : ''}%=%s"
