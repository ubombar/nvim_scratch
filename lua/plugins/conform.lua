return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- lazy-load before saving
	cmd = { "ConformInfo" },
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "golines", "gofmt" },
				rust = { "rustfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				ocaml = { "ocamlformat" },
				python = { "isort", "black" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				nix = { "nixpkgs_fmt" }, -- ✅ Nix formatter
			},
			--  Autoformat on save
			format_on_save = {
				lsp_fallback = true, -- use LSP formatter if no conform formatter
				timeout_ms = 3000,
			},

			-- Optional: customize formatter behavior
			formatters = {
				golines = {
					prepend_args = { "--max-len=120" },
				},
				prettier = {
					prepend_args = { "--tab-width", "2" },
				},
				ocamlformat = {
					command = "ocamlformat",
					args = { "--name", "$FILENAME", "-" },
					stdin = true,
				},
			},
		})
	end,
}
