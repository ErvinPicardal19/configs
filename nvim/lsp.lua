vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
      vim.lsp.start({
        name = "clangd",
        cmd = { "/usr/bin/clangd" },
        root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
      })
    end
})

-- Enable virtual text diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})
