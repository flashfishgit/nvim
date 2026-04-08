-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.winbar = "%=%m %f"

vim.g.root_spec = {
  { ".root_marker" },
  "lsp", -- LSP root if available
  { ".git" }, -- markers
  "cwd", -- fallback
}
