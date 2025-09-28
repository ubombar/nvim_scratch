vim.lsp.enable({
	"gopls", -- Go
	"rust_analyzer", -- Rust
	"ts_ls", -- TypeScript / JavaScript
	"ocamllsp", -- OCaml
	"lua_ls", -- Lua
	"pyright", -- Python
	"nil", -- Nix Language
	"beautysh", -- Zsh and Bash
})

vim.diagnostic.config({
	-- Show diagnostics as virtual text (inline)
	virtual_text = {
		prefix = "●", -- or '■', '▎', ''
		spacing = 2,
	},

	-- Show virtual lines (Neovim ≥0.10)
	virtual_lines = false, -- true if you prefer separate lines under code

	-- Underline problematic code
	underline = true,

	-- Don't update diagnostics while typing
	update_in_insert = false,

	-- Sort diagnostics by severity
	severity_sort = true,

	-- Floating window config (for `vim.diagnostic.open_float()`)
	float = {
		border = "rounded",
		source = true, -- show source in diagnostic popup
		header = "",
		prefix = "",
	},

	-- Gutter signs (left column icons)
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})
