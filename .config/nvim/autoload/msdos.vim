" ============================================================================
    " File: msdos.vim
    " Author: Faris Chugthai
    " Description: Windows specific modifications
    " Last Modified: Aug 18, 2019
" ============================================================================

" Guards: {{{1
if has('unix') | finish | endif

let s:debug = 1

let s:cpo_save = &cpoptions
set cpoptions-=C

" Options: {{{1
if exists('+shellslash')   " don't drop the +!
  set shellslash
endif

" I'm running pwsh but honestly the support is too sloppy.

" In usr_41 it's mentioned that files formatted with dos formatting won't
" run vim scripts correctly so holy shit that might explain a hell of a lot
set fileformats=unix,dos

" slash" and "unix" are useful on Windows when sharing view files
" with Unix.  The Unix version of Vim cannot source dos format scripts,
" but the Windows version of Vim can source unix format scripts.
set sessionoptions+=unix,slash viewoptions+=unix,slash

" ConEmu is complaining but it stops if we do this
if !empty($TERM) | unlet $TERM | endif

" So this HAS to be a bad idea; however, all 3 DirChanged autocommands emit
" errors and that's a little insane
" set eventignore=DirChanged

function! msdos#Cmd() abort  " {{{1

  " All the defaults when running cmd as comspec on windows 10
  set shell=cmd.exe
  " set shellcmdflag=/s\ /c
  set shellpipe=>%s\ 2>&1
  set shellredir=>%s\ 2>&1
  " Is this necessary? Or should it be empty?
  set shellxquote=(
  set shellxescape=^
  " What about setting shellquote to "" so that cmd gets the args quoted?

endfunction

command! Cmd call msdos#Cmd()

function! msdos#PowerShell() abort  " {{{1

  " 07/23/2019: Just found out that even when using powershell comspec is
  " supposed to be set to cmd. Explains a few things
  if !empty($SHELL) | unlet! $SHELL | endif
  let $SHELL = 'C:/pwsh/7-preview/pwsh.exe'
  set shell=pwsh.exe
  set shellquote=
  set shellxquote=
  set shellpipe=\| shellredir=> shellxquote=
  let &shellcmdflag = '-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -Command '
  set shellredir=\|\ Out-File\ -Encoding\ UTF8\ %s
  set shellpipe=\|\ Out-File\ -Encoding\ UTF8\ %s

   echomsg 'Using powershell as the system shell.'
   return
endfunction

command! PowerShell call msdos#Powershell()

" Holy hell is this annoying don't do this!!
" cabbrev pwsh PowerShell

function! msdos#pwsh_help(helppage) abort

  echomsg 'Setting the shell to powershell.'
  call msdos#PowerShell()
  r!pwsh -noprofile -nologo -command get-help a:helppage

  echomsg 'Note that shell was not restored'

endfunction

command! PwshHelp call msdos#pwsh_help(shellescape(<f-args>))

" Atexit: {{{1

let &cpoptions = s:cpo_save
unlet s:cpo_save
