local M = {}
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

function M.setup()
  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Down>"] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        { "i" }
      ),
      ["<Up>"] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        { "i" }
      ),
      ["<CR>"] = cmp.mapping.confirm(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "spell" },
      { name = "path" },
      { name = "crates" },
      { name = "calc" },
      { name = "emoji" },
      { name = "npm", keyword_length = 4 },
    }),
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  })

  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
  )
end

return M
