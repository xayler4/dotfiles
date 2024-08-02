-- plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'nvim-tree/nvim-web-devicons'
Plug 'loctvl842/monokai-pro.nvim'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'stevearc/oil.nvim'
Plug 'chrisgrieser/nvim-spider'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'gbprod/substitute.nvim'
Plug 'folke/flash.nvim'
Plug 'myusuf3/numbers.vim'

Plug('Shougo/deoplete.nvim', {['do'] = ':UpdateRemotePlugins'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

-- plugins options
vim.call('deoplete#enable')

require 'nvim-web-devicons'.setup {
	color_icons = true,
	default = false
}

require 'monokai-pro'.setup ({
	transparent_background = true,
	filter = 'spectrum'
})


require 'telescope'.setup {
	defaults = {
		mappings = {
			i = {
				['<esc>'] = require('telescope.actions').close
			}
		}
	}
}

require 'flash'.setup {
	modes = {
		search = {
			enabled = true
		}
	}
}

require 'substitute'.setup()

require 'oil'.setup()

-- general preferences
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.lightline = {
	colorscheme = 'monokaipro'
}
vim.cmd('colorscheme monokai-pro')

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = 'unnamedplus'

-- keybindings
local telescope_builtin = require 'telescope.builtin'
vim.keymap.set('n', '<space>f', telescope_builtin.find_files, {})
vim.keymap.set('n', '<space>b', telescope_builtin.buffers, {})

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

vim.keymap.set(
	{ "n", "o", "x" },
	"<leader>w",
	"<cmd>lua require('spider').motion('w')<CR>",
	{ desc = "Spider-w" }
)
vim.keymap.set(
	{ "n", "o", "x" },
	"<leader>e",
	"<cmd>lua require('spider').motion('e')<CR>",
	{ desc = "Spider-e" }
)
vim.keymap.set(
	{ "n", "o", "x" },
	"<leader>b",
	"<cmd>lua require('spider').motion('b')<CR>",
	{ desc = "Spider-b" }
)

vim.keymap.set('i', '(', '()<left>')
vim.keymap.set('i', '[', '[]<left>')
vim.keymap.set('i', '{', '{}<left>')
vim.keymap.set('i', '<C-<>', '<><left>')

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.cmd([[
	autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
]])

vim.cmd([[
	call serverstart(tempname())
	let &titlestring="nvim %F -- [" . v:servername . "]"
	set title
]])
