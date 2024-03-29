local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local actions = require("telescope.actions")

local M = {}

M.project_files = function(opts)
  opts = opts or {}

  local _git_pwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
    return
  end

  require("telescope.builtin").git_files(opts)
end

function M.setup()
  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      file_browser = {
        theme = "ivy",
      },
    },
    defaults = {
      -- layout_strategy = "flex",
      layout_config = {
        anchor = "N",
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<c-t>"] = trouble.open_with_trouble,
          ["<C-u>"] = false,
        },
        n = {
          ["<c-t>"] = trouble.open_with_trouble,
        },
      },
      prompt_prefix = "❯ ",
      selection_caret = " ",
      winblend = 5,
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("file_browser")
  telescope.load_extension("gh")

  local util = require("util")

  util.nnoremap("<Leader><Space>", "<cmd>Telescope find_files<cr>")
  util.nnoremap("<Leader>fh", "<cmd>Telescope find_files hidden=true<cr>")

  util.nnoremap("<Leader>fp", M.project_files)
  util.nnoremap("<Leader>.", function()
    require("telescope.builtin").find_files({
      cwd = vim.fn.expand("%:p:h", "."),
    })
  end)
  util.nnoremap("<Leader>fd", function()
    require("telescope.builtin").git_files({
      cwd = "~/.config/nvim",
    })
  end)
end

return M
