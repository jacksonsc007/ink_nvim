local map = vim.keymap.set
-- nnoremap <C-w>gd <Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>

vim.notify("vscode mapping is activated.")

local vscode = require('vscode')
vim.notify = vscode.notify

map("n", "<leader>e", "<Cmd>lua require('vscode').action('workbench.view.explorer')<CR>")

-- we do not map windows move in nvim
map("n", "<C-j>", "<C-w>j", {remap=true})
map("n", "<C-k>", "<C-w>k", {remap=true})
map("n", "<C-h>", "<C-w>h", {remap=true})
map("n", "<C-l>", "<C-w>l", {remap=true})


-- invoke whichkey entension
-- map("n", "<leader>", "<Cmd>lua require('vscode').call('VSCodeNotify', {args=whichkey.show})<CR>")
map("n", "<leader>", "<Cmd>lua require('vscode').action('whichkey.show')<CR>")

-- peek definition
map("n", "<C-w>gd", "<Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>")
map("n", "<leader>gd", "<Cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>")

-- peek reference
map("n", "<leader>fr", "<Cmd>lua require('vscode').action('editor.action.referenceSearch.trigger')<CR>")


-- jump between tabs
map("n", "H", "gT", {remap=true})
map("n", "L", "gt", {remap=true})

-- close vscode tabs
map("n", "<leader>x", "<Cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>")

-- peek declaration
map("n", "<leader>pdc", "<Cmd>lua require('vscode').action('editor.action.peekDeclaration')<CR>")
-- peek defination
map("n", "<leader>pdf", "<Cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>")
