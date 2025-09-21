local mason = require("mason")
local mason_laspconfig = require("mason-lspconfig")

mason.setup()
mason_laspconfig.setup({
    ensure_installed = { "gopls" },
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

-- Configure gopls with new Neovim API
vim.lsp.config("gopls", {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
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

-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = { "go", "lua" },
    highlight = { enable = true },
})
