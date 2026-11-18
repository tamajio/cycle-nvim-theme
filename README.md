# cycle-nvim-theme

Preview installed Neovim colorschemes by cycling through them, then keep or cancel the selection.

## Requirements

- Neovim 0.9 or later

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'tamajio/cycle-nvim-theme',
  keys = {
    {
      '<leader>tp',
      '<Cmd>CycleNvimTheme<CR>',
      desc = 'Preview colorschemes',
    },
  },
}
```

## Usage

Run `:CycleNvimTheme` (or use the example `<leader>tp` mapping).

- `n`: preview the next available colorscheme
- `p`: preview the previous available colorscheme
- `<Enter>`: keep the current colorscheme for this Neovim session
- `<Esc>` or `q`: restore the colorscheme active when the preview started

The plugin cycles through colorschemes available to Neovim's `:colorscheme` completion.

## Inspiration

This plugin was inspired by Spacemacs' colorscheme cycling command.
