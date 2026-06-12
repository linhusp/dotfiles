-- NOTE: Only for core mappings/commands
-- General
G.map('n', '<leader>so', ':update<CR>:so<CR>')
G.map('n', '<leader>w', ':w<CR>')
G.map('n', '<leader>r', ':restart<CR>')
-- G.map('n', '<leader>e', ':Explore<CR>')
G.map('n', '<leader>u', ':Undotree<CR>')
G.map('n', '<leader>o', '<C-^>')

-- Delete trailing whitespaces
G.map(
    { 'n', 'v', 'x' },
    '<leader>x',
    [[:s/\s\+$//e<CR>]],
    'Delete trailing whitespaces'
)

-- Indent text block continually
G.map('v', '<', '<gv')
G.map('v', '>', '>gv')

-- Quickly selecting & changing buffer
-- NOTE: better use a file picker plugin instead
-- map('n', '<leader>b', ':ls<CR>:b<space>')

-- CD to current buffer
G.map('n', '<leader>cd', ':cd %:p:h<CR>', 'CD to where the current buffer is')

-- Jump to eol in insert mode
G.map('i', '<A-e>', '<C-\\><C-n>A')

-- Jump to previous bracket (stupidly)
G.map('i', '<A-i>', [[<C-\><C-n> :call search('[{[(]', 'bes')<CR>a]])

-- Select the entire buffer
G.map('', '<leader>a', '<C-\\><C-n>ggVG<CR>')

-- Split line by coma, the reverse of J, with auto-indent (stupidly)
G.map(
    { 'n', 'v' },
    '<leader>sj',
    [[:s/,\zs\s*\ze\S/\r/ge|noh<CR>`[v`]=]],
    'Split lines by comma with auto-indent (stupidly)'
)

-- Move a line up/down conveniently
G.map('v', 'J', [[:m '>+1<CR>gv=gv]], 'Move a line up one line')
G.map('v', 'K', [[:m '>-2<CR>gv=gv]], 'Move a line down one line')

-- Tabs
G.map('n', '<leader>t', ':tabnew<CR>')

-- Disable search highlighting
G.map('n', '<BS>', ':noh|normal!<C-l><CR>')

-- Copy/paste to system clipboard
G.map({ 'n', 'v' }, '<leader>y', '"+y')
G.map({ 'n', 'v' }, '<leader>Y', '"+Y')
G.map({ 'n', 'v' }, '<leader>p', '"+p')
G.map({ 'n', 'v' }, '<leader>P', '"+P')

-- Select lastest text block
G.map('', 'gV', '`[v`]', 'Select lastest block')

-- Enable `&` for other modes
G.map({ 'v', 'x' }, '&', ':&&<CR>')

-- Alternating a bunch of `<C-w>...` movements into <A-...> instead:
------ Resize windows
G.map('', '<A-+>', ':resize +5<CR>')
G.map('', '<A-->', ':resize -5<CR>')
G.map('', '<A->>', ':vertical resize +5<CR>')
G.map('', '<A-<>', ':vertical resize -5<CR>')

------ Split windows to left/right/up/down
G.map('', '<A-H>', '<C-w>H')
G.map('', '<A-J>', '<C-w>J')
G.map('', '<A-K>', '<C-w>K')
G.map('', '<A-L>', '<C-w>L')

------ Maximize a window to width/height
G.map('', '<A-|>', '<C-w>|')
G.map('', '<A-_>', '<C-w>_')

------ Reset spliting
G.map('', '<A-=>', '<C-w>=')

------ Jump half a creen up/down
G.map('', '<A-u>', '<C-u>')
G.map('', '<A-d>', '<C-d>')

-- Swapping windows vertically to horizontally and viceversa
G.map('', '<leader>[', '<C-w>t<C-w>K')
G.map('', '<leader>]', '<C-w>t<C-w>H')

-- Nagigate between windows in all modes
G.map('', '<A-h>', '<C-\\><C-n><C-w>h')
G.map('', '<A-j>', '<C-\\><C-n><C-w>j')
G.map('', '<A-k>', '<C-\\><C-n><C-w>k')
G.map('', '<A-l>', '<C-\\><C-n><C-w>l')

-- Inspect highlighting
G.map('n', 'zs', ':Inspect<CR>')
G.map('n', 'zt', ':InspectTree<CR>')

-- Stupidly Smart-Enter inside a bracket
-- G.map('i', '<A-o>', [[<CR><C-\><C-n>O]], opts)

-- Better Smart-Enter
G.map('i', '<CR>', function()
    local col = vim.fn.col('.')
    local line = vim.api.nvim_get_current_line()
    local before = line:sub(col - 1, col - 1)
    local after = line:sub(col, col)
    local pairs = { ['{'] = '}', ['['] = ']', ['('] = ')' }

    if pairs[before] == after then
        return vim.api.nvim_replace_termcodes('<CR><C-o>O', true, true, true)
    end

    -- Fallback
    return vim.api.nvim_replace_termcodes('<CR>', true, true, true)
end, { expr = true, replace_keycodes = true })
