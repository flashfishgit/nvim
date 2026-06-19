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

vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = "/home/flashfish/Documents/Repo/FH/PRO/Repo/PickAndPlace/pickandplace.worktree/Add_Firmware_Application_Code/Feeder/Feeder_Firmware/*",
  callback = function()
    vim.opt_local.modeline = false
    vim.opt_local.modelines = 0
  end,
})

--vim.g.clipboard = {
--  name = "xclip",
--  copy = {
--    ["+"] = "xclip -selection clipboard",
--    ["*"] = "xclip -selection primary",
--  },
--  paste = {
--    ["+"] = "xclip -selection clipboard -o",
--    ["*"] = "xclip -selection primary -o",
--  },
--  cache_enabled = 0,
--}
