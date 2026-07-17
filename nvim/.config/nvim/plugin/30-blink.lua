vim.pack.add({
    G.gh .. 'rafamadriz/friendly-snippets',
    G.gh .. 'saghen/blink.lib',
    G.gh .. 'saghen/blink.cmp',
})

local completion = {
    ghost_text = { enabled = true, show_with_menu = true },
    documentation = { auto_show = true },
    accept = { auto_brackets = { enabled = false } },
    menu = {
        auto_show = false,

        -- Custom completion menu
        draw = {
            columns = {
                { 'label', 'label_description', gap = 1 },
                { 'kind' },
                { 'source_name' },
            },
            components = {
                source_name = {
                    -- Reduce length of source_name
                    text = function(ctx)
                        local alias = {
                            LSP = 'LSP',
                            Path = 'Path',
                            Snippets = 'Snip',
                            Buffer = 'Buf',
                            Cmdline = 'Cmd',
                        }
                        return alias[ctx.source_name]
                    end,
                },
            },
        },
    },
}

-- Enable signature help but don't show it automatically
local signature = { enabled = true, trigger = { enabled = false } }

local sources = {
    min_keyword_length = 2,

    -- Dynamically picking providers by treesitter node/ft
    default = function(_)
        local success, node = pcall(vim.treesitter.get_node)
        if
            success
            and node
            and vim.tbl_contains(
                { 'comment', 'line_comment', 'block_comment' },
                node:type()
            )
        then
            return { 'buffer' }
        else
            return { 'lsp', 'path', 'snippets', 'buffer' }
        end
    end,

    -- Hide snippets after trigger characters
    providers = {
        snippets = {
            should_show_items = function(ctx)
                return ctx.trigger.initial_kind ~= 'trigger_character'
            end,
        },
    },
}

local keymap = {
    ['<A-f>'] = { 'select_and_accept', 'fallback' },
    ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
    ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
}

local cmdline = {
    completion = { menu = { auto_show = false } },
    keymap = {
        ['<A-f>'] = { 'select_and_accept', 'fallback' },
        ['<CR>'] = { 'accept_and_enter', 'fallback' },
    },
}

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
    completion = completion,
    sources = sources,
    signature = signature,
    keymap = keymap,
    cmdline = cmdline,
})
