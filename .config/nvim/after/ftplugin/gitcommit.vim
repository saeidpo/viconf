" Git_Commit:

" Thoughtbot: {{{1
" Taken from:
" <https://github.com/thoughtbot/dotfiles/blob/master/vim/ftplugin/gitcommit.vim>

" Automatically wrap at 72 characters and spell check commit messages
setlocal textwidth=72
setlocal spell

" General: {{{1
" Keep the first line of a git commit 50 char long and everything after 72.
setlocal colorcolumn=50,73
setlocal linebreak

" If you want a hint at the required hl-ColorColumn syntax.
" hi ColorColumn ctermbg=lightgrey guibg=lightgrey
