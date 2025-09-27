return {
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


}
