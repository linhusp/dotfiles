-- General
vim.o.undofile = true -- Persistent undo
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true -- Enable current line highlighting
vim.o.cursorlineopt = 'number' -- Highlight the current line number
vim.o.guicursor = '' -- Let the terminal renders the cursor
vim.o.scrolloff = 6
vim.o.pumborder = 'single'
vim.o.winborder = 'single'
-- vim.o.splitbelow = true
-- vim.o.splitright = true
-- vim.o.pumheight = 10 -- Make popup menu smaller
-- vim.o.pummaxwidth = 100 -- Make popup menu not too wide
vim.o.laststatus = 2 -- Always show status
vim.opt.shortmess:append('ac')

-- Text indicators
vim.o.list = true
vim.o.listchars = 'tab:|.,trail:~,extends:>,precedes:<,nbsp:%'
vim.o.fillchars = 'eob: '

-- Text editing
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true -- Turn tabs to spaces
vim.o.tabstop = 4 -- Show tab as 4 spaces
vim.o.softtabstop = 4
vim.o.shiftwidth = 4 -- Use 4 spaces to indent
vim.o.wrap = true
vim.o.linebreak = true -- Wrap lines
vim.o.breakindent = true -- Indent wrapped line
vim.o.textwidth = 80
-- vim.cmd('set formatoptions+=tcnl1qj')

-- Searching and Substitution
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.inccommand = 'split' -- Create a split preview for substitution

-- Disable builtin completion (should I do that?)
-- vim.opt.complete = ''
-- vim.opt.completeopt = ''

-- Mouse, but why?
vim.o.mousemodel = 'extend'

-- Make lsp semantic highlighting always below treesitter
-- vim.hl.priorities.semantic_tokens = 95

-- Disable the annoying auto-commenting on new line
vim.cmd('autocmd BufEnter * set formatoptions-=ro')

-- Filetype autocmds
vim.cmd('autocmd BufNewFile,BufRead *.ini set ft=conf')
vim.cmd([[autocmd BufnewFile,BufRead *.conf set commentstring=#\ %s]])

-- Terminal
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no')

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- CWD when nvim a dir/file from the terminal
vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('CwdVimEnter', { clear = true }),
    callback = function()
        local target = vim.fn.argv()[1]

        if type(target) ~= 'string' then
            return
        end

        if vim.fn.isdirectory(target) ~= 1 then
            -- vim.fn.input(vim.inspect(target))
            local parent = vim.fs.dirname(target)

            if vim.fn.isdirectory(parent) ~= 1 then
                return
            end

            target = parent
        end

        vim.fn.chdir(target)
    end,
})
