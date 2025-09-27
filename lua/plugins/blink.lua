return {
	{
		"L3MON4D3/LuaSnip",
		keys = {}
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("blink.cmp").setup({
				fuzzy = { implementation = "lua" },
				keymap = {
					-- Built-in preset: gives you common sensible defaults
					preset = "default",

					-- Or customize manually if you want finer control:
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<CR>"] = { "accept", "fallback" }, -- Enter accepts the current item
				},
			})
		end,
		opts = {
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
	-- {
	-- 	"saghen/blink.cmp",
	-- 	dependencies = {
	-- 		"rafamadriz/friendly-snippets",
	-- 	},
	-- 	version = "1.*",
	-- 	config = function()
	-- 		require("blink.cmp").setup({
	-- 			snippets = { preset = "luasnip" },
	-- 			signature = { enabled = true },
	-- 			appearance = {
	-- 				use_nvim_cmp_as_default = false,
	-- 				nerd_font_variant = "normal",
	-- 			},
	-- 			sources = {
	-- 				default = { "lsp", "path", "snippets", "buffer" },
	-- 				providers = {
	-- 					cmdline = {
	-- 						min_keyword_length = 2,
	-- 					},
	-- 				},
	-- 			},
	-- 			keymap = {
	-- 				["<C-f>"] = {},
	-- 			},
	-- 			cmdline = {
	-- 				enabled = false,
	-- 				completion = { menu = { auto_show = true } },
	-- 				keymap = {
	-- 					["<CR>"] = { "accept_and_enter", "fallback" },
	-- 				},
	-- 			},
	-- 			completion = {
	-- 				menu = {
	-- 					border = nil,
	-- 					scrolloff = 1,
	-- 					scrollbar = false,
	-- 					draw = {
	-- 						columns = {
	-- 							{ "kind_icon" },
	-- 							{ "label",      "label_description", gap = 0 },
	-- 							{ "kind" },
	-- 							{ "source_name" },
	-- 						},
	-- 					},
	-- 				},
	-- 				documentation = {
	-- 					window = {
	-- 						border = nil,
	-- 						scrollbar = false,
	-- 						winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
	-- 					},
	-- 					auto_show = true,
	-- 					auto_show_delay_ms = 500,
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		require("luasnip.loaders.from_vscode").lazy_load()
	-- 	end,
	-- },
}
