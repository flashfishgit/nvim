local function find_vsg_config(dir)
  local root = vim.fs.root(dir, { "vsg_config.yaml", ".vsg.yaml" })
  if not root then
    return nil
  end

  local config = root .. "/vsg_config.yaml"
  if vim.fn.filereadable(config) == 1 then
    return config
  end

  config = root .. "/.vsg.yaml"
  if vim.fn.filereadable(config) == 1 then
    return config
  end

  return nil
end

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "vsg" },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      opts.formatters_by_ft.vhdl = function(bufnr)
        local file = vim.api.nvim_buf_get_name(bufnr)
        local config = find_vsg_config(vim.fs.dirname(file))

        if config then
          return { "vsg" }
        end

        return {}
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.vsg = {
        command = "vsg",
        args = function(_, ctx)
          local config = find_vsg_config(ctx.dirname)

          local args = {}
          if config then
            vim.list_extend(args, { "--configuration", config })
          end

          vim.list_extend(args, {
            "-f",
            ctx.filename,
            "--fix",
          })

          return args
        end,
        stdin = false,
        exit_codes = { 0, 1 },
      }
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
        vhdl = { "vsg" },
      })

      lint.linters.vsg = function()
        local file = vim.api.nvim_buf_get_name(0)
        local config = find_vsg_config(vim.fs.dirname(file))

        if not config then
          return nil
        end

        return {
          cmd = "vsg",
          stdin = false,
          append_fname = false,
          args = {
            "--configuration",
            config,
            "-f",
            file,
            "--output_format",
            "syntastic",
          },
          ignore_exitcode = true,
          parser = require("lint.parser").from_errorformat("%tRROR: %f(%l)%*[^(] -- %m,%tARNING: %f(%l)%*[^(] -- %m", {
            source = "vsg",
            severity = {
              E = vim.diagnostic.severity.ERROR,
              W = vim.diagnostic.severity.WARN,
            },
          }),
        }
      end

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        pattern = { "*.vhd", "*.vhdl" },
        callback = function(args)
          local file = vim.api.nvim_buf_get_name(args.buf)
          local config = find_vsg_config(vim.fs.dirname(file))

          if config then
            lint.try_lint("vsg")
          end
        end,
      })
    end,
  },
}
