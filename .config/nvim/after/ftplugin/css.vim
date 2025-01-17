" ============================================================================
    " File: css.vim
    " Author: Faris Chugthai
    " Description: css ftplugin
    " Last Modified: June 08, 2019
" ============================================================================

" Guard: {{{1
if exists('g:did_css_after_ftplugin') || &compatible || v:version < 700
  finish
endif
let g:did_css_after_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

" Options: {{{1

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal suffixesadd=.html,.css
setlocal omnifunc=csscomplete#CompleteCSS

compiler csslint

if has_key(plugs, 'ale') && &filetype==#'css'
  call ftplugins#ALE_CSS_Conf()
endif

" Atexit: {{{1

let b:undo_ftplugin = 'set et< sw< sts< sua<'
let &cpoptions = s:cpo_save
unlet s:cpo_save
