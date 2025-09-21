local map = vim.keymap.set

-- Enter command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Easy exit on insert mode
map("i", "jk", "<ESC>")

-- Save the buffer
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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

-- Splits
map("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })
map("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" })

-- Buffer management
map("n", "<leader>bn", ":enew<CR>", { desc = "New empty buffer" })
map("n", "<leader>bb", ":buffers<CR>", { desc = "List buffers" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Quick save/quit
map("n", "<leader>W", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q!<CR>", { desc = "Quit" })
map("n", "<leader>X", function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- Go to next buffer first
    if vim.fn.bufnr("$") > 1 then
        vim.cmd("bnext")
    else
        vim.cmd("enew") -- if it's the only buffer, open a new empty one
    end

    -- If buffer is modified, force delete
    if vim.bo[bufnr].modified then
        vim.cmd("bd! " .. bufnr)
    else
        vim.cmd("bd " .. bufnr)
    end
end, { desc = "Close buffer and go to next (force if unsaved)" })
map("n", "<leader>x", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd("bnext") -- go to next buffer (wraps around if last)
    vim.cmd("bd " .. bufnr) -- delete the old one
end, { desc = "Close buffer and go to next" })
map(
    "n",
    "<leader>n",
    ":enew<CR>",
    { noremap = true, silent = true, desc = "New buffer" }
)

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlight on <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
