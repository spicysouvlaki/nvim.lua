require('plugins')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[
  let mapleader=" "
  set rnu
  set nu
  set ic
  set clipboard=unnamed
  colorscheme tokyonight 
  set mouse+=a
]])

require'go'.setup({
    goimport = 'gopls', -- if set to 'gopls' will use golsp format
    gofmt = 'gopls', -- if set to gopls will use golsp format
    max_line_len = 240,
    tag_transform = false,
    test_dir = '',
    comment_placeholder = '   ',
    lsp_cfg = true, -- false: use your own lspconfig
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = true, -- use on_attach from go.nvim
    dap_debug = true,
    test_runner = 'richgo'
})

local protocol = require 'vim.lsp.protocol'

-- Setup nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, -- { name = 'vsnip' }, -- For vsnip users.
        {name = 'luasnip'} -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {{name = 'buffer'}})
})

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Mappings.
local opts = {noremap = true, silent = true}

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa',
               '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr',
               '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl',
               '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
               opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
               opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

local nvim_lsp = require('lspconfig')
local servers = {'pyright', 'gopls', 'vimls', 'tsserver'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {flags = {debounce_text_changes = 150}}
end

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

require('nvim_comment').setup({
    comment_empty = false,
    line_mapping = "<leader>/"
})

local actions = require("telescope.actions")
require("telescope").setup {
    defaults = {mappings = {i = {["<esc>"] = actions.close}}}
}

local cmd = vim.cmd
local g = vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>ft', '<cmd>Telescope<CR>')
map('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')
map('n', '<leader>p', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>f', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fs', '<cmd>Telescope treesitter<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands<CR>')
map('n', '<leader>fp', '<cmd>Telescope project<CR>')
map('n', '<leader>fm', '<cmd>Telescope marks<CR>')
map('n', '<c-k>', '<cmd>wincmd k<CR>') -- ctrlhjkl to navigate splits
map('n', '<c-j>', '<cmd>wincmd j<CR>')
map('n', '<c-h>', '<cmd>wincmd h<CR>')
map('n', '<c-l>', '<cmd>wincmd l<CR>')

local wk = require("which-key")
wk.register({
    ["<leader>f"] = {name = "+file"},
    ["<leader>ff"] = {"<cmd>Telescope find_files<cr>", "Find File"},
    ["<leader>fr"] = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
    ["<leader>fn"] = {"<cmd>enew<cr>", "New File"}
})

vim.cmd([[
  let g:dashboard_default_executive ='telescope'
  nmap <Leader>ss :<C-u>SessionSave<CR>
  nmap <Leader>sl :<C-u>SessionLoad<CR>
  nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
  nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
  nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
  nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
  nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
  nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
]])
