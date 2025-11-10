local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
  cmd = { "/usr/bin/clangd", "--background-index" },
}

