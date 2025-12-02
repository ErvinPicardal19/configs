-- Function to display diagnostics for the current line on the command line
function show_current_line_diagnostics()
    local current_line = vim.fn.line('.')  -- Get current line (1-based index)
    local diagnostics = vim.diagnostic.get(0, {lnum = current_line - 1})  -- 0-based index
    local cmd_line_prev = vim.fn.getcmdline()

    if #diagnostics > 0 then
        local messages = {}
        for _, diag in ipairs(diagnostics) do
            table.insert(messages, string.format('%s: %s', diag.source, diag.message))
        end
        -- Join and print all diagnostic messages for the current line
        vim.api.nvim_out_write(table.concat(messages, ", ") .. "\n")
    else
        vim.api.nvim_out_write(cmd_line_prev .. "\n")
    end
end

-- LSP setup for clangd
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        -- Start the LSP server (clangd)
        vim.lsp.start({
            name = "clangd",
            cmd = { "/usr/bin/clangd" },
            root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
        })

        -- Run linting and then show diagnostics after buffer is saved
        vim.cmd [[autocmd CursorMoved <buffer> lua show_current_line_diagnostics()]]
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
        -- Start the LSP server (clangd)
        vim.lsp.start({
            name = "pyright",
            cmd = { "pyright-langserver", "--stdio" },
            root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
        })

        -- Run linting and then show diagnostics after buffer is saved
        vim.cmd [[autocmd CursorMoved <buffer> lua show_current_line_diagnostics()]]
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sh" },
    callback = function()
        -- Start the LSP server (clangd)
        -- Start bash-language-server manually using vim.lsp.start()
        vim.lsp.start({
            name = "bashls",
            cmd = { "bash-language-server", "start" },
            root_dir = vim.fn.getcwd(),  -- or use your own root finder
            filetypes = { "sh", "bash" },
            settings = {
                bashIde = {
                    globPattern = "*@(.sh|.inc|.bash|.command)"
                }
            }
        })

        -- Run linting and then show diagnostics after buffer is saved
        vim.cmd [[autocmd CursorMoved <buffer> lua show_current_line_diagnostics()]]
    end
})

-- Enable virtual text diagnostics for LSP
vim.diagnostic.config({
    virtual_text = {
        source = 'always',  -- Display the source of the diagnostic (e.g., clangd, lint)
    },
    signs = true,
    underline = true,
    update_in_insert = true,
})

-- Set text wrapping to 80 characters
vim.o.textwidth = 80

