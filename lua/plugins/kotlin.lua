-- JetBrains' kotlin-lsp via kotlin.nvim.
-- The plugin starts the server itself; do not vim.lsp.enable('kotlin_lsp').
-- Server install: Mason (kotlin-lsp), see plugins/mason.lua.
-- Per-project overrides go in a .kotlin-lsp.lua at the project root.
require('kotlin').setup {
  root_markers = { 'settings.gradle.kts', 'settings.gradle', 'build.gradle.kts', 'build.gradle', 'pom.xml', 'gradlew', 'mvnw', '.git' },

  inlay_hints = {
    enabled = true,
  },

  folding = { enabled = true },

  -- 'ask' opens vim.ui.select synchronously from BufWritePost, and the
  -- telescope picker can't take focus from there, so re-import without asking.
  reload_workspace = { on_build_file_save = 'always' },

  code_lens = { enabled = true },

  java_files = true,
}

-- kotlin-lsp numbers document versions itself, so the version on a rename
-- result is behind Neovim's changedtick and Neovim drops the edit with
-- "Buffer ... newer than edits". kotlin.nvim clears the version for
-- workspace/applyEdit but not for textDocument/rename; do the same here.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kotlin-rename-version', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or client.name ~= 'kotlin_lsp' then
      return
    end
    client.handlers['textDocument/rename'] = function(err, result, ctx)
      for _, change in ipairs(result and result.documentChanges or {}) do
        if change.textDocument then
          change.textDocument.version = vim.NIL
        end
      end
      return vim.lsp.handlers['textDocument/rename'](err, result, ctx)
    end
  end,
})
