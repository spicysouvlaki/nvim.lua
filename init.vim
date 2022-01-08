set runtimepath^=~/.vim runtimepath+=~/.vim/after
set runtimepath+=~/.neovim
let &packpath = &runtimepath

set rnu
set nu
set ic

" colorscheming from https://github.com/sonph/onehalf/tree/master/vim
call plug#begin()
Plug 'neovim/nvim-lspconfig'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ray-x/go.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'David-Kunz/jester'
Plug 'sbdchd/neoformat' " prettier
Plug 'tpope/vim-fugitive'
Plug 'terrortylor/nvim-comment'
Plug 'folke/zen-mode.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'windwp/nvim-autopairs'
Plug 'folke/which-key.nvim'

" nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" nvim-cmp snips
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

set clipboard=unnamed

colorscheme tokyonight 

let mapleader=" "

"""" GO
set autowrite
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "3s"
let g:go_rename_command = "gopls"

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" dashboard
let g:dashboard_default_executive ='telescope'

let g:dashboard_custom_header =[
    \'          ▀████▀▄▄              ▄█ ',
    \'            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
    \'    ▄        █          ▀▀▀▀▄  ▄▀  ',
    \'   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
    \'  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
    \'  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
    \'   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
    \'    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
    \'   █   █  █      ▄▄           ▄▀   ',
    \'   █   █  █                  ▄▀   ',
    \]

highlight dashboardFooter    ctermfg=240
" highlight dashboardHeader    ctermfg=114
highlight dashboardcenter    ctermfg=215
highlight dashboardShortCut  ctermfg=245

" """ COC
" 
" " TextEdit might fail if hidden is not set.
" set hidden
" 
" " Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup
" 
" " Give more space for displaying messages.
" set cmdheight=2
" 
" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300
" 
" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" 
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
" 
" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 
" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
" 
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
" 
" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
" 
" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)
" 
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
" 
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 
" " Add (Neo)Vim's native statusline support.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


 lua <<EOF
 require 'go'.setup({
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
 
   test_runner = 'richgo',
 })
 
 local protocol = require'vim.lsp.protocol'
EOF

lua <<EOF
-- vim.g.markdown_fenced_languages = {
--  "ts=typescript"
--}
--nvim_lsp = require'lspconfig'
--nvim_lsp.denols.setup {
--    on_attach = on_attach,
--    root_dir = nvim_lsp.util.root_pattern("deno.json"),
--    init_options = {
--        lint = true,
--    },
--}
--
--nvim_lsp.gopls.setup {
--    cmd = {"gopls", "serve"},
--    settings = {
--      gopls = {
--        analyses = {
--          unusedparams = true,
--        },
--        staticcheck = true,
--      },
--    },
--}
--  function goimports(timeout_ms)
--    local context = { only = { "source.organizeImports" } }
--    vim.validate { context = { context, "t", true } }
--
--    local params = vim.lsp.util.make_range_params()
--    params.context = context
--
--    -- See the implementation of the textDocument/codeAction callback
--    -- (lua/vim/lsp/handler.lua) for how to do this properly.
--    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--    if not result or next(result) == nil then return end
--    local actions = result[1].result
--    if not actions then return end
--    local action = actions[1]
--
--    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
--    -- is a CodeAction, it can have either an edit, a command or both. Edits
--    -- should be executed first.
--    if action.edit or type(action.command) == "table" then
--      if action.edit then
--        vim.lsp.util.apply_workspace_edit(action.edit)
--      end
--      if type(action.command) == "table" then
--        vim.lsp.buf.execute_command(action.command)
--      end
--    else
--      vim.lsp.buf.execute_command(action)
--    end
--  end
EOF

" autocmd BufWritePre *.go lua goimports(1000)
" nvim_lsp.tsserver.setup {
"   on_attach = on_attach,
"   root_dir = nvim_lsp.util.root_pattern("package.json"),
"   init_options = {
"     lint = true,
"   },
" }

" command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


    -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
    cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
EOF

lua << EOF
 require('nvim_comment').setup({
     comment_empty = false,
     line_mapping = "<leader>/",
 }) 
 require("which-key").setup {
     timeout_ms=100,
 }
EOF
