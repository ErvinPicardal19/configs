local Plug = vim.fn['plug#']
vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

Plug('projekt0n/github-nvim-theme')
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug('mfussenegger/nvim-lint')
-- add more Plug('author/repo', {...}) lines as needed

vim.call('plug#end')

vim.cmd("colorscheme github_dark")
