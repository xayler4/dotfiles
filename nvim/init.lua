-- plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'nvim-tree/nvim-web-devicons'
Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'stevearc/oil.nvim'
Plug 'chrisgrieser/nvim-spider'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'gbprod/substitute.nvim'
Plug 'folke/flash.nvim'
Plug 'myusuf3/numbers.vim'
Plug 'jbyuki/quickmath.nvim'

Plug('nvim-telescope/telescope.nvim', {['branch'] = '0.1.x'})
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' })
Plug('Shougo/deoplete.nvim', {['do'] = ':UpdateRemotePlugins'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

-- plugins options
vim.call('deoplete#enable')

require('lualine').setup {
    options = {
		theme = 'nord'
    }
}

require 'nvim-web-devicons'.setup {
	color_icons = true,
	default = false
}

require 'telescope'.setup {
	defaults = {
		mappings = {
			i = {
				['<esc>'] = require('telescope.actions').close
			}
		},
		pickers = {
			find_files = {
				hidden = true
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


require 'oil'.setup ({
	view_options = {
		show_hidden = true
	}
})

require 'substitute'.setup()

vim.g.nord_disable_background = true

require('nord').set()

-- general preferences
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd[[colorscheme nord]]

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false

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
vim.keymap.set('i', '\"', '\"\"<left>')
vim.keymap.set('i', '\'', '\'\'<left>')
vim.keymap.set('i', '<C-<>', '<><left>')
vim.keymap.set('i', '<C-S-2>', '\"')
vim.keymap.set('i', '<C-\'>', '\'')

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.cmd([[
	autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
]])

vim.cmd([[
	call serverstart(tempname())
	let &titlestring="nvim %F -- [" . v:servername . "]"
	set title
]])
