return {
  "kkoomen/vim-doge",
  build = ":call doge#install()", -- installs templates
  cmd = "DogeGenerate",
  ft = { "cpp", "c", "h" },
  config = function()
    vim.g.doge_doc_standard = "doxygen"
    vim.g.doge_enable_mappings = 1
  end,
}
