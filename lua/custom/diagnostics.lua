local M = {}

local excluded_clients = {
  harper_ls = true,
  codebook = true,
}

local enabled = false

local function get_info()
  if enabled then
    return 'normal'
  else
    return 'Harper & Codebook hidden'
  end
end

function M.set_enabled(new_enabled)
  enabled = new_enabled

  for client_name in pairs(excluded_clients) do
    if not enabled then
      for _, client in ipairs(vim.lsp.get_clients { name = client_name }) do
        local namespace = vim.lsp.diagnostic.get_namespace(client.id)
        vim.diagnostic.reset(namespace)
      end
    end

    vim.lsp.enable(client_name, enabled)
  end

  vim.notify('Diagnostics: ' .. get_info())
end

function M.toggle() M.set_enabled(not enabled) end

M.set_enabled(false)

vim.keymap.set('n', '<leader>tg', function() M.toggle() end, { desc = '[T]oggle [G]rammatical diagnostics (Harper, Codebook)' })

return M
