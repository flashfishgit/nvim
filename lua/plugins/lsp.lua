return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    opts.servers = opts.servers or {}
    opts.servers.clangd = {
      cmd = {
        "clangd",
        "--background-index",
        "--query-driver=/home/flashfish/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/*-gcc",
      },
      root_dir = lspconfig.util.root_pattern("build/compile_commands.json", ".git"),
    }

    -- debug print so you can see exactly what Neovim will launch:
    print("🚀 clangd command:", vim.inspect(opts.servers.clangd.cmd))

    lspconfig.clangd.setup(opts)
    return opts
  end,
}
