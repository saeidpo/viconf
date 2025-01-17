" ============================================================================
  " File: lua.vim
  " Author: Faris Chugthai
  " Description: Lua ftplugin
  " Last Modified: May 09, 2019
" ============================================================================

" Guard: {{{1
if exists('g:did_lua_after_ftplugin') || &compatible || v:version < 700
  finish
endif
let g:did_lua_after_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions-=C

" Options: {{{1
setlocal shiftwidth=2
setlocal expandtab
setlocal softtabstop=2
setlocal commentstring=--\ %s

" Apparently this is a problem. Echoes out an error message.
" setlocal comments=--\ %s

" Atexit: {{{1
let b:undo_ftplugin = 'set sw< et< sts< cms<'

let &cpoptions = s:cpo_save
unlet s:cpo_save
