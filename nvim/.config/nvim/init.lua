vim.g.netrw_liststyle = 3 -- Tree style listing
vim.g.python3_host_prog = '/usr/bin/python'
vim.g.mapleader = ' '

vim.cmd('filetype plugin indent on')

_G.G = {} -- Global table to reuse things

G.map = function(modes, lhs, rhs, desc_and_opts)
    local opts = { silent = true }
    if type(desc_and_opts) == 'string' then
        opts.desc = desc_and_opts
    elseif type(desc_and_opts) == 'table' then
        opts = vim.tbl_extend('force', opts, desc_and_opts)
    end
    vim.keymap.set(modes, lhs, rhs, opts)
end

G.lazy = function(pack_name, mod_name, opts)
    if not package.loaded[mod_name] then
        vim.cmd.packadd(pack_name)
        require(mod_name).setup(opts or {})
    end
end

G.gh = 'https://github.com/'

-- --- Builtin modules -----------------------------------------------
vim.cmd.packadd('nvim.undotree')

-- --- Minimal lazied plugins ----------------------------------------
vim.g.prosession_dir = vim.fn.stdpath('cache') .. '/sessions'
vim.g.prosession_on_startup = 0
vim.pack.add({ G.gh .. 'tpope/vim-obsession' })
vim.pack.add({
    G.gh .. 'dhruvasagar/vim-prosession',
    G.gh .. 'catgoose/nvim-colorizer.lua',
}, { load = function() end })

G.map('n', '<leader>s', function()
    if vim.fn.exists(':Prosession') == 0 then
        vim.cmd.packadd('vim-prosession')
    end
    vim.cmd('Prosession')
end, { desc = 'Cmd Prosession' })

G.map('n', '<leader>cl', function()
    G.lazy('nvim-colorizer.lua', 'colorizer', {})
    vim.cmd('ColorizerToggle')
end, { desc = 'Cmd ColorizerToggle' })

-- --- Minimal plugins -----------------------------------------------
vim.pack.add({
    G.gh .. 'arborist-ts/arborist.nvim',
    G.gh .. 'j-hui/fidget.nvim',
    G.gh .. 'nvimdev/indentmini.nvim',
    G.gh .. 'stevearc/oil.nvim',
    G.gh .. 'shortcuts/no-neck-pain.nvim',
})

require('arborist').setup({
    update_cadence = 'manual',
    disable = { indent = { 'xml' } },
    ignore = { 'ini', 'conf', 'no-neck-pain' },
})

require('fidget').setup({ progress = { suppress_on_insert = true } })
require('indentmini').setup({ exclude = { 'markdown' }, minlevel = 2 })
require('oil').setup({ default_file_explorer = false, delete_to_trash = true })

require('no-neck-pain').setup({
    width = 85,
    buffers = { right = { enabled = false } },
    colors = { blend = -0.1 },
})

G.map('n', '<leader>e', ':Oil<CR>', 'Open parent directory')
G.map('n', '<leader><Tab>', ':NoNeckPain<CR>', 'Cmd NoNeckPain')

-- --- LSP stuff -----------------------------------------------------
vim.pack.add({
    G.gh .. 'neovim/nvim-lspconfig',
    G.gh .. 'mason-org/mason.nvim',
})

require('mason').setup()

-- Ensure installed
-- 'lua_ls', 'stylua', 'pyrefly', 'ruff', 'bashls', 'shellcheck',
-- 'shellharden', 'shfmt', 'biome', 'prettier', 'tombi',
vim.lsp.enable({ 'lua_ls', 'pyrefly', 'bashls', 'qmlls' })

G.map('n', '<leader>vl', function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
end, { desc = 'Toggle diagnostic virtual lines' })
G.map('n', '<leader>lf', vim.lsp.buf.format, 'LSP format buffer')
G.map('n', '<leader>d', vim.diagnostic.open_float, 'Show diagnostics')

-- Force lsp semantic highlights to be below treesitter
-- vim.hl.priorities.semantic_tokens = 95
