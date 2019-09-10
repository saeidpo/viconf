" ============================================================================
  " File: man.vim
  " Author: Faris Chugthai
  " Description: Autoloaded functions for working with help buffers
  " Last Modified: July 23, 2019
" ============================================================================

" Guards: {{{1
let s:cpo_save = &cpoptions
set cpoptions-=C

" Pydoc Cword: {{{1
function! pydoc_help#PydocCword() abort

  " Holy shit it works!!!
  let s:temp_cword = expand('<cWORD>')
  enew
  exec ':r! pydoc ' . s:temp_cword
  setlocal relativenumber
  setlocal filetype=rst
  setlocal nomodified
  setlocal buflisted
  silent setlocal nomodifiable

  " If you wanna keep going we can change the status line. We can change how
  " we invoke python
endfunction

" Pydoc Split Cword: {{{1
function! pydoc_help#SplitPydocCword() abort
  let s:temp_cword = expand('<cWORD>')
  split
  enew
  exec ':r! pydoc ' . s:temp_cword
  setlocal relativenumber
  setlocal filetype=rst
  setlocal nomodified
  setlocal buflisted
  silent setlocal nomodifiable
endfunction

" Pydoc Arg: {{{1

function! pydoc_help#Pydoc(module) abort

  " Look at me handling user configured arguments!
  if exists('g:pydoc_window')
    if type('g:pydoc_window') == v:t_string
      exec g:pydoc_window
    else
      throw '/autoload/pydoc_help:'
            \ . ' g:pydoc_window needs to be one of "split" "vsplit" or "tabe"'
    endif
  else
    split
  endif

  enew
  " exec ':r! pydoc ' . a:module
  " so the above will have to be modified to allow for py3 if it exists
  " in the plugin definition i only check for either python3 or python2
  " so there's no need to throw an error that neither are loaded. they have
  " to be. however i just loaded py2 docs by accident.
  " i could go the route of calling provider#python3#Call(); however, I can't
  " find the docs for it and the source code is outrageously unclear so fuck
  " it dispatch it to the shell and walk away
  if has('python3')
    if !has('unix')
      exec 'r! python.exe -m pydoc ' . a:module
    else
      exec 'r! python3 -m pydoc ' . a:module
    endif
  elseif has('python')  " not sure how to guarantee that python points to py2...
    exec 'r! python -m pydoc ' . a:module
  endif

  setlocal relativenumber
  setlocal filetype=rst
  setlocal buflisted
  silent setlocal nomodified
  silent setlocal nomodifiable
  nnoremap <buffer> <silent> q <Cmd>bd!<CR>

  " If you wanna keep going we can change the status line.
endfunction

" Helptags: {{{1

function! pydoc_help#Helptab() abort
  setlocal number relativenumber
  if exists('*nvim_list_wins')
    if len(nvim_list_wins()) > 1
      wincmd T
    endif
  else
    return
  endif

  setlocal nomodified
  setlocal buflisted
  " Complains that we can't modify any buffer.
  " But its a local option so yes we can
  " Fuck it use a try catch to shut it up
  try
    silent setlocal nomodifiable
  catch /^Vim:E788:*/
  endtry
endfunction

" Async Pydoc: {{{1

" Dude this actually works
function! pydoc_help#async_cursor() abort

  call jobstart('pydoc ' . expand('<cWORD>'), {'on_stdout':{j,d,e->append(line('.'),d)}})
endfunction

function! pydoc_help#broken_scratch_buffer() abort  " {{{1
 
  " From he api-floatwin. Only new versions of Nvim (maybe 0.4+ only?)
  let buf = nvim_create_buf(v:false, v:true)

  " original: should fill with pydoc output
  " call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])
  let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
      \ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}
  let win = nvim_open_win(buf, 0, opts)
  " optional: change highlight, otherwise Pmenu is used
  " call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')

  " To close the float, |nvim_win_close()| can be used.
endfunction

function! pydoc_help#sphinx_build(...) abort  " {{{1
  " TODO: 
endfunction

function! pydoc_help#the_curse_of_nvims_floating_wins() abort  " {{{1 No seriously they're difficult to work with
  " Keep working out the 
  let s:opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0, 'row': 1, 'anchor': 'NW', 'style': 'minimal', 'focusable': v:true }
  let s:win_handle = nvim_open_win(bufnr('%'), 0, s:opts)
  let floating_winnr  = nvim_win_get_number(s:win_handle)
  " So now we finally have a winnr which we can work with in a more reasonable
  " fashion. Sweet!!
  call nvim_win_set_option(s:win_handle, 'winhl', 'Special')
endfunction
 
" Pydoc.vim: {{{1
" Don't redefine the functions if this ftplugin has been executed previously
" and before finish create the local mappings in the current buffer
if !has('python3') |  finish | endif

if exists('*s:ShowPyDoc') && g:pydoc_perform_mappings
    call s:PerformMappings()
    finish
endif
 
if !exists('g:pydoc_perform_mappings')
    let g:pydoc_perform_mappings = 1
endif
 
if !exists('g:pydoc_highlight')
    let g:pydoc_highlight = 1
endif
 
if !exists('g:pydoc_cmd')
    let g:pydoc_cmd = ':python3 -m pydoc'
endif
 
if !exists('g:pydoc_open_cmd')
    let g:pydoc_open_cmd = 'split'
endif
 
highlight pydoc cterm=reverse gui=reverse
 
function! s:GetWindowLine(value)   " {{{2
    if a:value < 1
        return float2nr(winheight(0)*a:value)
    else
        return a:value
    endif
endfunction
 
" Args: name: lookup; type: 0: search, 1: lookup
function! pydoc_help#ShowPyDoc(name, type) abort  " {{{2
    if a:name == ''
        return
    endif
 
    if g:pydoc_open_cmd == 'split'
        if exists('g:pydoc_window_lines')
            let l:pydoc_wh = s:GetWindowLine(g:pydoc_window_lines)
        else
            let l:pydoc_wh = 10
        endif
    endif
 
    if bufloaded("__doc__")
        let l:buf_is_new = 0
        if bufname("%") == "__doc__"
            " The current buffer is __doc__, thus do not
            " recreate nor resize it
            let l:pydoc_wh = -1
        else
            " If the __doc__ buffer is open, jump to it
            if exists("g:pydoc_use_drop")
                execute "drop" "__doc__"
            else
                execute "sbuffer" bufnr("__doc__")
            endif
            let l:pydoc_wh = -1
        endif
    else
        let l:buf_is_new = 1
        execute g:pydoc_open_cmd '__doc__'
        if g:pydoc_perform_mappings
            call s:PerformMappings()
        endif
    endif
 
    setlocal modifiable
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal syntax=man
    setlocal nolist
 
    normal ggdG
    " Remove function/method arguments
    let s:name2 = substitute(a:name, '(.*', '', 'g' )
    " Remove all colons
    let s:name2 = substitute(s:name2, ':', '', 'g' )
    if a:type == 1
        let s:cmd = g:pydoc_cmd . ' ' . shellescape(s:name2)
    else
        let s:cmd = g:pydoc_cmd . ' -k ' . shellescape(s:name2)
    endif
    if &verbose
        echomsg "pydoc: calling " s:cmd
    endif
    execute  "silent read !" s:cmd
    normal 1G
 
    if exists('l:pydoc_wh') && l:pydoc_wh != -1
        execute "resize" l:pydoc_wh
    end
 
    if g:pydoc_highlight == 1
        execute 'syntax match pydoc' "'" . s:name2 . "'"
    endif
 
    let l:line = getline(2)
    if l:line =~ "^no Python documentation found for.*$"
        if l:buf_is_new
            execute "bdelete!"
        else
            normal u
            setlocal nomodified
            setlocal nomodifiable
        endif
        redraw
        echohl WarningMsg | echo l:line | echohl None
    else
        setlocal nomodified
        setlocal nomodifiable
    endif
endfunction
 
function! s:ReplaceModuleAlias()  " {{{2
    " Replace module aliases with their own name.
    "
    " For example:
    "   import foo as bar
    " if `bar` is in the ExpandModulePath's return value, it should be
    " replaced with `foo`.
    let l:cur_col = col(".")
    let l:cur_line = line(".")
    let l:module_path = s:ExpandModulePath()
    let l:module_names = split(l:module_path, '\.')
    let l:module_orig_name = l:module_names[0]
    if search('import \+[0-9a-zA-Z_.]\+ \+as \+' . l:module_orig_name)
        let l:line = getline(".")
        let l:name = matchlist(l:line, 'import \+\([a-zA-Z0-9_.]\+\) \+as')[1]
        if l:name != ''
            let l:module_orig_name = l:name
        endif
    endif
    if l:module_names[0] != l:module_orig_name
        let l:module_names[0] = l:module_orig_name
    endif
    call cursor(l:cur_line, l:cur_col)
    return join(l:module_names, ".")
endfunction
 
function! s:ExpandModulePath()  " {{{2
    " Extract the 'word' at the cursor, expanding leftwards across identifiers
    " and the . operator, and rightwards across the identifier only.
    "
    " For example:
    "   import xml.dom.minidom
    "           ^   !
    "
    " With the cursor at ^ this returns 'xml'; at ! it returns 'xml.dom'.
    let l:line = getline(".")
    let l:pre = l:line[:col(".") - 1]
    let l:suf = l:line[col("."):]
    return matchstr(pre, "[A-Za-z0-9_.]*$") . matchstr(suf, "^[A-Za-z0-9_]*")
endfunction
 
" Mappings
function! s:PerformMappings()  " {{{2
    nnoremap <silent> <buffer> <Leader>pw :call <SID>ShowPyDoc('<C-R><C-W>', 1)<CR>
    nnoremap <silent> <buffer> <Leader>pW :call <SID>ShowPyDoc('<C-R><C-A>', 1)<CR>
    nnoremap <silent> <buffer> <Leader>pk :call <SID>ShowPyDoc('<C-R><C-W>', 0)<CR>
    nnoremap <silent> <buffer> <Leader>pK :call <SID>ShowPyDoc('<C-R><C-A>', 0)<CR>
 
    " remap the K (or 'help') key
    nnoremap <silent> <buffer> K :call <SID>ShowPyDoc(<SID>ReplaceModuleAlias(), 1)<CR>
endfunction
 
if g:pydoc_perform_mappings
    call s:PerformMappings()
endif
 
" Commands
" Atexit: {{{1
let &cpoptions = s:cpo_save
unlet s:cpo_save
