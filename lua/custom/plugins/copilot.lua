return {
  'github/copilot.vim',
  lazy = false,
  config = function() -- Mapping tab is already used in NvChad
    vim.g.copilot_no_tab_map = true -- Disable tab mapping
    vim.g.copilot_assume_mapped = true -- Assume that the mapping is already done

    vim.keymap.set('i', '<C-l>', function()
      vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
    end, { desc = 'Copilot Accept', noremap = true, silent = true })

    -- Toggle Copilot on/off for current buffer with <leader>ct
    vim.keymap.set('n', '<leader>ct', function()
      if vim.b.copilot_enabled == false then
        -- Enable Copilot for current buffer
        vim.b.copilot_enabled = true
        print 'Copilot enabled for current buffer'
      else
        -- Disable Copilot for current buffer
        vim.b.copilot_enabled = false
        print 'Copilot disabled for current buffer'
      end
    end, { desc = 'Toggle Copilot', noremap = true, silent = true })

    -- Optional: Add a keymap to check Copilot status
    vim.keymap.set('n', '<leader>cs', '<cmd>Copilot status<CR>', { desc = 'Copilot Status', noremap = true, silent = true })
  end,
}
