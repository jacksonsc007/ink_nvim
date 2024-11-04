-- NOTE by INK: Default config for cmp is maintained by nvchad.
-- The following is my personal configuration based on it.
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline", -- For command-line completion
      "fcying/cmp-async-path",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Set up completion for search (`/`) and command (`:`)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        -- reference: https://github.com/hrsh7th/nvim-cmp/blob/29fb4854573355792df9e156cb779f0d31308796/lua/cmp/config/mapping.lua#L32
        mapping = cmp.mapping.preset.cmdline(
        {
          ['<Tab>'] = { c = cmp.mapping.confirm({ select = true }) },
          ['<C-j>'] =
          {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end,
          },
          ['<C-k>'] =
          {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end,
          },
        }),
        -- mapping = {
        --   ['<CR>'] = { c = cmp.mapping.confirm({ select = true }) },  -- Enter confirms in command mode
        --   ['<Tab>'] = { c = cmp.mapping.select_next_item() },         -- Tab navigates to next completion
        --   ['<S-Tab>'] = { c = cmp.mapping.select_prev_item() },       -- Shift-Tab navigates to previous completion
        -- },
        sources = cmp.config.sources({
          { name = "async_path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- original com-path does not support windows-style path, we opt to com-async-path
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "async_path" },
      }))

      -- change mapping defined by NVChad
      opts.mapping = {
            -- ["<C-k>"] = cmp.mapping.select_prev_item(),
            -- ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),

            ["<Tab>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              },

            ["<c-j>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
            end, { "i", "s" }),

            ["<c-k>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                  else
                    fallback()
                  end
            end, { "i", "s" }),
      }

    end,
  },
  {
    -- disable it as we use an alternative
    "hrsh7th/nvim-cmp-path",
    enabled=false,
  }
}
