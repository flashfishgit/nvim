return {
  "dlyongemallo/sanity.nvim",
  cmd = { "SanityLoadLog", "SanityRunValgrind" },
  opts = {
    -- picker = "fzf-lua",  -- "telescope", "mini.pick", "snacks"; nil to auto-detect
    -- keymaps = {
    --   stack_next = "]s",   -- set to false to disable
    --   stack_prev = "[s",   -- set to false to disable
    --   show_stack = false,  -- set to a key (e.g., "<a-s>") to enable
    --   explain    = false,  -- set to a key (e.g., "<a-e>") to enable
    --   related    = false,  -- set to a key (e.g., "<a-r>") to enable
    --   suppress   = false,  -- set to a key (e.g., "<a-x>") to enable
    --   debug      = false,  -- set to a key (e.g., "<a-d>") to enable
    -- },
    -- track_origins = "ask",  -- true (always), false (never), "ask" (prompt on uninit errors)
    -- stack_fold_limit = 6,  -- fold long call chains in :SanityStack; 0 to disable
    -- valgrind_suppressions = { ".valgrind.supp" },  -- passed as --suppressions= to valgrind
  },
}
