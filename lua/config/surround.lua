local M = {}

function M.setup()
  require("nvim-surround").setup({
    keymaps = { -- vim-surround style keymaps
      insert = "ys",
      visual = "S",
      delete = "ds",
      change = "cs",
    },
    delimiters = {
      pairs = {
        ["("] = { "( ", " )" },
        [")"] = { "(", ")" },
        ["{"] = { "{ ", " }" },
        ["}"] = { "{", "}" },
        ["<"] = { "< ", " >" },
        [">"] = { "<", ">" },
        ["["] = { "[ ", " ]" },
        ["]"] = { "[", "]" },
      },
      separators = {
        ["'"] = { "'", "'" },
        ['"'] = { '"', '"' },
        ["`"] = { "`", "`" },
      },
      HTML = {
        ["t"] = true,
      },
      aliases = {
        ["a"] = ">",
        ["b"] = ")",
        ["B"] = "}",
        ["r"] = "]",
        ["q"] = { '"', "'", "`" },
      },
    },
  })
end

return M
