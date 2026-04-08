-- vim.api.nvim_set_hl(0, "VertSplit", {fg = "#ffffff", bg = "#ffffff"})

vim.cmd("highlight FzfBorder guifg=#ffffff guibg=#ffffff")
vim.cmd("")
-- vim.api.nvim_set_hl(0, "FzfBorder", { fg = "#ffffff", bg = "#ffffff" })

vim.cmd("let g:fzf_colors = { 'border': ['fg', 'FzfBorder']}")

vim.cmd('colorscheme industry')
