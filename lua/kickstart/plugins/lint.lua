---@module 'lazy'
---@type LazySpec
return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- local pattern = ':(%d+):(%d+): %a+: %((%a*)%) (.*)'
      -- local groups = { 'lnum', 'col', 'severity', 'code', 'message' }
      -- local severity_map = {
      --   ['error'] = vim.diagnostic.severity.WARN,
      -- }
      -- local defaults = { ['source'] = 'swiftformat' }
      -- lint.linters.swiftformat = {
      --   name = 'swiftformat',
      --   cmd = 'swiftformat',
      --   stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
      --   append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
      --   args = { '--lint', '2>&1', '|', 'grep', '-E', '":\\d+:\\d+:.*"' }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
      --   stream = 'both', -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      --   ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
      --   env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
      --   parser = require('lint.parser').from_pattern(pattern, groups, severity_map, defaults),
      -- }

      local original = lint.linters.swiftlint
      lint.linters.swiftlint = function()
        local linter = original()
        local arg = vim.fn.stdpath 'data' .. '/swiftlint.yaml'

        linter.args = vim.list_extend(linter.args, {
          '--config',
          arg,
        })

        return linter
      end

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        swift = { 'swiftlint' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
      local lint_progress = function()
        local linters = require('lint').get_running()
        if #linters == 0 then
          return 'None 󰦕'
        end
        return table.concat(linters, ', ') .. ' 󱉶'
      end
      vim.keymap.set('n', '<leader>l', function() require('lint').try_lint() end, { desc = '[L]int file' })
      vim.keymap.set('n', '<leader>L', "<CMD>echo 'Currently working Linters: " .. lint_progress() .. "'<CR>", { desc = 'Show current [L]inkers' })
    end,
  },
}
