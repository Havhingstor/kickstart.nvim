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
  },
}
