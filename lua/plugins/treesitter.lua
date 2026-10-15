require('tree-sitter-manager').setup {
  ensure_installed = {
    'bash', 'c', 'markdown', 'markdown_inline', 'query',
    'vim', 'vimdoc', 'diff', 'go', 'tsx', 'typescript',
    'json', 'sql', 'html', 'haskell', 'yaml',
    'prisma', 'make', 'gleam', 'kotlin',
  },
  highlight = true,
}
