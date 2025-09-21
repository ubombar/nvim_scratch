require("conform").setup({
    formatters_by_ft = {
        python = { "black" }, -- or "ruff_format"
    },
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
