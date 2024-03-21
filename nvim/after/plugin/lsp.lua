local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {
     'pyright',
     'tsserver',
     'rust_analyzer',
     'lua_ls',
     'bashls',
     'clangd',
     'cmake',
     'cssls',
     'dockerls',
     'docker_compose_language_service',
     'eslint',
     'gradle_ls',
     'html',
--     'haskel_language_server',
     'jsonls',
--     'java_language_server',
     'kotlin_language_server',
     'ltex',
     'autotools_ls',
     'markdown_oxide',
     'ocamllsp',
     'intelephense',
     'sqlls',
     'yamlls'
  },
  handlers = {
    lsp_zero.default_setup,
  }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<tab>'] = cmp.mapping.confirm({select = true}),
    ['<enter>'] = cmp.mapping.confirm({select = true}),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})
