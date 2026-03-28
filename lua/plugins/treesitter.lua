-- New nvim-treesitter only exposes config.setup() for install_dir.
-- Highlighting and indent are built into Neovim 0.12.
require('nvim-treesitter.config').setup {}

-- Install parsers via the new CLI-style API
local parsers = {
  'bash', 'c', 'markdown', 'markdown_inline', 'query',
  'vim', 'vimdoc', 'diff', 'go', 'tsx', 'typescript',
  'json', 'sql', 'html', 'haskell', 'yaml',
  'prisma', 'make', 'gleam',
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
