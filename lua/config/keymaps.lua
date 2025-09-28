-- Easy exit on insert mode
vim.keymap.set("i", "jk", "<ESC>")

-- Quick exit the terminal floating window
-- vim.keymap.set("t", "<C-w>q", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })

-- Resize splits with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer management
vim.keymap.set("n", "<leader>x", function()
	if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
		vim.cmd("b# | bd#")
	else
		vim.cmd("enew")
		vim.cmd("bd#")
	end
end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Delete
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Enable cycling the buffers using tab and shift tab

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Gitsigns
vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>", { desc = "Next Git hunk" })
vim.keymap.set("n", "[c", ":Gitsigns prev_hunk<CR>", { desc = "Previous Git hunk" })
vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>", { desc = "Git blame line (full)" })
vim.keymap.set("n", "<leader>ht", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle inline blame" })

-- Next and previous diagnostic (any severity)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
