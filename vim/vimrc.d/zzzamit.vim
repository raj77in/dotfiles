colorscheme kolor

set shiftwidth=4
set softtabstop=4


" {{{ Most common stuff.
syntax on
syntax enable
syntax sync fromstart
filetype on
filetype plugin on
filetype indent on

behave xterm
" let &t_Co = 256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm
let maplocalleader=','          " all my macros start with ,
let mapleader = ","
let g:mapleader = ","
" TODO: Do not keep verbose to 1.
" set verbose=2


" }}}


if 1    " expression evaluation compiled-in
        runtime! menu.vim
endif

" {{{ Some highlighting
"Highlight whitespaces in the end of line.
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" Highlight long lines...
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
map ,chl :hi clear OverLength
" }}}
"

let g:DirDiffExcludes = ".svn,*.jpg,*.png,*.gif,*.swp,*.a,*.so,*.o,*.pyc,*.exe,*.class,CVS,core,a.out"
let g:DirDiffIgnore = "Id:,Revision:,Date:"

" {{{ Specific to Amit Agarwal
"Other mappings for me.
"ab aka iAmit Agarwal
iab aka Amit Agarwal
iab akae "Amit Agarwal <<redacted>>"
":nnoremap <F5> "=strftime("%c")<CR>P<CR>===============================<CR>
:nnoremap <F5> "=strftime("%c")<CR><Esc>:Underline -<CR>o
":inoremap <F5> <C-R>=strftime("%c")<CR><CR>===============================<CR>
:inoremap <F5> <C-R>=strftime("%c")<CR><Esc>:Underline -<CR>o

" Insert the current filename ...  from :
" http://vim.wikia.com/wiki/Insert_current_filename
:inoremap <LocalLeader>fn <C-R>=expand("%:t:r")<CR>

:inoremap <LocalLeader>ch ----------CUT HERE---------- 
" }}}

" :set foldmethod=expr foldexpr=TimeStampFoldExpr() foldtext=TimeStampFoldText()

" {{{ Highlights
" set cursorcolumn!
set cursorline
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
hi CursorLine term=none cterm=none ctermbg=3      " adjust color
highlight MatchParen ctermbg=blue guibg=lightyellow
highlight MatchParen ctermbg=4
" }}}



" {{{ All Set commands

" All the set commands go here.
" set hidden   " A buffer becomes hidden when it is abandoned
" set list listchars=tab:\‣\
" set mousehide
" set nrformats=
" set t_Co=65536
" setl foldtext=FoldText()
set autochdir
set autoindent smartindent
set autoread
" set backspace=2 " make backspace work normal
set backspace=indent,eol,start       " backspacing over everything in insert mode
set browsedir=current
set cindent
set cmdheight=1 " the command bar is 1 high
" set cmdheight=2
set complete=.,w,b,u,U,t,i,d
set complete+=k
set completeopt=menu,longest,preview,menuone " more autocomplete <Ctrl>-P options
" set completeopt=menuone,preview
set copyindent
set dictionary=/usr/share/dict/words
set diffopt=filler,iwhite
set diffopt+=context:4
set diffopt+=iwhite
set diffopt+=vertical
" set diffopt=filler
" set display=lastline
" set errorbells visualbell
set noexpandtab
" set fillchars=vert:\ ,stl:\ ,stlnc:\  " make the splitters between windows be blank
set foldenable " Turn on folding
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff
set formatoptions=trqlwn
set formatoptions+=wcrq2lqn
set gcr=a:blinkon0              "Disable cursor blink
" set grepprg=/bin/grep\ -nH
" set guicursor+=i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor "Set scope for cursor in GUI.
" set guicursor+=sm:block-Cursor,a:blinkwait750-blinkoff750-blinkon750  "Set scope for cursor in GUI.
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor  "Set scope for cursor in GUI.
set hid " you can change buffer without saving
set history=700
set hlsearch " do highlight searched for phrases
set ignorecase smartcase
set incsearch " BUT do highlight as you type you search phrase
set infercase
set isfname+=@-@
set iskeyword+=!-~,^*,^45,^124,^34,192-255,%,^%,^_,^(,^),^&,_,$,@,%,#,-,. " none of these should be word dividers, so make them not be
set laststatus=2 " always show the status line
" set lazyredraw
set lbr
set linebreak
" set listchars=tab:>.,eol:\$
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " what to show when I hit :set list
set listchars+=nbsp:~  " show no-break space as tilde if supported
set listchars+=tab:\|_
set lz " do not redraw while running macros (much faster) (LazyRedraw)
set magic
set mat=2 " How many tenths of a second to blink when matching brackets
" set matchtime=5
" set modeline
set modeline modelines=5
" set modelines=3
" set more
set mouse=
" set mouse=a " use mouse everywhere
set noautowrite
set nobackup
set nocompatible
set noerrorbells " no noises for error
set nojoinspaces
set nonumber " turn off line numbers
set noswapfile
set novisualbell " don't blink
set nowb
set number
" set numberwidth=3
set numberwidth=4 " minimum width to use for the number column,not a fix size
set pastetoggle=<F10>
set popt=left:8pc,right:3pc
set preserveindent
set report=0 " tell us when anything is changed via :...
set ruler " Always show current positions along the bottom
set rulerformat=%=%h%m%r%w\ %(%c%V%),%l/%L\ %P
" set scrolloff=5
set scs
set selection=inclusive keymodel=startsel selectmode=key
set shiftround
set shiftwidth=4
set shortmess=at " shortens messages to avoid 'press a key' prompt
set shortmess+=atI " shortens messages to avoid 'press a key' prompt
set shortmess+=atTI
set shortmess+=afilmnrxoOtTI
set showbreak=...>>\ 
" set showcmd
set showmatch " show matching brackets
set showmode "Show current mode down the bottom
" set showtabline=2
" set sidescrolloff=5
set smartcase
set smartindent
set smarttab
" set so              "Set 7 lines to the cursor - when moving vertically using j/k
" set so=15 " Keep 10 lines (top/bottom) for scope
" set softtabstop=4
" set sr ts=4 sw=4 " default
" set ss=5
set switchbuf=useopen
" set t_Co=65535  " It seems that old versions of vim do not support more than 256 color values?
" set t_vb=
" set tabstop=4
" set titlestring="[Amit Agarwal] - %F"
" set tm=500
" set tw=500
" set vb t_vb=     " no noises for other
" set viminfo='100,f1  "Save up to 100 marks, enable capital marks
" set whichwrap+=<,>,h,l
" set whichwrap+=<,>,h,l  " backspace and cursor keys wrap to
" set wildignore=*.o,*~,*.pyc
" set wildmenu " turn on wild menu
" set wildmenu wildmode=longest:full,full
" set wrap
" Automaticall insert comment string in all files:
set fo+=c fo+=r fo+=o

" }}}

set t_Co=16777216
" set t_Co=256
" set t_Co=256
" set t_AF=^[[38;2;%p1%{65536}%\/%d;%p1%{256}%\/%{255}%&%d;%p1%{255}%&%dm
" set t_AB=^[[48;2;%p1%{65536}%\/%d;%p1%{256}%\/%{255}%&%d;%p1%{255}%&%dm

set lsp=0 " space it out a little more (easier to read)
if version >= 700 && (&term == "konsole" || &term == "konsole-16color")   "{{{
    " The max value that seems can be passed as a ctermfg or ctermbg is 65534,
    " otherwise this would work.
    "
    " set t_Co=16777216
    " set t_AF=^[[38;2;%p1%{65536}%\/%d;%p1%{256}%\/%{255}%&%d;%p1%{255}%&%dm
    " set t_AB=^[[48;2;%p1%{65536}%\/%d;%p1%{256}%\/%{255}%&%d;%p1%{255}%&%dm

    " Color values are encoded as follows:
    "   Number in the range of 0-65534
    "   red = upper 5 bits * 255 / 31
    "   green = middle 6 bits * 255 / 63
    "   blue = lowest 5 bits * 255 / 31
    "
    " Vim won't store 65535 as a color number, so white is indicated as 65534 as
    " a special case

    "set t_Co=65536
    "set t_Co=256
    "set t_AB=^[[48;2;%p1%{2048}%\/%{255}%*%{31}%\/%d;%p1%{32}%\/%{63}%&%{255}%*%{63}%\/%d;%?%p1%{65534}%=%t%{255}%e%p1%{31}%&%{255}%*%{31}%\/%;%dm
    "set t_AF=^[[38;2;%p1%{2048}%\/%{255}%*%{31}%\/%d;%p1%{32}%\/%{63}%&%{255}%*%{63}%\/%d;%?%p1%{65534}%=%t%{255}%e%p1%{31}%&%{255}%*%{31}%\/%;%dm
    "set t_AB=[48;2;
endif " }}}


" Added From :: http://www.pinkjuice.com/howto/vimxml/setup.xml
  " \:source $VIMRUNTIME/bundle/xmledit/ftplugin/xml.vim<CR>
  "\:colors peachpuff<CR>
map <Leader>x :set filetype=xml<CR>
  \:source $VIMRUNTIME/syntax/xml.vim<CR>
  \:set foldmethod=syntax<CR>
  \:source $VIMRUNTIME/syntax/syntax.vim<CR>
  \:setf xml
  \:iunmap <buffer> <Leader>.<CR>
  \:iunmap <buffer> <Leader>><CR>
  \:inoremap \> ><CR>
  \:echo "XML mode is on"<CR>
  " no imaps for <Leader>
  "\:inoremap \. ><CR>


" for  file change , to tab
"autocmd FileType csv :%s/,/    /g<CR>:set buftype=nowrite<CR>:nohl<CR>
map <LocalLeader>csv <Esc>:set ft=csv<CR>:%ArrangeColumn<CR>

" Do sane mappings for '' and ""
nnoremap    <buffer>   ""   ciW""<Esc>P
nnoremap    <buffer>   {{   ciw{}<Esc>P


" Move between files:
"map <c-left> <Esc>:N<CR>
"map <c-right> <Esc>:n<CR>


" Following Manuel's idea, adapt the former 'Super Star' tip from vim.org to work with
" :Search on a visual selection.
"vnoremap <silent> <Leader>*

" Set the current search pattern to the next one in the list
" nnoremap <silent> <Leader>n
" Set the current search pattern to the previous one in the list
"nnoremap <silent> <Leader>N


" For php files with html ::
" http://www.linuxquestions.org/questions/linux-software-2/vim-omin-completion-for-php-621940/#post3155311
" Assuming Vim 7 (full version) is installed,
"   adding the following to your ~/.vimrc should work.

"filetype plugin on
au FileType php set omnifunc=phpcomplete#CompletePHP

" You might also find this useful
" PHP Generated Code Highlights (HTML & SQL)

let php_sql_query=1
let php_htmlInStrings=1


" Display tabs according to colorscheme
let c_show_tabs = 1
"
" " Class space errors (trailing spaces etc) as errors - highlight
" according to colorscheme
let c_space_errors = 1


"Differenciate between insert and normal mode.
let &t_SI = "\<Esc>]12;green\x7"
let &t_EI = "\<Esc>]12;red\x7"

set tags=./tags,../tags,./../../tags,./**/tags,~/.tags/tags
" change colorscheme on cursor hold.
":autocmd CursorHold * call NextColor(1)
"
"Exit all the windows :)
nnoremap <leader>q :qall<CR>

"nmap ,cl /%changelog<CR>:r!date +'\%a \%b \%d \%Y'<CR>0i* <ESC>$a Amit Agarwal <<redacted>> -

let g:spec_chglog_packager="Amit Agarwal <<redacted>>"



" Convert comma seperated values to strings comma seperated, for ex a,b,c to 'a','b','c' only for current line
"map ,cv :s/\v(.*)@<=\s*([^,"]+)\s*(.*)@=/'\2'/g
"
"au FileType text setl tx ts=4 sw=4 tw=75 fo+=n2a
"au BufEnter *.rst setl tx ts=4 sw=4 tw=75 fo+=n2a
"au FileType mail setl tx ts=4 sw=4 tw=75 fo+=n2a
imap ,tt <esc>:setl tx ts=4 sw=4 tw=75 fo+=n2a<CR>gqip

" {{{ Fix the shift-insert in gvim mode
noremap! <S-Insert> <C-R>+
nnoremap <S-Insert> "+gP
snoremap <S-Insert> <Esc>gvc<C-R>+
xnoremap <S-Insert> c<C-R>+<Esc>
" }}}

" {{{ Some of my favourite maps
map <C-s> <esc>:w<CR> "Set CTRL+s to save the file
map <C-right> <esc>:bn<CR>
map <C-left> <esc>:bp<CR>

"Middle mouse button pastes in paste mode.
map <MouseMiddle> <esc>:set paste<cr><esc>"*p

"Other interesting maps ...
" map <F2> <Esc>:w<CR>
map <silent> <F2> :TlistToggle<CR>" F2 to toggle the taglist
" map! <F2> <Esc>:w<CR>

" }}}


" {{{ Colorcolumn and others from Instantly_Better_Vim_2013
highlight ColorColumn ctermbg=darkblue
call matchadd('ColorColumn', '\%81v', 900)

"=====[ Highlight matches when jumping to next ]=============
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

function! HLNext (blinktime)
    highlight RedOnRed ctermfg=red ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    echo matchlen
    let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
                \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
                \ . '\|'
                \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+3).'v.'
                \ . '\|'
                \ . '\%'.(lnum+1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.'
    let ring = matchadd('RedOnRed', ring_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction


"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

" exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
" set list
" 

" OR ELSE use the filetype mechanism to select automatically...
filetype on
augroup PatchDiffHighlight
    autocmd!
    autocmd FileType  diff   syntax enable
augroup END

" }}}

" {{{ Persistent undo and other undo settings
if has('persistent_undo')
    set undodir=/tmp/.vim/undodir
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" }}}

" {{{ Remember last position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"}}}

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
"
" Save with sudo, need this desparately.
cmap w!! w !sudo tee % >/dev/null

" some timeouts
set timeoutlen=1000
set ttimeoutlen=0


set runtimepath+="~/.vim"

let python_highlight_all=1
