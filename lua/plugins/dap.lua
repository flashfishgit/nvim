return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")

    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    }

    dap.configurations = {
      cpp = {
        {
          name = "ESP32 OpenOCD",
          type = "cppdbg",
          request = "launch",

          program = "${workspaceFolder}/build/HB_Controller.elf",
          cwd = "${workspaceFolder}",

          MIMode = "gdb",
          miDebuggerPath = "xtensa-esp32s3-elf-gdb",

          miDebuggerServerAddress = "localhost:3333",

          stopAtEntry = true,
          externalConsole = false,

          setupCommands = {
            {
              text = "target remote :3333",
            },
            {
              text = "monitor reset halt",
            },
            {
              text = "monitor reset init",
            },
          },
        },
        {
          name = "ESP32 OpenOCD",
          type = "cppdbg",
          request = "launch",

          program = "${workspaceFolder}/build/HB_Controller.elf",
          cwd = "${workspaceFolder}",

          MIMode = "gdb",
          miDebuggerPath = "xtensa-esp32s3-elf-gdb",
          miDebuggerServerAddress = "localhost:3333",

          stopAtEntry = true,
          externalConsole = false,

          setupCommands = {
            { text = "set remote hardware-watchpoint-limit 2" },
            { text = "monitor reset halt" },
            { text = "set mem inaccessible-by-default off" },
            { text = "set gdb_memory_map disable" },
          },

          customLaunchSetupCommands = {
            { text = "target extended-remote localhost:3333" },
            { text = "monitor reset halt" },
            { text = "monitor reset init" },
          },
        },
      },
      c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          MIMode = "lldb",
        },
        {
          name = "Attach to lldbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "lldb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = "/usr/bin/lldb",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
        },
        {
          name = "STM32 OpenOCD",
          type = "cppdbg",
          request = "launch",

          program = "${workspaceFolder}/build/Uebung01.elf",
          cwd = "${workspaceFolder}",

          MIMode = "gdb",
          miDebuggerPath = vim.fn.exepath("gdb"),
          miDebuggerServerAddress = "localhost:3333",
          targetArchitecture = "arm",

          stopAtEntry = true,
          stopAtConnect = true,
          externalConsole = false,

          setupCommands = {
            {
              text = "file ${workspaceFolder}/build/Uebung01.elf",
              description = "Load symbols",
              ignoreFailures = false,
            },
          },

          customLaunchSetupCommands = {
            {
              text = "target extended-remote localhost:3333",
              description = "Connect to OpenOCD",
              ignoreFailures = false,
            },
            {
              text = "monitor reset halt",
              description = "Reset and halt target",
              ignoreFailures = false,
            },
            {
              text = "load",
              description = "Flash firmware",
              ignoreFailures = false,
            },
            {
              text = "thbreak main",
              description = "Break at main",
              ignoreFailures = true,
            },
          },

          launchCompleteCommand = "exec-continue",
        },
      },
    }

    ui.setup()

    vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,

  keys = {
    { "<leader>d", function() end, desc = "Debugger" }, -- group label (noop)
    {
      "<leader>dt",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>du",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "Open REPL",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>dq",
      function()
        require("dap").terminate()
        require("dapui").close()
        require("nvim-dap-virtual-text").toggle()
      end,
      desc = "Terminate",
    },
    {
      "<leader>db",
      function()
        require("dap").list_breakpoints()
      end,
      desc = "List Breakpoints",
    },
    {
      "<leader>de",
      function()
        require("dap").set_exception_breakpoints({ "all" })
      end,
      desc = "Set Exception Breakpoints",
    },
  },
}
