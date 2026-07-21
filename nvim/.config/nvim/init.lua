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
G.ag = vim.api.nvim_create_augroup('NvimOptions', { clear = true })

-- Options -----------------------------------------------------------
vim.o.undofile = true -- Persistent undo
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true -- Enable current line highlighting
vim.o.cursorlineopt = 'number' -- Highlight the current line number
vim.o.guicursor = vim.o.guicursor
    .. ',n-v-c:block-blinkon0,i:block-blinkwait175-blinkon175-blinkoff150'
vim.o.scrolloff = 6
vim.o.pumborder = 'single'
vim.o.winborder = 'single'
vim.o.splitright = true
vim.o.laststatus = 2 -- Always show status
vim.o.shortmess = vim.o.shortmess .. 'acI' -- Less words, no intro
vim.o.mousemodel = 'extend' -- Mouse, but why?
vim.o.list = true
vim.o.listchars = 'tab:· ,trail:~,extends:>,precedes:<,nbsp:%'
vim.o.fillchars = 'eob: '
vim.o.smartindent = true
vim.o.expandtab = true -- Turn tabs to spaces
vim.o.tabstop = 4 -- Show tab as 4 spaces
vim.o.softtabstop = 4
vim.o.shiftwidth = 4 -- Use 4 spaces to indent
vim.o.wrap = true
vim.o.linebreak = true -- Wrap lines
vim.o.breakindent = true -- Indent wrapped line
vim.o.ttimeoutlen = 10 -- Make neovim evalute escape aggesively
vim.o.formatoptions = vim.o.formatoptions .. 'n1'
vim.o.ignorecase = true
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.inccommand = 'split' -- Create a split preview for substitution

-- Builtin modules ---------------------------------------------------
vim.cmd.packadd('nvim.undotree')

-- Minimal lazied ----------------------------------------------------
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

-- Minimal plugins ---------------------------------------------------
vim.pack.add({
    G.gh .. 'arborist-ts/arborist.nvim',
    G.gh .. 'nvimdev/indentmini.nvim',
    G.gh .. 'stevearc/oil.nvim',
    G.gh .. 'shortcuts/no-neck-pain.nvim',
    G.gh .. 'josstei/whisk.nvim',
})

require('arborist').setup({
    update_cadence = 'manual',
    disable = { indent = { 'xml' } },
    ignore = { 'ini', 'conf', 'no-neck-pain', 'PKGBUILD' },
})
require('indentmini').setup({
    char = '|',
    exclude = { 'markdown' },
    minlevel = 2,
})
require('oil').setup({ default_file_explorer = true, delete_to_trash = true })
require('no-neck-pain').setup({
    width = 85,
    buffers = { right = { enabled = false } },
    colors = { blend = -0.1 },
})
require('whisk').setup()

G.map('n', '<leader>e', '<Cmd>Oil<CR>')
G.map('n', '<leader><Tab>', '<Cmd>NoNeckPain<CR>')

-- LSP ---------------------------------------------------------------
vim.pack.add({
    G.gh .. 'neovim/nvim-lspconfig',
    G.gh .. 'mason-org/mason.nvim',
})

require('mason').setup()
vim.lsp.enable({ 'lua_ls', 'pyrefly', 'bashls', 'qmlls', 'gopls' })

G.map('n', '<leader>vl', function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
end, { desc = 'Toggle diagnostic virtual lines' })
G.map('n', '<leader>lf', vim.lsp.buf.format, 'LSP format buffer')
G.map('n', '<leader>d', vim.diagnostic.open_float, 'Show diagnostics')

-- Force lsp semantic highlights to be below treesitter
-- vim.hl.priorities.semantic_tokens = 95

-- Autocommands ------------------------------------------------------

-- Disable the annoying auto-commenting on new line
vim.api.nvim_create_autocmd('FileType', {
    group = G.ag,
    pattern = '*',
    command = 'setlocal formatoptions-=ro',
})

-- Filetype detection
vim.filetype.add({ extension = { ini = 'conf' } })

-- Terminal
vim.api.nvim_create_autocmd('TermOpen', {
    group = G.ag,
    pattern = '*',
    command = 'setlocal nonumber norelativenumber signcolumn=no',
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = G.ag,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Auto set cwd when nvim open the first time, if possible
vim.api.nvim_create_autocmd('BufEnter', {
    group = G.ag,
    once = true,
    callback = function()
        local target = vim.api.nvim_buf_get_name(0)
        if target == '' then return end

        -- Check for 'oil://' prefix and turn it into standard path
        if target:sub(1, 6) == 'oil://' then target = target:sub(7) end

        local is_dir = function(path)
            local stat = vim.uv.fs_stat(path)
            return stat and stat.type == 'directory'
        end

        if not is_dir(target) then target = vim.fs.dirname(target) end
        if is_dir(target) then vim.api.nvim_set_current_dir(target) end
    end,
})
