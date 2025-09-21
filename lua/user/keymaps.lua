local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- map(
--     "n",
--     "<leader>tt",
--     ":lua require('base46').toggle_transparency()<CR>",
--     { noremap = true, silent = true, desc = "Toggle Background Transparency" }
-- )

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- local gs = require("gitsigns")
--
-- -- Navigation between hunks
-- map("n", "]c", function()
--     gs.next_hunk()
-- end)
-- map("n", "[c", function()
--     gs.prev_hunk()
-- end)
-- map("n", "<leader>hs", gs.stage_hunk)
-- map("n", "<leader>hr", gs.reset_hunk)
-- map("n", "<leader>hp", gs.preview_hunk)
-- map("n", "<leader>hb", function()
--     gs.blame_line({ full = true })
-- end)
-- map("n", "<leader>ht", gs.toggle_current_line_blame)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })

-- Resize splits with arrows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map(
    "n",
    "<C-Left>",
    ":vertical resize -2<CR>",
    { desc = "Decrease window width" }
)
map(
    "n",
    "<C-Right>",
    ":vertical resize +2<CR>",
    { desc = "Increase window width" }
)

-- Buffer management
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- File explorer (assuming nvim-tree)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Quick save/quit
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>x", ":x<CR>", { desc = "Save & Quit" })

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlight on <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

