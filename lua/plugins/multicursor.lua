return {
  {
    "LazyVim/LazyVim",
    init = function()
      -- run *after* LazyVim sets its defaults
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimKeymaps",
        callback = function()
          for _, mode in ipairs({ "n", "x" }) do
            pcall(vim.keymap.del, mode, "<Up>")
            pcall(vim.keymap.del, mode, "<Down>")
          end

          -- now your multicursor bindings
          local mc = require("multicursor-nvim")
          local set = vim.keymap.set
          set({ "n", "x" }, "<Up>", function()
            mc.lineAddCursor(-1)
          end, { noremap = true, silent = true })
          set({ "n", "x" }, "<Down>", function()
            mc.lineAddCursor(1)
          end, { noremap = true, silent = true })
          set({ "n", "x" }, "<leader><Up>", function()
            mc.lineSkipCursor(-1)
          end, { noremap = true, silent = true })
          set({ "n", "x" }, "<leader><Down>", function()
            mc.lineSkipCursor(1)
          end, { noremap = true, silent = true })
        end,
      })
    end,
  },

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    lazy = false,
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<Up>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<Down>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<leader><Up>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<leader><Down>", function()
        mc.lineSkipCursor(1)
      end)

      -- Match-based add/skip
      set({ "n", "x" }, "<leader>n", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<leader>s", function()
        mc.matchSkipCursor(1)
      end)
      set({ "n", "x" }, "<leader>N", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<leader>S", function()
        mc.matchSkipCursor(-1)
      end)

      -- Mouse
      set("n", "<C-LeftMouse>", mc.handleMouse)
      set("n", "<C-LeftDrag>", mc.handleMouseDrag)
      set("n", "<C-LeftRelease>", mc.handleMouseRelease)

      -- Toggle
      set({ "n", "x" }, "<C-q>", mc.toggleCursor)

      -- Layer (active only when multiple cursors exist)
      mc.addKeymapLayer(function(layerSet)
        layerSet({ "n", "x" }, "<Left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<Right>", mc.nextCursor)
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
        layerSet("n", "df", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
          set({ "n", "x" }, "<leader>n", mc.matchAddCursor)
        end)
      end)

      -- Highlights
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
