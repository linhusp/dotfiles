-- NOTE: This file is only for core mappings/commands
local all_modes = { 'n', 'v', 'i', 't' }

-- General
G.map('n', '<leader>ls', ':update<CR>:so<CR>')
G.map('n', '<leader>w', ':w<CR>')
G.map('n', '<leader>r', ':restart<CR>')
G.map('n', '<leader>u', ':Undotree<CR>')
G.map('n', '<leader>o', '<C-^>')
G.map('n', '<leader>t', ':tabnew<CR>')

-- Delete trails
G.map({ 'n', 'v' }, '<leader>x', [[:s/\s\+$//e<CR>]], 'Delete trails')

-- Indent text block continually
G.map('v', '<', '<gv')
G.map('v', '>', '>gv')

-- Quickly selecting & changing buffer
-- NOTE: use mini.pick instead
-- map('n', '<leader>b', ':ls<CR>:b<space>')

-- Set CWD to buffer
G.map('n', '<leader>cd', ':cd %:p:h<CR>', 'Set CWD to buffer')

-- Jump to eol in insert mode
G.map('i', '<A-e>', '<C-o>A')

-- Jump to previous bracket (stupidly)
G.map('i', '<A-i>', [[<C-\><C-n>:call search('[{[(]', 'bes')<CR>a]])

-- Select the entire buffer, then jump back to previous position
G.map('n', '<leader>a', function()
    local pre_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '[vV\x16]*:*',
        once = true,
        callback = function()
            -- Only restore position if return to normal mode
            if
                vim.api.nvim_get_mode().mode == 'n'
                and vim.api.nvim_win_is_valid(0)
            then
                vim.api.nvim_win_set_cursor(0, pre_pos)
                vim.cmd('norm! zz') -- Also center the layout
            end
        end,
    })
    vim.cmd('norm! ggVG')
end, { desc = 'Select the entire buffer' })

-- Split line by coma, the reverse of J, with auto-indent (stupidly)
-- NOTE: use mini.splitjoin instead
-- G.map('v', 'gs', [[:s/,\zs\s*\ze\S/\r/ge|noh<CR>`[v`]=]], 'Split by comma')

-- Disable search highlighting
G.map('n', '<BS>', ':noh|normal!<C-l><CR>')

-- Copy/paste to system clipboard
G.map({ 'n', 'v' }, '<leader>y', '"+y')
G.map({ 'n', 'v' }, '<leader>Y', '"+Y')
G.map({ 'n', 'v' }, '<leader>p', '"+p')
G.map({ 'n', 'v' }, '<leader>P', '"+P')

-- Select lastest text block
G.map({ 'n', 'v' }, 'gV', '`[v`]', 'Select lastest block')

-- Enable `&` for other modes
G.map({ 'v', 'x' }, '&', ':&&<CR>')

-- Resize windows
G.map(all_modes, '<A-+>', '<Cmd>resize +5<CR>')
G.map(all_modes, '<A-->', '<Cmd>resize -5<CR>')
G.map(all_modes, '<A->>', '<Cmd>vertical resize +5<CR>')
G.map(all_modes, '<A-<>', '<Cmd>vertical resize -5<CR>')

-- Split windows to left/right/up/down
G.map(all_modes, '<A-H>', '<Cmd>wincmd H<CR>')
G.map(all_modes, '<A-J>', '<Cmd>wincmd J<CR>')
G.map(all_modes, '<A-K>', '<Cmd>wincmd K<CR>')
G.map(all_modes, '<A-L>', '<Cmd>wincmd L<CR>')

-- Maximize a window to width/height
G.map(all_modes, '<A-|>', '<Cmd>wincmd |<CR>')
G.map(all_modes, '<A-_>', '<Cmd>wincmd _<CR>')

-- Reset spliting
G.map(all_modes, '<A-=>', '<Cmd>wincmd =<CR>')

-- Jump half a creen up/down
G.map({ 'n', 'v' }, '<A-u>', '<C-u>')
G.map({ 'n', 'v' }, '<A-d>', '<C-d>')

-- Nagigate between windows in all modes except insert
G.map(all_modes, '<A-h>', '<C-\\><C-n><C-w>h')
G.map(all_modes, '<A-j>', '<C-\\><C-n><C-w>j')
G.map(all_modes, '<A-k>', '<C-\\><C-n><C-w>k')
G.map(all_modes, '<A-l>', '<C-\\><C-n><C-w>l')

-- Inspect highlighting
G.map('n', 'zs', '<Cmd>Inspect<CR>')
G.map('n', 'zt', '<Cmd>InspectTree<CR>')

-- Caching these at startup to parse string one time only
local stupid_cr = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
local smart_cr = vim.api.nvim_replace_termcodes('<CR><C-o>O', true, true, true)
local pairs = { ['{'] = '}', ['['] = ']', ['('] = ')' }

-- Better Smart-Enter
G.map('i', '<CR>', function()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local line = vim.api.nvim_get_current_line()
    local before = line:sub(col - 1, col - 1)
    local after = line:sub(col, col)
    if pairs[before] == after then return smart_cr end
    return stupid_cr -- Fallback
end, { expr = true, replace_keycodes = true, desc = 'Smart-Enter' })
