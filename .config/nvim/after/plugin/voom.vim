" ============================================================================
    " File: voom.vim
    " Author: Faris Chugthai
    " Description: voom configuration
    " Last Modified: April 02, 2019
" ============================================================================

" Guard: {{{1
if !has_key(plugs, 'voom')
    finish
endif

if exists('g:did_voom_conf') || &compatible || v:version < 700
    finish
endif
let g:did_voom_conf = 1


" Options: {{{1
"g:voom_ft_modes" is a Vim dictionary: keys are filetypes (|ft|), values are
" corresponding markup modes (|voom-markup-modes|). Example:
    " let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}
" This option allows automatic selection of markup mode according to the filetype
" of the source buffer. If 'g:voom_ft_modes' is defined as above, and 'filetype'
" of the current buffer is 'tex', then the command
    " :Voom
" is identical to the command
    " :Voom latex

" g:voom_default_mode" is a string with the name of the default markup mode.
" For example, if there is this in .vimrc:
    " let g:voom_default_mode = 'asciidoc'
" then, the command
    " :Voom
" is identical to
    " :Voom asciidoc
" unless 'g:voom_ft_modes' is also defined and has an entry for the current
" filetype.

let g:voom_ft_modes = {'markdown': 'markdown', 'rst': 'rst', 'zimwiki': 'dokuwiki'}
let g:voom_default_mode = 'rst'
let g:voom_python_versions = [3]