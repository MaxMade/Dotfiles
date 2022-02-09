-------------
-- Plugins --
-------------

require('packer').startup(function(use)
	use({'wbthomason/packer.nvim'})

	use({'tpope/vim-fugitive'})

	use({'tpope/vim-commentary'})

	use({'tpope/vim-surround'})

	use({'ellisonleao/gruvbox.nvim'})

	use({'nvim-lualine/lualine.nvim'})

	use({
		'SirVer/ultisnips',
		requires = {'honza/vim-snippets'}
	})

	use({
		'folke/todo-comments.nvim',
		requires = {
			{'nvim-lua/plenary.nvim'},
		}
	})

	use({'ggandor/lightspeed.nvim'})

	use({'rhysd/vim-grammarous'})

	use({'godlygeek/tabular'})

	use({'ntpeters/vim-better-whitespace'})

	use({'nvim-neorg/neorg'})

	use({'lukas-reineke/indent-blankline.nvim'})

	use({'neovim/nvim-lspconfig'})

	use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})

	use({'ray-x/lsp_signature.nvim'})

	use({
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'quangnguyen30192/cmp-nvim-ultisnips'
		}
	})

	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
		}
	})

	use({'kyazdani42/nvim-web-devicons'})

	use({'lewis6991/gitsigns.nvim'})

	use({'lewis6991/spellsitter.nvim'})
end)

---------------
-- Variables --
---------------

local vim_fn = vim.fn
local vim_opt = vim.opt
local vim_cmd = vim.cmd
local vim_api = vim.api
local vim_global = vim.g

local cmp = require('cmp')
local neorg = require('neorg')
local lualine = require('lualine')
local lspconfig = require('lspconfig')
local lspconfig_config = require('lspconfig/configs')
local gitsigns = require('gitsigns')
local spellsitter = require('spellsitter')
local lightspeed = require('lightspeed')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lsp_signature = require('lsp_signature')
local todo_comments = require('todo-comments')
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local treesitter_config = require('nvim-treesitter.configs')
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

local error_sign = ''
local info_sign = ''
local warning_sign = ''
local hint_sign = ''

---------
-- LSP --
---------

-- clang
lspconfig.clangd.setup({cmd={'clangd', '--background-index', '-j=4', '--clang-tidy'}})

-- python-language-server
lspconfig.pylsp.setup({})

-- bash-language-server
lspconfig.bashls.setup({})

-- texlab
lspconfig.texlab.setup({})

-- gopls
lspconfig.gopls.setup({})

-- vscode-html-languageserver
lspconfig.html.setup({})

-- vscode-css-languageserver
lspconfig.cssls.setup({})

-- vscode-json-languageserver
lspconfig.jsonls.setup({})

-- rust-analyzer
lspconfig.rust_analyzer.setup({})

-- jdtls
lspconfig.jdtls.setup({})

------------------
-- VIM Settings --
------------------

-- Generic settings
vim_opt.clipboard = 'unnamedplus'
vim_opt.incsearch = true
vim_opt.cursorline = true
vim_opt.number = true
vim_opt.relativenumber = true
vim_opt.ignorecase = true
vim_opt.smartcase = true
vim_opt.splitright = true
vim_opt.splitbelow = true
vim_opt.backup = false
vim_opt.writebackup = false
vim_opt.swapfile = false
vim_opt.autoindent = true
vim_opt.showmatch = true
vim_opt.encoding = 'utf-8'
vim_opt.listchars = {tab = '‣\t', trail = '␣', space = '␣', precedes = '⇤', extends = '⇥', eol = '↲'}
vim_opt.wrap = false
vim_opt.colorcolumn = '80'
vim_opt.laststatus = 2
vim_opt.hlsearch = true
vim_opt.timeoutlen = 1000
vim_opt.ttimeoutlen = 0
vim_opt.switchbuf = vim_opt.switchbuf + {'usetab', 'newtab'}
vim_opt.completeopt = {'menu', 'menuone', 'noselect'}
vim_opt.fillchars = {vert = '│'}
vim_opt.whichwrap = vim_opt.whichwrap + '<>hl[]'
vim_opt.termguicolors = true
vim_opt.hidden = true
vim_opt.inccommand = 'nosplit'
vim_opt.background = 'dark'
vim_opt.wildmenu = true
vim_opt.wildmode = {'longest:full', 'full'}
vim_opt.tags = './tags;$HOME'
vim_opt.guicursor = 'n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50'

vim_opt.tabstop = 4
vim_opt.shiftwidth = 4
vim_opt.softtabstop = 4
vim_opt.expandtab = false

-- Global options
vim_global.mapleader = ' '

-----------
-- Signs --
-----------

vim_fn.sign_define('LspDiagnosticsSignError', {text = error_sign, texthl = 'LspDiagnosticsSignError', numhl = ""})
vim_fn.sign_define('LspDiagnosticsSignWarning', {text = warning_sign, texthl = 'LspDiagnosticsSignWarning', numhl = ""})
vim_fn.sign_define('LspDiagnosticsSignHint', {text = hint_sign, texthl = 'LspDiagnosticsSignHint', numhl = ""})
vim_fn.sign_define('LspDiagnosticsSignInformation', {text = info_sign, teexthl = 'LspDiagnosticsSignInformation', numhl = ""})
vim_fn.sign_define('LspDiagnosticsSignOther', {text = error_sign, texthl = 'LspDiagnosticsSignOther', numhl = ""})

------------------
-- Highlighting --
------------------

vim_cmd([[
augroup LightspeedHighlight
autocmd!
autocmd   ColorScheme   *   hi   LightspeedLabel                    gui=bold,undercurl   guifg=lightgreen
autocmd   ColorScheme   *   hi   LightspeedLabelOverlapped          gui=bold,undercurl   guifg=lightyellow
autocmd   ColorScheme   *   hi   LightspeedLabelDistant             gui=bold,undercurl   guifg=lightgreen
autocmd   ColorScheme   *   hi   LightspeedLabelDistantOverlapped   gui=bold,undercurl   guifg=lightblue
autocmd   ColorScheme   *   hi   LightspeedShortcut                 gui=bold             guifg=black         guibg=lightgreen
autocmd   ColorScheme   *   hi   LightspeedMaskedChar               gui=bold,undercurl   guifg=white
autocmd   ColorScheme   *   hi   LightspeedGreyWash                                      guifg=grey
autocmd   ColorScheme   *   hi   LightspeedUnlabeledMatch           gui=bold             guifg=black         guibg=white
autocmd   ColorScheme   *   hi   LightspeedPendingOpArea            gui=bold             guifg=black         guibg=lightred
autocmd   ColorScheme   *   hi   LightspeedOneCharMatch             gui=bold             guifg=black         guibg=lightgreen
augroup end
]])

-----------------
-- Colorscheme --
-----------------

vim_cmd('silent! colorscheme gruvbox')

---------------------
-- Plugin Settings --
---------------------

-- nvim-cmp
cmp.setup({
	snippet = {
		expand = function(args)
			vim_fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}),
	},
	sources = {
		{name = 'nvim_lsp'},
		{name = 'ultisnips'},
		{name = 'buffer'},
		{name = 'neorg'},
	}
 })


local lsp_servers = {'clangd', 'pylsp', 'bashls', 'texlab', 'gopls', 'html', 'cssls', 'jsonls', 'jdtls'}
for _,v in pairs(lsp_servers) do
	lspconfig[v].setup({capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())})
end

vim_cmd [[autocmd FileType TelescopePrompt lua cmp.setup.buffer {enabled = false}]]

-- UltiSnips
vim_global['UltiSnipsExpandTrigger'] = '<c-j>'
vim_global['UltiSnipsJumpForwardTrigger'] = '<c-j>'
vim_global['UltiSnipsJumpBackwardTrigger'] = '<c-k>'

-- gitsigns
gitsigns.setup({
	signs = {
		add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
		change       = {hl = 'GitSignsChange', text = '┇', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		delete       = {hl = 'GitSignsDelete', text = '━', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		topdelete    = {hl = 'GitSignsDelete', text = '━', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		changedelete = {hl = 'GitSignsChange', text = '╍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
	},
})

-- lualine
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
	lualine_b = {
		'branch',
		'diff',
		{
			'diagnostics',
			sources={'nvim_diagnostic'},
			sections = {'error', 'warn', 'info', 'hint'},
			symbols = {
				error = error_sign .. '  ',
				warn = warning_sign .. '  ',
				info = info_sign .. '  ',
				hint = hint_sign .. '  '
			}
		}
	},
    lualine_c = {'filename'},

    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- vim-better-whitespace
vim_global['better_whitespace_enabled'] = 1

-- treesitter

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

treesitter_config.setup({
	highlight = {enable = true},
	ensure_installed = { "c", "cpp", "python", "java", "go", "rust", "javascript", "lua", "bash", "latex", "html", "css", "norg" },
})

-- telescope
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = telescope_actions.move_selection_next,
				["<C-k>"] = telescope_actions.move_selection_previous,
				["<C-d>"] = telescope_actions.delete_buffer,
			},

			n = {
				["<C-j>"] = telescope_actions.move_selection_next,
				["<C-k>"] = telescope_actions.move_selection_previous,
				["<C-d>"] = telescope_actions.delete_buffer,
				["<C-c>"] = telescope_actions.close,
				["gg"] = telescope_actions.move_to_top,
				["G"] = telescope_actions.move_to_bottom,
			},
		},

		layout_config = {
			vertical = {width = 0.8}
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
telescope.load_extension('fzf')

-- lsp_signature.nvim
lsp_signature.setup({hint_prefix=""})

-- lightspeed
lightspeed.setup({})

-- neorg
neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					my_workspace = "~/neorg"
				}
			}
		}
	},
})

-- spellsitter
spellsitter.setup({})

-- todo-comments
todo_comments.setup({})

------------------
-- Key Mappings --
------------------

-- Undo, Redo
vim_api.nvim_set_keymap('n', 'u', ':undo<CR>', {noremap = true})
vim_api.nvim_set_keymap('n', 'U', ':redo<CR>', {noremap = true})

-- Yanking
vim_api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})

-- Delete line
vim_api.nvim_set_keymap('n', 'm', '"_d', {noremap = true})
vim_api.nvim_set_keymap('v', 'm', '"_d', {noremap = true})

vim_api.nvim_set_keymap('n', 'mm', '"_dd', {noremap = true})

vim_api.nvim_set_keymap('n', 'M', '"_D', {noremap = true})
vim_api.nvim_set_keymap('v', 'M', '"_D', {noremap = true})

vim_api.nvim_set_keymap('n', 'x', '"_x', {noremap = true})
vim_api.nvim_set_keymap('v', 'x', '"_x', {noremap = true})

vim_api.nvim_set_keymap('n', 'c', '"_c', {noremap = true})
vim_api.nvim_set_keymap('v', 'c', '"_c', {noremap = true})
vim_api.nvim_set_keymap('n', 'C', '"_C', {noremap = true})

-- Suspend
vim_api.nvim_set_keymap('n', '<c-z>', ':sus<CR>', {})
vim_api.nvim_set_keymap('v', '<c-z>', ':sus<CR>', {})
vim_api.nvim_set_keymap('c', '<c-z>', ':sus<CR>', {})

-- Command history
vim_api.nvim_set_keymap('c', '<c-k>', '<UP>', {})
vim_api.nvim_set_keymap('c', '<c-j>', '<DOWN>', {})

-- Show hidden character
vim_api.nvim_set_keymap('n', '<leader>q', ':set list! list?<CR>', {})

-- Telescope
vim_api.nvim_set_keymap('n', '<leader>o', ':lua require("telescope.builtin").find_files()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>O', ':lua require("telescope.builtin").git_files()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>i', ':lua require("telescope.builtin").buffers({ignore_current_buffer=true})<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>?', ':lua require("telescope.builtin").help_tags()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>c', ':lua require("telescope.builtin").tags()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>C', ':lua require("telescope.builtin").current_buffer_tags()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>r', ':lua require("telescope.builtin").grep_string()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>R', ':lua require("telescope.builtin").live_grep()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>x', ':lua require("telescope.builtin").commands()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>h', ':lua require("telescope.builtin").command_history()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>a', ':lua require("telescope.builtin").man_pages()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>/', ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', {})

-- Git
vim_api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>gc', ':Gvdiffsplit!<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>gr', ':diffget //3<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>gl', ':diffget //2<CR>', {})

-- Make
vim_api.nvim_set_keymap('n', '<leader>mm', ':make! ', {})
vim_api.nvim_set_keymap('n', '<leader>mo', ':cw<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>mn', ':cnext<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>mp', ':cprev<CR>', {})

-- Spell-/Grammar-Checking
vim_api.nvim_set_keymap('n', '<F2>', ':GrammarousCheck --lang=eng<CR>', {})
vim_api.nvim_set_keymap('n', '<F3>', ':GrammarousCheck --lang=de<CR>', {})
vim_api.nvim_set_keymap('n', '<F4>', ':GrammarousReset<CR>', {})
vim_api.nvim_set_keymap('n', '<F5>', ':setlocal spell! spelllang=en_us<CR>', {})
vim_api.nvim_set_keymap('n', '<F6>', ':setlocal spell! spelllang=de_de<CR>', {})

-- LSP
vim_api.nvim_set_keymap('n', '<leader>yh', ':lua vim.lsp.buf.hover()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yr', ':lua vim.lsp.buf.rename()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yf', ':lua vim.lsp.buf.range_formatting()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yF', ':lua vim.lsp.buf.formatting()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yn', ':lua vim.diagnostic.goto_next()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yN', ':lua vim.diagnostic.goto_prev()<CR>', {})

vim_api.nvim_set_keymap('n', '<leader>yc', ':lua require("telescope.builtin").lsp_references()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yt', ':lua require("telescope.builtin").lsp_type_definitions({jump_type="never"})<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yi', ':lua require("telescope.builtin").lsp_implementations({jump_type="never"})<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yd', ':lua require("telescope.builtin").lsp_definitions({jump_type="never"})<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>ya', ':lua require("telescope.builtin").lsp_code_actions()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yA', ':lua require("telescope.builtin").lsp_range_code_actions()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>ys', ':lua require("telescope.builtin").lsp_document_symbols()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yS', ':lua require("telescope.builtin").lsp_workspace_symbols()<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yg', ':lua require("telescope.builtin").diagnostics({bufnr=0})<CR>', {})
vim_api.nvim_set_keymap('n', '<leader>yG', ':lua require("telescope.builtin").diagnostics()<CR>', {})

-- Python debugging
vim_api.nvim_set_keymap('n', '<leader>pb', 'oimport pdb; pdb.set_trace()<ESC>', {})
vim_api.nvim_set_keymap('n', '<leader>pB', 'Oimport pdb; pdb.set_trace()<ESC>', {})

-- Clear search
vim_api.nvim_set_keymap('n', '<F7>', ':noh<CR>', {noremap = true})

-- Highlight trailing whitespaces
vim_api.nvim_set_keymap('n', '<F8>', ':ToggleWhitespace<CR>', {noremap = true})

--------------
-- Autocmds --
--------------

vim_cmd([[
	au FileType gitcommit set tw=72
	au FileType python    set expandtab
	au FileType tex       set expandtab
]])
