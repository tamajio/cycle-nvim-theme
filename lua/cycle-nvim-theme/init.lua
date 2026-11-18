-- SPDX-License-Identifier: MIT

local M = {}

function M.open()
  local schemes = vim.fn.getcompletion('', 'color')
  if #schemes == 0 then
    vim.notify('No colorschemes are available.', vim.log.levels.ERROR)
    return
  end

  local original = vim.g.colors_name or 'default'
  local index = 1
  for i, scheme in ipairs(schemes) do
    if scheme == original then
      index = i
      break
    end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'

  local width = 42
  local height = 2
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
    title = ' Colorscheme ',
    title_pos = 'center',
  })

  local finished = false
  local function render()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      '  ' .. schemes[index],
      '  p: previous   n: next   Enter: keep   Esc: cancel',
    })
  end

  local function close(keep)
    if finished then
      return
    end
    finished = true
    if not keep then
      vim.cmd.colorscheme(original)
    end
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  local function step(amount)
    index = (index - 1 + amount) % #schemes + 1
    vim.cmd.colorscheme(schemes[index])
    render()
  end

  vim.keymap.set('n', 'p', function()
    step(-1)
  end, { buffer = buf, silent = true })
  vim.keymap.set('n', 'n', function()
    step(1)
  end, { buffer = buf, silent = true })
  vim.keymap.set('n', '<CR>', function()
    close(true)
  end, { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', function()
    close(false)
  end, { buffer = buf, silent = true })
  vim.keymap.set('n', 'q', function()
    close(false)
  end, { buffer = buf, silent = true })

  render()
end

return M
