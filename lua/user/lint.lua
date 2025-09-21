local lint = require("lint")

lint.linters_by_ft = {
    -- python = { "ruff" }, -- or "flake8", "pylint"
    -- lua = { "luacheck" },
    -- go = { "golangci_lint" },
    -- rust = { "clippy" },
    -- javascript = { "eslint" },
    -- typescript = { "eslint" },
}

-- run lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
