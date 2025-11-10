vim.cmd('let g:netrw_banner=0')
vim.cmd('let g:netrw_liststyle=3')


-- Enable syntax and plugins (for netrw)
vim.cmd('syntax enable')
vim.cmd('filetype plugin on')

local function toggle_filetree()
    local current_tab_wins = vim.api.nvim_tabpage_list_wins(0)

    -- Iterate over all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "filetype") == "netrw" then
            -- Terminal buffer exists, switch to its window
            for _, win in ipairs(current_tab_wins) do
                if vim.api.nvim_win_get_buf(win) == buf then
                    vim.api.nvim_set_current_win(win)
                    local width = math.floor(vim.o.columns * 0.2)
                    vim.api.nvim_win_set_width(0, width)
                    return
                end
            end
        end
    end

    -- No terminal found, open a new one at bottom
    vim.cmd("vsplit")
    local width = math.floor(vim.o.columns * 0.2)
    vim.api.nvim_win_set_width(0, width)
    vim.cmd("Ex")
end

local function netrw_openfile()
      local filename = vim.fn.expand('<cfile>')
      local win_count = #vim.api.nvim_tabpage_list_wins(0)
      local filetype = vim.bo.filetype

      if win_count == 1 and filetype == 'netrw' then
          vim.cmd('botright vsplit ' .. vim.fn.fnameescape(filename))
          toggle_filetree()
          vim.cmd('wincmd l')
      else
          vim.cmd('wincmd l')
          vim.cmd('edit ' .. vim.fn.fnameescape(filename))
      end
end

-- Toggle Filetree
vim.keymap.set({'v', 'n'}, '<leader>n', toggle_filetree)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "<leader>n", ":q<CR>", { buffer = true })
	end,
})

-- Handle opening file in Netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "<CR>", netrw_openfile, { buffer = true })
	end,
})

