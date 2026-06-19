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
    { "<leader>d", function() end, desc = "Debugger" },

    -- Start / Continue / Stop
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue / Start Debugging",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dp",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dq",
      function()
        require("dap").terminate()
        require("dapui").close()
      end,
      desc = "Terminate Debug Session",
    },
    {
      "<leader>dQ",
      function()
        require("dap").disconnect()
        require("dapui").close()
      end,
      desc = "Disconnect Debugger",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last Debug Config",
    },
    {
      "<leader>dR",
      function()
        local dap = require("dap")

        if dap.restart then
          dap.restart()
        else
          dap.terminate()
          vim.defer_fn(function()
            dap.run_last()
          end, 300)
        end
      end,
      desc = "Restart Debug Session",
    },

    -- Stepping
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
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Move Down Stack Frame",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Move Up Stack Frame",
    },

    -- Breakpoints
    {
      "<leader>dt",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Conditional Breakpoint",
    },
    {
      "<leader>dL",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      desc = "Logpoint",
    },
    {
      "<leader>db",
      function()
        require("dap").list_breakpoints()
      end,
      desc = "List Breakpoints",
    },
    {
      "<leader>dX",
      function()
        require("dap").clear_breakpoints()
      end,
      desc = "Clear All Breakpoints",
    },

    -- REPL / UI
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle DAP REPL",
    },
    {
      "<leader>dU",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle Debug UI",
    },
    {
      "<leader>dv",
      function()
        require("nvim-dap-virtual-text").toggle()
      end,
      desc = "Toggle Virtual Text",
    },

    -- DAP UI elements
    {
      "<leader>ds",
      function()
        require("dapui").float_element("scopes", { enter = true })
      end,
      desc = "Show Scopes",
    },
    {
      "<leader>dS",
      function()
        require("dapui").float_element("stacks", { enter = true })
      end,
      desc = "Show Call Stack",
    },
    {
      "<leader>dw",
      function()
        require("dapui").float_element("watches", { enter = true })
      end,
      desc = "Show Watches",
    },
    {
      "<leader>dW",
      function()
        require("dapui").elements.watches.add()
      end,
      desc = "Add Watch",
    },
    {
      "<leader>df",
      function()
        require("dapui").float_element("breakpoints", { enter = true })
      end,
      desc = "Show Breakpoints Window",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "Evaluate Expression",
    },
    {
      "<leader>dh",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Hover Variable",
    },
    {
      "<leader>d?",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      desc = "Centered Scopes Float",
    },

    -- Exception breakpoints
    {
      "<leader>dE",
      function()
        require("dap").set_exception_breakpoints({ "all" })
      end,
      desc = "Break on All Exceptions",
    },

    -- Sessions / configs
    {
      "<leader>da",
      function()
        require("dap").continue({
          before = function(config)
            print("Starting DAP config: " .. (config.name or "unknown"))
          end,
        })
      end,
      desc = "Start With Config Info",
    },
    {
      "<leader>dP",
      function()
        local dap = require("dap")
        local sessions = dap.sessions()

        vim.print(sessions)
      end,
      desc = "Print Active DAP Sessions",
    },

    -- Visual mode evaluate
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      mode = { "v" },
      desc = "Evaluate Selection",
    },
  },
}
