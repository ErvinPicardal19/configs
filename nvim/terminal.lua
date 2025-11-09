local function toggle_bottom_terminal()
    local current_tab_wins = vim.api.nvim_tabpage_list_wins(0)

    -- Iterate over all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
            -- Terminal buffer exists, switch to its window
            for _, win in ipairs(current_tab_wins) do
                if vim.api.nvim_win_get_buf(win) == buf then
                    vim.api.nvim_set_current_win(win)
                    return
                end
            end
        end
    end

    -- No terminal found, open a new one at bottom
    vim.cmd("set winheight=38")
    vim.cmd("botright split | terminal")
end

vim.keymap.set({ 'n' }, '<C-\\>', function()
	toggle_bottom_terminal()
	vim.cmd('startinsert')
end, {desc = "Bottom Terminal"})

vim.keymap.set('t', '<C-\\>', '<C-\\><C-n><C-w>w', {desc = "Exit Terminal"})
vim.api.nvim_create_autocmd({"TermOpen","TermEnter"}, {
	pattern = "*",
	callback = function ()
		vim.cmd("startinsert")
	end,
})
