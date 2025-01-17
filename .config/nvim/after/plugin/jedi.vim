" ============================================================================
    " File: jedi.vim
    " Author: Faris Chugthai
    " Description: jedi modifications
    " Last Modified: May 04, 2019
" ============================================================================

" The modifications made here try to optimize Jedi's utilities; however,
" many features are disabled. Jedi was responsible for over 80% of my startuptime
" in some cases, which I was initially shocked by.

" Guard: {{{1
if !has_key(plugs, 'jedi-vim')
    finish
endif

if exists('g:did_jedi_after_plugin') || &compatible || v:version < 700
    finish
endif
let g:did_jedi_after_plugin = 1

" Options: {{{1

let g:jedi#use_tabs_not_buffers = 1

" Huge contributor to Jedi's affect on startuptime
let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 1

let g:jedi#show_call_signatures = 0

if g:termux
    let g:jedi#smart_auto_mappings = 0

elseif g:ubuntu
    let g:jedi#smart_auto_mappings = 1
endif

let g:jedi#enable_completions = 0
let g:jedi#force_py_version = 3
let g:jedi#use_splits_not_buffers = 'winwidth'

" Why would I choose C-n?

let g:jedi#completions_command = '<C-P>'

" Make sure completeopt contains noinsert,noselect as well.

" No! Also ensure `:set completeopt` contains noinsert,noselect
let g:jedi#popup_select_first = 0
