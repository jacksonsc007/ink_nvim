-------------------------------------
--- Ink keymap setting for quick edit
-------------------------------------
local map = vim.keymap.set

-- unmap the default key in nvchad
local unmap = vim.api.nvim_del_keymap
-- unmap('n', '<C-j>')
-- unmap('n', '<C-k>')
-- unmap('n', '<C-h>')
-- unmap('n', '<C-l>')


-- move the start and end of line, in insert mode.
map("i", "<A-l>", "<Esc>$a")
map("i", "<A-h>", "<Esc>^a")
-- surround selected content with pairs
-- NOTE: My personal implementation has bugs.
-- So I final resort to use surround plugins.
--
-- prevent l from jump to the next line
-- vim.o.whichwrap = vim.o.whichwrap:gsub("[lh]", "")
-- map('x', '"','<Esc>`<i"<Esc>`>la"<Esc>')
-- map("x", "'","<Esc>`<i'<Esc>`>la'<Esc>")
-- map('x', '(','<Esc>`<i(<Esc>`>la)<Esc>%')
-- map('x', '(', 's(<C-r>")<Esc>', { noremap = true, silent = true })
-- map('x', '[','<Esc>`<i[<Esc>`>la]<Esc>%')
--
-- switch buffer
map("n", "H", "<cmd>bp<CR>")
map("n", "L", "<cmd>bn<CR>")

-- visually jump line
map("n", "j", "gj")
map("n", "k", "gk")

-- move line and character
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- select all
map("n", "<leader>a", "<Esc>ggVG")


-- Set vimtex for markdown files
-- vim.api.nvim_command('autocmd FileType markdown setlocal filetype=tex')
-- edit and create
-- vim.api.nvim_command('autocmd BufNewFile * :write')

-- jump to non-space character when press 0 twice 
vim.keymap.set('n', '0', function()

  -- Get the current cursor column
  local col = vim.fn.col('.')
  -- If the cursor is in the first column, jump to the first non-blank character
  if col == 1 then
    return '^'
  else
    -- Otherwise, perform the regular '0' action
    return '0'
  end
end, { expr = true })



----------------------------------
--- nvimtree mapping
----------------------------------
-- disable default mapping in NVChad
-- unmap("n", "<C-n>")
-- unmap("n", "<leader>e")
-- map("n", "", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<C-0>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

----------------------------------
--- leap plugin setting
----------------------------------
vim.keymap.set('n',        's', '<Plug>(leap)')
vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')


----------------------------------
--- luasnip plugin setting
----------------------------------
local ls = require("luasnip")
-- vim.api.nvim_set_keymap("i", "<Tab>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", {silent = true, noremap = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require'luasnip'.expand_or_jump()<CR>", {silent = true, noremap = true})
-- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<leader>j", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<leader>k", function() ls.jump(-1) end, {silent = true})

-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})

-- Extend LaTeX snippets to markdown
ls.filetype_extend("markdown", {"tex"})

----------------------------------
--- session manager plugin setting
----------------------------------
local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands
-- open vimtree automatically
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = "SessionLoadPost",
  group = config_group,
  callback = function()
    require('nvim-tree.api').tree.toggle(false, true)
  end,
})
map('n', '<leader>fs', '<cmd>SessionManager load_session<CR>', {desc = "Load Session"})
-- auto save session
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function ()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Don't save while there's any 'nofile' buffer open.
      if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
        return
      end
    end
    require('session_manager').save_current_session()
  end
})


-- snippet test
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
      s("debug_snippet", {
          t({"debug=True", ""}),
          t({"if debug:", ""}),
          t({"    # Improve torch tensor printing", ""}),
          t({"    import torch", ""}),
          t({"    def custom_repr(self):", ""}),
          t({"        return f'{Tensor:{tuple(self.shape)}} {original_repr(self)}'", ""}),
          t({"    original_repr = torch.Tensor.__repr__", ""}),
          t({"    torch.Tensor.__repr__ = custom_repr", ""}),
          t({"", ""}),
          t({"    # Debug with debugpy", ""}),
          t({"    import debugpy", ""}),
          t({"    # Listen on a specific port (choose any available port, e.g., 61074)", ""}),
          t({"    debugpy.listen(('0.0.0.0', 61074))", ""}),
          t({"    print('Waiting for debugger to attach...')", ""}),
          t({"    # Optional: Wait for the debugger to attach before continuing execution", ""}),
          t({"    debugpy.wait_for_client()", ""}),
      }),
})
