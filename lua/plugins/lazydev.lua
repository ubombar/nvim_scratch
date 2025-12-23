return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig", -- Core LSP client
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- LSP/DAP/linter installer
			{ "williamboman/mason-lspconfig.nvim" }, -- Mason <-> LSP bridge
		},
	},
	{
		"nvimtools/none-ls.nvim", -- successor of null-ls
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				-- sources = {
				-- 	-- Formatters
				-- 	null_ls.builtins.formatting.stylua, -- Lua
				-- 	null_ls.builtins.formatting.rustfmt, -- Rust
				-- 	null_ls.builtins.formatting.gofmt, -- Go
				-- 	null_ls.builtins.formatting.prettier, -- JS/TS
				-- 	null_ls.builtins.formatting.ocamlformat, -- OCaml
				-- 	null_ls.builtins.formatting.nixpkgs_fmt, -- Nix
				-- 	null_ls.builtins.formatting.shfmt, -- Shell (sh/zsh/bash)
				--
				-- 	-- Linters (optional)
				-- 	null_ls.builtins.diagnostics.eslint, -- JS/TS
				-- 	null_ls.builtins.diagnostics.shellcheck, -- Shell linting
				-- 	null_ls.builtins.code_actions.shellcheck, -- Opti
				-- },
				sources = {
					-- ✅ Formatters
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.gofmt, -- Go
					null_ls.builtins.formatting.prettier, -- JS/TS
					null_ls.builtins.formatting.ocamlformat, -- OCaml
					null_ls.builtins.formatting.nixpkgs_fmt, -- Nix
					null_ls.builtins.formatting.shfmt, -- Shell

					-- ✅ Linters
					null_ls.builtins.diagnostics.golangci_lint, -- Go (THIS is what you want)
					null_ls.builtins.diagnostics.eslint, -- JS/TS (requires eslint binary)
					null_ls.builtins.diagnostics.shellcheck, -- Shell linting
					null_ls.builtins.code_actions.shellcheck, -- Shell code actions
				},
			})
		end,
	},
}
