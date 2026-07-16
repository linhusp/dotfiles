vim.pack.add({
    G.gh .. 'nvim-mini/mini.pick',
    G.gh .. 'nvim-mini/mini.comment',

    -- * va)at - select both around `)` and around the next tag
    -- * yinq - yank inside the next quote
    -- * g[f - go to the nearest function quote
    -- * cila - change the inner of last argument
    G.gh .. 'nvim-mini/mini.ai',

    -- * gS - to toggle
    G.gh .. 'nvim-mini/mini.splitjoin',
})

local pick = require('mini.pick')
local win_center = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)
    return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
    }
end

pick.setup({
    window = { config = win_center },
})

-- Custom the default files picker:
-- * replacing `rg` for `fd` for better syntax and matching
-- * be able to both picking hidden files and ingoring `.git/`
-- * to resolve symlinks to files
-- * to sort results
pick.registry.files = function()
    local cmd = 'fd -t f -t l -H -E .git -E .var'
    if vim.fn.getcwd() == vim.fn.expand('~') then
        cmd = cmd .. ' --max-depth 1'
    end
    cmd = cmd .. '| sort'
    pick.start({
        source = { items = vim.fn.systemlist(cmd), name = 'Files (fd)' },
    })
end

G.map('n', '<leader>f', '<Cmd>Pick files<CR>', 'Pick files')
G.map('n', '<leader>b', '<Cmd>Pick buffers<CR>', 'Pick buffers')
G.map('n', '<leader>gs', '<Cmd>Pick grep_live<CR>', 'Pick grep')

require('mini.comment').setup({ options = { ignore_blank_line = true } })
require('mini.ai').setup()
require('mini.splitjoin').setup()
