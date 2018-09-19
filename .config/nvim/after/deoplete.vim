" Deoplete: {{{

" Needs to be set manually default is infact 0
let g:deoplete#enable_at_startup = 1

" TODO:
"				*deoplete#smart_close_popup()*
" deoplete#smart_close_popup()
"         Insert candidate and re-generate popup menu for deoplete.
"         Note: It must be in |map-<expr>|.
" >
"         inoremap <expr><C-h>
"         \ deoplete#smart_close_popup()."\<C-h>"
"         inoremap <expr><BS>
"         \ deoplete#smart_close_popup()."\<C-h>"
" <
"         Note: This mapping conflicts with |SuperTab| or |endwise|
"         plugins.
"         Note: This key mapping is for <C-h> or <BS> keymappings.

"
let g:deoplete#enable_smart_case = 1
set completeopt+=noinsert                    " Autoselect feature

"" On <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

"" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

"" Do not complete too short words
call deoplete#custom#source(
\ 'dictionary', 'min_pattern_length', 3)

" Collect keywords from buffer path not directory Nvim was launched from
call deoplete#custom#source(
\ 'file', 'enable_buffer_path', 'True')

autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

" load deop and ultisnips after entering insert mode.
augroup load_us_deop
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips', 'deoplete'
                \| autocmd! load_us_deop)

    " line below may be the default now.
    " autocmd InsertEnter * call deoplete#enable()
    " keep custom option a dict so we can add as necessary
    call deoplete#custom#option({
    \ 'auto_complete_delay': 200,
    \ 'smart_case': v:true,
    \ })
    " call deoplete#custom#option('smart_case', v:true)

    " Close the autocompleter when we leave insert mode
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Remove this if you'd like to use fuzzy search
"call deoplete#custom#source(
"\ 'dictionary', 'matchers', ['matcher_head'])

"" If dictionary is already sorted, no need to sort it again.
call deoplete#custom#source(
\ 'dictionary', 'sorters', [])

" Setting up the omnifuncs
" set omnifunc=LanguageClient#complete

" Enable jedi source debug messages
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" Note: You must enable
"|deoplete-source-attribute-is_debug_enabled| to debug the
"sources.
" call deoplete#custom#source('jedi', 'is_debug_enabled', 1)

" }}}
