-- General
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

-- Text indicators and editing
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

-- vim.cmd('set formatoptions+=tcnl1qj')

-- Searching and Substitution
vim.o.ignorecase = true
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.inccommand = 'split' -- Create a split preview for substitution

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
