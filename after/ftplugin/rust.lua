local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set('n', '<C-k>', function() vim.cmd.RustLsp { 'hover', 'actions' } end, { desc = 'Rust Hover', silent = true, buffer = bufnr })

require 'util.rust-runner'

vim.keymap.set('n', '<leader>ra', '<Plug>RustHoverAction', { desc = 'Rust [A]ction', silent = true, buffer = bufnr })
vim.keymap.set('n', '<leader>rE', function() vim.cmd.RustLsp 'explainError' end, { desc = 'Rust [E]xplain Error', silent = true, buffer = bufnr })
vim.keymap.set('n', '<leader>re', function() vim.cmd.RustLsp 'renderDiagnostic' end, { desc = 'Rust R[e]nder Diagnostic', silent = true, buffer = bufnr })
vim.keymap.set('n', '<leader>rD', function() vim.cmd.RustLsp 'openDocs' end, { desc = 'Rust Open [D]ocs', silent = true, buffer = bufnr })
vim.keymap.set('n', '<leader>rm', function() vim.cmd.RustLsp 'parentModule' end, { desc = 'Rust Open Parent [M]odule', silent = true, buffer = bufnr })
