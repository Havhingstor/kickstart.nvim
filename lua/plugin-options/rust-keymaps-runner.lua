local bufnr = vim.api.nvim_get_current_buf()
local get_args = function(start_args)
  local args = start_args
  local finished = false
  while not finished do
    local value = vim.fn.input 'Next Argument: '
    if value == nil then
      return
    elseif value == '' then
      finished = true
    else
      table.insert(args, value)
    end
  end

  return args
end

-- Describe half commands

vim.keymap.set('n', '<leader>r', '', { desc = '[R]ust' })
vim.keymap.set('n', '<leader>rd', '', { desc = 'Rust [D]ebug' })
vim.keymap.set('n', '<leader>rr', '', { desc = 'Rust [R]un' })
vim.keymap.set('n', '<leader>rt', '', { desc = 'Rust [T]est' })

-- Debugging
vim.keymap.set('n', '<leader>rdd', function() vim.cmd.RustLsp { 'debuggables' } end, { desc = 'Rust Debug', silent = true, buffer = bufnr })

vim.keymap.set(
  'n',
  '<leader>rdD',
  function() vim.cmd.RustLsp { 'debuggables', bang = true } end,
  { desc = 'Rust Debug last target', silent = true, buffer = bufnr }
)

vim.keymap.set('n', '<leader>rda', function()
  local args = get_args { 'debuggables' }
  if args == nil then
    return
  end
  vim.cmd.RustLsp(args)
end, { desc = 'Rust Debug with arguments', silent = true, buffer = bufnr })

vim.keymap.set('n', '<leader>rdA', function()
  local args = get_args { 'debuggables', bang = true }
  if args == nil then
    return
  end
  vim.cmd.RustLsp(args)
end, { desc = 'Rust Debug last target with arguments', silent = true, buffer = bufnr })

-- Running
vim.keymap.set('n', '<leader>rrr', function() vim.cmd.RustLsp { 'runnables' } end, { desc = 'Rust Run', silent = true, buffer = bufnr })

vim.keymap.set(
  'n',
  '<leader>rrR',
  function() vim.cmd.RustLsp { 'runnables', bang = true } end,
  { desc = 'Rust Run last target', silent = true, buffer = bufnr }
)

vim.keymap.set('n', '<leader>rra', function()
  local args = get_args { 'runnables' }
  if args == nil then
    return
  end
  vim.cmd.RustLsp(args)
end, { desc = 'Rust Run with arguments', silent = true, buffer = bufnr })

vim.keymap.set('n', '<leader>rrA', function()
  local args = get_args { 'runnables', bang = true }
  if args == nil then
    return
  end
  vim.cmd.RustLsp(args)
end, { desc = 'Rust Run last target with arguments', silent = true, buffer = bufnr })

-- Testing
vim.keymap.set('n', '<leader>rtt', function() vim.cmd.RustLsp { 'testables' } end, { desc = 'Rust Test', silent = true, buffer = bufnr })

vim.keymap.set(
  'n',
  '<leader>rtT',
  function() vim.cmd.RustLsp { 'testables', bang = true } end,
  { desc = 'Rust Test last target', silent = true, buffer = bufnr }
)

vim.keymap.set('n', '<leader>rta', function()
  local args = get_args { 'testables' }
  if args == nil then
    return
  end
  vim.cmd.RustLsp(args)
end, { desc = 'Rust Test with arguments', silent = true, buffer = bufnr })

vim.keymap.set('n', '<leader>rtA', function()
  local args = get_args { 'testables', bang = true }
  if args == nil then
    return
  end
  vim.cmd.RustLsp(args)
end, { desc = 'Rust Test last target with arguments', silent = true, buffer = bufnr })
