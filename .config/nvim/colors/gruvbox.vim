" Description: Retro groove color scheme for Vim
" Maintainer: Faris Chugthai
" Previous Maintainer: morhetz <morhetz@gmail.com>
" Original Source: https://github.com/morhetz/gruvbox
" Last Modified: Sep 29, 2019
" -----------------------------------------------------------------------------

" Go to line 475 for where my section starts.
" Areas to note are that the color pallette is on line87.
" Guards: {{{
if exists('g:did_gruvbox_colors') || &compatible || v:version < 700
		finish
endif
" let g:did_gruvbox_colors = 1

scriptencoding utf8

let s:cpo_save = &cpoptions
set cpoptions-=C
" }}}
" Supporting Code: -------------------------------------------------------- {{{
" Initialisation: {{{

if v:version > 580
	hi clear
	if exists('syntax_on')
		syntax reset
	endif
endif

let g:colors_name='gruvbox'

" }}}
" Global Settings: {{{

if !exists('g:gruvbox_bold')
	let g:gruvbox_bold = 1
endif

if !exists('g:gruvbox_italic')
	if has('gui_running') || $TERM_ITALICS ==? 'true'
		let g:gruvbox_italic = 1
	else
		let g:gruvbox_italic = 0
	endif
endif

if !exists('g:gruvbox_undercurl')
	let g:gruvbox_undercurl=1
endif

if !exists('g:gruvbox_underline')
	let g:gruvbox_underline=1
endif

if !exists('g:gruvbox_inverse')
	let g:gruvbox_inverse=1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
	let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_termcolors')
	let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
	let g:gruvbox_invert_indent_guides=0
endif

if exists('g:gruvbox_contrast')
	echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
	let g:gruvbox_contrast_dark='medium'
elseif !exists('g:gruvbox_contrast_light')
	let g:gruvbox_contrast_light='medium'
endif

let s:is_dark=(&background ==? 'dark')

" }}}
" The actual color pallette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#1d2021', 234]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

" These 2 are comment string colors. If you wanna see a variation
" on how bright or dark that colors is go here and check it out
" http://www.0to255.com/928374
let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
" let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
" Yo but honestly the bright aqua is green. 142-192-224 is way more aqua
" Sorry i don't know how to figure out what the corresponding 0-255 value is
let s:gb.bright_aqua    = ['#8ec0e1', 108]     " 142-192-224
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis Options: {{{

let s:bold = 'bold,'
if g:gruvbox_bold == 0
	let s:bold = ''
endif

let s:italic = 'italic,'
if g:gruvbox_italic == 0
	let s:italic = ''
endif

let s:underline = 'underline,'
if g:gruvbox_underline == 0
	let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
	let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:gruvbox_inverse == 0
	let s:inverse = ''
endif

" }}}
" Map s:vars to s:vars: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
	let s:bg0  = s:gb.dark0
	if g:gruvbox_contrast_dark ==? 'soft'
		let s:bg0  = s:gb.dark0_soft
	elseif g:gruvbox_contrast_dark ==? 'hard'
		let s:bg0  = s:gb.dark0_hard
	endif

	let s:bg1  = s:gb.dark1
	let s:bg2  = s:gb.dark2
	let s:bg3  = s:gb.dark3
	let s:bg4  = s:gb.dark4

	let s:gray = s:gb.gray_245

	let s:fg0 = s:gb.light0
	let s:fg1 = s:gb.light1
	let s:fg2 = s:gb.light2
	let s:fg3 = s:gb.light3
	let s:fg4 = s:gb.light4

	let s:fg4_256 = s:gb.light4_256

	let s:red    = s:gb.bright_red
	let s:green  = s:gb.bright_green
	let s:yellow = s:gb.bright_yellow
	let s:blue   = s:gb.bright_blue
	let s:purple = s:gb.bright_purple
	let s:aqua   = s:gb.bright_aqua
	let s:orange = s:gb.bright_orange
else
	let s:bg0  = s:gb.light0
	if g:gruvbox_contrast_light ==? 'soft'
		let s:bg0  = s:gb.light0_soft
	elseif g:gruvbox_contrast_light ==? 'hard'
		let s:bg0  = s:gb.light0_hard
	endif

	let s:bg1  = s:gb.light1
	let s:bg2  = s:gb.light2
	let s:bg3  = s:gb.light3
	let s:bg4  = s:gb.light4

	let s:gray = s:gb.gray_244

	let s:fg0 = s:gb.dark0
	let s:fg1 = s:gb.dark1
	let s:fg2 = s:gb.dark2
	let s:fg3 = s:gb.dark3
	let s:fg4 = s:gb.dark4

	let s:fg4_256 = s:gb.dark4_256

	let s:red    = s:gb.faded_red
	" 06/08/2019: This is showing up white on WSL...?
	" GruvboxGreenBold xxx cterm=bold ctermfg=142 gui=bold guifg=#b8bb26

	let s:green  = s:gb.faded_green
	let s:yellow = s:gb.faded_yellow
	let s:blue   = s:gb.faded_blue
	let s:purple = s:gb.faded_purple
	let s:aqua   = s:gb.faded_aqua
	let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
	let s:bg0[1]    = 0
	let s:fg4[1]    = 7
	let s:gray[1]   = 8
	let s:red[1]    = 9
	let s:green[1]  = 10
	let s:yellow[1] = 11
	let s:blue[1]   = 12
	let s:purple[1] = 13
	let s:aqua[1]   = 14
	let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

let g:terminal_ansi_colors = ['#1d2021', '#cc241d', '#98971a', '#d79921',
			\ '#458588', '#b16286', '#689d6a', '#a89984', '#928374', '#fb4934',
			\ '#b8bb26', '#fabd2f', '#83a598', '#d3869b', '#8ec07c', '#ebdbb2']
if has('nvim')
	let g:terminal_color_0 = '#1d2021'
	let g:terminal_color_1 = '#cc241d'
	let g:terminal_color_2 = '#98971a'
	let g:terminal_color_3 = '#d79921'
	let g:terminal_color_4 = '#458588'
	let g:terminal_color_5 = '#b16286'
	let g:terminal_color_6 = '#689d6a'
	let g:terminal_color_7 = '#a89984'
	let g:terminal_color_8 = '#928374'
	let g:terminal_color_9 = '#fb4934'
	let g:terminal_color_10 = '#b8bb26'
	let g:terminal_color_11 = '#fabd2f'
	let g:terminal_color_12 = '#83a598'
	let g:terminal_color_13 = '#d3869b'
	let g:terminal_color_14 = '#8ec07c'
	let g:terminal_color_15 = '#ebdbb2'
endif

" }}}
" Override Default Settings: {{{

let s:hls_cursor = s:orange
if exists('g:gruvbox_hls_cursor')
	let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:gruvbox_number_column')
	let s:number_column = get(s:gb, g:gruvbox_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
			\ g:gitgutter_override_sign_column_highlight == 1
	let s:sign_column = s:number_column
else
	let g:gitgutter_override_sign_column_highlight = 0

	if exists('g:gruvbox_sign_column')
		let s:sign_column = get(s:gb, g:gruvbox_sign_column)
	endif
endif

let s:color_column = s:bg1
if exists('g:gruvbox_color_column')
	let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:gruvbox_vert_split')
	let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvbox_invert_signs')
	if g:gruvbox_invert_signs == 1
		let s:invert_signs = s:inverse
	endif
endif

let s:invert_selection = s:inverse
if exists('g:gruvbox_invert_selection')
	if g:gruvbox_invert_selection == 0
		let s:invert_selection = ''
	endif
endif

let s:invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
	if g:gruvbox_invert_tabline == 1
		let s:invert_tabline = s:inverse
	endif
endif

let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
	if g:gruvbox_italicize_comments == 0
		let s:italicize_comments = ''
	endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
	if g:gruvbox_italicize_strings == 1
		let s:italicize_strings = s:italic
	endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
	" Arguments: group, guifg, guibg, gui, guisp

	" foreground
	let fg = a:fg

	" background
	if a:0 >= 1
		let bg = a:1
	else
		let bg = s:none
	endif

	" emphasis
	if a:0 >= 2 && strlen(a:2)
		let emstr = a:2
	else
		let emstr = 'NONE,'
	endif

	" special fallback
	if a:0 >= 3
		if g:gruvbox_guisp_fallback !=? 'NONE'
			let fg = a:3
		endif

		" bg fallback mode should invert higlighting
		if g:gruvbox_guisp_fallback ==? 'bg'
			let emstr .= 'inverse,'
		endif
	endif

	let histring = [ 'hi', a:group,
				\ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
				\ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
				\ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
				\ ]

	" special
	if a:0 >= 3
		call add(histring, 'guisp=' . a:3[0])
	endif

	execute join(histring, ' ')
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
" call s:HL('GruvboxFg0', s:fg0)
hi GruvboxFg0 ctermfg=229 guifg=#fbf1c7 gui=NONE cterm=NONE guisp=NONE ctermbg=NONE guibg=NONE
call s:HL('GruvboxFg1', s:fg1)
call s:HL('GruvboxFg2', s:fg2)
call s:HL('GruvboxFg3', s:fg3)
call s:HL('GruvboxFg4', s:fg4)
call s:HL('GruvboxGray', s:gray)
call s:HL('GruvboxBg0', s:bg0)
" call s:HL('GruvboxBg1', s:bg1)
call s:HL('GruvboxBg2', s:bg2)
" call s:HL('GruvboxBg3', s:bg3)
call s:HL('GruvboxBg4', s:bg4)

call s:HL('GruvboxRed', s:red)
" OFFICIALLY NOT USED ANYMORE!
" hi GruvboxRedBold cterm=bold ctermfg=167 gui=bold guifg=#fb4934 ctermbg=NONE guibg=NONE guisp=NONE
" call s:HL('GruvboxRedBold', s:red, s:none, s:bold)
call s:HL('GruvboxGreen', s:green)
call s:HL('GruvboxGreenBold', s:green, s:none, s:bold)
call s:HL('GruvboxYellow', s:yellow)
call s:HL('GruvboxYellowBold', s:yellow, s:none, s:bold)
" call s:HL('GruvboxBlue', s:blue)
hi GruvboxBlue ctermfg=109 guifg=#83a598 guibg=NONE ctermbg=NONE guisp=NONE gui=NONE cterm=NONE
" call s:HL('GruvboxBlue', s:blue)
" Mostly green?
" call s:HL('GruvboxBlue', s:blue)
" call s:HL('GruvboxBlueBold', s:blue, s:none, s:bold)
" hi GruvboxBlueBold cterm=bold ctermfg=109 gui=bold guifg=#83a598
call s:HL('GruvboxPurple', s:purple)
" call s:HL('GruvboxPurpleBold', s:purple, s:none, s:bold)
" Aqua is the real blue
" call s:HL('GruvboxAqua', s:aqua)
" hi GruvboxAqua ctermfg=108 guifg=#8ec0e1 cterm=bold gui=bold ctermfg=108 guifg=#8ec0e1
" call s:HL('GruvboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('GruvboxOrange', s:orange)
call s:HL('GruvboxOrangeBold', s:orange, s:none, s:bold)

" call s:HL('GruvboxRedSign', s:red, s:sign_column, s:invert_signs)
hi GruvboxRedSign ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=#3c3836 cterm=NONE gui=NONE guisp=NONE
call s:HL('GruvboxGreenSign', s:green, s:sign_column, s:invert_signs)

" Let's replace GruvboxYellowSign with QuickFixLine
" call s:HL('GruvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
" hi GruvboxYellowSign ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=#3c3836

" hi GruvboxBlueSign ctermfg=109 ctermbg=237 guifg=#83a598 guibg=#3c3836
" call s:HL('GruvboxBlueSign', s:blue, s:sign_column, s:invert_signs)
" hi GruvboxPurpleSign  ctermfg=175 ctermbg=237 guifg=#d3869b guibg=#3c3836
" call s:HL('GruvboxPurpleSign', s:purple, s:sign_column, s:invert_signs)
" call s:HL('GruvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)

" }}}
" }}}
" Vanilla colorscheme ------------------------------------------------------ {{{
" General UI: {{{

if s:is_dark
	set background=dark
else
	set background=light
endif

if v:version >= 700
" }}}
" Completions: {{{
		hi Pmenu guifg=#ebdbb2 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE ctermfg=223 ctermbg=237
		hi PmenuSbar guifg=NONE guibg=#504945 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=187
		hi PmenuSel guifg=#504945 guibg=#83a598 guisp=NONE gui=bold cterm=bold ctermfg=187 ctermbg=23
		hi PmenuThumb guifg=NONE guibg=#7c6f64 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=137
	" }}}
" Cursorline And Tabline: {{{
	" Screen line that the cursor is
	" call s:HL('CursorLine',   s:none, s:bg1)
	hi CursorLine ctermbg=237 guibg=#3c3836 guifg=NONE ctermfg=NONE cterm=NONE gui=NONE guisp=NONE

	" Line number of CursorLine
	" call s:HL('CursorLineNr', s:yellow, s:bg1)
	hi CursorLineNr guifg=#fabd2f guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE ctermbg=237

	" Screen column that the cursor is
	hi! link CursorColumn CursorLine

	" Tab pages line filler
	" call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
	hi TablineFill ctermfg=243 ctermbg=237 guifg=#7c6f64 guibg=#3c3836 guisp=NONE gui=NONE cterm=NONE

	" Active tab page label
	" call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
	hi TabLineSel ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836 cterm=NONE gui=NONE guisp=NONE

	" Not active tab page label. Can you add stuff after the fact?
	hi! link TabLine TabLineFill

	" Match paired bracket under the cursor
	" call s:HL('MatchParen', s:none, s:bg3, s:bold)
	hi MatchParen cterm=bold ctermbg=241 gui=bold guibg=#665c54 guisp=NONE ctermfg=NONE guifg=NONE
endif

" Moved cursor things up to be with the cursorlines:

" Character under cursor
hi Cursor guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
" call s:HL('Cursor', s:none, s:none, s:inverse)

" Visual mode cursor, selection
hi! link vCursor Cursor

" Input moder cursor
hi! link iCursor Cursor

" Language mapping cursor
hi! link lCursor Cursor

if v:version >= 703

	" Highlighted screen columns
	" call s:HL('ColorColumn',  s:none, s:color_column)
	hi ColorColumn ctermbg=237 guibg=#3c3836 ctermfg=NONE guifg=NONE cterm=NONE gui=NONE guisp=None

	" Concealed element: \lambda → λ
	" call s:HL('Conceal', s:blue, s:none)
	hi Conceal guifg=#83a598 guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermbg=NONE ctermfg=23
	" ALTERNATIVE:
	" hi Conceal guifg=#076678 guibg=NONE guisp=NONE gui=NONE cterm=NONE

endif

" }}}
" Unsorted highlight groups: {{{
" Normal text
hi Normal ctermfg=223 ctermbg=234 guifg=#ebdbb2 guibg=#1d2021 guisp=NONE gui=NONE cterm=NONE
hi NormalNC ctermfg=223 ctermbg=234 guifg=#ebdbb2 guibg=#1d2021 guisp=NONE gui=NONE cterm=NONE

" Did you know that we now have a normalfloat? Go find the if has('nvim')
" block way below and i detail it

" hi! link NonText GruvboxBg2
hi NonText guifg=#d5c4a1 guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=239 ctermbg=NONE

" call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi Visual cterm=reverse gui=reverse guisp=NONE ctermbg=241 ctermfg=NONE guibg=#665c54 guifg=NONE

hi link VisualNOS Visual
hi link VisualNC Visual

" call s:HL('Search',    s:yellow, s:bg0, s:inverse)
hi Search cterm=reverse ctermfg=214 ctermbg=234 gui=reverse guifg=#fabd2f guibg=#1d2021 guisp=NONE

" call s:HL('Underlined', s:blue, s:none, s:underline)
" hi Underlined cterm=underline ctermfg=109 gui=underline guifg=#83a598
" ALTERNATIVE:
hi Underlined cterm=underline ctermfg=23 gui=underline guifg=#83a598 ctermbg=NONE guisp=NONE guibg=NONE

" call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
hi StatusLine guifg=#504945 guibg=#ebdbb2 guisp=NONE gui=reverse cterm=reverse ctermfg=239 ctermbg=223

" call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)
hi StatusLineNC guifg=#3c3836 guibg=#a89984 guisp=NONE gui=reverse cterm=reverse ctermfg=237 ctermbg=246
hi! link StatusLineTerm StatusLine

" The column separating vertically split windows
" call s:HL('VertSplit', s:bg3, s:vert_split)
hi VertSplit guifg=#665c54 guibg=#1d2021 guisp=NONE gui=NONE cterm=NONE ctermbg=234 ctermfg=241

" Current match in wildmenu completion
" call s:HL('WildMenu', s:blue, s:bg2, s:bold)
hi WildMenu guifg=#83a598 guibg=#504945 guisp=NONE gui=bold cterm=bold ctermbg=81 ctermfg=109

" Titles for output from :set all, :autocmd, etc.
" hi! link Title GruvboxGreenBold
" DUDE DON"T UNDERLINE ITS SO HARD TO READ IN RST
hi Title guifg=#b8bb26 guibg=NONE guisp=NONE gui=bold cterm=bold ctermfg=100 ctermbg=NONE

" Directory: Replacement for GruvboxAquaBold!
hi Directory ctermfg=108 guifg=#8ec0e1 cterm=bold gui=bold ctermfg=108 guifg=#8ec0e1

" Error messages on the command line
" call s:HL('rrror', s:aqua, s:vim_bg, s:inverse)
" hi Error guibg=NONE ctermfg=108 ctermbg=234 gui=reverse,bold,italic cterm=bold,italic,reverse guifg=#8ec0e1
hi Error ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=#3c3836 gui=NONE cterm=NONE guisp=NONE

" call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
hi ErrorMsg cterm=bold,italic,reverse ctermfg=234 ctermbg=167 gui=bold,italic,reverse guifg=#1d2021 guibg=#fb4934

" try, catch, throw
" hi! link Exception GruvboxRed
hi Exception ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE gui=BOLD cterm=BOLD guisp=NONE

" More prompt: -- More --
" hi! link MoreMsg GruvboxYellowBold
hi MoreMsg cterm=bold ctermfg=214 gui=bold guifg=#fabd2f guisp=NONE guibg=NONE ctermbg=NONE

" Current mode message: -- INSERT --
" hi! link ModeMsg GruvboxYellowBold
hi  ModeMsg cterm=bold ctermfg=214 gui=bold guifg=#fabd2f guisp=NONE guibg=NONE ctermbg=NONE

" 'Press enter' prompt and yes/no questions
" hi! link Question GruvboxOrangeBold
hi  Question cterm=bold ctermfg=214 gui=bold guifg=#fabd2f guisp=NONE guibg=NONE ctermbg=NONE

" Warning messages
hi WarningMsg cterm=bold ctermfg=167 gui=bold guifg=#fb4934 ctermbg=NONE guibg=NONE guisp=NONE

hi link Quote              Question
hi link Noise              Question

" }}}
" Missing Highlight Groups: {{{

" Sep 23, 2019: Realized allllll these were missing

hi SpecialChar ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836 gui=NONE guisp=NONE cterm=NONE
hi SpecialComment ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836 gui=NONE guisp=NONE cterm=NONE

							" *hl-SpecialKey* SpecialKey	Unprintable characters: text displayed differently from what
		" it really is. But not 'listchars' whitespace. |hl-Whitespace|
" hi SpecialKey ctermfg=81 guifg=#504945 ctermbg=NONE guibg=NONE gui=NONE cterm=NONE guisp=NONE

hi Ignore guifg=bg guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=bg ctermbg=NONE
hi CursorIM guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi ToolbarLine guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE ctermbg=241 ctermfg=NONE
hi ToolbarButton guifg=#fbf1c7 guibg=#665c54 guisp=NONE gui=bold cterm=bold ctermbg=241 ctermfg=NONE
hi NormalMode guifg=#a89984 guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermbg=234
hi InsertMode guifg=#83a598 guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermbg=234
hi ReplaceMode guifg=#8ec07c guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermbg=234
hi VisualMode guifg=#fe8019 guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermbg=234 ctermfg=208
hi CommandMode guifg=#d3869b guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermbg=234
hi Warnings guifg=#fe8019 guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermbg=234 ctermfg=208
hi Delimiter guifg=#fe8019 guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=208 ctermbg=NONE
hi QuickFixLine ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=#3c3836 guisp=NONE cterm=NONE gui=NONE


" EndOfBuffer: New replacement for GruvboxBlueSign
" hi EndOfBuffer guifg=#f9f5d7 guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermbg=NONE ctermfg=230
" NO DON'T MAKE A SEPARATE BACKGROUND IT LOOKS WEIRD WHEN THE FILE ENDS
" hi EndOfBuffer ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=NONE cterm=italic gui=italic guisp=NONE
" I was stuck in a tty for a few days so trust me when i say you want cterm
" and term to be normal
hi! link EndOfBuffer Normal
" }}}
" Gutter: {{{

" Line number for :number and :# commands
" call s:HL('LineNr', s:bg4, s:number_column)
" hi LineNr guifg=#a89984 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi LineNr guifg=#7c6f64 guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermbg=NONE ctermfg=137

" Column where signs are displayed
" call s:HL('SignColumn', s:none, s:sign_column)
hi SignColumn guifg=NONE guibg=#3c3836 guisp=NONE gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE

" Line used for closed folds
" call s:HL('Folded', s:gray, s:bg1, s:italic)
hi Folded cterm=italic ctermfg=245 ctermbg=237 gui=italic guifg=#928374 guibg=#3c3836 guisp=NONE

" Column where folds are displayed
" call s:HL('FoldColumn', s:gray, s:bg1)
hi FoldColumn  guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=237 guibg=#3c3836 guifg=#928374

" Preprocessor #define
" hi! link Define GruvboxAqua
hi Define guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=108 ctermbg=NONE

hi Debug guifg=#fb4934 guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermbg=NONE ctermfg=124
" }}}
" Syntax Highlighting: {{{

" call s:HL('Special', s:orange, s:none, s:italicize_strings)
hi Special cterm=italic ctermfg=208 ctermbg=NONE gui=italic guifg=#fe8019 guibg=NONE guisp=NONE

hi! link Tag Special

hi Comment cterm=italic ctermfg=245 gui=italic guifg=#928374 ctermbg=NONE guibg=NONE guisp=NONE
" call s:HL('Comment', s:gray, s:none, s:italicize_comments)

" call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
hi Todo cterm=bold,italic ctermfg=223 ctermbg=234 gui=bold,italic guifg=#ebdbb2 guibg=#1d2021 guisp=NONE

" Generic statement
" hi! link Statement GruvboxRed
hi Statement  ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE guisp=NONE

" if, then, else, endif, switch, etc.
" hi! link Conditional GruvboxRed
hi Conditional ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE guisp=NONE

" for, do, while, etc.
" hi! link Repeat GruvboxRed
hi Repeat ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE guisp=NONE

" case, default, etc.
" hi! link Label GruvboxRed
hi Label ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE guisp=NONE

" sizeof, "+", "*", etc.
" hi! link Operator GruvboxRed
hi Operator ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE guisp=NONE

" Any other keyword
" hi! link Keyword GruvboxRed
hi Keyword ctermfg=167 guifg=#fb4934 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE guisp=NONE

" Variable name
" hi! link Identifier GruvboxBlue
hi Identifier ctermfg=172 ctermbg=234 guifg=#83a598 cterm=NONE gui=NONE guisp=NONE guibg=#1d2021

" hi! link IdentifierBold GruvboxBlueBold
hi IdentifierBold ctermfg=172 ctermbg=234 cterm=bold gui=bold guisp=NONE guifg=#83a598 guibg=#1d2021

" Function name
" Yeah this is the color you want
hi Function cterm=italic ctermfg=234 gui=italic guifg=#83a598 ctermbg=NONE guibg=NONE guisp=NONE

" Generic preprocessor
" hi! link PreProc GruvboxAqua
hi PreProc guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=108 ctermbg=NONE

" Preprocessor #include
" hi! link Include GruvboxAqua
hi Include guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=108 ctermbg=NONE

" Same as Define
" hi! link Macro GruvboxAqua
" Macro: Replacement for GruvboxAquaSign
" TODO: shouldn't have a keyword with a background tho :/
hi Macro ctermfg=108 ctermbg=237 guifg=#8ec0e1 guibg=#3c3836 gui=bold cterm=bold guisp=NONE

" Preprocessor #if, #else, #endif, etc.
" hi! link PreCondit GruvboxAqua
hi PreCondit guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=108 ctermbg=NONE

" Generic constant
" hi! link Constant GruvboxPurple
hi Constant ctermfg=13 ctermbg=NONE guifg=#ffa0a0 guibg=NONE guisp=NONE gui=NONE cterm=NONE

" Character constant: 'c', '/n'
" hi! link Character GruvboxPurple
hi Character ctermfg=13 ctermbg=NONE guifg=#ffa0a0 guibg=NONE guisp=NONE gui=NONE cterm=NONE

" String constant: "this is a string"
" call s:HL('String',  s:green, s:none, s:italicize_strings)
" actually looks weird as shit don't do that
" hi String ctermfg=13 ctermbg=NONE guifg=#ffa0a0 guibg=NONE
hi String ctermfg=142 ctermbg=NONE guifg=#b8bb26 guibg=NONE guisp=NONE gui=italic cterm=italic

hi Boolean ctermfg=13 ctermbg=NONE guifg=#ffa0a0 guibg=NONE guisp=NONE gui=NONE cterm=NONE
" hi! link Boolean GruvboxPurple
hi Number ctermfg=13 ctermbg=NONE guifg=#ffa0a0 guibg=NONE guisp=NONE gui=NONE cterm=NONE
" Number constant: 234, 0xff
" hi! link Number GruvboxPurple
hi Float ctermfg=13 ctermbg=NONE guifg=#ffa0a0 guibg=NONE guisp=NONE gui=NONE cterm=NONE
" Floating point constant: 2.3e10
" hi! link Float GruvboxPurple

" Generic type
" hi! link Type GruvboxYellow
" uhhh that's a great brigt neon green but horrible for TYPE...btw apparently
" that's like our most used color lol
" hi Type ctermbg=NONE guibg=NONE guisp=NONE ctermfg=121 gui=bold guifg=#60ff60
hi Type guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=214 ctermbg=NONE

" static, register, volatile, etc
" let's make them natch types
" hi! link StorageClass GruvboxOrange
hi StorageClass ctermfg=214 guifg=#fabd2f guisp=NONE gui=NONE cterm=NONE guibg=NONE ctermbg=NONE

" struct, union, enum, etc.
" hi! link Structure GruvboxAqua
hi Structure guifg=#8ec07c guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=29 ctermbg=NONE

" typedef
" hi! link Typedef GruvboxYellow
hi Typedef guifg=#fabd2f guibg=NONE guisp=NONE gui=NONE cterm=NONE ctermfg=172 ctermbg=NONE

" }}}
" Diffs: {{{

hi DiffAdd guifg=#b8bb26 guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermfg=100 ctermbg=234
hi DiffChange guifg=#8ec07c guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermfg=29 ctermbg=234
hi DiffDelete guifg=#fb4934 guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermfg=124 ctermbg=234
hi DiffText guifg=#fabd2f guibg=#1d2021 guisp=NONE gui=reverse cterm=reverse ctermfg=172 ctermbg=234
" }}}
" Other: {{{
" What the hell are these?
" RedrawDebugClear xxx ctermbg=11 guibg=Yellow
" RedrawDebugComposed xxx ctermbg=10 guibg=Green
" RedrawDebugNormal xxx cterm=reverse gui=reverse
" RedrawDebugRecompose xxx ctermbg=9 guibg=Red

" Spelling: {{{
" Don't add guisp=blue that shit looks weird and confusing
" call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
" call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
hi SpellCap cterm=underline,italic ctermfg=109 gui=undercurl,italic guifg=#83a598 ctermbg=NONE guisp=NONE

" Not recognized word
" Let's go with GruvboxBlueSign. Uh? Somewhere it defines guisp=Red so now
" it's still red. Idk where that got defined but I honestly might leave it.
hi SpellBad gui=undercurl cterm=undercurl ctermfg=109 ctermbg=237 guifg=#83a598 guibg=#3c3836

" call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
hi SpellBad gui=undercurl cterm=undercurl ctermbg=237 guibg=#3c3836 guifg=#fb4934 ctermfg=167

" Wrong spelling for selected region
" call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
" TODO: ctermfg  ctermbg
hi SpellLocal guifg=#8ec07c guibg=NONE guisp=NONE gui=italic,undercurl cterm=italic,undercurl

" Rare word
" call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
" Replacement for GruvboxPurpleSign
" TODO: ctermfg  ctermbg
hi SpellRare guifg=#d3869b guibg=NONE guisp=NONE gui=italic,undercurl cterm=italic,undercurl


" }}}
" }}}
" }}}
" Plugin specific -------------------------------------------------------- {{{
" AKA Plugins You Don't Have: {{{

if 0
	" EasyMotion: {{{

	hi! link EasyMotionTarget Search
	hi! link EasyMotionShade Comment

	" }}}
	" Sneak: {{{

	hi! link Sneak Search
	hi! link SneakLabel Search

	" }}}
	" BufTabLine: {{{

	call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
	call s:HL('BufTabLineActive', s:fg4, s:bg2)
	call s:HL('BufTabLineHidden', s:bg4, s:bg1)
	call s:HL('BufTabLineFill', s:bg0, s:bg0)

	" }}}
	" Dirvish: {{{

	hi! link DirvishPathTail Macro
	hi! link DirvishArg Typedef

	" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
endif
" }}}
" Plugins You Have: {{{

" Jesus. Here are the plugins you currently have. We'll figure out a smarter way
" to check if the plugin actually exists another time.

" Aug 10, 2019: Well now we need to define a few more

" Coc: {{{

" CocCodeLens
" CocCursorRange
" CocErrorFloat
" CocErrorSign
" CocErrorVirtualText
" CocGitAddedSign
" CocGitChangeRemovedSign
" CocGitChangedSign
" CocGitRemovedSign
" CocGitTopRemovedSign
" CocHighlightRead
" CocHighlightText
" CocHighlightWrite
" CocHintVirtualText
" CocInfoFloat
" CocInfoVirtualText
hi link CocErrorLine Exception
hi link CocWarningLine WarningMsg
hi link CocInfoLine EndOfBuffer
hi link CocHintLine GruvboxGreenSign
hi link CocSelectedLine Visual

" Override one of his...actually now a few
hi! link CocInfoSign SpellRare
hi! link CocErrorHighlight Error
hi! link CocWarningHighlight GruvboxOrangeBold
hi link CocInfoHighlight EndOfBuffer
hi! link CocHintHighlight GruvboxGreenSign
hi! link CocGitAddedSign GruvboxYellowBold
hi! link CocCodeLens Macro
hi! link CocErrorSign Error
hi! link CocWarningSign GruvboxGreenSign
hi! link CocHintFloat Float
hi! link CocHintSign Macro
hi! link CocSelectedText Search
hi! link CocUnderline Underlined
hi! link CocListFgYellow GruvboxYellow
hi! link CocListFgBlue GruvboxBlue
hi! link CocListFgGreen GruvboxGreen
hi! link CocListFgGrey GruvboxBg4
hi! link CocListBgGrey GruvboxBg0

hi! link CocListFgRed GruvboxRed
hi! link CocListFgYellow GruvboxYellow
hi! link CocListFgCyan Macro

" Ooo its a good idea to define the pum
" CocFloating

" }}}
" Signify: {{{

hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange Macro
hi! link SignifySignDelete GruvboxRedSign

" }}}
" Startify: {{{
hi! link StartifyBracket Delimiter
hi! link StartifyFile Identifier
hi! link StartifyFooter Title
hi! link StartifyHeader Delimiter
hi! link StartifyNumber Number
hi! link StartifyPath Directory
hi! link StartifySection Statement
hi! link StartifySlash Delimiter
hi! link StartifySpecial Special

" }}}
" NERDTree: {{{

hi link NERDTreeBookmarks Typedef
hi link NERDTreeCWD Underlined
hi link NERDTreeDir Directory
hi link NERDTreeDirSlash Delimiter
hi link NERDTreeNodeDelimeters Delimiter
hi link hideBracketsInNERDTree Conceal
hi! link NERDTreeFile Structure

" }}}
" Asynchronous Lint Engine: {{{

" call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
" call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
" call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi link ALEErrorSign Error
hi link ALEWarningSign QuickFixLine
hi link ALEInfoSign Directory
hi link ALEError Error
hi link ALEWarning QuickFixLine
hi link ALEInfo Macro

" }}}
" GitGutter: {{{

hi link GitGutterAdd GruvboxGreenSign
hi link GitGutterChange Macro
hi link GitGutterDelete GruvboxRedSign
hi link GitGutterChangeDelete Macro

" }}}
" GitCommit: "{{{
" Do I have this plugin? Is this a fugitive thing?
hi link gitcommitSelectedFile GruvboxGreen
hi link gitcommitDiscardedFile GruvboxRed

" }}}
" Tagbar: {{{
hi! link TagbarSignature Question
hi! link TagbarTitle Title
" I mean this is whats displayed at the top of the buffer so why not title?
hi! link TagbarHelp Define

" }}}
" FZF: {{{

hi! fzf1 ctermfg=161 ctermbg=238 guifg=#E12672 guibg=#565656 cterm=bold,underline
hi! fzf2 ctermfg=151 ctermbg=238 guifg=#BCDDBD guibg=#565656 cterm=bold,underline
hi! fzf3 ctermfg=252 ctermbg=238 guifg=#D9D9D9 guibg=#565656 cterm=bold,underline
" }}}
" }}}" }}}}
" Filetype specific ------------------------------------------------------- {{{
" Man.vim: {{{
" Define the default highlighting.
" Only when an item doesn't have highlighting yet

highlight default link manTitle          Title
highlight default link manSectionHeading Statement
highlight default link manOptionDesc     Constant
highlight default link manReference      PreProc
highlight default link manSubHeading     Function

highlight default link manUnderline Underlined
highlight default link manBold GruvboxYellowBold
highlight default link manItalic htmlItalic

" And the rest
hi! link manCError Error
hi! link manEmail Directory
hi! link manEnvVar Identifier
hi! link manEnvVarFile Identifier
hi! link manEnvVarFile Identifier
hi! link manFile GruvboxYellow
hi! link manFiles GruvboxFg0
hi! link manFooter GruvboxPurple
hi! link manHighlight GruvboxYellow
hi! link manHistory GruvboxYellow
hi! link manHeaderFile GruvboxYellow
hi! link manSectionHeading GruvboxOrangeBold
hi! link manSentence GruvboxFg2
hi! link manSignal GruvboxPurple
hi! link manURL GruvboxGreen

" }}}
" Netrw: {{{
" Hate to be that guy but Netrw is considered an ftplugin

hi link netrwClassify Directory
hi link netrwCmdNote Directory
hi link netrwCmdSep VertSplit
hi link netrwComma Delimiter
hi link netrwComment Comment
if has('nvim')
  hi link netrwCopyTgt IncSearch
else
  " Is this canoniccal vim?
  hi link netrwCopyTgt StorageClass
endif

hi link netrwDateSep Delimiter
hi link netrwDir Directory
hi link netrwExe Macro
hi link netrwGray Folded
hi link netrwHelpCmd Directory
hi link netrwHide Conceal
hi link netrwHidePat Folded
hi link netrwLib Directory
hi link netrwLink Underlined
hi link netrwList PreCondit
hi link netrwPlain String
hi link netrwQHTopic Number
hi link netrwSizeDate Delimiter
hi link netrwSlash Delimiter
hi link netrwSortBy Title
hi link netrwSortSeq netrwList
hi link netrwSpecial netrwClassify
hi link netrwSymLink Special
hi link netrwTime Delimiter
hi link netrwTimeSep Delimiter
hi link netrwTreeBar Special
hi link netrwTreeBarSpace Special
hi link netrwVersion Float

" }}}
" Rst: {{{

hi! link rstDirectivesh     Question
hi! link rstDirectivepython Question
hi! link rstInlineLiteral   Identifier

" Well heres the built in syntax file
hi link rstCitation                     String
hi link rstCitationReference            Identifier
hi link rstCodeBlock                    String
hi link rstComment                      Comment
hi link rstDelimiter                    Delimiter
hi link rstDirective                    Keyword
hi link rstDoctestBlock                 PreProc
" hi link rstExDirective                  String
" Blends in with the rest of the string
hi link rstExDirective                  Identifier
hi link rstExplicitMarkup               rstDirective
hi link rstFileLink                     rstHyperlinkReference
hi link rstFootnote                     String
hi link rstFootnoteReference            Identifier
hi link rstHyperLinkReference           Identifier
hi link rstHyperlinkTarget              String
hi link rstInlineInternalTargets        Identifier
hi link rstInlineLiteral                String
hi link rstInterpretedTextOrHyperlinkReference  Identifier
hi link rstLiteralBlock                 String
hi link rstQuotedLiteralBlock           String
hi link rstSections                     Title
hi link rstSimpleTableLines             rstTableLines
hi link rstStandaloneHyperlink          Identifier
hi link rstSubstitutionDefinition       rstDirective
hi link rstSubstitutionReference        PreProc
hi link rstTableLines                   rstDelimiter
hi link rstTodo                         Todo
hi link rstTransition                   rstSections
" }}}
" Tmux: {{{

hi def link tmuxFormatString      Identifier
hi def link tmuxAction            Boolean
hi def link tmuxBoolean           Boolean
hi def link tmuxCommands          Keyword
hi def link tmuxComment           Comment
hi def link tmuxKey               Special
hi def link tmuxNumber            Number
hi def link tmuxFlags             Identifier
hi def link tmuxOptions           Function
hi def link tmuxString            String
hi def link tmuxTodo              Todo
hi def link tmuxVariable          Identifier
hi def link tmuxVariableExpansion Identifier

" }}}
" Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged Directory

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

" }}}
" Html: {{{

hi link htmlScriptTag Tag

" Default syntax
hi link htmlTag                     Function
hi link htmlEndTag                  Identifier
hi link htmlArg                     Type
hi link htmlTagName                 htmlStatement
hi link htmlSpecialTagName          Exception
hi link htmlValue                     String
hi link htmlSpecialChar             Special

hi htmlBold                cterm=bold gui=bold
hi htmlBoldUnderline       cterm=bold,underline gui=bold,underline
hi htmlBoldItalic          cterm=bold,italic gui=bold,italic
hi htmlBoldUnderlineItalic  cterm=bold,italic,underline gui=bold,italic,underline
hi htmlUnderline           cterm=underline gui=underline
hi htmlUnderlineItalic     cterm=italic,underline gui=italic,underline
hi htmlItalic              cterm=italic gui=italic
hi link htmlH1                      Title
hi link htmlH2                      htmlH1
hi link htmlH3                      htmlH2
hi link htmlH4                      htmlH3
hi link htmlH5                      htmlH4
hi link htmlH6                      htmlH5
hi link htmlHead                    PreProc
hi link htmlTitle                   Title
hi link htmlBoldItalicUnderline     htmlBoldUnderlineItalic
hi link htmlUnderlineBold           htmlBoldUnderline
hi link htmlUnderlineItalicBold     htmlBoldUnderlineItalic
hi link htmlUnderlineBoldItalic     htmlBoldUnderlineItalic
hi link htmlItalicUnderline         htmlUnderlineItalic
hi link htmlItalicBold              htmlBoldItalic
hi link htmlItalicBoldUnderline     htmlBoldUnderlineItalic
hi link htmlItalicUnderlineBold     htmlBoldUnderlineItalic
hi link htmlLink                    Underlined
hi link htmlLeadingSpace            None

if v:version > 800 || v:version == 800 && has("patch1038")
		hi def htmlStrike              term=strikethrough cterm=strikethrough gui=strikethrough
else
		hi def htmlStrike              term=underline cterm=underline gui=underline
endif

hi link htmlPreStmt            PreProc
hi link htmlPreError           Error
hi link htmlPreProc            PreProc
hi link htmlPreAttr            String
hi link htmlPreProcAttrName    PreProc
hi link htmlPreProcAttrError   Error
hi link htmlSpecial            Special
hi link htmlSpecialChar        Special
hi link htmlString             String
hi link htmlStatement          Statement
hi link htmlComment            Comment
hi link htmlCommentPart        Comment
hi link htmlValue              String
hi link htmlCommentError       htmlError
hi link htmlTagError           htmlError
hi link htmlEvent              javaScript
hi link htmlError              Error

hi link javaScript             Special
hi link javaScriptExpression   javaScript
hi link htmlCssStyleComment    Comment
hi link htmlCssDefinition      Special
" }}}
" Xml: {{{

hi! link xmlTag GruvboxBlue
hi! link xmlEndTag GruvboxBlue
hi! link xmlTagName GruvboxBlue
hi! link xmlEqual GruvboxBlue
hi! link docbkKeyword Keyword

hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword Keyword
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxPurple
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxPurple

hi! link xmlAttrib Directory
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray

hi! link xmlEntity GruvboxOrange
hi! link xmlEntityPunct GruvboxOrange
" }}}
" Vim: {{{
" Defined In Syntax File: {{{
hi! link vimAbb	vimCommand
hi! link vimAddress	vimMark
hi! link vimAuHighlight	vimHighlight
hi! link vimAugroupError	Error
hi! link vimAugroupKey	Keyword
hi! link vimAutoCmd	vimCommand
hi! link vimAutoCmdOpt	vimOption
hi! link vimAutoEvent	Type
hi! link vimAutoSet	vimCommand
hi! link vimBehave	vimCommand
hi! link vimBehaveModel	vimBehave
hi! link vimBracket	Delimiter
hi! link vimCmplxRepeat	SpecialChar
hi! link vimCommand	Statement
hi! link vimComment	Comment
hi! link vimCommentString	vimString
hi! link vimCommentTitle	PreProc
hi! link vimCondHL	vimCommand
hi! link vimContinue	Special
hi! link vimCtrlChar	SpecialChar
hi! link vimEchoHL	vimCommand
hi! link vimEchoHLNone	vimGroup
hi! link vimElseIfErr	Error
hi! link vimElseif	vimCondHL
hi! link vimEnvvar	PreProc
hi! link vimError	Error
hi! link vimFBVar	vimVar
hi! link vimFTCmd	vimCommand
hi! link vimFTOption	vimSynType
hi! link vimFgBgAttrib	vimHiAttrib
hi! link vimFold	Folded
hi! link vimFunc Function
hi! link vimFuncKey	vimCommand
hi! link vimFuncName	Function
hi! link vimFuncSID	Special
hi! link vimFuncVar	Identifier
hi! link vimFunction Function
hi! link vimGroup	Type
hi! link vimGroupAdd	vimSynOption
hi! link vimGroupName	vimGroup
hi! link vimGroupRem	vimSynOption
hi! link vimGroupSpecial	Special
hi! link vimHLGroup	vimGroup
hi! link vimHLMod	PreProc
hi! link vimHiAttrib	PreProc
hi! link vimHiBang vimHighlight
hi! link vimHiCTerm	vimHiTerm
hi! link vimHiClear	vimHighlight
hi! link vimHiCtermFgBg	vimHiTerm
hi! link vimHiGroup	vimGroupName
hi! link vimHiGui	vimHiTerm
hi! link vimHiGuiFgBg	vimHiTerm
hi! link vimHiGuiFont	vimHiTerm
hi! link vimHiGuiRgb	vimNumber
hi! link vimHiNmbr	Number
hi! link vimHiStartStop	vimHiTerm
hi! link vimHiTerm	Type
hi! link vimHighlight	Operator
hi! link vimInsert	vimString

" vimIsCommand is a terrible regex honestly don't match it with anything
" Output of `syn list vimIsCommand
" --- Syntax items ---
" vimIsCommand   xxx match /\<\h\w*\>/  contains=vimCommand
"                    match /<Bar>\s*\a\+/  transparent contains=vimCommand,vimNotation
" \h is any upper case letter. \w is any letter. wtf? that contains SO many false positives

" hi! link vimIsCommand       vimOption
hi! link vimIskSep	Delimiter
hi! link vimKeyCode	vimSpecFile
hi! link vimKeyword	Statement
hi! link vimLet	vimCommand
hi! link vimLineComment	vimComment
hi! link vimMap	vimCommand
hi! link vimMapBang	vimCommand
hi! link vimMapMod	vimBracket
hi! link vimMapModKey	vimFuncSID
hi! link vimMark	Number
hi! link vimMarkNumber	vimNumber
hi! link vimMenuMod	vimMapMod
hi! link vimMenuName	PreProc
hi! link vimMenuNameMore	vimMenuName
hi! link vimMtchComment	vimComment
hi! link vimNorm	vimCommand
hi! link vimNotFunc	vimCommand
hi! link vimNotPatSep	vimString
hi! link vimNotation	Special
hi! link vimNumber GruvboxRed
hi! link vimOper	Operator
hi! link vimOperError	Error
hi! link vimOption	PreProc
hi! link vimParenSep	Delimiter
hi! link vimPatSep	SpecialChar
hi! link vimPatSepErr	vimError
hi! link vimPatSepR	vimPatSep
hi! link vimPatSepZ	vimPatSep
hi! link vimPatSepZone	vimString
hi! link vimPattern	Type
hi! link vimPlainMark	vimMark
hi! link vimPlainRegister	vimRegister
hi! link vimRegister	SpecialChar
hi! link vimScriptDelim	Comment
hi! link vimSearch	vimString
hi! link vimSearchDelim	Statement
hi! link vimSep	Delimiter
hi! link vimSetMod	vimOption
hi! link vimSetSep	Statement
hi! link vimSetString	vimString
hi! link vimSpecFile	Identifier
hi! link vimSpecFileMod	vimSpecFile
hi! link vimSpecial	Type
hi! link vimStatement	Statement
hi! link vimStdPlugin       Function
hi! link vimString	String
hi! link vimStringCont	vimString
hi! link vimStringEnd	vimString
hi! link vimSubst	vimCommand
hi! link vimSubst1	vimSubst
hi! link vimSubstDelim	Delimiter
hi! link vimSubstFlags	Special
hi! link vimSubstSubstr	SpecialChar
hi! link vimSubstTwoBS	vimString
hi! link vimSynCase	Type
hi! link vimSynCaseError	Error
hi! link vimSynContains	vimSynOption
hi! link vimSynError	Error
hi! link vimSynKeyContainedin	vimSynContains
hi! link vimSynKeyOpt	vimSynOption
hi! link vimSynMtchGrp	vimSynOption
hi! link vimSynMtchOpt	vimSynOption
hi! link vimSynNextgroup	vimSynOption
hi! link vimSynNotPatRange	vimSynRegPat
hi! link vimSynOption	Special
hi! link vimSynPatRange	vimString
hi! link vimSynReg	Type
hi! link vimSynRegOpt	vimSynOption
hi! link vimSynRegPat	vimString
hi! link vimSynType	vimSpecial
hi! link vimSyncC	Type
hi! link vimSyncError	Error
hi! link vimSyncGroup	vimGroupName
hi! link vimSyncGroupName	vimGroupName
hi! link vimSyncKey	Type
hi! link vimSyncNone	Type
hi! link vimSyntax	vimCommand
hi! link vimTodo	Todo
hi! link vimUnmap	vimMap
hi! link vimUserAttrb	vimSpecial
hi! link vimUserAttrbCmplt	vimSpecial
hi! link vimUserAttrbCmpltFunc	Special
hi! link vimUserAttrbError	Error
hi! link vimUserAttrbKey	vimOption
hi! link vimUserCmd vimUserCommand
hi! link vimUserCmdError	Error
hi! link vimUserCommand	vimCommand
hi! link vimVar	Identifier
hi! link vimWarn	WarningMsg

" }}}
" And yours: {{{
" Vim Errors: {{{
hi link vimBehaveError	vimError
hi link vimBufnrWarn	vimWarn
hi link vimCollClassErr	vimError
hi link vimEmbedError	vimError
hi link vimErrSetting	vimError
hi link vimFTError	vimError
hi link vimFunc         	vimError
hi link vimFuncBody Function
hi link vimFunctionError	vimError
hi link vimHiAttribList	vimError
hi link vimHiCtermError	vimError
hi link vimHiKeyError	vimError
hi link vimKeyCodeError	vimError
hi link vimMapModErr	vimError
hi link vimSubstFlagErr	vimError
hi link vimSynCaseError	vimError
hi link vimSynError Exception

" }}}
" Nvim Specific: {{{

if has('nvim')
	" How does a nice light blue sound?
	hi! NvimInternalError guibg=NONE ctermfg=108 ctermbg=234 gui=reverse guifg=#8ec0e1 guisp=NONE
	hi link nvimAutoEvent	vimAutoEvent
	hi link nvimHLGroup	vimHLGroup
  hi link NvimIdentifierKey IdentifierBold
	hi link nvimInvalid Exception
	hi link nvimMap	vimMap
	hi link nvimUnmap	vimUnmap

	hi link TermCursor Cursor
	hi TermCursorNC ctermfg=237 ctermbg=223 guifg=#3c3836 guibg=#ebdbb2 guisp=NONE cterm=NONE gui=NONE

	" *hl-NormalFloat* NormalFloat	Normal text in floating windows.
	hi NormalFloat ctermfg=223 ctermbg=234 guifg=#ebdbb2 guibg=#1d2021 guisp=NONE gui=undercurl cterm=undercurl

	" *hl-IncSearch*
	" IncSearch	'incsearch' highlighting; also used for the text replaced with ':s///c'
	hi IncSearch cterm=reverse ctermfg=208 ctermbg=234 gui=reverse guifg=#fe8019 guibg=#1d2021 guisp=NONE

	" From he nvim-terminal-emulator
	hi debugPC term=reverse ctermbg=darkblue guibg=darkblue
	hi debugBreakpoint term=reverse ctermbg=red guibg=red
endif


" }}}

" Here's every highlighting group I've ran into and a note with what it represents
" The last letter of an autocmd like wth
hi link vimAugroup	vimAugroupKey

" Lmao the comma between BufEnter,BufReadPre
hi link vimAutoEventList vimAutoEvent

hi link vimClusterName WildMenu
hi link vimCmdSep vimCommand
hi link vimCommentTitleLeader	vimCommentTitle
hi link vimEcho	String

" the spaces between words in an execute statement like wth
hi link vimExecute Label

hi link vimHiAttribList Underlined
hi link vimHiCtermColor Underlined
hi link vimHiFontname Underlined
hi link vimHiKeyList Keyword

hi link vimIskSep Keyword
hi link vimMapModErr Exception

hi link vimMapLhs vimNotation
hi link vimMapRhs vimNotation
hi link vimMapRhsExtend	vimNotation
hi link vimOnlyHLGroup VisualNOS
hi link vimOnlyCommand vimCommand
hi link vimOnlyOption GruvboxGreen
hi link vimSet vimSetEqual

" There's a highlighting group for the equals sign in a set option statement...
hi link vimSetEqual	Operator
hi link vimSynKeyRegion Keyword
hi link vimHiAttribList vimHighlight

" This syntax group is literally whitespace...
hi link vimSynRegion Nontext
hi link vimSyncLines Number

" Here are a few more xxx cleared syn groups
hi link vimUserFunc Function

hi link vimPythonRegion Identifier
" }}}
" }}}
" C: {{{

hi link cOperator Operator
hi! link cStructure Structure

" }}}
" Python: {{{

hi link pythonAsync			Statement
hi link pythonAttribute Identifier
hi link pythonBoolean Boolean
hi link pythonBuiltin		Function
hi link pythonBuiltinFunc GruvboxOrange
hi link pythonBuiltinObj GruvboxOrange
hi link pythonCoding Identifier
hi link pythonComment		Comment
hi link pythonConditional		Conditional
hi link pythonDecorator		Define
hi link pythonDecoratorName		Function
hi link pythonDoctest		Special
hi link pythonDoctestValue	Define
hi link pythonDot GruvboxFg3
hi link pythonDottedName GruvboxGreenBold
hi link pythonEscape		Special
hi link pythonException		Exception
hi link pythonExceptions		Structure
hi link pythonFunction		Function
hi link pythonImport Identifier
hi link pythonInclude		Include
hi link pythonMatrixMultiply Number
hi link pythonNumber Number
hi link pythonOperator		Operator
hi link pythonQuotes		String
hi link pythonRawString		String
hi link pythonRepeat		Repeat
hi link pythonRun Identifier
hi link pythonSpaceError		Error
hi link pythonStatement		Statement
hi link pythonString		String
hi link pythonSync IdentifierBold
hi link pythonTodo			Todo
hi link pythonTripleQuotes		pythonQuotes

" }}}
" CSS: {{{

hi link cssAnimationAttr cssAttr
hi link cssAnimationProp cssProp
hi link cssAtKeyword PreProc
hi link cssAtRule Include
hi link cssAtRuleLogical Statement
hi link cssAttr Constant
hi link cssAttrComma Special
hi link cssAttributeSelector String
hi link cssAuralAttr cssAttr
hi link cssAuralProp cssProp
hi link cssBackgroundAttr cssAttr
hi link cssBackgroundProp cssProp
hi link cssBorderAttr cssAttr
hi link cssBorderOutlineProp Directory
hi link cssBorderProp cssProp
hi link cssBoxAttr cssAttr
hi link cssBoxProp cssProp
hi link cssBraceError Error
hi link cssBraces Function
hi link cssCascadeAttr cssAttr
hi link cssCascadeProp cssProp
hi link cssClassName Function
hi link cssClassNameDot Function
hi link cssColor Constant
hi link cssColorProp cssProp
hi link cssComment Comment
hi link cssCommonAttr cssAttr
hi link cssContentForPagedMediaAttr cssAttr
hi link cssContentForPagedMediaProp cssProp
hi link cssCustomProp Special
hi link cssDeprecated Error
hi link cssDimensionAttr cssAttr
hi link cssDimensionProp cssProp
hi link cssError Error
hi link cssFlexibleBoxAttr cssAttr
hi link cssFlexibleBoxProp cssProp
hi link cssFontAttr cssAttr
hi link cssFontDescriptor Special
hi link cssFontDescriptorAttr cssAttr
hi link cssFontDescriptorProp cssProp
hi link cssFontProp cssProp
hi link cssFunction Constant
hi link cssFunctionComma Function
hi link cssFunctionName Function
hi link cssGeneratedContentAttr cssAttr
hi link cssGeneratedContentProp cssProp
hi link cssGradientAttr cssAttr
hi link cssGridAttr cssAttr
hi link cssGridProp cssProp
hi link cssHacks Comment
hi link cssHyerlinkAttr cssAttr
hi link cssHyerlinkProp cssProp
hi link cssIEUIAttr cssAttr
hi link cssIEUIProp cssProp
hi link cssIdentifier Function
hi link cssImportant Special
hi link cssInteractAttr cssAttr
hi link cssInteractProp cssProp
hi link cssKeyFrameProp Constant
hi link cssLineboxAttr cssAttr
hi link cssLineboxProp cssProp
hi link cssListAttr cssAttr
hi link cssListProp cssProp
hi link cssMarginAttr cssAttr
hi link cssMarqueeAttr cssAttr
hi link cssMarqueeProp cssProp
hi link cssMediaAttr cssAttr
hi link cssMediaComma Normal
hi link cssMediaProp cssProp
hi link cssMediaType Special
hi link cssMobileTextProp cssProp
hi link cssMultiColumnAttr cssAttr
hi link cssMultiColumnProp cssProp
hi link cssNoise Noise
hi link cssPaddingAttr cssAttr
hi link cssPaddingProp Directory
hi link cssPageMarginProp cssAtKeyword
hi link cssPageProp cssProp
hi link cssPagePseudo PreProc
hi link cssPagedMediaAttr cssAttr
hi link cssPagedMediaProp cssProp
hi link cssPositioningAttr cssAttr
hi link cssPositioningProp cssProp
hi link cssPrintAttr cssAttr
hi link cssPrintProp cssProp
hi link cssProp StorageClass
hi link cssPseudoClassId PreProc
hi link cssPseudoClassLang Constant
hi link cssRenderAttr cssAttr
hi link cssRenderProp cssProp
hi link cssRubyAttr cssAttr
hi link cssRubyProp cssProp
hi link cssSelectorOp Special
hi link cssSelectorOp2 Special
hi link cssSpeechAttr cssAttr
hi link cssSpeechProp cssProp
hi link cssStringQ String
hi link cssStringQQ String
hi link cssTableAttr cssAttr
hi link cssTableProp cssProp
hi link cssTagName Statement
hi link cssTextAttr cssAttr
hi link cssTextProp cssProp
hi link cssTransformAttr cssAttr
hi link cssTransformProp cssProp
hi link cssTransitionAttr cssAttr
hi link cssTransitionProp cssProp
hi link cssUIAttr cssAttr
hi link cssUIProp cssProp
hi link cssURL String
hi link cssUnicodeEscape Special
hi link cssUnicodeRange Constant
hi link cssUnitDecorators Number
hi link cssValueAngle Number
hi link cssValueFrequency Number
hi link cssValueInteger Number
hi link cssValueLength Number
hi link cssValueNumber Number
hi link cssValueTime Number
hi link cssVendor Comment
" }}}
" JavaScript: {{{

hi! link javaScriptBraces GruvboxFg0
hi! link javaScriptFunction Directory
hi! link javaScriptIdentifier GruvboxRed
hi! link javaScriptMember GruvboxBlue
hi! link javaScriptNull GruvboxPurple
hi! link javaScriptNumber GruvboxPurple
hi! link javaScriptParens GruvboxFg3


" Wait who fucked up the casing here???
hi! link javascriptArrayMethod GruvboxFg2
hi! link javascriptArrayStaticMethod GruvboxFg2
hi! link javascriptArrowFunc GruvboxYellow
hi! link javascriptAsyncFunc Directory
hi! link javascriptAsyncFuncKeyword Keyword
hi! link javascriptAwaitFuncKeyword Keyword
hi! link javascriptBOMLocationMethod GruvboxFg2
hi! link javascriptBOMNavigatorProp GruvboxFg2
hi! link javascriptBOMWindowMethod GruvboxFg2
hi! link javascriptBOMWindowProp GruvboxFg2
hi! link javascriptBrackets GruvboxFg0
hi! link javascriptCacheMethod GruvboxFg2
hi! link javascriptClassExtends Directory
hi! link javascriptClassKeyword Keyword
hi! link javascriptClassName GruvboxYellow
hi! link javascriptClassStatic GruvboxOrange
hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptClassSuperName GruvboxYellow
hi! link javascriptDOMDocMethod GruvboxFg2
hi! link javascriptDOMDocProp GruvboxFg2
hi! link javascriptDOMElemAttrs GruvboxFg0
hi! link javascriptDOMEventMethod GruvboxFg0
hi! link javascriptDOMNodeMethod GruvboxFg0
hi! link javascriptDOMStorageMethod GruvboxFg0
hi! link javascriptDateMethod GruvboxFg2
hi! link javascriptDefault Directory
hi! link javascriptDocNamedParamType GruvboxFg4
hi! link javascriptDocNotation GruvboxFg4
hi! link javascriptDocParamName GruvboxFg4
hi! link javascriptDocTags GruvboxFg4
hi! link javascriptEndColons GruvboxFg2
hi! link javascriptExceptions GruvboxRed
hi! link javascriptExport Directory
hi! link javascriptForOperator GruvboxRed
hi! link javascriptFuncArg GruvboxFg2
hi! link javascriptFuncKeyword Keyword
hi! link javascriptGlobal GruvboxYellow
hi! link javascriptGlobalMethod GruvboxFg2
hi! link javascriptHeadersMethod GruvboxFg0
hi! link javascriptIdentifier GruvboxOrange
hi! link javascriptImport Directory
hi! link javascriptLabel GruvboxBlue
hi! link javascriptLogicSymbols GruvboxFg0
hi! link javascriptMathStaticMethod GruvboxFg2
hi! link javascriptMessage GruvboxRed
hi! link javascriptNodeGlobal GruvboxFg2
hi! link javascriptObjectLabel GruvboxBlue
hi! link javascriptOperator GruvboxRed
hi! link javascriptProp GruvboxFg2
hi! link javascriptPropertyName GruvboxBlue
hi! link javascriptStringMethod GruvboxFg2
hi! link javascriptTemplateSB Directory
hi! link javascriptTemplateSubstitution GruvboxFg0
hi! link javascriptURLUtilsProp GruvboxFg2
hi! link javascriptVariable GruvboxRed
hi! link javascriptYield GruvboxRed

" From the vim syn file

hi link javaScriptComment		Comment
hi link javaScriptLineComment		Comment
hi link javaScriptCommentTodo		Todo
hi link javaScriptSpecial		Special
hi link javaScriptStringS		String
hi link javaScriptStringD		String
hi link javaScriptStringT		String
hi link javaScriptCharacter		Character
hi link javaScriptSpecialCharacter	javaScriptSpecial
hi link javaScriptNumber		javaScriptValue
hi link javaScriptConditional		Conditional
hi link javaScriptRepeat		Repeat
hi link javaScriptBranch		Conditional
hi link javaScriptOperator		Operator
hi link javaScriptType			Type
hi link javaScriptStatement		Statement
hi link javaScriptFunction		Function
hi link javaScriptBraces		Function
hi link javaScriptError		Error
hi link javaScrParenError		javaScriptError
hi link javaScriptNull			Keyword
hi link javaScriptBoolean		Boolean
hi link javaScriptRegexpString		String

hi link javaScriptIdentifier		Identifier
hi link javaScriptLabel		Label
hi link javaScriptException		Exception
hi link javaScriptMessage		Keyword
hi link javaScriptGlobal		Keyword
hi link javaScriptMember		Keyword
hi link javaScriptDeprecated		Exception
hi link javaScriptReserved		Keyword
hi link javaScriptDebug		Debug
hi link javaScriptConstant		Label
hi link javaScriptEmbed		Special

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword Keyword
hi! link jsExtendsKeyword Keyword
hi! link jsExportDefault Directory
hi! link jsTemplateBraces Directory
hi! link jsGlobalNodeObjects GruvboxFg1
hi! link jsGlobalObjects GruvboxFg1
hi! link jsFunction Directory
hi! link jsFuncParens GruvboxFg3
hi! link jsParens GruvboxFg3
hi! link jsNull GruvboxPurple
hi! link jsUndefined GruvboxPurple
hi! link jsClassDefinition GruvboxYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved Directory
hi! link typeScriptLabel Directory
hi! link typeScriptFuncKeyword Keyword
hi! link typeScriptIdentifier Identifier
hi! link typeScriptBraces Operator
hi! link typeScriptEndColons Operator
hi! link typeScriptDOMObjects GruvboxFg1
hi! link typeScriptAjaxMethods GruvboxFg1
hi! link typeScriptLogicSymbols GruvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects GruvboxFg1
hi! link typeScriptParens Operator
hi! link typeScriptOpSymbols GruvboxFg3
hi! link typeScriptHtmlElemProperties GruvboxFg1
hi! link typeScriptNull GruvboxPurple
hi! link typeScriptInterpolationDelimiter Directory

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword Keyword
hi! link purescriptModuleName GruvboxFg1
hi! link purescriptWhere Directory
hi! link purescriptDelimiter GruvboxFg4
hi! link purescriptType GruvboxFg1
hi! link purescriptImportKeyword Keyword
hi! link purescriptHidingKeyword Keyword
hi! link purescriptAsKeyword Keyword
hi! link purescriptStructure Directory
hi! link purescriptOperator GruvboxBlue

hi! link purescriptTypeVar Type
hi! link purescriptConstructor Typedef
hi! link purescriptFunction Function
hi! link purescriptConditional Conditional
hi! link purescriptBacktick Operator

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp GruvboxFg3
hi! link coffeeSpecialOp GruvboxFg3
hi! link coffeeCurly GruvboxOrange
hi! link coffeeParen GruvboxFg3
hi! link coffeeBracket GruvboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter Delimiter
hi! link rubyInterpolationDelimiter Directory
" So TPope defined all of these but they got wiped in the hi clear. So copy
" paste it is?
hi link rubyASCIICode		Character
hi link rubyBoolean			Boolean
hi link rubyClass			rubyDefine
hi link rubyConditional		Conditional
hi link rubyConditionalModifier	rubyConditional
hi link rubyControl			Statement
hi link rubyDefine			Define
hi link rubyException		Exception
hi link rubyExceptional		rubyConditional
hi link rubyFloat			Float
hi link rubyFunction		Function
hi link rubyInclude			Include
hi link rubyInteger			Number
hi link rubyMethodExceptional	rubyDefine
hi link rubyModule			rubyDefine
hi link rubyOptionalDo		rubyRepeat
hi link rubyRepeat			Repeat
hi link rubyRepeatModifier		rubyRepeat

hi link rubyIdentifier		Identifier

" hi def link rubyInterpolationDelimiter	Delimiter
" hi def link rubyStringDelimiter		Delimiter
hi link rubyAccess			Statement
hi link rubyAttribute		Statement
hi link rubyBeginEnd		Statement
hi link rubyBlockParameter		rubyIdentifier
hi link rubyCapitalizedMethod	rubyLocalVariableOrMethod
hi link rubyClassVariable		rubyIdentifier
hi link rubyComment			Comment
hi link rubyConstant		Type
hi link rubyData			Comment
hi link rubyDataDirective		Delimiter
hi link rubyDocumentation		Comment
hi link rubyError			Error
hi link rubyEval			Statement
hi link rubyGlobalVariable		rubyIdentifier
hi link rubyHeredoc			rubyString
hi link rubyInstanceVariable	rubyIdentifier
hi link rubyInvalidVariable		Error
hi link rubyKeyword			Keyword
hi link rubyNoInterpolation		rubyString
hi link rubyOperator		Operator
hi link rubyPredefinedConstant	rubyPredefinedIdentifier
hi link rubyPredefinedIdentifier	rubyIdentifier
hi link rubyPredefinedVariable	rubyPredefinedIdentifier
hi link rubyPseudoVariable		Constant
hi link rubyQuoteEscape		rubyStringEscape
hi link rubyRegexp			rubyString
hi link rubyRegexpAnchor		rubyRegexpSpecial
hi link rubyRegexpCharClass		rubyRegexpSpecial
hi link rubyRegexpComment		Comment
hi link rubyRegexpDelimiter		rubyStringDelimiter
hi link rubyRegexpDot		rubyRegexpCharClass
hi link rubyRegexpEscape		rubyRegexpSpecial
hi link rubyRegexpQuantifier	rubyRegexpSpecial
hi link rubyRegexpSpecial		Special
hi link rubySharpBang		PreProc
hi link rubySpaceError		rubyError
hi link rubyString			String
hi link rubyStringEscape		Special
hi link rubySymbol			Constant
hi link rubySymbolDelimiter		rubySymbol
hi link rubyTodo			Todo

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier GruvboxRed
hi! link objcDirective GruvboxBlue

" }}}
" Go: {{{

hi! link goDirective Directory
hi! link goConstants GruvboxPurple
hi! link goDeclaration GruvboxRed
hi! link goDeclType GruvboxBlue
hi! link goBuiltins GruvboxOrange

" }}}
" Lua: {{{

hi link luaStatement		Statement
hi link luaRepeat		Repeat
hi link luaFor			Repeat
hi link luaString		String
hi link luaString2		String
hi link luaNumber		Number
hi link luaOperator		Operator
hi link luaIn			Operator
hi link luaConstant		Constant
hi link luaCond		Conditional
hi link luaElse		Conditional
hi link luaFunction		Function
hi link luaComment		Comment
hi link luaTodo		Todo
hi link luaTable		Structure
hi link luaError		Error
hi link luaParenError		Error
hi link luaBraceError		Error
hi link luaSpecial		SpecialChar
hi link luaFunc		Identifier

" }}}
" MoonScript: {{{

hi! link moonSpecialOp GruvboxFg3
hi! link moonExtendedOp GruvboxFg3
hi! link moonFunction GruvboxFg3
hi! link moonObject GruvboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation GruvboxBlue
hi! link javaDocTags Directory
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange
hi! link javaVarArg GruvboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment
hi! link elixirStringDelimiter GruvboxGreen
hi! link elixirInterpolationDelimiter Directory
hi! link elixirModuleDeclaration GruvboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition GruvboxFg1
hi! link scalaCaseFollowing GruvboxFg1
hi! link scalaCapitalWord GruvboxFg1
hi! link scalaTypeExtension GruvboxFg1

hi! link scalaKeyword Keyword
hi! link scalaKeywordModifier Keyword

hi! link scalaSpecial Directory
hi! link scalaOperator GruvboxFg1

hi! link scalaTypeDeclaration GruvboxYellow
hi! link scalaTypeTypePostDeclaration GruvboxYellow

hi! link scalaInstanceDeclaration GruvboxFg1
hi! link scalaInterpolation Directory

" }}}
" Markdown: {{{

" call s:HL('markdownItalic', s:fg3, s:none, s:italic)
hi markdownItalic cterm=italic gui=italic
hi! link markdownText Normal
hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 Title
hi! link markdownH4 Title
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow

hi! link markdownCode Directory
hi! link markdownCodeBlock Directory
hi! link markdownCodeDelimiter Directory

hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray

hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3

hi link markdownHeadingDelimiter Delimiter
hi! link markdownUrl Underlined
hi! link markdownUrlTitleDelimiter Underlined

" call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi link markdownLinkText Underlined
hi! link markdownIdDeclaration markdownLinkText

" I hate the built-in definition of a markdown error so sorry
hi! link markdownError markdownText

" Sep 29, 2019: Shit gotta add in a whole new batch of markdown highlighting

hi link mkdBlockquote    Comment
hi link mkdBold          PmenuSel
hi link mkdCode          String
hi link mkdCodeDelimiter ColorColumn
hi link mkdCodeEnd       String
hi link mkdCodeStart     String
hi link mkdDelimiter     Delimiter
hi link mkdFootnote      TablineSel
hi link mkdFootnotes     Underlined
hi link mkdHeading       Tag
hi link mkdID            Identifier
hi link mkdInlineURL     Underlined
" This appears to be trailing whitespace
hi link mkdLineBreak     Whitespace
hi link mkdLink          Underlined
hi link mkdLinkDef       mkdID
hi link mkdLinkDefTarget mkdURL
hi link mkdLinkTitle     htmlString
hi link mkdListItem      Identifier
hi link mkdNonListItemBlock Normal
hi link mkdRule          Identifier
" hi link mkdSnippetJS    Label
hi link mkdSnippetVIM    Label
hi link mkdString        String
hi link mkdURL           Underlined

" }}}
" Json: {{{

hi! link jsonBraces         Operator
hi! link jsonCommentError   NONE
hi! link jsonFold           Folded
hi! link jsonKeyword        Keyword
hi! link jsonKeywordMatch   Keyword
hi! link jsonQuote          GruvboxGreen
hi! link jsonString         String
hi! link jsonStringMatch    Question

" }}}
" Sh: {{{
hi link bashAdminStatement	shStatement
hi link bashSpecialVariables	shShellVariables
hi link bashStatement		shStatement
hi link shAlias		Identifier
hi link shArithRegion	shShellVariables
hi link shArithmetic		Special
hi link shAstQuote	shDoubleQuote
hi link shAtExpr	shSetList
hi link shBQComment	shComment
hi link shBeginHere	shRedir
hi link shBkslshDblQuote	shDoubleQuote
hi link shBkslshSnglQuote	shSingleQuote
hi link shCase             Question
hi link shCaseBar	shConditional
hi link shCaseCommandSub	shCommandSub
hi link shCaseDoubleQuote	shDoubleQuote
hi link shCaseError		Error
hi link shCaseEsac         Question
hi link shCaseEsacSync     Question
hi link shCaseExSingleQuote Question
hi link shCaseIn	shConditional
hi link shCaseLabel        Question
hi link shCaseRange        Question
hi link shCaseSingleQuote	shSingleQuote
hi link shCaseStart	shConditional
hi link shCharClass		Identifier
hi link shCmdParenRegion   Question
hi link shCmdSubRegion	shShellVariables
hi link shColon	shComment
hi link shComma            Question
hi link shCommandSub		Special
hi link shCommandSubBQ		shCommandSub
hi link shComment		Comment
hi link shCondError		Error
hi link shConditional		Conditional
hi link shCtrlSeq		Special
hi link shCurlyError		Error
hi link shCurlyIn          Question
hi link shDblBrace         Question
hi link shDblParen         Question
hi link shDeref	shShellVariables
hi link shDerefDelim	shOperator
hi link shDerefEscape      Question
hi link shDerefLen		shDerefOff
hi link shDerefOff		shDerefOp
hi link shDerefOp	shOperator
hi link shDerefOpError		Error
hi link shDerefPOL	shDerefOp
hi link shDerefPPS	shDerefOp
hi link shDerefPPSleft     Question
hi link shDerefPPSright    Question
hi link shDerefPSR	shDerefOp
hi link shDerefPSRleft     Question
hi link shDerefPSRright    Question
hi link shDerefPattern     Question
hi link shDerefSimple	shDeref
hi link shDerefSpecial	shDeref
hi link shDerefString	shDoubleQuote
hi link shDerefVar	shDeref
hi link shDerefVarArray    Question
hi link shDerefWordError		Error
hi link shDo               Question
hi link shDoError		Error
hi link shDoSync           Question
hi link shDoubleQuote	shString
hi link shEcho	shString
hi link shEchoDelim	shOperator
hi link shEchoQuote	shString
hi link shEmbeddedEcho	shString
hi link shEsacError		Error
hi link shEscape	shCommandSub
hi link shExDoubleQuote	shDoubleQuote
hi link shExSingleQuote	shSingleQuote
hi link shExpr             Question
hi link shExprRegion		Delimiter
hi link shFor              Question
hi link shForPP	shLoop
hi link shForSync          Question
hi link shFunction	Function
hi link shFunctionFour     Question
hi link shFunctionKey		Keyword
hi link shFunctionName		Function
hi link shFunctionOne      Identifier
hi link shFunctionStart    Question
hi link shFunctionThree    Question
hi link shFunctionTwo      Question
hi link shHereDoc	shString
hi link shHereDoc01		shRedir
hi link shHereDoc02		shRedir
hi link shHereDoc03		shRedir
hi link shHereDoc04		shRedir
hi link shHereDoc05		shRedir
hi link shHereDoc06		shRedir
hi link shHereDoc07		shRedir
hi link shHereDoc08		shRedir
hi link shHereDoc09		shRedir
hi link shHereDoc10		shRedir
hi link shHereDoc11		shRedir
hi link shHereDoc12		shRedir
hi link shHereDoc13		shRedir
hi link shHereDoc14		shRedir
hi link shHereDoc15		shRedir
hi link shHereDoc16        Question
hi link shHerePayload	shHereDoc
hi link shHereString	shRedir
hi link shIf               Identifier
hi link shIfSync           Question
hi link shInError		Error
hi link shLoop	shStatement
hi link shNoQuote	shDoubleQuote
hi link shNumber		Number
hi link shOK               Question
hi link shOperator		Operator
hi link shOption	shCommandSub
hi link shParen	shArithmetic
hi link shParenError		Error
hi link shPattern	shString
hi link shPosnParm	shShellVariables
hi link shQuickComment	shComment
hi link shQuote	shOperator
hi link shRange	shOperator
hi link shRedir	shOperator
hi link shRepeat		Repeat
hi link shSet		Statement
hi link shSetList		Identifier
hi link shSetListDelim	shOperator
hi link shSetOption	shOption
hi link shShellVariables		PreProc
hi link shSingleQuote	shString
hi link shSnglCase		Statement
hi link shSource	shOperator
hi link shSource	shOperator
hi link shSpecial		Special
hi link shSpecialDQ		Special
hi link shSpecialNoZS		shSpecial
hi link shSpecialNxt	shSpecial
hi link shSpecialSQ		Special
hi link shSpecialStart	shSpecial
hi link shSpecialVar       Question
hi link shStatement		Statement
hi link shString		String
hi link shStringSpecial	shSpecial
hi link shSubSh            Question
hi link shSubShRegion	shOperator
hi link shTest             Question
hi link shTestDoubleQuote	shString
hi link shTestError		Error
hi link shTestOpr	shConditional
hi link shTestPattern	shString
hi link shTestSingleQuote	shString
hi link shTodo		Todo
hi link shTouch            Question
hi link shTouchCmd	shStatement
hi link shUntilSync        Question
hi link shVarAssign        Question
hi link shVariable	shSetList
hi link shWhileSync        Question
hi link shWrapLineOperator	shOperator

" }}}
" QF: {{{
hi link qfFileName	Directory
hi link qfLineNr	LineNr
hi link qfError	Error

" }}}
" Django: {{{
hi link djangoTagBlock PreProc
hi link djangoVarBlock PreProc
hi link djangoStatement Statement
hi link djangoFilter Identifier
hi link djangoArgument Constant
hi link djangoTagError Error
hi link djangoVarError Error
hi link djangoError Error
hi link djangoComment Comment
hi link djangoComBlock Comment
hi link djangoTodo Todo

" }}}
" Tutor: {{{
hi link tutorEmail tutorLink
hi link tutorEmphasis htmlItalic
hi link tutorExpect Special
hi link tutorInlineOK tutorOK
hi link tutorInlineX tutorX
hi link tutorInternalAnchor Underlined
hi link tutorLink PmenuSel
hi link tutorLinkAnchor Underlined
hi link tutorLinkBands Delimiter
hi link tutorMarks htmlBold
hi link tutorSection Title
hi link tutorSectionBullet Delimiter
hi link tutorShellPrompt Delimiter
hi link tutorTOC Directory
hi link tutorURL tutorLink
hi link tutorBold htmlBold
" TODO:
hi tutorOK ctermfg=green guifg=#00ff88 cterm=bold gui=bold
hi tutorX ctermfg=red guifg=#ff2000  cterm=bold gui=bold
" tutorURL       xxx links to tutorLink
" tutorEmail     xxx links to tutorLink
" }}}
" CSV: {{{

hi! link CSVColumnHeaderOdd Title
hi! link CSVColumnHeaderEven IdentifierBold
" }}}
" Makefiles: {{{
hi! link makeStatement Type
hi! link makeExport Boolean
hi! link makeOverride Boolean
hi! link makeCommandError Exception

" }}}
" Help: {{{

" Default syntax
hi link helpBacktick	Ignore
hi link helpBar		Ignore
hi link helpBoolean		Boolean
hi link helpCharacter	Character
hi link helpCommand		Comment
hi link helpComment		Comment
hi link helpConditional	Conditional
hi link helpConstant	Constant
hi link helpDebug		Debug
hi link helpDefine		Define
hi link helpDelimiter	Delimiter
hi link helpDeprecated	Todo
hi link helpError		Error
hi link helpExample		Comment
hi link helpException	Exception
hi link helpFloat		Float
hi link helpFunction	Function
hi link helpGraphic CursorLineNr
hi link helpHeader		PreProc
hi link helpHeadline	Statement
hi link helpHyperTextEntry	String
hi link helpHyperTextJump	Identifier
hi link helpIdentifier	Identifier
hi link helpIgnore		Ignore
hi link helpInclude		Include
hi link helpKeyword		Keyword
hi link helpLabel		Label
hi link helpMacro		Macro
hi link helpNormal Normal
hi link helpNote		Todo
hi link helpNumber		Number
hi link helpOperator	Operator
hi link helpOption		Type
hi link helpPreCondit	PreCondit
hi link helpPreProc		PreProc
hi link helpRepeat		Repeat
hi link helpSectionDelim	PreProc
hi link helpSpecial		Special
hi link helpSpecialChar	SpecialChar
hi link helpSpecialComment	SpecialComment
hi link helpStar		Ignore
hi link helpStatement	Statement
hi link helpStorageClass	StorageClass
hi link helpString		String
hi link helpStructure	Structure
hi link helpTag		Tag
hi link helpTodo		Todo
hi link helpType		Type
hi link helpTypedef		Typedef
hi link helpURL		String
hi link helpUnderlined	Underlined
hi link helpVim		Identifier
hi link helpWarning WarningMsg
" }}}
" }}}
" vim: set sw=2 ts=2 sts=2 et fdm=marker fdls=1 fdl=1:
