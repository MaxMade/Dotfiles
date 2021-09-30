-------------
-- Plugins --
-------------

local plugin_path = os.getenv('HOME') .. '/.local/share/nvim/plugged'
vim.call('plug#begin', plugin_path)
	vim.fn['plug#']('tpope/vim-fugitive')
	vim.fn['plug#']('tpope/vim-commentary')
	vim.fn['plug#']('tpope/vim-surround')

	vim.fn['plug#']('rktjmp/lush.nvim') -- Required by ellisonleao/gruvbox.nvim
	vim.fn['plug#']('ellisonleao/gruvbox.nvim')
	vim.fn['plug#']('itchyny/lightline.vim')

	vim.fn['plug#']('SirVer/ultisnips')
	vim.fn['plug#']('honza/vim-snippets')

	vim.fn['plug#']('easymotion/vim-easymotion')
	vim.fn['plug#']('mbbill/undotree')
	vim.fn['plug#']('vimwiki/vimwiki')
	vim.fn['plug#']('rhysd/vim-grammarous')
	vim.fn['plug#']('godlygeek/tabular')
	vim.fn['plug#']('ntpeters/vim-better-whitespace')
	vim.fn['plug#']('lukas-reineke/indent-blankline.nvim')

	vim.fn['plug#']('neovim/nvim-lspconfig')
	vim.fn['plug#']('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
	vim.fn['plug#']('ray-x/lsp_signature.nvim')

	vim.fn['plug#']('hrsh7th/cmp-nvim-lsp')
	vim.fn['plug#']('hrsh7th/cmp-buffer')
	vim.fn['plug#']('hrsh7th/nvim-cmp')
	vim.fn['plug#']('quangnguyen30192/cmp-nvim-ultisnips')

	vim.fn['plug#']('nvim-lua/plenary.nvim') -- Required by nvim-telescope/telescope.nvim
	vim.fn['plug#']('nvim-telescope/telescope.nvim')
	vim.fn['plug#']('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make'})
	vim.fn['plug#']('kyazdani42/nvim-web-devicons')
	vim.fn['plug#']('lewis6991/gitsigns.nvim')
vim.call('plug#end')

---------
-- LSP --
---------

-- clang
require('lspconfig').clangd.setup({cmd={'clangd', '--background-index', '-j=4', '--clang-tidy'}})

-- python-language-server
require('lspconfig').pylsp.setup({})

-- bash-language-server
require('lspconfig').bashls.setup({})

-- texlab
require('lspconfig').texlab.setup({})

-- gopls
require('lspconfig').gopls.setup({})

-- vscode-langservers-extracted
require('lspconfig').html.setup({})
require('lspconfig').cssls.setup({})
require('lspconfig').jsonls.setup({})

-- lua-language-server
require('lspconfig/configs')['lualsp'] = {
	default_config = {
		cmd={'lua-language-server'},
		filetypes={'lua'},
		root_dir = require('lspconfig/util').path.dirname,
	},
}
require('lspconfig').lualsp.setup({})

-- ghdl_ls
require('lspconfig/configs')['ghdl_ls'] = {
	default_config = {
		cmd={'ghdl-ls'},
		filetypes={'vhdl'},
		root_dir = require('lspconfig/util').path.dirname,
	},
}
require('lspconfig').ghdl_ls.setup({})

------------------
-- VIM Settings --
------------------

-- Generic settings
vim.opt.clipboard = 'unnamedplus'
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.showmatch = true
vim.opt.encoding = 'utf-8'
vim.opt.listchars = {tab = '‣\t', trail = '␣', space = '␣', precedes = '⇤', extends = '⇥', eol = '↲'}
vim.opt.wrap = false
vim.opt.colorcolumn = '80'
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.switchbuf = vim.opt.switchbuf + {'usetab', 'newtab'}
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.fillchars = {vert = '│'}
vim.opt.whichwrap = vim.opt.whichwrap + '<>hl[]'
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.inccommand = 'nosplit'
vim.opt.background = 'dark'
vim.opt.wildmenu = true
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.tags = './tags;$HOME'
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

-- Global options
vim.g.mapleader = ' '

------------
-- Colors --
------------

vim.cmd [[
augroup HighlighSpelling
	autocmd!
	autocmd ColorScheme * hi SpellBad                             guisp=Red    gui=italic,bold,undercurl
	autocmd ColorScheme * hi SpellCap                             guisp=Yellow gui=italic,bold,undercurl
	autocmd ColorScheme * hi SpellRare                            guisp=Blue   gui=italic,bold,undercurl
	autocmd ColorScheme * hi SpellLocal                           guisp=Blue   gui=italic,bold,undercurl
augroup END
]]

vim.cmd [[
augroup HighlightLSP
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextError       guifg=Red    gui=italic,bold,underline
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextWarning     guifg=Orange gui=italic,bold,underline
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextHint        guifg=Green  gui=italic,bold,underline
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextInformation guifg=Yellow gui=italic,bold,underline
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextOther       guifg=Blue   gui=italic,bold,underline

	autocmd ColorScheme * hi LspDiagnosticsUnderlineError         guisp=Red    gui=undercurl
	autocmd ColorScheme * hi LspDiagnosticsUnderlineWarning       guisp=Orange gui=undercurl
	autocmd ColorScheme * hi LspDiagnosticsUnderlineHint          guisp=Green  gui=undercurl
	autocmd ColorScheme * hi LspDiagnosticsUnderlineInformation   guisp=Yellow gui=undercurl
	autocmd ColorScheme * hi LspDiagnosticsUnderlineOther         guisp=Blue   gui=undercurl

	autocmd ColorScheme * hi LspDiagnosticsSignError              guifg=Red
	autocmd ColorScheme * hi LspDiagnosticsSignWarning            guifg=Orange
	autocmd ColorScheme * hi LspDiagnosticsSignHint               guifg=Green
	autocmd ColorScheme * hi LspDiagnosticsSignInformation        guifg=Yellow
	autocmd ColorScheme * hi LspDiagnosticsSignOther              guifg=Blue
augroup END
]]

vim.fn.sign_define('LspDiagnosticsSignError', {text = '', texthl = 'LspDiagnosticsSignError', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = '', texthl = 'LspDiagnosticsSignWarning', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = '', texthl = 'LspDiagnosticsSignHint', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = '', teexthl = 'LspDiagnosticsSignInformation', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignOther', {text = '', texthl = 'LspDiagnosticsSignOther', numhl = ""})

-- Colorscheme
vim.cmd 'silent! colorscheme gruvbox'

---------------------
-- Plugin Settings --
---------------------

-- nvim-cmp
require('cmp').setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		['<Tab>'] = require('cmp').mapping.select_next_item(),
		['<S-Tab>'] = require('cmp').mapping.select_prev_item(),
		['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
		['<C-f>'] = require('cmp').mapping.scroll_docs(4),
		['<C-Space>'] = require('cmp').mapping.complete(),
		['<C-e>'] = require('cmp').mapping.close(),
		['<CR>'] = require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'buffer' },
	}
  })


local lsp_servers = {'clangd', 'pylsp', 'bashls', 'texlab', 'gopls', 'html', 'cssls', 'jsonls', 'lualsp', 'ghdl_ls'}
for _,v in pairs(lsp_servers) do
	require('lspconfig')[v].setup({capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())})
end

vim.cmd [[autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }]]

-- UltiSnips
vim.g['UltiSnipsExpandTrigger'] = '<c-j>'
vim.g['UltiSnipsJumpForwardTrigger'] = '<c-j>'
vim.g['UltiSnipsJumpBackwardTrigger'] = '<c-k>'

-- gitsigns
require('gitsigns').setup({
	signs = {
		add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
		change       = {hl = 'GitSignsChange', text = '┇', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		delete       = {hl = 'GitSignsDelete', text = '━', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		topdelete    = {hl = 'GitSignsDelete', text = '━', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		changedelete = {hl = 'GitSignsChange', text = '╍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
	},
})

-- GruvBox
vim.g['gruvbox_contrast_dark'] = 'hard'
vim.g['gruvbox_contrast_light'] = 'hard'
vim.g['gruvbox_invert_selection'] = 0
vim.g['gruvbox_improved_warnings'] = 1

-- Lightline
vim.g['lightline'] = {
	colorscheme = 'gruvbox',
	active = {
		left  = {{'mode'}, {'readonly', 'filename', 'modified'}},
		right = {{'lineinfo'}, {'percent'}, {'fileformat'}, {'filetype'}}
	}
}

-- Vimwiki
vim.g['vimwiki_list'] = {{path = '~/.vimwiki/', syntax = 'markdown', ext = '.md'}}

-- vim-better-whitespace
vim.g['better_whitespace_enabled'] = 1

-- treesitter
require('nvim-treesitter.configs').setup({highlight = {enable = true}})

-- telescope
require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
				["<C-d>"] = require('telescope.actions').delete_buffer,
			},

			n = {
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
				["<C-d>"] = require('telescope.actions').delete_buffer,
				["<C-c>"] = require('telescope.actions').close,
				["gg"] = require('telescope.actions').move_to_top,
				["G"] = require('telescope.actions').move_to_bottom,
			},
		},

		layout_config = {
			vertical = { width = 0.8 }
		},

	},
	pickers = {},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	},
})
require('telescope').load_extension('fzf')

-- lsp_signature.nvim
require('lsp_signature').setup({ hint_prefix="" })

------------------
-- Key Mappings --
------------------

-- Undo, Redo
vim.api.nvim_set_keymap('n', 'u', ':undo<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'U', ':redo<CR>', {noremap = true})

-- Yanking
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})

-- Delete line
vim.api.nvim_set_keymap('n', 'm', '"_d', {noremap = true})
vim.api.nvim_set_keymap('v', 'm', '"_d', {noremap = true})

vim.api.nvim_set_keymap('n', 'mm', '"_dd', {noremap = true})

vim.api.nvim_set_keymap('n', 'M', '"_D', {noremap = true})
vim.api.nvim_set_keymap('v', 'M', '"_D', {noremap = true})

vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true})
vim.api.nvim_set_keymap('v', 'x', '"_x', {noremap = true})

vim.api.nvim_set_keymap('n', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('v', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('n', 'C', '"_C', {noremap = true})

-- Suspend
vim.api.nvim_set_keymap('n', '<c-z>', ':sus<CR>', {})
vim.api.nvim_set_keymap('v', '<c-z>', ':sus<CR>', {})
vim.api.nvim_set_keymap('c', '<c-z>', ':sus<CR>', {})

-- Command history
vim.api.nvim_set_keymap('c', '<c-k>', '<UP>', {})
vim.api.nvim_set_keymap('c', '<c-j>', '<DOWN>', {})

-- Show hidden character
vim.api.nvim_set_keymap('n', '<leader>q', ':set list! list?<CR>', {})

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>o', ':lua require("telescope.builtin").find_files()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>O', ':lua require("telescope.builtin").git_files()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>i', ':lua require("telescope.builtin").buffers({ignore_current_buffer=true})<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>?', ':lua require("telescope.builtin").help_tags()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>c', ':lua require("telescope.builtin").tags()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>C', ':lua require("telescope.builtin").current_buffer_tags()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>r', ':lua require("telescope.builtin").grep_string()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>R', ':lua require("telescope.builtin").live_grep()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>x', ':lua require("telescope.builtin").commands()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>h', ':lua require("telescope.builtin").command_history()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("telescope.builtin").man_pages()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>/', ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', {})

-- Git
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Gvdiffsplit!<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gr', ':diffget //3<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //2<CR>', {})

-- Make
vim.api.nvim_set_keymap('n', '<leader>mm', ':make! ', {})
vim.api.nvim_set_keymap('n', '<leader>mo', ':cw<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>mn', ':cnext<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>mp', ':cprev<CR>', {})

-- Spell-/Grammar-Checking
vim.api.nvim_set_keymap('n', '<F2>', ':GrammarousCheck --lang=eng<CR>', {})
vim.api.nvim_set_keymap('n', '<F3>', ':GrammarousCheck --lang=de<CR>', {})
vim.api.nvim_set_keymap('n', '<F4>', ':GrammarousReset<CR>', {})
vim.api.nvim_set_keymap('n', '<F5>', ':setlocal spell! spelllang=en_us<CR>', {})
vim.api.nvim_set_keymap('n', '<F6>', ':setlocal spell! spelllang=de_de<CR>', {})

-- LSP
vim.api.nvim_set_keymap('n', '<leader>yh', ':lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yr', ':lua vim.lsp.buf.rename()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yf', ':lua vim.lsp.buf.range_formatting()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yF', ':lua vim.lsp.buf.formatting()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yn', ':lua vim.lsp.diagnostic.goto_next()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yN', ':lua vim.lsp.diagnostic.goto_prev()<CR>', {})

vim.api.nvim_set_keymap('n', '<leader>yc', ':lua require("telescope.builtin").lsp_references()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yt', ':lua require("telescope.builtin").lsp_type_definitions({jump_type="never"})<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yi', ':lua require("telescope.builtin").lsp_implementations({jump_type="never"})<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yd', ':lua require("telescope.builtin").lsp_definitions({jump_type="never"})<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ya', ':lua require("telescope.builtin").lsp_code_actions()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yA', ':lua require("telescope.builtin").lsp_range_code_actions()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ys', ':lua require("telescope.builtin").lsp_document_symbols()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yS', ':lua require("telescope.builtin").lsp_workspace_symbols()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yg', ':lua require("telescope.builtin").lsp_document_diagnostics()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yG', ':lua require("telescope.builtin").lsp_workspace_diagnostics()<CR>', {})

-- Python debugging
vim.api.nvim_set_keymap('n', '<leader>pb', 'oimport pdb; pdb.set_trace()<ESC>', {})
vim.api.nvim_set_keymap('n', '<leader>pB', 'Oimport pdb; pdb.set_trace()<ESC>', {})

-- vimwiki
vim.api.nvim_set_keymap('n', '<Leader>k', '<Plug>VimwikiIndex', {})

-- Clear search
vim.api.nvim_set_keymap('n', '<F7>', ':noh<CR>', {noremap = true})

-- Highlight trailing whitespaces
vim.api.nvim_set_keymap('n', '<F8>', ':ToggleWhitespace<CR>', {noremap = true})

-- Undo Tree
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', {noremap = true})

-- vim-easymotion
vim.api.nvim_set_keymap('', '<leader>', '<Plug>(easymotion-prefix)', {})

-- TODO: nvim-cmp

--------------
-- Autocmds --
--------------

vim.cmd [[
	au FileType gitcommit set tw=72
	au FileType python    set expandtab
	au FileType tex       set expandtab
]]
