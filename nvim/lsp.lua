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

-- Make the function globally accessible
_G.statusline_diagnostic = function()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1  -- Get the current line (0-indexed)
  local diags = vim.diagnostic.get(0, { lnum = line })  -- Get diagnostics for this line

  if vim.tbl_isempty(diags) then
    return ""  -- No diagnostics on the current line
  end

  -- Sort diagnostics by severity (highest severity first)
  table.sort(diags, function(a, b) return a.severity < b.severity end)
  
  -- Get the highest priority diagnostic
  local diag = diags[1]

  -- Map severity to icons or messages
  local icons = {
    [vim.diagnostic.severity.ERROR] = " ",  -- Error icon
    [vim.diagnostic.severity.WARN]  = " ",  -- Warning icon
    [vim.diagnostic.severity.INFO]  = " ",  -- Info icon
    [vim.diagnostic.severity.HINT]  = " ",  -- Hint icon
  }

  -- Return a string that will display the icon and message
  return ("%s%s"):format(icons[diag.severity] or "", diag.message)
end

-- Set the statusline to show the diagnostic message
vim.o.statusline = "%f %m %= %{v:lua.statusline_diagnostic()}"
