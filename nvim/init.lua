-- plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'crispybaccoon/aki'

vim.call('plug#end')

-- plugins options
require 'aki'.setup {
  transparent_background = true,
  contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
  override_terminal = true,
  style = {
    search = { reverse = true },
  },
  overrides = { }, -- add custom overrides
}

vim.cmd('colorscheme aki')

-- general preferences
vim.opt.number = true

-- keybindings
vim.keymap.set('n', 'C-J', '<C-W>j')
vim.keymap.set('n', 'C-k', '<C-W>k')
vim.keymap.set('n', 'C-l', '<C-W>l')
vim.keymap.set('n', 'C-h', '<C-W>h')
