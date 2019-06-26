" ============================================================================
    " File: coc.vim
    " Author: Faris Chugthai
    " Description: Coc plugin mods
    " Last Modified: March 22, 2019
" ============================================================================

" Options are in coc_settings.json

" Guard: {{{1
if !has_key(plugs, 'coc.nvim')
    finish
endif

if exists('b:did_coc_after_plugin') || &compatible || v:version < 700
    finish
endif
let b:did_coc_after_plugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

" Mappings: {{{1

" This section primarily focuses on setting up the autocompletion aspect
" Refresh completions with C-Space
inoremap <silent><expr> <C-Space> coc#refresh()

" Set Enter to accept autocompletion. More settings in
" ~/.config/nvim/coc-settings.json
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? '\<C-n>' :
"       \ <SID>check_back_space() ? '\<TAB>' :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? '\<C-p>' : '\<C-h>'

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" like VSCode. >

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-j>'

" Note: the `coc-snippets` extension is required for this to work.
" Holy hell that's a hell of a setup!
" Supertab's also installed hahahah
let g:coc_snippet_prev = '<C-k>'

" Use `[c` and `]c` to navigate diagnostics
" First check that gitgutter doesn't have these mapped first
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" Now let's start working with the niceties of an LSP. Docs and symbols
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  " Jun 15, 2019: Added none if we do something like `:r!pydoc thing`
  if (index(['vim','help','none'], &filetype) >= 0)
    execute 'h ' . expand('<cWORD>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nnoremap <leader>rn <Plug>(coc-rename)

augroup CocConf
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end


" Using CocList: {{{1
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" I'm gonna redo the mappings and try this piecemeal
noremap <silent> <C-c>r <Cmd>CocListResume<CR>
noremap <silent> <C-c>d <Cmd>CocList diagnostics<CR>


" Remap for rename current word

" Remap for format selected region. e for errors and visual selection
xmap <leader>ev  <Plug>(coc-format-selected)
nmap <leader>ev  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
" nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ca  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>cqf  <Plug>(coc-fix-current)

" Dude that is an OBNOXIOUS amount of typing though.
noremap <silent> <C-c>q <Plug>(coc-fix-current)

" Commands: {{{1

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 SortImport :call CocAction('runCommand', 'editor.action.organizeImport')

" Atexit: {{{1
let &cpoptions = s:cpo_save
unlet s:cpo_save
