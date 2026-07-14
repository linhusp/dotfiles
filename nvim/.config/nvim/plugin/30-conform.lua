vim.pack.add({ G.gh .. 'stevearc/conform.nvim' })

-- Lazy conform
require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_organize_imports', 'ruff_format' },
        bash = { 'shellharden', 'shfmt' },
        sh = { 'shellharden', 'shfmt' },
        json = { 'biome' },
        javascript = { 'biome' },
        markdown = { 'prettier' },
        toml = { 'tombi' },
        css = { 'prettier' },
    },
    formatters = {
        stylua = { append_args = { '--column-width', '80' } },
        ruff_format = {
            append_args = {
                '--config',
                'line-length=80',
                '--config',
                'format.quote-style=\'single\'',
            },
        },
        shfmt = {
            append_args = {
                '-i',
                '4', -- Indent spaces
                '-ci', -- Indent switch cases
                '-bn', -- Binary operators start line
            },
        },
        biome = { append_args = { '--format-with-errors', 'true' } },
    },
})

G.map({ 'n', 'v' }, '<leader>gf', function()
    require('conform').format({ async = true, lsp_fallback = true })
end, 'Lazy Conform format')
