-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell)

-- ~/.config/nvim/lua/config/autocmds.lua
local function update_doxygen_header()
  -- Only run if file content was modified
  if not vim.bo.modified then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
  local filename = vim.fn.expand("%:t")
  local now = os.date("%Y-%m-%d %H:%M:%S")

  if not lines[1] or not lines[1]:match("^/%*%*") then
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
      "/**",
      " * @file " .. filename,
      " * @brief ",
      " *",
      " * @author Marco Soellinger",
      " * @date " .. now,
      " * @last_modified " .. now,
      " */",
      "",
    })
    return
  end

  for i, line in ipairs(lines) do
    if line:match("@last_modified") then
      vim.api.nvim_buf_set_lines(0, i - 1, i, false, {
        " * @last_modified " .. now,
      })
      return
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.h", "*.hpp", "*.hh", "*.c", "*.cpp", "*.cc" },
  callback = update_doxygen_header,
})
