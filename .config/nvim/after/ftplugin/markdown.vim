" ============================================================================
    " File: markdown.vim
    " Author: Faris Chugthai
    " Description: Markdown
    " Last Modified: April 20, 2019
" ============================================================================

" Guard: {{{1
if exists('g:did_markdown_after_ftplugin') || &compatible || v:version < 700
  finish
endif
let g:did_markdown_after_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions-=C

" Options: {{{1

" Enable spellchecking.
setlocal spell!

" Automatically wrap at 80 characters after whitespace
setlocal textwidth=80
setlocal colorcolumn=80
" Then break lines if they're too long.
" setlocal linebreak

" Fix tabs so that we can have ordered lists render properly
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

let g:markdown_folding = 1

" TPope's markdown plugin. Light enough footprint when settings vars to not
" need a check
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

let g:markdown_minlines = 100

setlocal foldtext=MarkdownFoldText()

" Mappings: {{{1

" I don't know if you're supposed to run an initial au! for augroups that
" only define Filetype events. I think it's supposed to be reserved for when
" the event is as common as BufReadPre or BufNewFile or something.
augroup filetype_markdown

    " autocmd!
    autocmd FileType markdown noremap <buffer> <localleader>1 m`yypVr=``
    autocmd FileType markdown noremap <buffer> <localleader>2 m`yypVr-``
    autocmd FileType markdown noremap <buffer> <localleader>3 m`^i### <esc>``4l
    autocmd FileType markdown noremap <buffer> <localleader>4 m`^i#### <esc>``5l
    autocmd FileType markdown noremap <buffer> <localleader>5 m`^i##### <esc>``6l
augroup END

" Plugins: {{{1


function! MarkdownFoldText()  " TPope

  let hash_indent = s:HashIndent(v:foldstart)
  let title = substitute(getline(v:foldstart), '^#\+\s*', '', '')
  let foldsize = (v:foldend - v:foldstart + 1)
  let linecount = '['.foldsize.' lines]'
  return hash_indent.' '.title.' '.linecount

endfunction

function! ALE_Markdown_Conf()

  let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']

endfunction

if has_key(plugs, 'ale')
  call ALE_Markdown_Conf()
endif

" Atexit: {{{1

let b:undo_ftplugin = 'set spell< cc< tw< et< ts< sts< sw<'

let &cpoptions = s:cpo_save
unlet s:cpo_save
