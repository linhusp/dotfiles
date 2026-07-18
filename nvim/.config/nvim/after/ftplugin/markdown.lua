-- Attempt to add/remove strikethrough in markdown files
vim.api.nvim_create_user_command('ToggleStrike', function(cmd)
    local s = cmd.line1
    local e = cmd.line2

    local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
    local strike_count = 0

    -- Count lines wrapped in strikethrough
    for _, line in ipairs(lines) do
        if line:match('^%s*~~.*~~$') then strike_count = strike_count + 1 end
    end

    if strike_count == #lines then
        -- If all lines have it then remove it and keep indentation
        for i, line in ipairs(lines) do
            local indent, content = line:match('^([%s]*)~~(.*)~~$')
            if indent and content then lines[i] = indent .. content end
        end
    else
        -- If mixed/none then add it to the missing lines and keep indentation
        for i, line in ipairs(lines) do
            local indent, content = line:match('^([%s]*)(.*)$')
            if not line:match('^~~.*~~$') then
                lines[i] = indent .. '~~' .. content .. '~~'
            end
        end
    end

    vim.api.nvim_buf_set_lines(0, s - 1, e, false, lines)
end, { range = true })

G.map({ 'n', 'x' }, '<leader>ms', ':ToggleStrike<CR>')
