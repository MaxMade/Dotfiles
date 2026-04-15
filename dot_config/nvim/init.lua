-----------------
-- VIM Settings --
------------------

-- Generic settings
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.mouse = "a"
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
vim.opt.encoding = "utf-8"
vim.opt.wrap = false
vim.opt.colorcolumn = "80"
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.switchbuf = vim.opt.switchbuf + { "usetab", "newtab" }
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.fillchars = { vert = "│" }
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.inccommand = "nosplit"
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.tags = "./tags;$HOME"
vim.opt.title = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  extends = ">",
  precedes = "<",
  space = "·",
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

-- Global options
vim.g.mapleader = " "

--------------------------------------------------------------------------
-- Install lazy.nvim automatically - A modern plugin manager for Neovim --
--------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-------------
-- Plugins --
-------------

local plugins = {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({})
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {},
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
    end
  },
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },

    version = "*",

    opts = {
      keymap = {
        preset = "default",

        ["<C-Space>"] = { "show" },
        ["<C-e>"] = { "hide" },

        ["<CR>"] = { "accept", "fallback" },

        ["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
        ["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      appearance = {
        nerd_font_variant = "normal",
      },

      completion = {
        documentation = { auto_show = true },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      snippets = {
        preset = "luasnip",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = {
        "rust_analyzer",
        "clangd",
        "pylsp",
        "bashls",
        "texlab",
        "gopls",
        "jdtls",
        "openscad_lsp",
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-d>"] = require("telescope.actions").delete_buffer,
              ["<C-;>"] = require("telescope.actions").select_drop,
            },

            n = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-d>"] = require("telescope.actions").delete_buffer,
              ["<C-c>"] = require("telescope.actions").close,
              ["gg"] = require("telescope.actions").move_to_top,
              ["G"] = require("telescope.actions").move_to_bottom,
              ["<C-;>"] = require("telescope.actions").select_drop,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
      })
      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end)
      vim.keymap.set("n", "gy",
        function() require("telescope.builtin").lsp_type_definitions({ jump_type = "never" }) end)
      vim.keymap.set("n", "gi",
        function() require("telescope.builtin").lsp_implementations({ jump_type = "never" }) end)
      vim.keymap.set("n", "gd",
        function() require("telescope.builtin").lsp_definitions({ jump_type = "never" }) end)

      vim.keymap.set("n", "<leader>s", function() require("telescope.builtin").lsp_document_symbols() end)
      vim.keymap.set("n", "<leader>S", function() require("telescope.builtin").lsp_workspace_symbols() end)
      vim.keymap.set("n", "<leader>d", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end)
      vim.keymap.set("n", "<leader>D", function() require("telescope.builtin").diagnostics() end)

      vim.keymap.set("n", "<leader>f", function() require("telescope.builtin").find_files() end)
      vim.keymap.set("n", "<leader>F", function() require("telescope.builtin").git_files() end)
      vim.keymap.set("n", "<leader>b",
        function() require("telescope.builtin").buffers({ ignore_current_buffer = true }) end)
      vim.keymap.set("n", "<leader>h", function() require("telescope.builtin").help_tags() end)
      vim.keymap.set("n", "<leader>c", function() require("telescope.builtin").tags() end)
      vim.keymap.set("n", "<leader>C", function() require("telescope.builtin").current_buffer_tags() end)
      vim.keymap.set("n", "<leader>/", function() require("telescope.builtin").grep_string() end)
      vim.keymap.set("n", "<leader>?", function() require("telescope.builtin").live_grep() end)

      vim.keymap.set("n", "z=", function() require("telescope.builtin").spell_suggest() end)
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "┃" },
        change       = { text = "┇" },
        delete       = { text = "━" },
        topdelete    = { text = "━" },
        changedelete = { text = "╍" },
      },
    }
  },

}

local lazy_opts = {}

require("lazy").setup(plugins, lazy_opts)

-----------------
-- Keybindings --
-----------------

-- Undo, Redo
vim.api.nvim_set_keymap("n", "u", ":undo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { noremap = true, silent = true })

-- Yanking
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })

-- Delete line
vim.api.nvim_set_keymap("n", "m", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "m", '"_d', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "mm", '"_dd', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "M", '"_D', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "M", '"_D', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "x", '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "x", '"_x', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "C", '"_C', { noremap = true, silent = true })


-- Suspend
vim.api.nvim_set_keymap("n", "<c-z>", ":sus<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "<c-z>", ":sus<CR>", { silent = true })
vim.api.nvim_set_keymap("c", "<c-z>", ":sus<CR>", { silent = true })

-- Command history
vim.api.nvim_set_keymap("c", "<c-k>", "<UP>", {})
vim.api.nvim_set_keymap("c", "<c-j>", "<DOWN>", {})

-- Make
vim.api.nvim_set_keymap("n", "<leader>mm", ":make! ", {})
vim.api.nvim_set_keymap("n", "<leader>mo", ":cw<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>mn", ":cnext<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>mN", ":cprev<CR>", { silent = true })

-- Spell-/Grammar-Checking
vim.api.nvim_set_keymap("n", "<F4>", ":setlocal spell! spelllang=de_de,en_us<CR>", { silent = true })

-- LSP
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { noremap = true })

vim.keymap.set("n", "<leader>o", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "<leader>=", function() vim.lsp.buf.format({ async = true }) end)
vim.keymap.set("v", "<leader>=", function() vim.lsp.buf.range_formatting() end)
vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>A", function() vim.lsp.buf.range_code_action() end)

vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end)

-- Whitespace
vim.keymap.set("n", "<leader>t", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle whitespace visibility" })
--------------
-- Autocmds --
--------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function(args)
    vim.opt.tw = 72
    vim.opt.spell = true
    vim.opt.spelllang = { "de_de", "en_us" }
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    vim.opt.expandtab = true
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function(args)
    vim.opt.tw = 0
    vim.opt.expandtab = true
  end
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.texi",
  callback = function(args)
    vim.opt.ft = "tex"
    vim.opt.tw = 0
    vim.opt.expandtab = true
  end
})
