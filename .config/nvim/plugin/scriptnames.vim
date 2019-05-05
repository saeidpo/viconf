
" Scriptnames:

function! g:Scriptnames(re)  " {{{1
" Command to filter :scriptnames output by a regex
    redir => scriptnames
    silent scriptnames
    redir END

    let filtered = filter(split(scriptnames, "\n"), "v:val =~ '" . a:re . "'")
    echo join(filtered, ' \n ')
endfunction
command! -nargs=? Scriptnames call g:Scriptnames(<f-args>)


function! g:ScriptnamesDict() abort  " {{{1
" From 10,000 lines deep in :he eval
" Get the output of ":scriptnames" in the scriptnames_output variable.
" Call by entering `:echo g:ScriptNamesDict()` or the command below.
  let scriptnames_output = ''
  redir => scriptnames_output
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

command! -nargs=0 Scriptnamesdict echo g:ScriptnamesDict()