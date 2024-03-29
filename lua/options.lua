local indent = 2

vim.g.mapleader = " "

vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.shortmess:append("I"):append("c") -- don't give the intro message when starting Vim |:intro|
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.list = true -- Show some invisible characters (tabs...
-- vim.opt.listchars:append("eol:↴") -- show eol character
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = indent -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wrap = true -- Enable line wrap
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.foldmethod = "syntax"
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- don't load the plugins below
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- show cursor line only in active window
vim.api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { command = "set cursorline" }
)
vim.api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { command = "set nocursorline" }
)

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = [[*\(.git/COMMIT_EDITMSG\|.git/NEOGIT_COMMIT_EDITMSG\)\@<!]],
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ftdetect
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.fish", command = "setfiletype fish" }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.nix", command = "setfiletype nix" }
)

-- windows to close with "q"
vim.api.nvim_create_autocmd("Filetype", {
  pattern = "help,startuptime,qf,lspinfo,spectre_panel",
  command = "nnoremap <buffer><silent> q :close<CR>",
})
vim.api.nvim_create_autocmd(
  "Filetype",
  { pattern = "man", command = "nnoremap <buffer><silent> q :quit<CR>" }
)

vim.cmd([[
  augroup MkdirRun
  autocmd!
  autocmd BufWritePre * lua require("util").mkdir()
  augroup END
]])
