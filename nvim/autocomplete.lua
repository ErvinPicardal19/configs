vim.cmd('set completeopt=menuone,noinsert,noselect')
-- menuone: Shows a menu even if there's only one completion result.
-- noinsert: Prevents the first completion from being inserted automatically.

-- noselect: Prevents automatic selection of the first completion result.

-- Search down into subfolders
-- Provides tab-completion for all file-related tasks
vim.cmd('set path+=**')

-- Display all matching files when we tab complete
vim.cmd('set wildmenu')

vim.cmd('set omnifunc=ccomplete#Complete')
