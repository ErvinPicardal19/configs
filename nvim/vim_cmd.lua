
vim.keymap.set({ 'n' }, '<leader>[', ':tabp<CR>')
vim.keymap.set({ 'n' }, '<leader>]', ':tabn<CR>')

vim.keymap.set({ 'n' }, '<leader>1', '1gt')
vim.keymap.set({ 'n' }, '<leader>2', '2gt')
vim.keymap.set({ 'n' }, '<leader>3', '3gt')
vim.keymap.set({ 'n' }, '<leader>4', '4gt')
vim.keymap.set({ 'n' }, '<leader>5', '5gt')
vim.keymap.set({ 'n' }, '<leader>6', '6gt')
vim.keymap.set({ 'n' }, '<leader>7', '7gt')
vim.keymap.set({ 'n' }, '<leader>8', '8gt')
vim.keymap.set({ 'n' }, '<leader>9', '9gt')

vim.keymap.set({ 'n' }, '<leader>f', ':BLines<CR>')
vim.keymap.set({ 'n' }, '<leader>r', ':Rg<CR>')
vim.keymap.set({ 'n' }, '<leader>F', ':Files<CR>')
vim.keymap.set({ 'n' }, '<leader>g', ':BCommits<CR>')
vim.keymap.set({ 'n' }, '<leader>G', ':Commits<CR>')

vim.keymap.set({ 'x' }, '<C-r>', 'y:s/<C-r>"//g<Left><Left>')

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if vim.opt.diff:get() then
--         vim.cmd("windo set wrap linebreak breakindent")
--     end
--   end
-- })
-- 
-- vim.opt.diffopt:append("vertical")
-- vim.opt.diffopt:append("iwhite")
-- vim.opt.diffopt:append("algorithm:patience")

-- Convert tabs to spaces
_G.tabs_default="expandtab"
vim.cmd("set " .. _G.tabs_default)

vim.keymap.set({ 'n' }, '<leader>t', function()
	if _G.tabs_default == "expandtab" then
		_G.tabs_default="noexpandtab"
		vim.cmd("set " .. _G.tabs_default)
	else
        	_G.tabs_default="expandtab"
		vim.cmd("set " .. _G.tabs_default)
	end
end)
