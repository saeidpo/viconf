" ============================================================================
  " File: html.vim
  " Author: Faris Chugthai
  " Description: Html ftplugin
  " Last Modified: June 08, 2019
" ============================================================================

" Guard: {{{1
if exists('g:did_html_after_ftplugin') || &compatible || v:version < 700
  finish
endif
let g:did_html_after_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions-=C

" Options: {{{1

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal suffixesadd=.html

" So this is from |ft-html-omni| I don't know if that call is necessary
setlocal omnifunc=htmlcomplete#CompleteTags
call htmlcomplete#DetectOmniFlavor()

" from runtime/ftplugin/html.vim

let g:ft_html_autocomment = 1

" Plugins: {{{1
if has_key(plugs, 'ale') && &filetype==#'html'
  call ftplugins#ALE_Html_Conf()
endif

" Atexit: {{{1
let b:undo_ftplugin = 'set et< sw< sts< sua<'
let &cpoptions = s:cpo_save
unlet s:cpo_save
