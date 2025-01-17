" ============================================================================
  " File: vimscript.vim
  " Author: Faris Chugthai
  " Description: Helpers for writing Vimscript files
  " Last Modified: July 13, 2019
" ============================================================================

" Guards: {{{1
let s:cpo_save = &cpoptions
set cpoptions-=C

" Global Ftplugin: {{{1

function! vimscript#after_ft() abort

  let s:debug = 1
  let s:cur_ft = &filetype
  let s:after_ftplugin_dir = fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/after/ftplugin/'
  let s:after_ftplugin_file = s:after_ftplugin_dir . s:cur_ft . '.vim'
  let s:ftplugin_dir = fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/ftplugin/'
  let s:ftplugin_file = s:ftplugin_dir . s:cur_ft . '.vim'

  if file_readable(s:ftplugin_file)
    if s:debug | echomsg 's:ftplugin is ' . string(s:ftplugin_file) | endif
    exec 'edit ' . s:ftplugin_file
    return

  elseif file_readable(s:after_ftplugin_file)
    if s:debug | echomsg 's:ftplugin is ' . string(s:after_ftplugin_file) | endif
    exec 'edit ' . s:after_ftplugin_file
    return

  elseif file_readable(fnamemodify(resolve(stdpath('config') . '/ftplugin' . s:cur_ft . '.vim')))
    exec 'edit ' . stdpath('config') . '/ftplugin/' . s:cur_ft . '.vim'
    return

  elseif file_readable(fnamemodify(resolve(stdpath('config') . '/after/ftplugin' . s:cur_ft . '.vim')))
    exec 'edit ' . stdpath('config') . '/after/ftplugin/' . s:cur_ft . '.vim'
    return

  " If we can't find anything I wrote at least show me the default
  elseif v:true
    exec 'split $VIMRUNTIME/ftplugin/' . s:cur_ft . '.vim'
  endif

  echomsg 'No ftplugin found!'

  " This seems like a reasonable return after a fail.
  return v:False

endfunction


function! vimscript#BetterProfiler(fname) abort  " {{{1
  " Because Vim's built in profiling capabilities are nonsensical like wtf?

  " Toggle debugging
  let s:Debug = 1

  let s:logfile = expand(stdpath('data') . '/site/profile.log')
  profile! start s:logfile

  if s:Debug
  " echomsg fname actually causes an error so that's good i guess
    echomsg string(a:fname)
  endif

" :prof[ile][!] file {pattern}
" 		Profile script file that matches the pattern {pattern}.
" 		See |:debug-name| for how {pattern} is used.
" 		This only profiles the script itself, not the functions
" 		defined in it.
" 		When the [!] is added then all functions defined in the script
" 		will also be profiled.
" 		Note that profiling only starts when the script is loaded
" 		after this command.  A :profile command in the script itself
" 		won't work.
  profile file a:fname
  source a:fname
  profile stop
  profile dump

  exec 'e ' a:fname

endfunction

" let s:Debug = 1
" let b:fname = '~/projects/viconf/.config/nvim/colors/gruvbox8.vim'
" call g:BetterProfiler(b:fname)

" AH I forgot Junegunn has one written as well!

" Profile: {{{1

" Profile a func or file. Oooo I could use XDG_DATA_HOME instead of _ROOT there
function! vimscript#profile(bang) abort
  if a:bang
    profile pause
    noautocmd qall
  else
    let s:logfile = expand(stdpath('data') . '/site/profile.log')
    profile start s:logfile
    profile func *
    profile file *
  endif
endfunction


function! vimscript#Scriptnames(re) abort  " {{{1
" Command to filter :scriptnames output by a regex
    redir => scriptnames
    silent scriptnames
    redir END

    let filtered = filter(split(scriptnames, "\n"), "v:val =~ '" . a:re . "'")
    echo join(filtered, ' \n ')
endfunction


function! vimscript#ScriptnamesDict() abort  " {{{1
" From 10,000 lines deep in :he eval
" Get the output of ":scriptnames" in the scriptnames_output variable.
" Call by entering `:echo g:ScriptNamesDict()` or the command below.
  let s:scriptnames_output = ''
  redir => s:scriptnames_output
  silent scriptnames
  redir END

  " Split the output into lines and parse each line.	Add an entry to the "scripts" dictionary.
  let scripts = {}
  for line in split(scriptnames_output, "\n")
    " Only do non-blank lines.
    if line =~ '\S'
      " Get the first number in the line.
      let nr = matchstr(line, '\d\+')
      " Get the file name, remove the script number " 123: ".
      let name = substitute(line, '.\+:\s*', '', '')
      " Add an item to the Dictionary
      let scripts[nr] = name
    endif
  endfor

  " TODO: that var is pretty hard to read. can we format the output?
  " pretty_printed = keys(scripts)

  " We didn't scope the var so is the below line necessary?
  " unlet scriptnames_output
  return scripts
endfunction

function s:get_scriptnames() abort  " {{{1
  let s:scriptnames_output = ''
  redir => s:scriptnames_output
  silent scriptnames
  redir END
  return s:scriptnames_output
endfunction


function! vimscript#fzf_scriptnames() abort  " {{{1
  " TODO: Why is the LSP complaining?
  call fzf#vim#run(fzf#wrap({s:get_scriptnames()},
        \ 0,
        \ 0,
        \ <bang>0 ? fzf#vim#with_preview('up:60%')
        \ : fzf#vim#with_preview('right:50%:hidden', '?'),
        \ <bang>0))
endfunction


" Atexit: {{{1
let &cpoptions = s:cpo_save
unlet s:cpo_save
