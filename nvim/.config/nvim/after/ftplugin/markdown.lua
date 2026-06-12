-- Attempt to add/remove strikethrough in markdown files
G.map(
    { 'v', 'x' },
    '<leader>ms',
    [[:s/^/\~\~/<CR>gv:s/$/\~\~/<CR>:noh<CR>]],
    'Add strikethrough to a block in markdown'
)
G.map(
    { 'v', 'x' },
    '<leader>mS',
    [[:s/^\~\~\(.*\)\~\~$/\1/<CR>:noh<CR>]],
    'Remove strikethrough from a block in markdown'
)
