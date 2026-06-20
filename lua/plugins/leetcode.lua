return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  cmd = "Leet",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },

  keys = {
    { "<leader>ll", "<cmd>Leet list<cr>", desc = "LeetCode List" },
    { "<leader>ld", "<cmd>Leet daily<cr>", desc = "LeetCode Daily" },
    { "<leader>lr", "<cmd>Leet run<cr>", desc = "LeetCode Run" },
    { "<leader>ls", "<cmd>Leet submit<cr>", desc = "LeetCode Submit" },
    { "<leader>li", "<cmd>Leet info<cr>", desc = "LeetCode Info" },
    { "<leader>lc", "<cmd>Leet console<cr>", desc = "LeetCode Console" },
    { "<leader>lt", "<cmd>Leet tabs<cr>", desc = "LeetCode Tabs" },
    { "<leader>lo", "<cmd>Leet open<cr>", desc = "Open in Browser" },
    { "<leader>ly", "<cmd>Leet yank<cr>", desc = "Yank Code" },
    { "<leader>lL", "<cmd>Leet lang<cr>", desc = "Change Language" },
    { "<leader>lR", "<cmd>Leet reset<cr>", desc = "Reset Code" },
  },

  opts = {
    arg = "leetcode.nvim",
    lang = "cpp",

    cn = {
      enabled = false,
      translator = true,
      translate_problems = true,
    },

    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    plugins = {
      non_standalone = false,
    },

    logging = true,

    injector = {
      ["cpp"] = {
        imports = function()
          return {
            "#include <bits/stdc++.h>",
            "using namespace std;",
          }
        end,
      },
    },

    cache = {
      update_interval = 60 * 60 * 24 * 7,
    },

    editor = {
      reset_previous_code = true,
      fold_imports = true,
    },

    console = {
      open_on_runcode = true,
      dir = "row",
      size = {
        width = "90%",
        height = "75%",
      },
      result = {
        size = "60%",
      },
      testcase = {
        virt_text = true,
        size = "40%",
      },
    },

    description = {
      position = "left",
      width = "40%",
      show_stats = true,
    },

    picker = { provider = nil },

    hooks = {
      ["enter"] = {},
      ["question_enter"] = {},
      ["leave"] = {},
    },

    -- These are LeetCode UI keys, not global keymaps.
    keys = {
      toggle = { "q" },
      confirm = { "<CR>" },
      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },

    theme = {},
    image_support = true,
  },
}
