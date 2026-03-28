require('mason').setup {}
require('mason-tool-installer').setup {
  ensure_installed = {
    'goimports',
    'gopls',
    'kotlin-lsp',
  },
}
