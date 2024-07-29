-- plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'nvim-tree/nvim-web-devicons'
Plug 'comfysage/evergarden'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'stevearc/oil.nvim'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'gbprod/substitute.nvim'
Plug('Shougo/deoplete.nvim', {['do'] = ':UpdateRemotePlugins'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

-- plugins options
vim.call('deoplete#enable')

require 'nvim-web-devicons'.setup {
	color_icons = true,
	default = false
}

require 'evergarden'.setup {
  transparent_background = true,
  contrast_dark = 'hard', -- 'hard'|'medium'|'soft'
  override_terminal = true,
  style = {
    tabline = { reverse = true, color = 'green' },
    search = { reverse = false, inc_reverse = true },
    types = { italic = true },
    keyword = { italic = true },
    comment = { italic = false },
    sign = { highlight = false },
  },
  overrides = { }, -- add custom overrides
}

require 'lualine'.setup {
	options = {
		theme = 'evergarden'
	}
}

require 'telescope'.setup {
	defaults = {
		mappings = {
			i = {
				['<esc>'] = require('telescope.actions').close
			}
		}
	}
}

require 'substitute'.setup()

require 'oil'.setup()

-- general preferences
vim.cmd('colorscheme evergarden')

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = 'unnamedplus'

-- keybindings
vim.keymap.set('n', '<C-J>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<C-h>', '<C-W>h')

local telescope_builtin = require 'telescope.builtin'
vim.keymap.set('n', '<C-f>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-b>', telescope_builtin.buffers, {})

local substitute = require 'substitute'
vim.keymap.set('n', 's', substitute.operator)
vim.keymap.set('n', 'ss', substitute.line)
vim.keymap.set('n', 'S', substitute.eol)
vim.keymap.set('x', 's', substitute.visual)

local exchange = require 'substitute.exchange'
vim.keymap.set('n', 'sx', exchange.operator)
vim.keymap.set('n', 'sxx', exchange.line)
vim.keymap.set('x', 'X', exchange.visual)
vim.keymap.set('n', 'sxc', exchange.cancel)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
