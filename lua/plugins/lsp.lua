return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")
    local esp32 = require("esp32")

    local root = require("lazyvim.util").root.get()

    local function is_esp_project(root_dir)
      return vim.fn.filereadable(root_dir .. "/.esp") == 1
    end

    if is_esp_project(root) then
      print("ESP32 project detected, setting up ESP32 LSP...")
      opts.servers = opts.servers or {}
      opts.servers.clangd = esp32.lsp_config()

      --[[
      opts.cmd = {
        "/home/flashfish/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd",
        "--compile-commands-dir=build.clang",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      }
      ]]
    else
      print("No ESP32 project detected, using default clangd setup...")
      opts.cmd = { "clangd" } -- Use system default
    end

    lspconfig.clangd.setup(opts)
    return opts
  end,
}
