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
Plugin 'mitchpaulus/latex-plus'
Plugin 'mitchpaulus/vim-siemens-pplc'
Plugin 'mitchpaulus/vim-tex2text'
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
"Use space key for leader, but actually use default leader so it shows up in
"status bar.
map <space> <leader>

"Fast saving
noremap <Leader>w :w<CR>
" Fast quitting
noremap <leader>q :q<cr>
" Really quit
noremap <leader>Q :q!<cr>
" Yank line without newlines
nnoremap yl ^y$
" Delete line without newlines
nnoremap dl ^d$
" Change line without newlines
nnoremap cl ^c$
" Insert [t]oday's [d]ate
nnoremap <leader>td i<c-r>=strftime('%Y-%m-%d')<cr> 
" Insert today's c-[d]ate
inoremap <c-d> <c-r>=strftime('%Y-%m-%d')<cr> 
" Quickly enter in ² symbol
inoremap ^2 <c-v>178
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

"This function is here to quickly be able to add word corrections.
function! s:AddToAbbrev(wrongSpelledWord)
    split $MYVIMRC
    set spell
    "G - to end of file, o - make new line and enter insert mode, iabbrev
    "[variable word]
    execute "normal! Goiabbrev " . a:wrongSpelledWord
    "store misspelled word in s register, replace with first spell suggestion,
    "repaste misspelled word, append and insert space.
    execute "normal! \"syiw1z=\"sPa\<space>"
    "leave user in visual mode, in case the first selection wasn't good.
    execute "normal! lviw"
endfunction

" [a]dd [a]bbreviation. Yanks inner word, runs the AddToAbbrev function.
nnoremap <leader>aa yiw:<C-u>call <SID>AddToAbbrev("<c-r>"")<cr>
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
inoremap <leader><c-u> <esc>hviwUea
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
set statusline=File:%F,\ FT:%y,C:%c,%p%%\ %{fugitive#statusline()}

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
set lines=9999                 " Show 75 lines on default opening.
set columns=110                " Show 90 columns on default opening.
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

" Ctrl-P {{{2
" For CTRL-P
let g:ctrlp_mruf_exclude = '.*log\|.*aux\|.*tmp\|.*\\.git\\.*' " Windows
let g:ctrlp_mruf_max = 250

let g:ctrlp_custom_ignore = '\.\(pdf\|png\|PNG\)$'
let g:ctrlp_by_filename = 1
" Chose <c-y> because it is analogous to ctrl-p but with the pointer
" finger
nnoremap <c-y> :CtrlPBuffer<cr>

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


" Autocorrect Mappings {{{1
"This is a mapping just for the vimrc to sort the abbreviations, case
"insensitively. Sort operates on characters after match by default.
"|||||||||||||||||||++++++++++++++++++++++++++++------------------------------------- Search for commented line 'Autocorrect Mappings'
"|||||||||||||||||||||||||||||||||||||||||||||||+------------------------------------ Move down one line
"||||||||||||||||||||||||||||||||||||||||||||||||++++++++++++------------------------ Sort command from beginning of iabbrevs, should be right after heading.
"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||++++++------------------ 1 or more any characters, non-greedy.
"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||++---------------- whitespace
"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||++++++---------- 1 or more any characters, non-greedy
"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||+++------- whitespace
"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||+----- case insensitive 
"|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||++++- Enter the Ex Command
nnoremap <leader>sa /\v^"Autocorrect Mappings<cr>j:.,$sort /\v.{-1,}\s.{-1,}\s/ i<cr>
"Autocorrect Mappings
iabbrev absoulte absolute
iabbrev accelearted accelerated
iabbrev aceptable acceptable
iabbrev accompolish accomplish
iabbrev Accordiing According
iabbrev accoriding according
iabbrev acutal actual
iabbrev actucally actually
iabbrev dadditional additional
iabbrev addresssed addressed
iabbrev addsd adds
iabbrev adeqauyate adequate
iabbrev adopeted adopted
iabbrev Ari Air
iabbrev ahir air
iabbrev iar air
iabbrev ari air
iabbrev alogrithm algorithm
iabbrev alogrighms algorithms
iabbrev aligened aligned
iabbrev alos also
iabbrev aslo also
iabbrev Althouugh Although
iabbrev amoutn amount
iabbrev analyis analysis
iabbrev analyiss analysis
iabbrev anlayiss analysis
iabbrev anlaysis analysis
iabbrev anaylytically analytically
iabbrev alnaalyze analyze
iabbrev anscestors ancestors
iabbrev Adn And
iabbrev adn and
iabbrev nad and
iabbrev tand and
iabbrev nadn and
iabbrev annula annual
iabbrev annother another
iabbrev anywereh anywhere
iabbrev appartent apparent
iabbrev apepndix appendix
iabbrev applicaiton application
iabbrev Applicaiton Application
iabbrev Applicaitons Applications
iabbrev apploied applied
iabbrev applky apply
iabbrev appraoch approach
iabbrev approahc approach
iabbrev approriate appropriate
iabbrev approximatled approximated
iabbrev approimated approximated
iabbrev approximatlye approximately
iabbrev approximatley approximately
iabbrev apprpoximatley approximately
iabbrev approximatation approximation
iabbrev arbitralily arbitrarily
iabbrev arbirary arbitrary
iabbrev raea area
iabbrev aroudn around
iabbrev Artifical Artificial
iabbrev aas as
iabbrev ascpects aspects
iabbrev assignead assigned
iabbrev Assitatn Assistant
iabbrev assuem assume
iabbrev Assuem Assume
iabbrev assuemd assumed
iabbrev assusmed assumed
iabbrev assuems assumes
iabbrev assumjption assumption
iabbrev assumptiosn assumptions
iabbrev assukmptions assumptions
iabbrev atmosphereic atmospheric
iabbrev attemping attempting
iabbrev Attendence Attendance
iabbrev availabee available
iabbrev avialbe available
iabbrev avaialbe available
iabbrev avialable available
iabbrev avialbalbe available
iabbrev avaialbable available
iabbrev availbale available
iabbrev avaiable available
iabbrev availbe available
iabbrev availbvle available
iabbrev avaialble available
iabbrev availalbe available
iabbrev availbabele available
iabbrev Backgroudn Background
iabbrev balnace balance
iabbrev balnaces balances
iabbrev basleines baselines
iabbrev Bascially Basically
iabbrev becuase because
iabbrev beginnign beginning
iabbrev beginnnign beginning
iabbrev beign being
iabbrev besdies besides
iabbrev betwen between
iabbrev beteween between
iabbrev billtion billion
iabbrev biler boiler
iabbrev bookelt booklet
iabbrev boudn bound
iabbrev boudnary boundary
iabbrev braod broad
iabbrev buildign building
iabbrev Buildign Building
iabbrev buikdlign building
iabbrev buliding building
iabbrev buiilding building
iabbrev buildnig building
iabbrev builgin building
iabbrev buioldings buildings
iabbrev buildigns buildings
iabbrev buiolgings buildings
iabbrev builgins buildings
iabbrev Calcuate Calculate
iabbrev Calcualte Calculate
iabbrev caluclate calculate
iabbrev claculated calculated
iabbrev calcualted calculated
iabbrev Caluclated Calculated
iabbrev claculation calculation
iabbrev caluclations calculations
iabbrev Calcibrated Calibrated
iabbrev calibrationg calibrating
iabbrev clal call
iabbrev cna can
iabbrev canbe can be
iabbrev capabiliity capability
iabbrev cappactiy capacity
iabbrev capicaity capacity
iabbrev cvase case
iabbrev Certian Certain
iabbrev certificaiton certification
iabbrev chnage change
iabbrev chagnes changes
iabbrev Chatper Chapter
iabbrev cahpter chapter
iabbrev cahractersictic characteristic
iabbrev childern children
iabbrev chilllers chillers
iabbrev cohsen chosen
iabbrev Clairdige Claridge
iabbrev xlosed closed
iabbrev ocde code
iabbrev coeffient coefficient
iabbrev coefficent coefficient
iabbrev coefificent coefficient
iabbrev coefficinets coefficients
iabbrev coli coil
iabbrev colleciton collection
iabbrev combinatino combination
iabbrev comibned combined
iabbrev Commerical Commercial
iabbrev commissiongin commissioning
iabbrev commisioning commissioning
iabbrev Commisisiong Commissioning
iabbrev commissionign commissioning
iabbrev ocmmon common
iabbrev commonlky commonly
iabbrev comapred compared
iabbrev competiting competing
iabbrev compelted completed
iabbrev compeleted completed
iabbrev compeletes completes
iabbrev compoonents components
iabbrev comrpession compression
iabbrev comptuer compute
iabbrev ocnclusions conclusions
iabbrev conculsions conclusions
iabbrev ocndenser condenser
iabbrev conenction connection
iabbrev condsidered considered
iabbrev consistnely consistently
iabbrev ocnstant constant
iabbrev constatn constant
iabbrev Constatn Constant
iabbrev ocnsatnt constant
iabbrev contianer container
iabbrev Conntainer Container
iabbrev continaer container
iabbrev coantainers containers
iabbrev contaienrs containers
iabbrev conntainers containers
iabbrev conatins contains
iabbrev Continousous Continuous
iabbrev Contionous Continuous
iabbrev contributrion contribution
iabbrev contirbutors contributors
iabbrev contorl control
iabbrev Cotnrl Control
iabbrev Contrls Controls
iabbrev ocntrosl controls
iabbrev convensition convention
iabbrev convetino convention
iabbrev coolign cooling
iabbrev cooloing cooling
iabbrev coolking cooling
iabbrev correclty correctly
iabbrev correspoinding corresponding
iabbrev correspongin corresponding
iabbrev correspoinds corresponds
iabbrev coiuld could
iabbrev coures course
iabbrev credites credits
iabbrev creiterion criterion
iabbrev crediterion criterion
iabbrev criticial critical
iabbrev curvativure curvature
iabbrev cusomt custom
iabbrev cycel cycle
iabbrev cylce cycle
iabbrev dialy daily
iabbrev Dallsa Dallas
iabbrev datapoints data points
iabbrev decreaesed decreased
iabbrev decreasees decreases
iabbrev fdefine define
iabbrev definned defined
iabbrev dnesity density
iabbrev depdnd depend
iabbrev derviative derivative
iabbrev derviate derivative
iabbrev derviative derivative
iabbrev deriviate derivative
iabbrev deriviateve derivative
iabbrev deriviatives derivatives
iabbrev descentdants descendants
iabbrev descritpion description
iabbrev desing design
iabbrev Desing Design
iabbrev detial detail
iabbrev detailede detailed
iabbrev detials details
iabbrev determiniation determination
iabbrev determein determine
iabbrev determineing determining
iabbrev Developement Development
iabbrev developes develops
iabbrev Difff Diff
iabbrev diffentert different
iabbrev difficutl difficult
iabbrev directins directions
iabbrev driectly directly
iabbrev direclty directly
iabbrev sdiscern discern
iabbrev disply display
iabbrev distercit district
iabbrev dirunal diurnal
iabbrev docuemnt document
iabbrev doen done
iabbrev Downtonw Downtown
iabbrev dorp drop
iabbrev diuct duct
iabbrev effectiley effectively
iabbrev effectes effects
iabbrev efficicency efficiency
iabbrev efficienty efficiency
iabbrev effortr effort
iabbrev electiricyt electricity
iabbrev electricay electricity
iabbrev electriciyt electricity
iabbrev elswe else
iabbrev emial email
iabbrev ned end
iabbrev endevor endeavor
iabbrev ENergy Energy
iabbrev nergy energy
iabbrev eneryg energy
iabbrev enenrgy energy
iabbrev Enginereing Engineering
iabbrev egineers engineers
iabbrev entier entire
iabbrev entrace entrance
iabbrev entorpy entropy
iabbrev enviornment environment
iabbrev eqaul equal
iabbrev equzl equal
iabbrev equaiton equation
iabbrev eequations equations
iabbrev equationas equations
iabbrev equaitons equations
iabbrev equilbrium equilibrium
iabbrev equpiment equipment
iabbrev euqipment equipment
iabbrev Equipemnt Equipment
iabbrev eerror error
iabbrev Especailly Especially
iabbrev eestimate estimate
iabbrev estitamed estimated
iabbrev estiamted estimated
iabbrev esitmating estimating
iabbrev esitimation estimation
iabbrev Eruopean European
iabbrev evaluateed evaluated
iabbrev evalueaiton evaluation
iabbrev everyting everything
iabbrev exmaple example
iabbrev execture execute
iabbrev exectued executed
iabbrev exericse exercise
iabbrev exercieses exercises
iabbrev Exisiting Existing
iabbrev exisitng existing
iabbrev expannding expanding
iabbrev exapansion expansion
iabbrev expansionj expansion
iabbrev Explaingin Explaining
iabbrev exponnets exponents
iabbrev extensibile extensible
iabbrev fractor factor
iabbrev Farenheit Fahrenheit
iabbrev fna fan
iabbrev felied field
iabbrev Figurte Figure
iabbrev fiel file
iabbrev finsih finish
iabbrev Finsihed Finished
iabbrev fiinished finished
iabbrev ifxes fixes
iabbrev lfow flow
iabbrev flolw flow
iabbrev folloiwing following
iabbrev follwoing following
iabbrev folowoing following
iabbrev fotter footer
iabbrev fro for
iabbrev ofr for
iabbrev Fro For
iabbrev Froest Forest
iabbrev Foiruier Fourier
iabbrev fule fuel
iabbrev fullfill fulfill
iabbrev funciton function
iabbrev fucntion function
iabbrev functdion function
iabbrev fundction function
iabbrev fucntions functions
iabbrev funcitons functions
iabbrev Fucnttions Functions
iabbrev rurther further
iabbrev grpahic graphic
iabbrev graviational gravitational
iabbrev gropus groups
iabbrev ahlls halls
iabbrev handaling handling
iabbrev ahndling handling
iabbrev handlaing handling
iabbrev handlign handling
iabbrev ahs has
iabbrev ahve have
iabbrev hvae have
iabbrev heaitng heating
iabbrev heaint heating
iabbrev ehating heating
iabbrev helpuful helpful
iabbrev hree: here:
iabbrev hgiher higher
iabbrev hikstorical historical
iabbrev HOliddays Holidays
iabbrev horizonatal horizontal
iabbrev HOwever However
iabbrev Howerver However
iabbrev humdity humidity
iabbrev humidty humidity
iabbrev Huniting Hunting
iabbrev idael ideal
iabbrev ingored ignored
iabbrev immediatly immediately
iabbrev impelmetn implement
iabbrev Implementner Implementer
iabbrev IMplemneter Implementer
iabbrev importantance importance
iabbrev improtant important
iabbrev importatn important
iabbrev imporve improve
iabbrev ina in a
iabbrev inthe in the
iabbrev inclucded included
iabbrev incompressibiility incompressibility
iabbrev incrteasing increasing
iabbrev indedependt independent
iabbrev indiciatiton indication
iabbrev indifivalu individual
iabbrev inddor indoor
iabbrev infomration information
iabbrev inforamtion information
iabbrev informaiton information
iabbrev informaitno information
iabbrev inoformation information
iabbrev inital initial
iabbrev intial initial
iabbrev intitiating initiating
iabbrev inelt inlet
iabbrev linet inlet
iabbrev insentive insensitive
iabbrev insensivitve insensitive
iabbrev Institutue Institute
iabbrev insturction instruction
iabbrev Integratign Integrating
iabbrev INterface Interface
iabbrev interioro interior
iabbrev interanl internal
iabbrev intenral internal
iabbrev interla internal
iabbrev itnerla internal
iabbrev internavl interval
iabbrev inot into
iabbrev Introduciton Introduction
iabbrev invserse inverse
iabbrev investement investment
iabbrev irreversilbe irreversible
iabbrev fis is
iabbrev isoalted isolated
iabbrev isothermla isothermal
iabbrev itme item
iabbrev itmes items
iabbrev jsut just
iabbrev ujst just
iabbrev dkey key
iabbrev Kimal Kimla 
iabbrev lable label
iabbrev leanring learning
iabbrev LIbrary Library
iabbrev librayr library
iabbrev olimitations limitations
iabbrev lienar linear
iabbrev liquied liquid
iabbrev littel little
iabbrev laod load
iabbrev Laod Load
iabbrev Lcoate Locate
iabbrev lcoated located
iabbrev locaiton location
iabbrev Macrosciptic Macroscopic
iabbrev magentic magnetic
iabbrev magintuide magnitude
iabbrev makea make a
iabbrev mapas maps
iabbrev makr mark
iabbrev materla material
iabbrev mathematica Mathematica
iabbrev maximimum maximum
iabbrev measuresed measured
iabbrev measuremnets measurements
iabbrev measuremnts measurements
iabbrev mechanicla mechanical
iabbrev memeter meter
iabbrev mehtod method
iabbrev Mniiimzie Minimize
iabbrev mimnimum minimum
iabbrev Mintue Minute
iabbrev mintues minutes
iabbrev minxing mixing
iabbrev maixing mixing
iabbrev modle model
iabbrev mdoel model
iabbrev modleing modeling
iabbrev mdoels models
iabbrev modesl models
iabbrev MOdified Modified
iabbrev modifeid modified
iabbrev moels moles
iabbrev montiors monitors
iabbrev montly monthly
iabbrev mroe more
iabbrev moring morning
iabbrev moter motor
iabbrev namign naming
iabbrev enearsets nearest
iabbrev enearest nearest
iabbrev NEedc Need
iabbrev neagagive negative
iabbrev n3egative negative
iabbrev neighbort neighbor
iabbrev neightbor neighbor
iabbrev Nueral Neural
iabbrev nomencalture nomenclature
iabbrev nomial nominal
iabbrev nnormal normal
iabbrev NOtes Notes
iabbrev nozle nozzle
iabbrev nubmer number
iabbrev Numverical Numerical
iabbrev numercial numerical
iabbrev occupnacy occupancy
iabbrev occpunacy occupancy
iabbrev occured occurred
iabbrev occuring occurring
iabbrev fo of
iabbrev oftne often
iabbrev operaties operates
iabbrev oeprational operational
iabbrev operaitonla operational
iabbrev operatialn operational
iabbrev operaitons operations
iabbrev oppostie opposite
iabbrev optimizaiton optimization
iabbrev optimziation optimization
iabbrev optimziaiton optimization
iabbrev origianl original
iabbrev oriigal original
iabbrev oringial original
iabbrev originatign originating
iabbrev toher other
iabbrev otudoor outdoor
iabbrev outelt outlet
iabbrev Outolok Outlook
iabbrev ouptut output
iabbrev aprameter parameter
iabbrev pareameters parameters
iabbrev parametesr parameters
iabbrev aprameters parameters
iabbrev apratemters parameters
iabbrev partent parent
iabbrev paretn parent
iabbrev paretns parents
iabbrev partail partial
iabbrev aprtial partial
iabbrev paraticlaur particular
iabbrev aprtition partition
iabbrev penatlty penalty
iabbrev penatly penalty
iabbrev pepople people
iabbrev perforamcne performance
iabbrev paln plan
iabbrev palusible plausible
iabbrev polts plots
iabbrev poitn point
iabbrev poitns points
iabbrev pooints points
iabbrev polytorpic polytropic
iabbrev ploytropic polytropic
iabbrev Protfoilo Portfolio
iabbrev protfolio portfolio
iabbrev poriton portion
iabbrev porition portion
iabbrev protions portions
iabbrev Posistions Positions
iabbrev positivie positive
iabbrev postivie positive
iabbrev possitve positive
iabbrev postive positive
iabbrev possilbities possibilities
iabbrev possilbe possible
iabbrev potentila potential
iabbrev potentail potential
iabbrev ptotently potentially
iabbrev pwoer power
iabbrev pwoered powered
iabbrev practivce practice
iabbrev predition prediciton
iabbrev pedicted predicted
iabbrev prediced predicted
iabbrev predicitng predicting
iabbrev prediciton prediction
iabbrev rpredicitons predictions
iabbrev Prelimiary Preliminary
iabbrev permier premier
iabbrev Prequisite Prerequisite
iabbrev prerequitsite prerequisite
iabbrev presneted presented
iabbrev apressure pressure
iabbrev priece price
iabbrev princeple principle
iabbrev priortization prioritization
iabbrev probelm problem
iabbrev prfoceed proceed
iabbrev Processs Process
iabbrev proces process
iabbrev prodcue produce
iabbrev prodcued produced
iabbrev produciton production
iabbrev prodcuts products
iabbrev profjiels profiles
iabbrev progrma program
iabbrev projecdts projects
iabbrev projexts projects
iabbrev properityes properties
iabbrev proeprty property
iabbrev porperty property
iabbrev porportion proportion
iabbrev propsoed proposed
iabbrev propsed proposed
iabbrev upmps pumps
iabbrev quaklity quality
iabbrev Quantificaitons Quantifications
iabbrev qunaittites quantities
iabbrev questionaire questionnaire
iabbrev quesitons questions
iabbrev reaised raised
iabbrev rasing raising
iabbrev artes rates
iabbrev artio ratio
iabbrev reasonlabe reasonable
iabbrev reasonlable reasonable
iabbrev resaonable reasonable
iabbrev reasonalbly reasonably
iabbrev recieve receive
iabbrev recoginition recognition
iabbrev referecne reference
iabbrev refrigeratant refrigerant
iabbrev refigerator refrigerator
iabbrev reagrds regards
iabbrev regernation regeneration
iabbrev regrssion regression
iabbrev reheta reheat
iabbrev rehate reheat
iabbrev realted related
iabbrev relationsihp relationship
iabbrev relationnship relationship
iabbrev Relationjships Relationships
iabbrev relavent relevant
iabbrev remtoe remote
iabbrev rpelaced replaced
iabbrev repclaced replaced
iabbrev replacemetn replacement
iabbrev reprot report
iabbrev requied required
iabbrev requiremnets requirements
iabbrev reaseach research
iabbrev reasearch research
iabbrev resistnace resistance
iabbrev respcet respect
iabbrev respecdt respect
iabbrev restul result
iabbrev resutls results
iabbrev retun return
iabbrev Reveiew Review
iabbrev rightt right
iabbrev riese rise
iabbrev Roayl Royal
iabbrev ORyal Royal
iabbrev sameple sample
iabbrev smaple sample
iabbrev sampel sample
iabbrev satifies satisfies
iabbrev asy say
iabbrev schdeule schedule
iabbrev schmatic schematic
iabbrev socpe scope
iabbrev sedond second
iabbrev selct select
iabbrev slection selection
iabbrev senstivity sensitivity
iabbrev sensitivtiy sensitivity
iabbrev senseor sensor
iabbrev snesors sensors
iabbrev seperated separated
iabbrev Sereis Series
iabbrev sereis series
iabbrev setpoinut setpoint
iabbrev setpoing setpoint
iabbrev seetup setup
iabbrev sevearl several
iabbrev shoudl should
iabbrev shouuuld should
iabbrev shyould should
iabbrev shwon shown
iabbrev shwoon shown
iabbrev shonw shown
iabbrev signficant significant
iabbrev simialr similar
iabbrev similarily similarly
iabbrev sijmple simple
iabbrev simplications simplifications
iabbrev simplifed simplified
iabbrev smiplified simplified
iabbrev sijmply simply
iabbrev Simulaiton Simulation
iabbrev simulaiton simulation
iabbrev ismulation simulation
iabbrev simulaitons simulations
iabbrev signle single
iabbrev singlue single
iabbrev lslides slides
iabbrev sloep slope
iabbrev samrt smart
iabbrev Soldi Solid
iabbrev soultin solution
iabbrev solutio solution
iabbrev solutiosn solutions
iabbrev sove solve
iabbrev Specilized Specialized
iabbrev specidic specific
iabbrev specificaiton specification
iabbrev specificiation specification
iabbrev specificaitons specifications
iabbrev specificantions specifications
iabbrev Specificiations Specifications
iabbrev sepcified specified
iabbrev spped speed
iabbrev Spreasheets Spreadsheets
iabbrev strated started
iabbrev statemetn statement
iabbrev statment statement
iabbrev statemnt statement
iabbrev staes states
iabbrev sattic static
iabbrev statsistics statistics
iabbrev stuatus status
iabbrev staem steam
iabbrev stroed stored
iabbrev storeis stories
iabbrev striaghtforward straightforward
iabbrev straighforward straightforward
iabbrev straem stream
iabbrev Streches Stretches
iabbrev striclty strictly
iabbrev stye style
iabbrev styel style
iabbrev sytle style
iabbrev sytles styles
iabbrev subcalculation sub calculation
iabbrev substantce substance
iabbrev subsance substance
iabbrev substituations substitutions
iabbrev succesful successful
iabbrev usch such
iabbrev suggesitons suggestions
iabbrev suppy supply
iabbrev supplky supply
iabbrev surroundsing surrounding
iabbrev surroudnings surroundings
iabbrev surroudngins surroundings
iabbrev sysntax syntax
iabbrev syntehtic synthetic
iabbrev sstem system
iabbrev sysmete system
iabbrev sysetm system
iabbrev systme system
iabbrev Systesm Systems
iabbrev systmes systems
iabbrev Ssytems Systems
iabbrev TAble Table
iabbrev takne taken
iabbrev taks task
iabbrev taought taught
iabbrev techniquers techniques
iabbrev tmepearute temperature
iabbrev temperaturne temperature
iabbrev temperatuer temperature
iabbrev temperautrte temperature
iabbrev temperture temperature
iabbrev temperautre temperature
iabbrev temperautetr temperature
iabbrev taemperatue temperature
iabbrev temperateur temperature
iabbrev temperaturea temperature
iabbrev tmepreature temperature
iabbrev tempeature temperature
iabbrev temperatue temperature
iabbrev tmeperature temperature
iabbrev tmperature temperature
iabbrev Tmepreautre Temperature
iabbrev tmepaeruater temperature
iabbrev Tempeature Temperature
iabbrev tmeperautre temperature
iabbrev tepmeartere temperature
iabbrev tempertuare temperature
iabbrev Temperatuer Temperature
iabbrev temperaature temperature
iabbrev tmepatuera temperature
iabbrev temperautre temperature
iabbrev tempearature temperature
iabbrev temperatre temperature
iabbrev tempetature temperature
iabbrev tempreature temperature
iabbrev temprautrre temperature
iabbrev tepmerature temperature
iabbrev emtperature temperature
iabbrev temperuate temperature
iabbrev tepmrauter temperature
iabbrev temperauter temperature
iabbrev tempreautre temperature
iabbrev temprature temperature
iabbrev tempeatuter temperature
iabbrev tmeprautre temperature
iabbrev tmeperatures temperatures
iabbrev temperautrtes temperatures
iabbrev temperautres temperatures
iabbrev tempeatueras temperatures
iabbrev temperaturres temperatures
iabbrev temprautes temperatures
iabbrev temperatues temperatures
iabbrev tempearutes temperatures
iabbrev tempeartures temperatures
iabbrev tempeatures temperatures
iabbrev temr term
iabbrev teerm term
iabbrev temrinal terminal
iabbrev temrinla terminal
iabbrev temrnal terminal
iabbrev termianil terminal
iabbrev termianl terminal
iabbrev tmenial terminal
iabbrev terminail terminal
iabbrev tyerminal terminal
iabbrev temrinaul terminal
iabbrev temrianl terminal
iabbrev termainl terminal
iabbrev temrnial terminal
iabbrev temrainil terminal
iabbrev teminal terminal
iabbrev temrainl terminal
iabbrev termain terminal
iabbrev temrial terminal
iabbrev termanil terminal
iabbrev termnial terminal
iabbrev Termain Terminal
iabbrev temrialn terminal
iabbrev terminla terminal
iabbrev TExas Texas
iabbrev htan than
iabbrev thna than
iabbrev taht that
iabbrev tahht that
iabbrev thatt that
iabbrev Teh The
iabbrev teh the
iabbrev hte the
iabbrev thre the
iabbrev ther the
iabbrev trhe the
iabbrev tyhe the
iabbrev THe The
iabbrev eht the
iabbrev thne then
iabbrev theorteical theoretical
iabbrev THere There
iabbrev Threfore Therefore
iabbrev Threrfore Therefore
iabbrev therfore therefore
iabbrev themal thermal
iabbrev themral thermal
iabbrev thermodynamcic thermodynamic
iabbrev tehrmodynamic thermodynamic
iabbrev tehrmodyanmic thermodynamic
iabbrev tehrmodynamic thermodynamic
iabbrev thermodynamci thermodynamic
iabbrev tehemodynamic thermodynamic
iabbrev thermodynaimics thermodynamics
iabbrev thermodynamcis thermodynamics
iabbrev Thermodynamcis Thermodynamics
iabbrev Thsi This
iabbrev htis this
iabbrev trhee three
iabbrev THree Three
iabbrev threshld threshold
iabbrev thershold threshold
iabbrev threohold threshold
iabbrev thresholld threshold
iabbrev threoshld threshold
iabbrev threhsodl threshold
iabbrev trhrehosld threshold
iabbrev threhsodl threshold
iabbrev Trhehsolds Thresholds
iabbrev throght through
iabbrev trhought through
iabbrev throuugh through
iabbrev trhoughout throughout
iabbrev teimstamp timestamp
iabbrev ot to
iabbrev toekn token
iabbrev otkens tokens
iabbrev Tooll Toll
iabbrev topci topic
iabbrev totla total
iabbrev trnasfer transfer
iabbrev trned trend
iabbrev trrended trended
iabbrev trendend trended
iabbrev Treid Tried
iabbrev tyeps types
iabbrev typeiclaly typically
iabbrev ultrasonci ultrasonic
iabbrev ucnertainties uncertainties
iabbrev uncertanity uncertainty
iabbrev unceratiny uncertainty
iabbrev uncertinay uncertainty
iabbrev unceratnainty uncertainty
iabbrev ucneratinty uncertainty
iabbrev uncertianty uncertainty
iabbrev Uncertainy Uncertainty
iabbrev uncertaintny uncertainty
iabbrev uncedrtainty uncertainty
iabbrev ucnerainty uncertainty
iabbrev unceratinay uncertainty
iabbrev unceraitny uncertainty
iabbrev unceratinty uncertainty
iabbrev Uncertianty Uncertainty
iabbrev Unceratinty Uncertainty
iabbrev udner under
iabbrev underreprsented underrepresented
iabbrev udnerstand understand
iabbrev understandiung understanding
iabbrev uint unit
iabbrev unti unit
iabbrev unjits units
iabbrev untis units
iabbrev uints units
iabbrev lunits units
iabbrev unikts units
iabbrev useufl useful
iabbrev usfeul useful
iabbrev usefullness usefulness
iabbrev usingn using
iabbrev uitlilty utility
iabbrev vcacuum vacuum
iabbrev vaccum vacuum
iabbrev vlaue value
iabbrev avlue value
iabbrev valeu value
iabbrev vlues values
iabbrev avlues values
iabbrev varialbe variable
iabbrev varialbes variables
iabbrev variabtion variation
iabbrev vairation variation
iabbrev varitions variations
iabbrev vareid varied
iabbrev verifiy verify
iabbrev verison version
iabbrev iva via
iabbrev Voluem Volume
iabbrev volumen volume
iabbrev wtaer water
iabbrev weke week
iabbrev wieght weight
iabbrev wlel well
iabbrev waht what
iabbrev hwat what
iabbrev whta what
iabbrev whne when
iabbrev whearas whereas
iabbrev whilee while
iabbrev Whiel While
iabbrev wholeheardely wholeheartedly
iabbrev widnow window
iabbrev wiht with
iabbrev wirth with
iabbrev witha with a
iabbrev withing within
iabbrev owrk work
iabbrev owkr work
iabbrev WOrking Working
iabbrev Wroking Working
iabbrev workign working
iabbrev Woriking Working
iabbrev woudl would
iabbrev owuld would
iabbrev zerio zero
iabbrev zoen zone
iabbrev Zoen Zone
iabbrev zonne zone
iabbrev zoens zones
