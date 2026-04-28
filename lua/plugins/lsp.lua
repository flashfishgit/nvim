local function has_file(root, name)
  return vim.fn.filereadable(root .. "/" .. name) == 1
end

local function clangd_cmd(root)
  if has_file(root, ".esp") then
    return {
      "/home/flashfish/.espressif/tools/esp-clang/esp-20.1.1_20250829/esp-clang/bin/clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
      "--query-driver=**/xtensa-esp32*-elf-*,**/riscv32-esp-elf-*,/home/flashfish/.espressif/tools/**/bin/*",
    }
  end

  return {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  }
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      texlab = {},
      marksman = {},

      clangd = {
        keys = {
          {
            "<leader>ch",
            "<cmd>LspClangdSwitchSourceHeader<cr>",
            desc = "Switch Source/Header (C/C++)",
          },
        },

        root_markers = {
          ".esp",
          ".root_marker_lsp",
          "compile_commands.json",
          "compile_flags.txt",
          "CMakeLists.txt",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "Makefile",
          "meson.build",
          "meson_options.txt",
          "build.ninja",
          ".git",
          "vhdl_ls.toml",
        },

        capabilities = {
          offsetEncoding = { "utf-16" },
        },

        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
    },

    setup = {
      clangd = function(_, opts)
        local root = vim.fs.root(0, {
          ".esp",
          ".root_marker_lsp",
          "compile_commands.json",
          "compile_flags.txt",
          "CMakeLists.txt",
          ".git",
        }) or vim.fn.getcwd()

        opts.cmd = clangd_cmd(root)

        local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")

        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, {
          server = opts,
        }))

        return false
      end,
    },
  },
}
