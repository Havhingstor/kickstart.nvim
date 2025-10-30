-- Rustaceanvim plugin

return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.g.rustaceanvim = function()
      -- Update this path
      local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb'
      local this_os = vim.uv.os_uname().sysname

      -- The path is different on Windows
      if this_os:find 'Windows' then
        codelldb_path = extension_path .. 'adapter\\codelldb.exe'
        liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
      else
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')
      end

      local cfg = require 'rustaceanvim.config'
      return {
        server = {
          on_attach = function(client, bufnr)
            vim.keymap.set('n', '<C-k>', function() vim.cmd.RustLsp { 'hover', 'actions' } end, { desc = 'Rust Hover', silent = true, buffer = bufnr })
            vim.keymap.set('n', '<leader>ra', '<Plug>RustHoverAction', { desc = 'Rust [A]ction', silent = true, buffer = bufnr })
            vim.keymap.set('n', '<leader>rE', function() vim.cmd.RustLsp 'explainError' end, { desc = 'Rust [E]xplain Error', silent = true, buffer = bufnr })
            vim.keymap.set(
              'n',
              '<leader>re',
              function() vim.cmd.RustLsp 'renderDiagnostic' end,
              { desc = 'Rust R[e]nder Diagnostic', silent = true, buffer = bufnr }
            )
            vim.keymap.set('n', '<leader>rD', function() vim.cmd.RustLsp 'openDocs' end, { desc = 'Rust Open [D]ocs', silent = true, buffer = bufnr })
            vim.keymap.set(
              'n',
              '<leader>rm',
              function() vim.cmd.RustLsp 'parentModule' end,
              { desc = 'Rust Open Parent [M]odule', silent = true, buffer = bufnr }
            )

            require 'custom.plugins.util.rust-keymaps-runner'
          end,
        },
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  end,
}
