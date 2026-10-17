-- Upstream mason-registry still points kotlin-lsp at download-cdn.jetbrains.com,
-- which 404s since JetBrains moved to signed redirects. This is the upstream
-- package.yaml with the host fixed (download.jetbrains.com).
-- Remove once https://github.com/mason-org/mason-registry/issues/17366 is fixed.
local base = 'https://download.jetbrains.com/language-server/kotlin-server/{{ version | strip_prefix "kotlin-lsp/v" }}/kotlin-server-{{ version | strip_prefix "kotlin-lsp/v" }}'
local bin = 'kotlin-server-{{ version | strip_prefix "kotlin-lsp/v" }}/bin/intellij-server'

return {
  schema = 'registry+v1',
  name = 'kotlin-lsp',
  description = 'Kotlin Language Server and plugin for Visual Studio Code',
  homepage = 'https://github.com/Kotlin/kotlin-lsp',
  licenses = { 'Apache-2.0' },
  languages = { 'Kotlin' },
  categories = { 'LSP' },
  source = {
    id = 'pkg:generic/Kotlin/kotlin-lsp@kotlin-lsp/v263.6379.0',
    download = {
      { target = 'darwin_x64', files = { ['kotlin-lsp.zip'] = base .. '.sit' }, bin = bin },
      { target = 'darwin_arm64', files = { ['kotlin-lsp.zip'] = base .. '-aarch64.sit' }, bin = bin },
      { target = 'linux_x64', files = { ['kotlin-lsp.tar.gz'] = base .. '.tar.gz' }, bin = bin },
      { target = 'linux_arm64', files = { ['kotlin-lsp.tar.gz'] = base .. '-aarch64.tar.gz' }, bin = bin },
      { target = 'win_x64', files = { ['kotlin-lsp.zip'] = base .. '.win.zip' }, bin = 'bin/intellij-server.exe' },
      { target = 'win_arm64', files = { ['kotlin-lsp.zip'] = base .. '-aarch64.win.zip' }, bin = 'bin/intellij-server.exe' },
    },
  },
  bin = { ['intellij-server'] = '{{source.download.bin}}' },
  neovim = { lspconfig = 'kotlin_lsp' },
}
