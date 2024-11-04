return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",  -- Optional: load the plugin lazily
    enabled = true,
    opts = {
        input = {
          -- Configurations for the input UI
          enabled = true,
          default_prompt = "Input:",
          prompt_align = "center",  -- Can be "left", "center", or "right"
          border = "rounded", -- Can be "none", "single", "double", "rounded", "solid", "shadow"
          win_options = {
            winblend = 10, -- Transparency
            winhighlight = "Normal:Normal,NormalNC:NormalNC",
          },
          override = function(conf)
            -- This is where you can customize the input window before opening
            return conf
          end,
        },
        select = {
            backend = { "telescope", "builtin" },
            telescope = require('telescope.themes').get_dropdown({
              layout_config = {
                width = 60,
                height = 15,
              },
            }),
            builtin = {
              border = "rounded",
              win_options = {
                winblend = 10,
                winhighlight = "Normal:Normal,NormalNC:NormalNC",
              },
            },
        },        
        
  }
  }
}
