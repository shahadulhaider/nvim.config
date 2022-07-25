local packer = require("util.packer")

local config = {
  profile = {
    enable = false,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  -- display = {
  --   open_fn = function()
  --     return require("packer.util").float({ border = "single" })
  --   end,
  -- },
}

local function plugins(use)
  -- common modules used by plugins
  use({ "nvim-lua/plenary.nvim", module = "plenary" })
  use({ "nvim-lua/popup.nvim", module = "popup" })

  -- improve startup time
  use({ "lewis6991/impatient.nvim" })
  use({ "nathom/filetype.nvim" })

  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", opt = true })

  -- notification
  use({
    "rcarriga/nvim-notify",
    event = "BufRead",
    config = function()
      require("config.notify").setup()
    end,
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    wants = {
      "nvim-lsp-ts-utils",
      "null-ls.nvim",
      "lua-dev.nvim",
    },
    config = function()
      require("config.lsp")
    end,
    requires = {
      {
        "SmiteshP/nvim-navic",
        config = function()
          require("config.navic").setup()
        end,
      },
      "simrat39/rust-tools.nvim",
      "mfussenegger/nvim-dap",
      "mattn/webapi-vim",
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "ray-x/lsp_signature.nvim",
      {
        "kosayoda/nvim-lightbulb",
        config = function()
          require("config.lightbulb").setup()
        end,
      },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("config.fidget").setup()
        end,
      },
    },
  })

  -- LSP ui
  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("config.trouble").setup()
    end,
  })

  -- completion
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.cmp").setup()
    end,
    wants = { "tabout.nvim", "LuaSnip", "nvim-autopairs", "plenary.nvim" },
    requires = {
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "David-Kunz/cmp-npm",
      -- "hrsh7th/cmp-copilot",
      -- "github/copilot.vim",
      -- {
      --   "saecki/crates.nvim",
      --   config = function()
      --     require("crates").setup()
      --   end,
      -- },
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require("config.luasnip").setup()
        end,
      },
      "rafamadriz/friendly-snippets",
      {
        "abecodes/tabout.nvim",
        config = function()
          require("tabout").setup()
        end,
        wants = { "nvim-treesitter" },
      },
      {
        "windwp/nvim-autopairs",
        config = function()
          require("config.autopairs").setup()
        end,
      },
    },
  })

  -- surround selections
  use({
    "kylechui/nvim-surround",
    config = function()
      require("config.surround").setup()
    end,
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    requires = {
      {
        "nvim-treesitter/playground",
        cmd = "TSHighlightCapturesUnderCursor",
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("config.treesitter").setup()
    end,
  })

  use({
    "AckslD/nvim-trevJ.lua",
    wants = { "nvim-treesitter" },
    config = function()
      require("config.trevj").setup()
    end,
  })

  use({
    "numToStr/Comment.nvim",
    opt = true,
    wants = "nvim-ts-context-commentstring",
    keys = { "gc", "gcc" },
    config = function()
      require("config.comments").setup()
    end,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })

  -- Theme: colors
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("config.theme")
    end,
  })

  use("lewpoly/sherbet.nvim")

  -- Theme: icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("config.devicons").setup()
    end,
  })

  use({
    "alvan/vim-closetag",
    config = function()
      require("config.closetag")
    end,
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
  })

  -- Statusline
  use({
    "feline-nvim/feline.nvim",
    config = function()
      require("config.feline").setup()
    end,
    wants = "nvim-web-devicons",
  })

  -- terminal
  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("config.terminal").setup()
    end,
  })

  use({
    "windwp/nvim-spectre",
    opt = true,
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  })

  -- files
  use({
    "tamago324/lir.nvim",
    wants = { "nvim-web-devicons", "plenary.nvim", "lir-git-status.nvim" },
    requires = { "nvim-lua/plenary.nvim", "tamago324/lir-git-status.nvim" },
    config = function()
      require("config.lir").setup()
    end,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeFindFile" },
    config = function()
      require("config.tree").setup()
    end,
  })

  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("config.project")
    end,
  })
  -- Fuzzy finder
  use({
    "ibhagwan/fzf-lua",
    requires = { "kyazdani42/nvim-web-devicons" },
  })
  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope").setup()
    end,
    cmd = { "Telescope" },
    keys = { "<leader><space>", "<leader>fd" },
    wants = {
      "plenary.nvim",
      "popup.nvim",
      -- "telescope-fzy-native.nvim",
      "telescope-fzf-native.nvim",
      "trouble.nvim",
      "telescope-symbols.nvim",
      "telescope-github.nvim",
    },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      -- "nvim-telescope/telescope-fzy-native.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-github.nvim",
    },
  })

  use({ "stevearc/dressing.nvim" })

  -- Indent Guides
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.blankline").setup()
    end,
  })

  --folds
  use({
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup()
    end,
  })

  use({
    "anuvyklack/fold-preview.nvim", -- only for preview
    requires = "anuvyklack/nvim-keymap-amend", -- only for preview
    config = function()
      require("fold-preview").setup()
    end,
  })

  -- Tabs
  use({
    "akinsho/nvim-bufferline.lua",
    tag = "v2.*",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require("config.bufferline").setup()
    end,
  })
  use({
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
  })

  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    tag = "v2.*",
    keys = "<F12>",
    config = function()
      require("config.toggleterm").setup()
    end,
  })

  -- Smooth Scrolling
  use({
    "karb94/neoscroll.nvim",
    keys = { "<C-u>", "<C-d>", "gg", "G" },
    config = function()
      require("config.scroll").setup()
    end,
  })
  -- use({
  --   "edluffy/specs.nvim",
  --   after = "neoscroll.nvim",
  --   config = function()
  --     require("config.specs")
  --   end,
  -- })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns").setup()
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    wants = "plenary.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("config.gitlinker").setup()
    end,
  })

  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    wants = {
      "plenary.nvim",
      "diffview.nvim",
    },
    requires = {
      {
        "sindrets/diffview.nvim",
        config = function()
          require("config.diffview").setup()
        end,
        after = "plenary.nvim",
      },
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.neogit").setup()
    end,
  })

  use({
    "akinsho/git-conflict.nvim",
    config = function()
      require("config.conflict").setup()
    end,
  })

  use({ "f-person/git-blame.nvim" })

  -- Writing
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  })

  use({ "jxnblk/vim-mdx-js" })

  use({
    "phaazon/hop.nvim",
    -- keys = { "gh" },
    -- cmd = { "HopWord", "HopLine" },
    config = function()
      -- require("util").nmap("gh", "<cmd>HopWord<CR>")
      -- require("util").nmap("gl", "<cmd>HopLine<CR>")
      require("config.hop")
      -- you can configure Hop the way you like here; see :h hop-config
    end,
  })

  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("config.lightspeed").setup()
    end,
  })

  -- use({
  --   "folke/trouble.nvim",
  --   event = "BufReadPre",
  --   wants = "nvim-web-devicons",
  --   cmd = { "TroubleToggle", "Trouble" },
  --   config = function()
  --     require("trouble").setup({
  --       auto_open = false,
  --       mode = "document_diagnostics",
  --     })
  --   end,
  -- })

  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })

  use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

  use({ "mbbill/undotree", cmd = "UndotreeToggle" })

  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    wants = "twilight.nvim",
    requires = { "folke/twilight.nvim" },
    config = function()
      require("config.zen").setup()
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("config.colorizer").setup()
    end,
  })

  use({
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require("config.todo").setup()
    end,
  })

  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
    end,
  })

  use({
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = function()
      require("config.illuminate").setup()
    end,
  })

  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  })

  -- qf/loc list helpers
  use({
    "stevearc/qf_helper.nvim",
    config = function()
      require("config.qfhelper").setup()
    end,
  })

  -- buffer cycle
  use({
    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.cybu").setup()
    end,
  })
end

return packer.setup(config, plugins)
