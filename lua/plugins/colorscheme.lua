return {
  -- Gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Everforest
  { "sainnhe/everforest" },

  -- Catppuccin
  { "catppuccin/nvim", name = "catppuccin" },

  -- Tokyonight
  { "folke/tokyonight.nvim" },

  -- Kanagawa
  { "rebelot/kanagawa.nvim" },

  -- Configure LazyVim to load a colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- Pick one of:
      -- "gruvbox"
      -- "everforest"
      -- "catppuccin-mocha", "catppuccin-latte", etc.
      -- "tokyonight-night", "tokyonight-storm", etc.
      -- "kanagawa", "kanagawa-dragon", etc.
      colorscheme = "kanagawa-dragon",
    },
  },
}
