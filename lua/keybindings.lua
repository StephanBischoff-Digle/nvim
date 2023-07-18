vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

vim.keymap.set('n', '<leader>l', '<cmd>lua vim.opt.list = not vim.opt.list:get()<cr>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
