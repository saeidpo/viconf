" Neovim Configuration:
" Maintainer: Faris Chugthai
" Last Change: Jul 06, 2019

" Preliminaries: {{{1
scriptencoding utf-8
let s:cpo_save = &cpoptions
set cpoptions-=c

" OS Setup: {{{2
" Termux check from Evervim. Thanks!
let g:termux = isdirectory('/data/data/com.termux')
let g:ubuntu = has('unix') && !has('macunix') && empty(g:termux)
" How is `has('win32')` a nvim specific thing. Tried in vim and it didn't work!
" TODO: !has('unix') is easier
let g:windows = has('win32') || has('win64')
let g:wsl = has('wsl') " TODO: it doesn't work. - From wsl

" unabashedly stolen from junegunn dude is too good.
let g:local_vimrc = fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/init.vim.local'
runtime g:local_vimrc

if !has('unix') | runtime winrc.vim | endif

set sessionoptions+=unix,slash

" Factor out all of the remote hosts stuff.
runtime remote.vim

" Vim Plug And Third Party Packages: {{{1
" Plug Check: {{{2
let s:plugins = filereadable(expand(stdpath('data') . '/site/autoload/plug.vim'))

if empty(s:plugins)
  " bootstrap plug.vim on new systems
  function! s:InstallPlug() abort

    if empty(executable('curl'))
      finish  " what scope does this statement end?
    endif

    try
      " Successfully executed on termux
      execute('!curl --progress-bar --create-dirs -Lo '
            \ . stdpath('data') . '/site/autoload/plug.vim'
            \ . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    catch
      echo v:exception
    endtry
  endfunction

  call <SID>InstallPlug()
endif

" Define The Plugs Dict: {{{2
" Don't assume that the InstallPlug() func worked so ensure it's defined
if empty('plugs') | let plugs = {} | else
  runtime junegunn.vim
endif

" General Syntax Highlighting: {{{1
" Gruvbox: {{{2
set synmaxcol=400                       " Lower max syntax highlighting

function! s:Gruvbox() abort
  " Define Gruvbox parameters and then set the colorscheme.
  let g:gruvbox_contrast_hard = 1
  let g:gruvbox_contrast_soft = 0
  let g:gruvbox_improved_strings = 1
  let g:gruvbox_italic = 1
  colorscheme gruvbox
endfunction

call s:Gruvbox()
syntax sync fromstart

" Builtin Plugins: {{{1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1

" Leader And Viminfo: {{{2
noremap <Space> <nop>
let g:maplocalleader = '<Space>'
map <Space> <Leader>

" if has(nvim-0.4): {{{1
if has('nvim-0.4')
  let &shadafile = stdpath('data') . '/shada/main.shada'
  " toggle transparency in the pum
  set pumblend=80
  try
    set pyxversion=3
  catch /^Vim:E518:*/
  endtry
endif

" Backups: {{{1

" Protect changes between writes. Default values of updatecount
" (200 keystrokes) and updatetime (4 seconds) are fine
set swapfile        " also note nvim sets directory to stdpath(data) . /swap

" persist the undo tree for each file
let &undodir = stdpath('config') . '/undodir'
set undofile

set backupext='.bak'        " like wth is that ~ nonsense?

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has('patch-8.1.0251')
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
  let &backupdir=stdpath('config') . '/undodir//'
end

" Global Options: {{{1
" Pep8 Global Options: {{{2
if &tabstop > 4 | set tabstop=4 | endif
if &shiftwidth > 4  | set shiftwidth=4 | endif
set expandtab smarttab      " On pressing tab, insert 4 spaces
set softtabstop=4
let g:python_highlight_all = 1

" Folds: {{{2
set foldenable
set foldlevelstart=0 foldlevel=0 foldnestmax=10 foldmethod=marker
" Use 2 columns to indicate fold level and whether a fold is open or closed.
set foldcolumn=2      " If less than 2 is used it can get pushed off screen in the TUI
set signcolumn=yes    " not fold related but signcolumn and foldcolumn seem close

" Buffers Windows Tabs: {{{2
try | set switchbuf=useopen,usetab,newtab | catch | endtry

set hidden
set splitbelow splitright
" Resize windows automatically. nvim also autosets equalalways
set winfixheight winfixwidth

" Admittedly I kinda know why the screen looks so small
if &textwidth!=0 | setl colorcolumn=+1 | else | setl colorcolumn=80 | endif
set cmdheight=2
set number relativenumber

" Spell Checker: {{{2
set spelllang=en spellsuggest=5

if filereadable(stdpath('config') . '/spell/en.utf-8.add')
  let &spellfile = stdpath('config') . '/spell/en.utf-8.add'
endif

" Autocompletion: {{{2
set wildmode=full:list:longest,full:list
set wildignore+=*.a,*.o,*.pyc,*~,*.swp,*.tmp

" A list of words that change how command line completion is done.
" Currently only one word is allowed: tagfile
set wildoptions=tagfile

set complete+=kspell                    " Autocomplete in insert mode
" Create a preview window and display all possibilities but don't insert
set completeopt=menu,menuone,noselect,noinsert,preview

" don't show more than 15 choices in the popup menu. defaults to 0
set pumheight=15

set ignorecase             " both smartcase and infercase require ignorecase to be set
set smartcase infercase    " the case when you search for stuff

" Path: {{{2
set path+=**                            " Recursively search dirs with :find
let &path = &path . ',' . stdpath('config')
let &path = &path . ',' . stdpath('data')
let &path = &path . ',' . expand('$VIMRUNTIME')

if &term =~# 'xterm-256color' || &term ==# 'cygwin' || &term ==# 'builtin_tmux'
      \ || &term ==# 'tmux-256color' || &term ==# 'builtin-vtpcon'
  set termguicolors

elseif exists('ConEmuAnsi')
  set termguicolors
endif

set makeencoding=char         " Used by the makeprg. system locale is used

" Other Global Options: {{{2
if &formatexpr ==# '' | setlocal formatexpr=format#Format() | endif

set tags+=./tags,./*/tags,~/projects/**/tags
set tagcase=smart
set showfulltag

set mouse=a
set isfname-==

if has('unix') | set autochdir | endif     " I think this is what's killing windows
set whichwrap+=<,>,h,l,[,]              " Reasonable line wrapping
set nojoinspaces
" Filler lines to keep text synced, 3 lines of context on diffs, don't diff hidden files,default foldcolumn is 2
set diffopt=filler,context:3,hiddenoff,foldcolumn:1
 if has('patch-8.1.0360')
	set diffopt+=internal,algorithm:patience
endif

set modeline
set autochdir browsedir="buffer"   " which directory is used for the file browser
let &showbreak = '↳ '                   " Indent wrapped lines correctly
set breakindent breakindentopt=sbr
set updatetime=100
set inccommand=split
let g:tutor_debug = 1
set terse     " Don't display the message when a search hits the end of file
set shortmess+=a
set shortmess-=tT
set sidescroll=10                       " Didn't realize the default is 1

" Mappings: {{{1
" General_Mappings: {{{2
" I accidentally do this so often it feels necessary
noremap q; q:
noremap Q @q
vnoremap <BS> d
" Switch CWD to the directory of the open buffer
noremap <Leader>cd <Cmd>cd %:p:h<CR><Bar><Cmd>pwd<CR>
" Save a file as root
noremap <Leader>W <Cmd>w !sudo tee % > /dev/null<CR>
noremap <Leader>sp <Cmd>setlocal spell!<CR>
noremap <Leader>s= z=

" Junegunn: {{{2
noremap <Leader>o o<Esc>
noremap <Leader>O O<Esc>
vnoremap < <gv
vnoremap > >gv
" I just realized these were set to nnoremap. Meaning visual mode doesn't get this mapping
noremap j gj
noremap k gk
" Help docs reminded me I hadn't done this!
noremap <Up> gk
noremap <Down> gj

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>
" Complete whole filenames/lines with a quicker shortcut key in insert mode
" Leave these as recursive mappings though
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>
" Let's add in dictionary, tags and a few others
imap <C-k> <C-x><C-k>
imap <C-]> <C-x><C-]>
imap <C-d> <C-x><C-d>
imap <C-i> <C-x><C-i>

" Dude read over :he getcharsearch(). Now ; and , search forward backward no matter what!!!
noremap <expr> ; getcharsearch().forward ? ';' : ','
noremap <expr> , getcharsearch().forward ? ',' : ';'

" Runtime: {{{1
" Matching Parenthesis: {{{2

runtime macros/matchit.vim

set showmatch matchpairs+=<:>
" Show the matching pair for 2 seconds
set matchtime=20

" From pi_paren.txt
" Matching parenthesises are highlighted A timeout of 300 msec (60 msec in Insert mode). This can be changed with the
" variables and their buffer-local equivalents b:matchparen_timeout and b:matchparen_insert_timeout.
let g:matchparen_timeout = 500
let g:matchparen_insert_timeout = 300

" Omnifuncs: {{{2

augroup omnifunc
    autocmd!
    autocmd Filetype c,cpp            setlocal omnifunc=ccomplete#Complete
    autocmd Filetype css              setlocal omnifunc=csscomplete#CompleteCSS
    autocmd Filetype html,xhtml       setlocal omnifunc=htmlcomplete#CompleteTags | call htmlcomplete#DetectOmniFlavor()
    autocmd Filetype javascript       setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd Filetype python           setlocal omnifunc=python3complete#Complete
    autocmd Filetype ruby             setlocal omnifunc=rubycomplete#Complete
    autocmd Filetype xml              setlocal omnifunc=xmlcomplete#CompleteTags

    " If there isn't a default or built-in, use the syntax highlighter
    autocmd Filetype *
        \   if &omnifunc == "" |
        \       setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
augroup END

" Functions_Commands: {{{1
" Statusline: {{{2

function! s:statusline_expr() abort
  " Define statusline groups for WebDevIcons, Fugitive and other plugins.
  " Define empty fallbacks if those plugins aren't installed. Then
  " use the builtins to fill out the information.
  if exists('*WebDevIconsGetFileTypeSymbol')
    let dicons = ' %{WebDevIconsGetFileTypeSymbol()} '
  else | let dicons = '' | endif
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
if exists('*CSV_WCol')
    let csv = '%1*%{&ft=~"csv" ? CSV_WCol() : ""}%*'
else | let csv = '' | endif

if exists('*strftime')
" Overtakes the whole screen when Termux zooms in
  if &columns > 80
    let tstmp = ' ' . '%{strftime("%H:%M %m/%d/%Y", getftime(expand("%:p")))}'  " last modified timestamp
  else | let tstmp = '' | endif
else | let tstmp = '' | endif

let cocline = StatusDiagnostic()

  return '[%n] %f '. dicons . '%m' . '%r' . ' %y ' . fug . csv . ' ' . ' %{&ff} ' . tstmp . cocline . sep . pos . '%*' . ' %P'
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let &statusline = <SID>statusline_expr()

" Clear Hlsearch: {{{2

set nohlsearch
augroup vimrc_incsearch_highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" NewGrep: {{{2
" he quickfix
command! -nargs=+ NewGrep execute 'silent grep! <args>' | copen

" Title: {{{2
" From `:he change`  line 352 tag g?g?
" Adding range means that the command defaults to current line
" Need to add a check that we're in visual mode and drop the '<,'> if not.
command! -nargs=0 -range Title <Cmd>'<,'>s/\v<(.)(\w*)/\u\1\L\2/g

" Atexit: {{{1
let &cpoptions = s:cpo_save
unlet s:cpo_save
