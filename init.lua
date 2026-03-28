-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Remove default copying to clipboard (only "y" and visual "x" is left)
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true, silent = true })
vim.keymap.set('n', 's', '"_s', { noremap = true, silent = true })
vim.keymap.set('n', 'S', '"_S', { noremap = true, silent = true })

-- Visual line for max line length restriction
vim.opt.colorcolumn = '80'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.keymap.set('n', '<leader>tf', function()
  if vim.b.disable_autoformat then
    vim.b.disable_autoformat = false
    print 'formatting enabled'
  else
    vim.b.disable_autoformat = true
    print 'formatting disabled'
  end
end, { desc = '[T]oggle [F]ormatting with Conform' })

vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover {
    max_width = 80,
    max_height = 200,
    border = 'solid',
  }
end, { desc = 'Hover docs' })

-- [[ Install plugins with vim.pack ]]

-- Build steps: run after :PackUpdate installs/updates plugins
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-build-steps', { clear = true }),
  callback = function()
    if vim.fn.exists(':TSUpdate') == 2 then
      vim.cmd('TSUpdate')
    end
    -- telescope-fzf-native
    local fzf_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
    if vim.fn.isdirectory(fzf_path) == 1 then
      vim.fn.system({ 'make', '-C', fzf_path })
    end
    -- LuaSnip jsregexp
    if vim.fn.has('win32') == 0 and vim.fn.executable('make') == 1 then
      local luasnip_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/LuaSnip'
      if vim.fn.isdirectory(luasnip_path) == 1 then
        vim.fn.system({ 'make', '-C', luasnip_path, 'install_jsregexp' })
      end
    end
  end,
})

vim.pack.add {
  -- Standalone
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/sainnhe/everforest',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  -- Telescope chain
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  -- todo-comments (needs plenary)
  'https://github.com/folke/todo-comments.nvim',
  -- Completion chain
  'https://github.com/L3MON4D3/LuaSnip',
  -- { src = 'https://github.com/saghen/blink.cmp', version = 'v1.*' },
  -- Mason chain
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  -- LSP (needs mason + blink)
  'https://github.com/neovim/nvim-lspconfig',
  -- Oil (needs web-devicons)
  'https://github.com/stevearc/oil.nvim',
}

-- [[ Plugin Setup ]]

-- Colorscheme (first, so UI is styled before other plugins load)
vim.g.everforest_enable_italic = true
vim.g.everforest_background = 'soft' -- 'hard'`, `'medium'`, `'soft'
vim.g.everforest_sign_column_background = 'none' -- 'none', 'grey'
vim.g.everforest_diagnostic_virtual_text = 'colored'
vim.cmd.colorscheme 'everforest'
vim.cmd.hi 'Comment gui=none'

-- guess-indent
require('guess-indent').setup {}
vim.keymap.set('n', '<leader>gi', '<cmd>:GuessIndent<CR>', { desc = '[G]uess [I]ndent' })

-- fidget
require('fidget').setup {}

-- mini
require('mini.pairs').setup()
require('mini.move').setup()

-- todo-comments
require('todo-comments').setup { signs = false }

-- lazydev
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- LuaSnip
require('luasnip').setup {}

-- [[ Telescope ]]
require('telescope').setup {
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_mru = true,
      previewer = false,
      mappings = {
        i = {
          ['<C-d>'] = 'delete_buffer',
        },
      },
      theme = 'dropdown',
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- [[ blink.cmp ]]
-- require('blink.cmp').setup {
--   keymap = {
--     preset = 'default',
--   },
--
--   appearance = {
--     nerd_font_variant = 'mono',
--   },
--
--   completion = {
--     documentation = {
--       auto_show = true,
--
--       window = {
--         min_width = 10,
--         max_width = 60,
--         max_height = 20,
--         border = 'rounded',
--         winblend = 0,
--         winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
--         scrollbar = true,
--         direction_priority = {
--           menu_north = { 'e', 'w', 'n', 's' },
--           menu_south = { 'e', 'w', 's', 'n' },
--         },
--       },
--     },
--   },
--
--   sources = {
--     default = { 'lsp', 'path', 'snippets', 'lazydev' },
--     providers = {
--       lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
--     },
--   },
--
--   snippets = { preset = 'luasnip' },
--
--   fuzzy = { implementation = 'lua' },
--
--   signature = { enabled = true },
-- }

-- [[ LSP ]]
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

    if client then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_lines = {
    current_line = true,
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
  virtual_text = false,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  clangd = {},
  gopls = {},

  docker_compose_language_service = {},
  prismals = {},
  terraformls = {},
  tflint = {},
  ts_ls = {},

  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}

-- Mason
require('mason').setup {}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'clangd',
  'codespell',
  'docker_compose_language_service',
  'eslint_d',
  'goimports',
  'gopls',
  'lua_ls',
  'prettierd',
  'prismals',
  'sql-formatter',
  'staticcheck',
  'stylua',
  'terraform',
  'terraformls',
  'tflint',
  'tfsec',
  'ts_ls',
  'xmlformatter',
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      if server_name == 'jdtls' then
        return
      end

      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

vim.lsp.enable 'gleam'

-- [[ Treesitter ]]
-- New nvim-treesitter only exposes config.setup() for install_dir.
-- Highlighting and indent are built into Neovim 0.12.
require('nvim-treesitter.config').setup {}

-- Install parsers via the new CLI-style API
local parsers = {
  'bash', 'c', 'luadoc', 'markdown', 'markdown_inline', 'query',
  'vim', 'vimdoc', 'diff', 'lua', 'go', 'tsx', 'typescript',
  'dockerfile', 'json', 'sql', 'html', 'haskell', 'yaml',
  'prisma', 'make', 'cpp', 'terraform', 'gleam',
}
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('ts-ensure-installed', { clear = true }),
  once = true,
  callback = function()
    for _, lang in ipairs(parsers) do
      pcall(vim.treesitter.language.add, lang)
    end
  end,
})

-- [[ Modular plugin configs ]]
require 'kickstart.plugins.gitsigns'
require 'kickstart.plugins.indent_line'
require 'custom.plugins.lualine'
require 'custom.plugins.oil'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
