-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'voldikss/vim-floaterm', -- Load Floaterm plugin and configure keybinds
    config = function()
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-n', '<cmd>FloatermNew!<cr>', { desc = '[N]ew Floaterm' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-k', '<cmd>FloatermKill<cr>', { desc = '[K]ill Current Floaterm' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-K', '<cmd>FloatermKill!<cr>', { desc = '[K]ill All Floaterms' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-h', '<cmd>FloatermPrev<cr>', { desc = 'Previous Floaterm' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-H', '<cmd>FloatermFirst<cr>', { desc = 'First Floaterm' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-l', '<cmd>FloatermNext<cr>', { desc = 'Next Floaterm' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-L', '<cmd>FloatermLast<cr>', { desc = 'Last Floaterm' })
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-t', '<cmd>FloatermToggle<cr>', { desc = 'Toggle Floaterm' })
    end,
  },
  {
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
          dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
          },
        }
      end
    end,
  },
}
