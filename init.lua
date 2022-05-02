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
		'L3MON4D3/LuaSnip',
		requires = {'rafamadriz/friendly-snippets'}
	})

	use({
		'folke/todo-comments.nvim',
		requires = {
			{'nvim-lua/plenary.nvim'},
		}
	})

	use({'ggandor/lightspeed.nvim'})

	use({'kevinhwang91/nvim-hlslens'})

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
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip'
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
vim.opt.listchars.tab = '‣\t'
vim.opt.listchars.trail = '␣'
vim.opt.listchars.space = '␣'
vim.opt.listchars.precedes = '⇤'
vim.opt.listchars.extends = '⇥'
vim.opt.listchars.eol = '↲'
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

-----------
-- Signs --
-----------

vim.fn.sign_define('LspDiagnosticsSignError', {text = error_sign, texthl = 'LspDiagnosticsSignError', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text = warning_sign, texthl = 'LspDiagnosticsSignWarning', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignHint', {text = hint_sign, texthl = 'LspDiagnosticsSignHint', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text = info_sign, teexthl = 'LspDiagnosticsSignInformation', numhl = ""})
vim.fn.sign_define('LspDiagnosticsSignOther', {text = error_sign, texthl = 'LspDiagnosticsSignOther', numhl = ""})

------------------
-- Highlighting --
------------------

vim.cmd([[
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

vim.cmd('silent! colorscheme gruvbox')

---------------------
-- Plugin Settings --
---------------------

-- nvim-cmp
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
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
		{name = 'luasnip'},
		{name = 'buffer'},
		{name = 'path'},
		{name = 'neorg'},
	}
 })
require("luasnip.loaders.from_vscode").lazy_load()


local lsp_servers = {'clangd', 'pylsp', 'bashls', 'texlab', 'gopls', 'html', 'cssls', 'jsonls', 'jdtls'}
for _,v in pairs(lsp_servers) do
	lspconfig[v].setup({capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())})
end

vim.cmd [[autocmd FileType TelescopePrompt lua cmp.setup.buffer {enabled = false}]]

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
vim.g['better_whitespace_enabled'] = 1

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
vim.keymap.set("n", "<leader>o", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>O", function() require("telescope.builtin").git_files() end)
vim.keymap.set("n", "<leader>i", function() require("telescope.builtin").buffers({ignore_current_buffer=true}) end)
vim.keymap.set("n", "<leader>?", function() require("telescope.builtin").help_tags() end)
vim.keymap.set("n", "<leader>c", function() require("telescope.builtin").tags() end)
vim.keymap.set("n", "<leader>C", function() require("telescope.builtin").current_buffer_tags() end)
vim.keymap.set("n", "<leader>r", function() require("telescope.builtin").grep_string() end)
vim.keymap.set("n", "<leader>R", function() require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<leader>x", function() require("telescope.builtin").commands() end)
vim.keymap.set("n", "<leader>h", function() require("telescope.builtin").command_history() end)
vim.keymap.set("n", "<leader>a", function() require("telescope.builtin").man_pages() end)
vim.keymap.set("n", "<leader>/", function() require("telescope.builtin").current_buffer_fuzzy_find() end)

-- Git
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Gvdiffsplit!<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gr', ':diffget //3<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //2<CR>', {})

-- Make
vim.api.nvim_set_keymap('n', '<leader>mm', ':make! ', {})
vim.api.nvim_set_keymap('n', '<leader>mo', ':cw<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>mn', ':cnext<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>mN', ':cprev<CR>', {})

-- Spell-/Grammar-Checking
vim.api.nvim_set_keymap('n', '<F2>', ':GrammarousCheck --lang=eng<CR>', {})
vim.api.nvim_set_keymap('n', '<F3>', ':GrammarousCheck --lang=de<CR>', {})
vim.api.nvim_set_keymap('n', '<F4>', ':GrammarousReset<CR>', {})
vim.api.nvim_set_keymap('n', '<F5>', ':setlocal spell! spelllang=en_us<CR>', {})
vim.api.nvim_set_keymap('n', '<F6>', ':setlocal spell! spelllang=de_de<CR>', {})

-- LSP
vim.keymap.set("n", "<leader>yh", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>yr", function() vim.lsp.buf.rename() end)
vim.keymap.set("n", "<leader>yf", function() vim.lsp.buf.range_formatting() end)
vim.keymap.set("n", "<leader>yF", function() vim.lsp.buf.formatting() end)

vim.keymap.set("n", "<leader>yn", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "<leader>yN", function() vim.diagnostic.goto_prev() end)

vim.keymap.set("n", "<leader>yc", function() require("telescope.builtin").lsp_references() end)
vim.keymap.set("n", "<leader>yt", function() require("telescope.builtin").lsp_type_definitions({jump_type="never"}) end)
vim.keymap.set("n", "<leader>yi", function() require("telescope.builtin").lsp_implementations({jump_type="never"}) end)
vim.keymap.set("n", "<leader>yd", function() require("telescope.builtin").lsp_definitions({jump_type="never"}) end)
vim.keymap.set("n", "<leader>ya", function() require("telescope.builtin").lsp_code_actions() end)
vim.keymap.set("n", "<leader>yA", function() require("telescope.builtin").lsp_range_code_actions() end)
vim.keymap.set("n", "<leader>ys", function() require("telescope.builtin").lsp_document_symbols() end)
vim.keymap.set("n", "<leader>yS", function() require("telescope.builtin").lsp_workspace_symbols() end)
vim.keymap.set("n", "<leader>yg", function() require("telescope.builtin").diagnostics({bufnr=0}) end)
vim.keymap.set("n", "<leader>yG", function() require("telescope.builtin").diagnostics() end)

-- Clear search
vim.api.nvim_set_keymap('n', '<F7>', ':noh<CR>', {noremap = true})

-- Highlight trailing whitespaces
vim.api.nvim_set_keymap('n', '<F8>', ':ToggleWhitespace<CR>', {noremap = true})

-- nvim-hlslens
-- TODO: Use nvim 0.7 function
vim.api.nvim_set_keymap("n", "n", [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "N", [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require("hlslens").start()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require("hlslens").start()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require("hlslens").start()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>l", ":noh<CR>", {noremap = true, silent = true})

-- LuaSnip
vim.keymap.set("i", "<C-j>", function() require("luasnip").jump(1) end)
vim.keymap.set("s", "<C-j>", function() require("luasnip").jump(1) end)
vim.keymap.set("i", "<C-k>", function() require("luasnip").jump(-1) end)
vim.keymap.set("s", "<C-k>", function() require("luasnip").jump(-1) end)

--------------
-- Autocmds --
--------------

vim.cmd([[
	au FileType mail      set tw=72
	au FileType gitcommit set tw=72
	au FileType python    set expandtab
	au FileType tex       set expandtab
]])
