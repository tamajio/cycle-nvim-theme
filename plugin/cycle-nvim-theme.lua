-- SPDX-License-Identifier: MIT

if vim.g.loaded_cycle_nvim_theme then
  return
end
vim.g.loaded_cycle_nvim_theme = true

vim.api.nvim_create_user_command('CycleNvimTheme', function()
  require('cycle-nvim-theme').open()
end, { desc = 'Preview and cycle through colorschemes' })
