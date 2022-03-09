local M = {}

function M.setup()
  local notify = require("notify")

  notify.setup({
    timeout = 100,
    max_width = 200,
  })
  vim.notify = notify
end

return M
