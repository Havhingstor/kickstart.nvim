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
      vim.keymap.set({ 'n', 'v', 'o' }, '<leader>-<leader>', '<cmd>FloatermToggle<cr>', { desc = 'Toggle Floaterm' })
    end,
  },
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      -- Your setup opts here
    },
  },
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'nvim-dap',
    },
  },
  {
    'oclay1st/gradle.nvim',
    cmd = { 'Gradle', 'GradleExec', 'GradleInit', 'GradleFavorites' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    opts = {}, -- options, see default configuration
    keys = {
      { '<leader>g', desc = '+Gradle', mode = { 'n', 'v' } },
      { '<leader>gg', '<cmd>Gradle<cr>', desc = 'Gradle Projects' },
      { '<leader>gf', '<cmd>GradleFavorites<cr>', desc = 'Gradle Favorite Commands' },
    },
  },
  {
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
        -- navigation inside VM mode (safe)
        ['Goto Next'] = '<C-ä>',
        ['Goto Prev'] = '<C-ö>',
      }
    end,
  },
  { 'lukas-reineke/virt-column.nvim', opts = {}, config = function() require('virt-column').setup() end },
}
