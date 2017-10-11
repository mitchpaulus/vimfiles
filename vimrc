" Vundle Plugins {{{1 
set nocompatible  " be iMproved, required for Vundle
filetype off    " required for Vundle.

if has('win32')
    set rtp+=~/vimfiles/bundle/Vundle.vim "This is for Windows Vundle.
    call vundle#begin('~/vimfiles/bundle')
endif

if has('unix')
    set rtp+=~/.vim/bundle/Vundle.vim "This is for Ubuntu/Linux Vundle.
    call vundle#begin()
endif

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'godlygeek/tabular'
Plugin 'lervag/vimtex'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'sickill/vim-monokai'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

call vundle#end()            " required for Vundle
filetype plugin indent on    " required for Vundle

if has('unix')
    let g:UltiSnipsSnippetDir = "~/.vim/UltiSnips"
endif

if has('win32')
    let g:UltiSnipsSnippetDir = "~/vimfiles/UltiSnips"
    let g:UltiSnipsSnippetDirectories = [$HOME.'/vimfiles/UltiSnips', 'UltiSnips']
endif

nnoremap <leader>ue :UltiSnipsEdit<cr>

" General Mappings {{{1
" Use space key for leader, but actually use default leader so it shows up in
" status bar.
map <space> <leader>
let maplocalleader=","
"Fast saving
noremap <Leader>w :w<CR>
" Fast quitting
noremap <leader>q :q<cr>
" Really quit
noremap <leader>Q :q!<cr>
" [Y]ank [l]ine without newlines
nnoremap yl ^y$
" [D]elete [l]ine without newlines
nnoremap dl ^d$
" [C]hange [l]ine without newlines
nnoremap cl ^c$
" Insert [t]oday's [d]ate
nnoremap <leader>td i<c-r>=strftime('%Y-%m-%d')<cr> 
" Insert today's c-[d]ate
inoremap <c-d> <c-r>=strftime('%Y-%m-%d')<cr> 
" Quickly enter in ² symbol
inoremap ^2 <c-v>178
" Quickly enter ft².
inoremap ft2 ft<c-v>178

" Quickly eneter in °F
inoremap DEGF °F

" From Vimscript the Hard Way chap 15
onoremap p i(
onoremap in( :<c-u>execute "normal! /(\r:nohlsearch\rvi("<cr>
onoremap il( :<c-u>execute "normal! ?(\r:nohlsearch\rvi("<cr>
vnoremap p i(

onoremap b i{
onoremap in{ :<c-u>execute "normal! /{\r:nohlsearch\rvi{"<cr>
onoremap il{ :<c-u>execute "normal! ?{\r:nohlsearch\rvi{"<cr>
vnoremap b i{

" Visually select inside latex table cell, first go back to last 
" & or beginning of line, mark to s, then go to next & or end of line \\
" then go to the end of the previous word, visually select back to
" original mark. 
vnoremap tc v?^\<bar>&<cr>wms/&\<bar>\\\\<cr>:nohlsearch<cr>gEv`s
onoremap tc :<c-u>execute 'normal! ?^\<bar>&' . "\r" . 'wms/&\<bar>\\\\' . "\r:nohlsearch\rgEv`s"<cr>

" Change paste settings 
nnoremap <leader>sp :<c-u>set paste!<cr>:set paste?<cr>

" Quickly change present working directory to 
" the current files directory.
nnoremap <leader>pw :<c-u>call <SID>ChangePWD()<cr>

function! s:ChangePWD()
    cd %:p:h
    pwd
endfunction

" Use par for formatting paragraphs on unix.
if has('unix')
    set formatprg=par\ -w72
endif

"Make it easy to edit the vimrc file. From
"http://learnvimscriptthehardway.stevelosh.com/chapters/07.html.
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" [e]dit [t]ikz plugin. 
nnoremap <leader>et :vsplit ~/vimfiles/bundle/latex-plus/ftplugin/tex.vim<cr>
"
"[C]lear [W]hitespace at End of Line
nnoremap <leader>cw :%s/\v\s+$//<cr>
"Default searches to be very magic and case-insensitive
"nnoremap / /\v

" These mappings are for VisualStudio Vim in order to get correct indentation.
nnoremap S ddO
nnoremap cc S

nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"Mapping to make current word in insert/normal mode capitalized. See Modal Mapping Vimscript the Hard Way.
"inoremap <leader><c-u> <esc>hviwUea
nnoremap <leader><c-u> viwU

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

"Use jk to escape insert mode. Suggested here:
"http://learnvimscriptthehardway.stevelosh.com/chapters/10.html
inoremap jk <esc>
nnoremap <TAB> }

" Quick mappings for the beginning and ends of lines
noremap H ^
noremap L $

" Want cntrl-backspace to delete whole word in insert mode
inoremap <C-BS> <C-W>

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

"Clear the previous search (c[lear] h[ighlight])
nnoremap <leader>ch :nohlsearch<cr>

nnoremap <leader>ss :set spell!<cr>:echo "Spell is now " . &spell<cr>
" Flip background color setting, from http://tilvim.com/2013/07/31/swapping-bg.html.
nnoremap <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Switch the setting of the [sh]ell slash setting. 
nnoremap <leader>sh :<c-u>call <SID>SwitchShellSlash()<CR>

function! s:SwitchShellSlash() 
    if &shellslash == 0
        set shellslash
    else
        set noshellslash
    endif    
    echo "shellslash setting is now " . &shellslash
endfunction


" Switch setting for [t]ext [w]idth.
nnoremap <leader>tw :<c-u>call <SID>ChangeTextWidth()<CR>

function! s:ChangeTextWidth()
    let &textwidth = ( &textwidth == 0 ? 72 : 0 )
    echo "textwidth is now " . &textwidth
endfunction


"These mappings are for moving around the windows quickly.
nnoremap <c-w> <c-w><c-w>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-c> <c-w>c
nnoremap <c-d> :BD<cr> " Delete buffer using the qpkorr/vim-bufkill package.

nnoremap <c-s> [s  " Move backwards in spell check.

nnoremap <c-n> :bn<cr>
" nnoremap <leader>j <c-w>j
" nnoremap <leader>k <c-w>k

" General Settings/Options {{{1
"Custom Status Line
set statusline=File:%.50F,\ FT:%y,C:%c,%p%%,HEX:%B,%{&ff},%{&encoding},%{fugitive#statusline()}
set hlsearch   " highlight search
set incsearch  " highlight temporary searches
set rnu        " Relative line numbering
set number     " Show the current line number
set cursorline
set encoding=utf-8
                               " set ignorecase                                                  " ignorecase on searching
set backspace=indent,eol,start " Want backspaces to always work as normal.
set scrolloff=2                " Want two lines above and below cursor when scrolling.
set smartcase                  " Use smartcase
set laststatus=2               " Always show the statusbar
set nowrap                     " No word wrap.
set lbr                        " Want line breaks at whitespace
set tabstop=4                  " show existing tab with 4 spaces width
set shiftwidth=4               " when indenting with '>', use 4 spaces width
set expandtab                  " On pressing tab, insert 4 spaces
set cmdheight=2                " Make the command window height 2 to avoid the hit-enter prompts
set history=1000               " Remember up to 1000 ex commands.
set lazyredraw
set ttyfast
set spelllang=en_us
set spellsuggest=10

set sessionoptions=buffers,curdir,winpos,winsize
set list
set listchars=tab:▸\ ,eol:¬

" Don't try to highlight lines longer than 100 chars (from sjl)
set synmaxcol=200

if has('gui_running')
    set lines=9999                 " Show 75 lines on default opening.
    set columns=110                " Show 90 columns on default opening.
else
    "set background=light
    "colorscheme solarized
endif

if &term =~? '256color'
    " set t_ut=
endif

function! s:SetSpellToHVACFile()
    if &l:spellfile==?""
        if has('win32')
            echom "Tried to set spellfile"
            setlocal spellfile=~\vimfiles\spell\hvac.utf-8.add
        endif
        if has('unix') 
            setlocal spellfile=~/.vim/spell/hvac.utf-8.add
        endif
    else 
        echom "Cleared spellfile"
        setlocal spellfile=
    endif
    echom &l:spellfile
endfunction

" Map to function to get [h]vac [s]pell file. 
nnoremap <leader>hs :<c-u>call <SID>SetSpellToHVACFile()<cr>

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_gtk3")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif


set isfname-={
set isfname-=}

set wildignore+=*.aux*
set wildignore+=*.log
set wildignore+=*.swp
set wildignore+=*.nav
set wildignore+=*.toc
set wildignore+=*.out
set wildignore+=*.fdb_latexmk
set wildignore+=*.blg
set wildignore+=*.fls
set wildignore+=*.xdv
set wildignore+=*.bbl
set wildignore+=*.snm
set wildignore+=*.lof
set wildignore+=*.lot
set wildignore+=*.dvi
set wildignore+=*.tmp
set wildignore+=*.synctex.gz

"Set hyphens and colons to be parts of words. Very useful in latex documents.
set iskeyword+=-
set iskeyword+=:
set noshellslash

" Plugin Specific Options {{{1

" NERDTree {{{2
" NERDTree Settings
" Open up nerd tree quickly.
nnoremap <leader>n :NERDTree<cr>
let NERDTreeIgnore=['\.aux.*$','\.fls$','\.lof$','\.toc$','\.out$','\.vrb$','\.nav$','\.snm$','\.bbl$','\.bib','\.fdb_latexmk$','\.xdv','\.gif','\.pdf','\~$','\.blg$','\.lot$']



" Gundo {{{2
" Gundo Options. New versions of GVIM don't have 
" original python support.
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
" Open up the undo tree.
nnoremap <F5> :<c-u>GundoToggle<cr>

"Tabular {{{2
"Tabular mapping to format table
" aligning on & and \\ at the end of the line.
" See http://stackoverflow.com/questions/19414193/regex-extract-string-not-between-two-brackets
vnoremap <leader>tf :<c-u>'<,'>Tab /[^\\]\zs&\<Bar>\({[^}{]*\)\@<!\(\\\\\)\([^{}]*}\)\@!/<cr>
nnoremap <leader>tf :<c-u>Tab /[^\\]\zs&\<Bar>\({[^}{]*\)\@<!\(\\\\\)\([^{}]*}\)\@!/<cr>
nnoremap <leader>t<Bar> :Tab /<Bar>/<cr>

" Fugitive {{{2
" Fugitive mappings for status, add, and commit.
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gph :Gpush<cr>
nnoremap <leader>gpl :Gpull<cr>

" Search for the current visual selection using '*'. See pg. 212 of Practical Vim
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

syntax enable

if has('gui_running') 
    let g:solarized_termcolors=256
    let g:solarized_termtrans=0
    colorscheme solarized
    "colorscheme monokai
endif

" Vimtex {{{2
"For vimtex
filetype plugin indent on
let g:vimtex_view_enabled = 0
let g:tex_flavor="latex"
let g:vimtex_quickfix_latexlog = {'overfull': 0, 'underfull':0}
let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'jobs',
            \ 'background' : 1,
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'options' : [
            \   '-pdf',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=0',
            \   '-interaction=nonstopmode',
            \ ],
            \}
"
" Ctrl-P {{{2
" For CTRL-P
let g:ctrlp_mruf_exclude = '.*log\|.*aux\|.*tmp\|.*\\.git\\.*' " Windows
let g:ctrlp_mruf_max = 250

let g:ctrlp_custom_ignore = '\.\(pdf\|png\|PNG\)$'
let g:ctrlp_by_filename = 1
" Chose <c-y> because it is analogous to ctrl-p but with the pointer
" finger
nnoremap <c-y> :CtrlPBuffer<cr>
" Chose <c-u> for most recently [u]sed
nnoremap <c-u> :CtrlPMRU<cr>

" MISC {{{1

"This is to make sure that when you first enter a file
"you don't get a whole bunch of highlighting.
nohlsearch

" FileType AutoCmd Mappings {{{1
function! s:MakeHeading(replaceCharacter)
    let previousSearch=@/
    "echom ":s/\\s\\+$//e\rVypVr".a:replaceCharacter.":noh\r"
    silent execute "normal! :s/\\s\\+$//e\rVypVr".a:replaceCharacter
    let @/=previousSearch
endfunction

function! s:CleanBibFile()
    %g/month\s*=/d
    %g/file\s*=/d
    %g/doi\s*=/d
    %g/issn\s*=/d
    %g/keywords\s*=/d
    %g/url\s*=/d
    %g/mendeley-groups\s*=/d
    %s/title\s*=\s*{\s*{\(.*\)}\s*}/title = {\1}/
endfunction

augroup filetypemappings
autocmd!
" make a header 1 line, deleting trailing whitespace first.
autocmd FileType markdown nnoremap <silent> <leader>h1 :<c-u>call <SID>MakeHeading("=")<cr>
autocmd FileType markdown nnoremap <silent> <leader>h2 :<c-u>call <SID>MakeHeading("-")<cr>
autocmd FileType markdown,tex,text set textwidth=72
autocmd FileType markdown,tex,text set spell
autocmd FileType help nnoremap <leader>hh mnA~<esc>`n
autocmd FileType help nnoremap <leader>hl mn78i=<esc>`n
autocmd FileType tex inoremap %%% \% 
autocmd FileType tex nnoremap [e ?\\begin{equation}<cr>:nohlsearch<cr>
autocmd FileType tex nnoremap ]e /\\begin{equation}<cr>:nohlsearch<cr>
autocmd FileType bib command! CleanBib call <SID>CleanBibFile()
augroup END

" Event Type Autocmd mappings {{{1
augroup eventtypemappings
autocmd!
" cshtml - html - close enough 
autocmd BufRead *.cshtml set filetype=html
" Save when losing focus, thanks SJL
autocmd BufLeave * :silent! w
augroup END
