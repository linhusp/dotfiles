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
pick.setup()

-- Custom the default files picker:
-- * replacing `rg` for `find` for better syntax and matching
-- * be able to both picking hidden files and ingoring `.git/`
-- * to resolve symlinks to files
-- * to sort results
pick.registry.files = function()
    -- local items = vim.fn.systemlist('fd -t f -H -E .git | sort')
    -- pick.start({ source = { items = items, name = 'Files (Sorted)' } })

    local cmd = [[
        find . -name .git -prune \
            -o \( -type f -o -type l -xtype f \) \
            -printf "%P\n" \
        | sort
    ]]

    pick.start({
        source = { items = vim.fn.systemlist(cmd), name = 'Files (Custom)' },
    })
end

G.map('n', '<leader>f', ':Pick files<CR>', 'Pick files')
G.map('n', '<leader>b', ':Pick buffers<CR>', 'Pick buffers')
G.map('n', '<leader>gs', ':Pick grep_live<CR>', 'Pick grep')

require('mini.comment').setup({ options = { ignore_blank_line = true } })
require('mini.ai').setup()
require('mini.splitjoin').setup()
