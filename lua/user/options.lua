local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

-- to enable cursorline
o.cursorlineopt = "both"

-- Set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true

-- You can also add relative line numbers, to help with jumping
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
--  Schedule the setting after `UiEnter` because it can increase startup-time
--  Remove this option if you want your OS clipboard to remain independent
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
	tab = "⇥ ",
	trail = "·",
	nbsp = "␣",
}
-- vim.opt.listchars = {
-- 	tab = "⇥ ",
-- 	trail = "·",
-- 	nbsp = "␣",
-- 	eol = "↵",
-- 	extends = ">",
-- 	precedes = "<",
-- 	conceal = "¤",
-- 	unprintable = "?",
-- }

-- Preview substitutions live, as you type
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Make the bar full width
vim.opt.laststatus = 3

-- Hide command line bar
vim.opt.cmdheight = 0

-- Flashes the text on a yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup(
		"kickstart-highlight-yank",
		{ clear = true }
	),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
})
