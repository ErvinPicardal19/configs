vim.lsp.config("clangd", {
    cmd = {"/usr/bin/clangd"},
    flags = { debounce_text_changes = 150 },
})

 vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.enable({ "clangd" })
  end
})
