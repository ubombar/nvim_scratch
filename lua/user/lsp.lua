local mason = require("mason")
local mason_laspconfig = require("mason-lspconfig")

mason.setup()
mason_laspconfig.setup({
	ensure_installed = {
		"gopls",   -- Go
		"pyright", -- Python
		"lua_ls",  -- Lua
		"rust_analyzer", -- Rust
		"vtsls",   -- TypeScript/JavaScr
		"nil_ls",  -- Nixipt
	},
})

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item({
			behavior = cmp.SelectBehavior.Insert,
		}),
		["<S-Tab>"] = cmp.mapping.select_prev_item({
			behavior = cmp.SelectBehavior.Insert,
		}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

-- LSP capabilities (for completion)
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
)

local function common_on_attach(client, bufnr)
	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {
		buffer = bufnr,
		silent = true,
		noremap = true,
		desc = "LSP: Go to definition",
	})
	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {
		buffer = bufnr,
		silent = true,
		noremap = true,
		desc = "LSP: Go to declaration",
	})
	vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {
		buffer = bufnr,
		silent = true,
		noremap = true,
		desc = "LSP: List references",
	})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {
		buffer = bufnr,
		silent = true,
		noremap = true,
		desc = "LSP: Hover documentation",
	})
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {
		buffer = bufnr,
		silent = true,
		noremap = true,
		desc = "LSP: Rename symbol",
	})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
		buffer = bufnr,
		silent = true,
		noremap = true,
		desc = "LSP: Code actions",
	})

	-- format on save, enable if the lsp supports it by default
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

-- Configure LSPs with new Neovim API
vim.lsp.config("gopls", {
	capabilities = capabilities,
	on_attach = common_on_attach,
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			completeUnimported = true,
			hints = {
				assignVariableTypes = true,
				parameterNames = true,
			},
		},
	},
})

vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = common_on_attach,
	settings = {
		python = {
			analysis = {
				autoImportCompletions = true,
				typeCheckingMode = "basic",
			},
		},
	},
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = common_on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
				},
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	on_attach = common_on_attach,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = true,
			diagnostics = { enable = true },
		},
	},
})

vim.lsp.config("vtsls", {
	capabilities = capabilities,
	on_attach = common_on_attach,
	settings = {
		typescript = { inlayHints = { parameterNames = { enabled = "all" } } },
	},
})

vim.lsp.config("nil_ls", {
	capabilities = capabilities,
	on_attach = common_on_attach,
	settings = {
		["nil"] = {
			formatting = {
				command = { "alejandra" }, -- or "alejandra", "nixfmt", etc.
			},
		},
	},
})

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "lua", "rust", "ocaml", "javascript" },
	highlight = { enable = false },
})
