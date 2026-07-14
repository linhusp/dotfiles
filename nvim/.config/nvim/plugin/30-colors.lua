vim.pack.add({
    G.gh .. 'xero/miasma.nvim',
    G.gh .. 'sainnhe/everforest',
    G.gh .. 'sainnhe/gruvbox-material',
})

-- Local plugins at .. /pack/me/opt
vim.cmd.packadd('dau-xanh.nvim')
vim.g.dauxanh_transparent_background = false

vim.cmd.colorscheme('dau-xanh')
