return {
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
