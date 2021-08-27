-------------
-- Plugins --
-------------

local plugin_path = os.getenv('HOME') .. '/.local/share/nvim/plugged'
vim.call('plug#begin', plugin_path)
	vim.fn['plug#']('airblade/vim-gitgutter')
	vim.fn['plug#']('tpope/vim-fugitive')

	vim.fn['plug#']('tpope/vim-commentary')
	vim.fn['plug#']('tpope/vim-surround')

	vim.fn['plug#']('morhetz/gruvbox')
	vim.fn['plug#']('itchyny/lightline.vim')

	vim.fn['plug#']('SirVer/ultisnips')
	vim.fn['plug#']('honza/vim-snippets')

	vim.fn['plug#']('easymotion/vim-easymotion')
	vim.fn['plug#']('mbbill/undotree')

	vim.fn['plug#']('junegunn/fzf.vim')
	vim.fn['plug#']('vimwiki/vimwiki')
	vim.fn['plug#']('rhysd/vim-grammarous')

	vim.fn['plug#']('godlygeek/tabular')
	vim.fn['plug#']('ntpeters/vim-better-whitespace')

	vim.fn['plug#']('neovim/nvim-lspconfig')
	vim.fn['plug#']('nvim-lua/completion-nvim')
	vim.fn['plug#']('ojroques/nvim-lspfuzzy')
	vim.fn['plug#']('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

---------
-- LSP --
---------

-- clang
require('lspconfig').clangd.setup({on_attach=require'completion'.on_attach, cmd={'clangd', '--background-index', '-j=4', '--clang-tidy'}})

-- python-language-server
require('lspconfig').pylsp.setup({on_attach=require'completion'.on_attach})

-- bash-language-server
require('lspconfig').bashls.setup({on_attach=require'completion'.on_attach})

-- texlab
require('lspconfig').texlab.setup({on_attach=require'completion'.on_attach})

-- gopls
require('lspconfig').gopls.setup({on_attach=require'completion'.on_attach})

-- tsserver
require('lspconfig').tsserver.setup({on_attach=require'completion'.on_attach})

-- Fuzzy Search
require('lspfuzzy').setup({jump_one = false})

-- completion
vim.cmd([[autocmd BufEnter * lua require('completion').on_attach()]])


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
-- vim.opt.backspace = {'indent', 'eol', 'start'}
-- vim.opt.complete -= 'i'
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
vim.opt.completeopt = {'longest', 'menuone', 'noinsert', 'noselect'}
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
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextInformation guifg=Yellow gui=italic,bold,underline
	autocmd ColorScheme * hi LspDiagnosticsVirtualTextHint        guifg=Green  gui=italic,bold,underline
augroup END
]]

-- Colorscheme
vim.cmd 'silent! colorscheme gruvbox'

---------------------
-- Plugin Settings --
---------------------

-- UltiSnips
vim.g['UltiSnipsExpandTrigger'] = '<c-j>'
vim.g['UltiSnipsJumpForwardTrigger'] = '<c-j>'
vim.g['UltiSnipsJumpBackwardTrigger'] = '<c-k>'

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

-- FZF
vim.g['fzf_buffers_jump'] = 1
vim.g['fzf_layout'] = {down = '60%'}

-- Vimwiki
vim.g['vimwiki_list'] = {{path = '~/.vimwiki/', syntax = 'markdown', ext = '.md'}}

-- completion-nvim
vim.g['completion_enable_snippet'] = 'UltiSnips'
vim.g['completion_matching_strategy_list'] = {'exact', 'substring', 'fuzzy', 'all'}

-- vim-better-whitespace
vim.g['better_whitespace_enabled'] = 1

-- treesitter
require('nvim-treesitter.configs').setup({highlight = {enable = true}})

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

-- FZF
vim.api.nvim_set_keymap('n', '<leader>o', ':Files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>i', ':Buffers<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>?', ':Helptags<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>c', [[:exe 'Tags ' . expand('<cword>')<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>C', ':Tags<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>r', [[:exe 'Ag ' . expand('<cword>')<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>R', ':Ag<CR>', {})

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
vim.api.nvim_set_keymap('n', '<leader>yt', ':lua vim.lsp.buf.type_definition()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yh', ':lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yi', ':lua vim.lsp.buf.implementation()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yd', ':lua vim.lsp.buf.definition()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yc', ':lua vim.lsp.buf.declaration()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yr', ':lua vim.lsp.buf.rename()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yf', ':lua vim.lsp.buf.range_formatting()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yF', ':lua vim.lsp.buf.formatting()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ya', ':lua vim.lsp.buf.code_action()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yn', ':lua vim.lsp.diagnostic.goto_next()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yN', ':lua vim.lsp.diagnostic.goto_prev()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ys', ':lua vim.lsp.buf.workspace_symbol()<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yg', ':LspDiagnostics 0<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>yG', ':LspDiagnostics<CR>', {})

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
vim.api.nvim_set_keymap('n', '<leader>', '<Plug>(easymotion-prefix)', {})

-- completion-nvim
vim.api.nvim_set_keymap('i', '<tab>', '<Plug>(completion_smart_tab)', {})
vim.api.nvim_set_keymap('i', '<s-tab>', '<Plug>(completion_smart_s_tab)', {})

--------------
-- Autocmds --
--------------

vim.cmd [[
au FileType gitcommit set tw=72
au FileType python set expandtab
au FileType tex set expandtab
]]
