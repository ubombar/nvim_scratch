return {
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
	-- Which-key: This adds the gey bindings as a popup.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup()
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
}
