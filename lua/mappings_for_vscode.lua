local map = vim.keymap.set
-- nnoremap <C-w>gd <Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>

vim.notify("vscode mapping is activated.")
map("n", "<C-w>gd", "<Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>")

local vscode = require('vscode')
vim.notify = vscode.notify

map("n", "<leader>e", "<Cmd>lua require('vscode').action('workbench.view.explorer')<CR>")
-- map windows move
map("n", "<C-j>", "<C-w>j", {remap=true})
map("n", "<C-k>", "<C-w>k", {remap=true})
map("n", "<C-h>", "<C-w>h", {remap=true})
map("n", "<C-l>", "<C-w>l", {remap=true})

-- tab opeartion
map("n", "H", "<Cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>")
map("n", "L", "<Cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>")
