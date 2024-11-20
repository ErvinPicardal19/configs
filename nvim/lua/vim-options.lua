vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nu")
vim.cmd("syntax on")
vim.cmd("set guicursor=")
vim.cmd("set mouse=")
vim.cmd("set relativenumber")
vim.cmd("")
vim.cmd("nnoremap <leader>t :tabnew<CR>")
vim.cmd("nnoremap <leader>] :tabn<CR>")
vim.cmd("nnoremap <leader>[ :tabp<cr>")
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
