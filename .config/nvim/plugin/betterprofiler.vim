" ============================================================================
  " File: betterprofiler.vim
  " Author: Faris Chugthai
  " Description: Profiling commands
  " Last Modified: May 30, 2019
" ============================================================================

" Guard: {{{1
if exists('g:did_better_profiler_vim_plugin') || &compatible || v:version < 700
  finish
endif
let g:did_better_profiler_vim_plugin = 1

let s:cpo_save = &cpoptions
set cpoptions-=c

if !has('profile') || !has('reltime')  " timing functionality
  finish
endif

if has('+shellslash')
  set shellslash
endif


" Probably shouldn't allow for a range but this needs a good amount of
" debugging anyway
command! -bang Profile
      \ -complete=buffer,file
      \ -nargs=1 -range=%
      \ call vimscript#profile(<bang>0)

" Atexit: {{{1

let &cpoptions = s:cpo_save
unlet s:cpo_save
