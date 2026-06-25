return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- 1. Changed from 'master'
    build = ':TSUpdate',

    -- 2. Removed 'main' and 'opts' entirely.
    -- 3. Added 'config' function to handle setup manually:
    config = function()
      local nvim_treesitter = require 'nvim-treesitter'

      -- Your ensure_installed list goes here:
      nvim_treesitter.install {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'latex',
        'swift',
        'xml',
        'csv',
        'json',
        'java',
        'gitignore',
        'gitcommit',
      }

      -- Enable Neovim's built-in highlighting and indentation
      vim.api.nvim_create_autocmd('FileType', {
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
--
