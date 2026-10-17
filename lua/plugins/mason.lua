require('mason').setup {
  registries = {
    -- Local overrides (see lua/mason-registry-local), checked first.
    'lua:mason-registry-local',
    'github:mason-org/mason-registry',
  },
}
require('mason-tool-installer').setup {
  ensure_installed = {
    'goimports',
    'gopls',
    'kotlin-lsp',
    'ktfmt',
  },
}
