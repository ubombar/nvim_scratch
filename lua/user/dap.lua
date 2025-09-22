local dap = require("dap")
local dapgo = require("dap-go")
local dapui = require("dapui")

dapgo.setup() -- auto-sets delve adapter

-- Continue / Start
vim.keymap.set("n", "<Leader>dd", dap.continue, { desc = "DAP: Start/Continue Debugging" })
vim.keymap.set("n", "<Leader>dD", dap.terminate, { desc = "DAP: Terminate Debugging" })

-- Stepping
vim.keymap.set("n", "<Leader>dl", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<Leader>dj", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<Leader>dk", dap.step_out, { desc = "DAP: Step Out" })

-- Breakpoints
vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Conditional Breakpoint" })

-- UI controls
vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })

-- Debugging utilities
vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "DAP: Run Last Debug Session" })
