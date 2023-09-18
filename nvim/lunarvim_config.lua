-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true           -- wrap lines
vim.opt.scrolloff = 10        -- keep the cursor of the border
vim.opt.autoindent = true     -- automatically add indent

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

lvim.format_on_save.enabled = true
lvim.builtin.dap.active = true

lvim.keys.normal_mode["grn"] = vim.lsp.buf.rename

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

-- Trouble keybinds
lvim.keys.normal_mode["<leader>xx"] = function() require("trouble").open() end
lvim.keys.normal_mode["<leader>xw"] = function() require("trouble").open("workspace_diagnostics") end
lvim.keys.normal_mode["<leader>xd"] = function() require("trouble").open("document_diagnostics") end
lvim.keys.normal_mode["<leader>xq"] = function() require("trouble").open("quickfix") end
lvim.keys.normal_mode["<leader>xl"] = function() require("trouble").open("loclist") end
lvim.keys.normal_mode["<leader>xr"] = function() require("trouble").open("lsp_references") end

--TODO lvim.builtin.which_key.mappings["x"] = {
--   name = "Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

lvim.plugins = {
  {
    "scalameta/nvim-metals",
    config = function()
      require("user.metals").config()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = '-',
        zindex = 20, -- The Z-index of the context window
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'function_definition',
            'class_definition',
            'object_definition',
            'enum_definition',
            'case_clause',
            'match_expression',
            'call_expression',
            'if_expression',
            'val_definition',
            'var_definition',
            'while_expression',
            'do_while_expression',
            'for_expression',
            'try_expression',
          },
        },
      }
    end
  },
  {
    "wakatime/vim-wakatime"
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup()
    end,
  }
}

lvim.builtin.dap.on_config_done = function(dap)
  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run or Test Target",
      metals = {
        runType = "runOrTestFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
  }
end
