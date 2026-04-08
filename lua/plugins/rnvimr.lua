return {
  "kevinhwang91/rnvimr",
  cmd = "RnvimrToggle",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.g.rnvimr_enable_ex = 1
    vim.g.rnvimr_draw_border = 1
    vim.g.rnvimr_bw_enable = 1
  end,
}
