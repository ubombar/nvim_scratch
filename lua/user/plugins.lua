local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Gruvbox: The theme
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- load before other plugins
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines
				contrast = "hard", -- "hard", "soft", or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})

			-- Apply the theme
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	-- Lualine: This is the bottom bar of vim.
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					icons_enabled = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	-- Bufferline: This adds tabs.
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons", -- optional, for icons
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- "tabs": show only tabpages; "buffers": show all buffers
					numbers = "none", -- show numbers: "none", "ordinal" (1,2,3), "buffer_id", or a function(bufnr)
					diagnostics = "nvim_lsp", -- show LSP diagnostics per buffer ("nvim_lsp" or "coc")
					separator_style = "thick", -- how separators between tabs look: "slant", "padded_slant", "thick", "thin", or { 'left', 'right' }
					show_buffer_close_icons = true, -- show little [x] per buffer
					show_close_icon = true, -- hide the global close icon (right corner)
				},
			})

			vim.keymap.set(
				"n",
				"<Tab>",
				"<cmd>BufferLineCycleNext<cr>",
				{ desc = "Next buffer" }
			)
			vim.keymap.set(
				"n",
				"<S-Tab>",
				"<cmd>BufferLineCyclePrev<cr>",
				{ desc = "Previous buffer" }
			)
		end,
	},
	-- Nvim-Tree: This is the side file exporer.
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 30,
					side = "left",
				},
				renderer = {
					highlight_git = true,
					icons = {
						show = {
							git = true,
							folder = true,
							file = true,
							folder_arrow = true,
						},
					},
				},
				filters = {
					dotfiles = false, -- hide dotfiles if true
				},
			})

			-- keymap to toggle tree
			vim.keymap.set(
				"n",
				"<leader>e",
				":NvimTreeToggle<CR>",
				{ desc = "Toggle file explorer" }
			)
		end,
	},
	-- Which-key: This adds the gey bindings as a popup.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup()
		end,
	},
	-- Telescope: This is the fuzzy finder.
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					layout_config = {
						horizontal = { prompt_position = "top" },
					},
					sorting_strategy = "ascending",
				},
			})

			-- Keymaps
			local builtin = require("telescope.builtin")
			vim.keymap.set(
				"n",
				"<leader>ff",
				builtin.find_files,
				{ desc = "Find files" }
			)
			vim.keymap.set(
				"n",
				"<leader>fg",
				builtin.live_grep,
				{ desc = "Live grep" }
			)
			vim.keymap.set(
				"n",
				"<leader>fb",
				builtin.buffers,
				{ desc = "Buffers" }
			)
			vim.keymap.set(
				"n",
				"<leader>fh",
				builtin.help_tags,
				{ desc = "Help tags" }
			)
		end,
	},
	-- Gitsigns: This is used to add git signs git blame etc.
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				signcolumn = true, -- Show git signs in the sign column
				numhl = false, -- Highlight numbers
				linehl = false, -- Highlight entire line
				word_diff = false, -- Highlight word changes inside lines
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with :Gitsigns toggle_current_line_blame
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})

			local gs = require("gitsigns")

			-- Keymaps
			vim.keymap.set("n", "]c", function()
				gs.next_hunk()
			end, { desc = "Next Git hunk" })
			vim.keymap.set("n", "[c", function()
				gs.prev_hunk()
			end, { desc = "Previous Git hunk" })
			vim.keymap.set(
				"n",
				"<leader>hs",
				gs.stage_hunk,
				{ desc = "Stage hunk" }
			)
			vim.keymap.set(
				"n",
				"<leader>hr",
				gs.reset_hunk,
				{ desc = "Reset hunk" }
			)
			vim.keymap.set(
				"n",
				"<leader>hp",
				gs.preview_hunk,
				{ desc = "Preview hunk" }
			)
			vim.keymap.set("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Git blame line (full)" })

			vim.keymap.set(
				"n",
				"<leader>ht",
				gs.toggle_current_line_blame,
				{ desc = "Toggle inline blame" }
			)
		end,
	},
	-- Treesitter: Make smart syntax highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- keep parsers up to date
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"python",
					"go",
					"rust",
					"javascript",
					"typescript",
					"html",
					"css",
					"json",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,              -- enable Tree-sitter highlighting
					additional_vim_regex_highlighting = false, -- disable regex highlighting
				},
				indent = {
					enable = true, -- better indentation
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>", -- start selection
						node_incremental = "<CR>", -- expand selection
						scope_incremental = "<S-CR>", -- expand to scope
						node_decremental = "<BS>", -- shrink selection
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- jump forward to textobj
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
					},
				},
			})
		end,
	},
	-- Comment: Adds <space>/ for comments.
	{
		"numToStr/Comment.nvim",
		config = function()
			local comment = require("Comment")
			comment.setup({})

			-- Keymaps
			vim.keymap.set("n", "<leader>/", function()
				require("Comment.api").toggle.linewise.current()
			end, { desc = "Toggle comment" })

			vim.keymap.set("v", "<leader>/", function()
				local esc =
					vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
				vim.api.nvim_feedkeys(esc, "nx", false)
				require("Comment.api").toggle.linewise(vim.fn.visualmode())
			end, { desc = "Toggle comment (visual)" })
		end,
	},
	-- LSPConfig: A helper for LSP configurations.
	{
		"neovim/nvim-lspconfig",
	},
	-- Mason: Used for installing LSPs.
	{
		"williamboman/mason.nvim",
	},
	-- LSPConfig: Used for configuring the language servers.
	{
		"williamboman/mason-lspconfig.nvim",
	},
	-- CMP: User for adding completions.
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
	},
	-- Lint: Used for linting stuff
	{
		"mfussenegger/nvim-lint",
	},
	-- Conform: User for custom formatting.
	{
		"stevearc/conform.nvim",
	},
	-- Autopairs: Closes paranthesis and quotes.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true, -- runs require("nvim-autopairs").setup({})
	},
	-- DAP: Debug Adapter Protocol for Go debugger.
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
		},
	},
	-- DAP-UI: Debug adapter ui.
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio", -- required
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			-- auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
		end,
	},
	-- ToggleTerm: Terminal inside vim.
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<C-\>]], -- toggle with Ctrl+\
				shade_terminals = true,
				shading_factor = 2,
				direction = "float", -- "horizontal" | "vertical" | "tab" | "float"
				float_opts = {
					border = "curved",
				},
			})

			local Terminal   = require("toggleterm.terminal").Terminal
			local float_term = Terminal:new({ hidden = true, direction = "float" })


			-- Open a *new* floating terminal (new tabbed instance)
			function NewTabTerm()
				local term = Terminal:new({ hidden = true, direction = "tab" })
				term:toggle()
			end

			-- Keymaps
			vim.keymap.set("n", "<leader>t", function()
				if not float_term:is_open() then
					float_term:toggle()
				end
			end, { desc = "Open floating terminal" })

			-- vim.keymap.set("n", "<Leader>T", NewTabTerm, { desc = "New tab terminal" })
			vim.keymap.set("n", "<leader>T", function()
				vim.cmd("enew") -- create a new empty buffer
				vim.cmd("term") -- open terminal inside it
				vim.cmd("startinsert") -- jump straight into insert mode
			end, { desc = "New terminal in new buffer" })

			vim.keymap.set({ "t", "n" }, "<Esc><Esc>", function()
				if float_term:is_open() then
					float_term:toggle()
				end
			end, { desc = "Hide floating terminal" })

			vim.keymap.set("t", "<Esc><Esc>", function()
				-- leave terminal insert mode
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
					"n",
					false
				)
				-- hide float if open
				if float_term:is_open() then
					float_term:toggle()
				end
			end, { desc = "Exit terminal mode and hide floating terminal" })
		end,
	}

})
