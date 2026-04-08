-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "df", "<Esc>", { noremap = true })

vim.keymap.set("i", "df", "<Esc>", { noremap = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "K", ":m '>-2<cr>gv=gv")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<C-u>zz")

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Switch panes (windows) using Ctrl + h/j/k/l
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set("i", "bb", "()", { noremap = true, silent = true })
vim.keymap.set("i", "bB", "{}", { noremap = true, silent = true })
vim.keymap.set("i", "<M-b>", "[]", { noremap = true, silent = true })

-- Map <F5> to run the build and launch the terminal in Lua
vim.api.nvim_set_keymap("n", "<leader>r", ":!./run.sh<CR>", { noremap = true, silent = true })
