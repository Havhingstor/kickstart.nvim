-- Xcodebuild.nvim plugin
local progress_handle

return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('xcodebuild').setup {
      code_coverage = {
        enabled = true,
      },
      integrations = {
        pymobiledevice = {
          enabled = true,
        },
      },
      show_build_progress_bar = false,
      logs = {
        notify = function(message, severity)
          local fidget = require 'fidget'
          if progress_handle then
            progress_handle.message = message
            if not message:find 'Loading' then
              progress_handle:finish()
              progress_handle = nil
              if vim.trim(message) ~= '' then
                fidget.notify(message, severity)
              end
            end
          else
            fidget.notify(message, severity)
          end
        end,
        notify_progress = function(message)
          local progress = require 'fidget.progress'

          if progress_handle then
            progress_handle.title = ''
            progress_handle.message = message
          else
            progress_handle = progress.handle.create {
              message = message,
              lsp_client = { name = 'xcodebuild.nvim' },
            }
          end
        end,
      },
    }

    local xcodebuild = require 'xcodebuild.integrations.dap'
    xcodebuild.setup()

    vim.keymap.set('n', '<leader>x', '', { desc = '[X]codebuild' })
    vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All [X]codebuild Actions' })
    vim.keymap.set('n', '<leader>xx', '<cmd>XcodebuildOpenInXcode<cr>', { desc = 'Open In [X]code' })
    vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild [L]ogs' })
    vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test [P]lan' })
    vim.keymap.set('n', '<leader>xe', '<cmd>XcodebuildTestExplorerToggle<cr>', { desc = 'Toggle Test [E]xplorer' })

    vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = '[B]uild Project' })
    vim.keymap.set('n', '<leader>xB', '<cmd>XcodebuildBuildForTesting<cr>', { desc = '[B]uild for Testing' })
    vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & [R]un Project' })

    vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run [T]ests' })
    vim.keymap.set('v', '<leader>xt', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Run Selected Tests' })
    vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run This [T]est Class' })
    vim.keymap.set('n', '<leader>x.', '<cmd>XcodebuildTestRepeat<cr>', { desc = 'Repeat Last Test Run' })
    vim.keymap.set('n', '<leader>xf', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Show [F]ailing Snapshots' })

    vim.keymap.set('n', '<leader>xd', '', { desc = '[D]ebug' })
    vim.keymap.set('n', '<leader>xdd', xcodebuild.build_and_debug, { desc = 'Build & [D]ebug' })
    vim.keymap.set('n', '<leader>xdD', xcodebuild.debug_without_build, { desc = '[D]ebug Without Building' })
    vim.keymap.set('n', '<leader>xdt', xcodebuild.debug_tests, { desc = 'Debug [T]ests' })
    vim.keymap.set('n', '<leader>xdT', xcodebuild.debug_class_tests, { desc = 'Debug Class [T]ests' })

    -- Code Coverage
    vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code [C]overage' })
    vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code [C]overage Report' })

    -- Setup
    vim.keymap.set('n', '<leader>xs', '', { desc = '[S]elect Options' })
    vim.keymap.set('n', '<leader>xsd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select [D]evice' })
    vim.keymap.set('n', '<leader>xss', '<cmd>XcodebuildSetup<cr>', { desc = 'Start [S]etup' })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'XcodebuildCoverageToggled',
      callback = function(event)
        local isOn = event.data
        require('gitsigns').toggle_signs(not isOn)
      end,
    })
  end,
}
