
" {{{ PHPHeader
function! Phpheader()
    so ~/.vim/phpheader
    sil exe "1," . 10 . "g/FileName: .*/s//FileName: " .expand("%")
    sil exe "1," . 10 . "g/Created: .*/s//Created: " .strftime('%a %b %d, %Y  %I:%M%p')

endfun
" }}}

" {{{ FT_Diff
function! FT_Diff()
        if v:version >= 600
                setlocal foldmethod=expr
                setlocal foldexpr=DiffFoldLevel(v:lnum)
        endif
endf
" }}}

" {{{ NoFoldsInDiffMode
function! NoFoldsInDiffMode()
        if &diff
                :silent! :%foldopen!
        " some more Console-mode-only settings
        set keywordprg=man
        set title titleold= titlestring=%t\ -\ VIM

        " change cursor color for Insert (commented out, doesn't work for me)
        endif
        "if &term == 'xterm' && 0
                "let &t_SI = "\e]12;CursorShape=1\x07"
                "let &t_EI = "\e]50;CursorShape=0\x07"
        "endif
endf
" }}}

" {{{ DiffFoldLevel
"Settings for Diff Files.
function! DiffFoldLevel(lineno)
        let line = getline(a:lineno)
        if line =~ '^Index:'
                return '>1'
        elseif line =~ '^===' || line =~ '^RCS file: ' || line =~ '^retrieving revision '
                let lvl = foldlevel(a:lineno - 1)
                return lvl >= 0 ? lvl : '='
        elseif line =~ '^diff'
                return getline(a:lineno - 1) =~ '^retrieving revision ' ? '=' : '>1'
        elseif line =~ '^--- ' && getline(a:lineno - 1) !~ '^diff\|^==='
                return '>1'
        elseif line =~ '^@'
                return '>2'
        elseif line =~ '^[- +\\]'
                let lvl = foldlevel(a:lineno - 1)
                return lvl >= 0 ? lvl : '='
        else
                return '0'
        endif
endf
" }}}


" {{{Update last modified time.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,20}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
" }}}

au Filetype c,cpp,css,javascript let b:match_words = &matchpairs

" {{{ CodeFormatters
augroup CodeFormatters
    autocmd!
    " "autocmd  BufWritePre   *.py    :silent %!PythonTidy.py
    "autocmd  BufWritePre   *.p[lm] :silent %!perltidy -q
    "autocmd  BufWritePre   *.xml   :silent %!xmlpp –t –c –n
    "autocmd  BufWritePre   *.[ch]  :silent %!indent
 "   "autocmd  BufWritePre   *.sh  :silent %!beautify_bash.py -
    autocmd  BufNewFile,BufReadPost   /media/D/RFC/*  setfiletype rfc
    autocmd  BufNewFile,BufReadPost   /media/D/RFC/*  :set syntax=rfc
    if expand('%:t') =~ "rfc"
        setfiletype rfc
    endif
augroup END
" }}}

" {{{ Diffs
augroup Diffs
  autocmd!
  autocmd BufRead,BufNewFile *.patch :setf diff
  "autocmd BufEnter           *       :call NoFoldsInDiffMode()
  autocmd FileType           diff    :call FT_Diff()
  autocmd FileType         diff :set diffopt+=iwhite
  autocmd FileType         diff :set diffopt+=icase
  " autocmd FileType         diff :set diffopt+=horizontal
  autocmd FileType         diff :set colorcolumn=
  "utocmd FileType *.c :autoindent
  "autocmd FileType *.c :set ofu=syntaxcomplete#Complete
  autocmd FileType *.c :cindent
  autocmd FileType *.c :set comments=sl:/*, mb:*, elx:*/
augroup END
" }}}
"
" Execute snipped

function! ExecuteSnippet(name)
    execute "normal! i" . a:name . "\<c-r>=TriggerSnippet()\<cr>"
endfunction

" {{{ Autocommands for shell and perl scripts.
augroup amit_ft
        autocmd!
        autocmd FileType sh setlocal comments+=:#
        autocmd FileType cpp,c setlocal formatprg=astyle\ -T4p
        " autocmd FileType c,cpp noremap ,bea :silent %!astyle -T4p --style=ansi -s4
        " autocmd FileType c,cpp noremap ,bea :silent %!indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1 -il0  -bad -bbb -bc -blf -fca -prs -saf -sob 
        autocmd FileType c,cpp noremap ,bea :silent %!indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1 -il0 -nut
        autocmd FileType c,cpp setlocal equalprg=astyle\ --style=kr\ -y
        autocmd FileType c,cpp setlocal noexpandtab
        autocmd BufEnter *.sh :set foldmethod=syntax
        autocmd BufEnter *.rst :set syntax=rest foldmethod=marker modifiable noreadonly tw=80 ts=4 colorcolumn=5,9 shiftwidth=4 softtabstop=4
        autocmd FileType rst :setf rest

        "autocmd FileType sshconfig :hi sshconfigHostSect ctermfg=100 guifg=100
        "autocmd FileType sshconfig :hi sshconfigKeyword ctermfg=201 guifg=201
        autocmd FileType sshconfig :hi sshconfigComment ctermfg=56

        autocmd FileType cvs :set tw=75
        autocmd BufWritePre * call LastModified()
        autocmd FileType sh noremap ,bea :silent %!beautify_bash.py -
        autocmd BufEnter *.p[lm] noremap ,bea :silent %!perltidy -q -syn -dws
        autocmd FileType make set sr noexpandtab ts=8 sw=8 " Makefile
        autocmd FileType man set sr noexpandtab ts=8 sw=8 " Man page (also used by psql to edit or view)
        autocmd FileType calendar set sr noexpandtab ts=8 sw=8 " calendar(1) reminder service


        autocmd FileType c      set si
        autocmd FileType mail   set noai
        autocmd FileType mail   set ts=4
        autocmd FileType mail   set tw=78
        autocmd FileType mail   set shiftwidth=3
        autocmd FileType mail   set expandtab
        autocmd FileType mail   map ,sig :silent read !~/bin/signature<CR>
        autocmd FileType mail   imap ,sig <ESC>:silent read !~/bin/signature<CR>
        autocmd FileType xslt   set ts=4
        autocmd FileType xslt   set shiftwidth=4
        autocmd FileType txt    set ts=4
        autocmd FileType txt    set expandtab
        autocmd FileType vim setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
        "autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
        autocmd Filetype lisp,scheme setlocal equalprg=~/.vim/bin/lispindent.lisp expandtab shiftwidth=2 tabstop=8 softtabstop=2
        autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
        autocmd FileType php setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd FileType php map ,fh :silent call Phpheader()<CR>
        autocmd FileType php noremap ,bea :silent %!php_beautifier - 2>/dev/null
        "au BufRead,BufNewFile *.php set ft=php.html.javascript syntax=php.html.jquery
        autocmd BufNewFile,BufRead *.html setlocal commentstring=<!--%s-->
        "au BufRead,BufNewFile *.php set ft=php.html syntax=php.html
        autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
        autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

        au BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
        au BufNewFile,BufRead *.js, *.html, *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
        au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
        " au BufNewFile *.py,*.php :call ExecuteSnippet('fileheader')

augroup END
" }}} 

" {{{ Autocommands for gnuplot files

augroup plt
    autocmd BufNewFile,BufRead *.plt :set ft=plt
    " autocmd FileType plt :setlocal commentstring=#
    highlight nonascii guibg=Red ctermbg=1 term=standout
    au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"
augroup END
" End autocmds for gnuplot }}}

" {{{ spec syntax
" SPEC File syntax
augroup syntax
    au BufNewFile,BufReadPost *.spec set filetype=spec
    let spec_chglog_format = "%a %b %d %Y Release <rel_noreply@roamware.com>"
    let spec_chglog_prepend = 1
    let spec_chglog_release_info = 1
    autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec | ks | call NewSpec() | 's
    fun NewSpec()
        exe "g/Name:/s/Name:/Name:\t\t" . expand("%:t:r")
    endfun
    " au BufNewFile,BufReadPost *.spec so ~/.vim/spec.vim
    au BufNewFile,BufReadPost *.spec setf spec
augroup END
" }}}

"Set the file name for the error file from make output.
"autocmd BufNewFile,BufReadPost *.err set makeef=bufname("%")

" {{{ XML
augroup xml
    " catalog should be set up
    autocmd FileType xml nmap <Leader>l :!xmllint --valid --noout %<CR>
    autocmd FileType xml nmap <Leader>r :!rxp -V -N -s -x<CR>

    autocmd FileType xml vmap <Leader>px :!xmllint --format %<CR>
    autocmd FileType xml nmap <Leader>px :!!xmllint --format %<CR>
    autocmd FileType xml nmap <Leader>pxa :%!xmllint --format %<CR>

    autocmd FileType xml nmap <Leader>i :%!xsltlint<CR>
    autocmd FileType yaml :let g:ansible_options = {'ignore_blank_lines': 0}
    autocmd FileType yaml :colorscheme luinnar
augroup END
" }}}


" autocmd VimEnter * NERDTree
" autocmd BufEnter * NERDTreeMirror
" autocmd VimEnter * wincmd w
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"

" {{{ Comments - F3/F4 add and remove
augroup Comment
    au FileType c,cpp,cc,h,v map <F3>    ^i//<ESC>j
    au FileType c,cpp,cc,h,v map <F4>    :s?\/\/??<CR>:nohl<CR>j
    au FileType python,sh    map <F3>    ^i#<ESC>j
    au FileType python,sh    map <F4>    :s?#??<CR>:nohl<CR>j
    au FileType tex          map <F3>    ^i%<ESC>j
    au FileType tex          map <F4>    :s?%??<CR>:nohl<CR>j
    au FileType php          map <F3>    ^i//<ESC>j
    au FileType php          map <F4>    :s?\/\/??<CR>:nohl<CR>j
    au FileType vim          map <F3>    ^i" <ESC>j
    au FileType vim          map <F4>    :s?" ??<CR>:nohl<CR>j
    au FileType xdefaults          map <F3>    ^i! <ESC>j
    au FileType xdefaults          map <F4>    :s?! ??<CR>:nohl<CR>j
augroup END
" }}}
"

autocmd BufEnter Dockerfile* :set ft=Dockerfile

" {{{ dtrace scripts - automatic header
" dtrace scripts
autocmd  FileType *.d setl ft=dtrace
function DTraceHead()

    0r ~/.vim/dtrace-header.d
    1,16 :g/File Name/s/:.*/\=expand("%")/
    1,16 g/Creation Date/s/:.*/\=strftime("%d-%m-%Y")/
    execute "normal ma"
endfunction
    " autocmd bufnewfile *.d call DTraceHead()
    " map ,fh :call DTraceHead()<CR>


    " autocmd Bufwritepre,filewritepre *.d exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
    autocmd bufwritepost,filewritepost *.c execute "normal `a"
" }}}


" {{{ For Vagrant
augroup vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
" }}}


" {{{ vim filetype
augroup vimft
    autocmd FileType vim setl foldlevel=0 foldmethod=marker foldcolumn=4 foldminlines=4
    autocmd FileType vim map ,p <Esc>0xI" {{{ <Esc>
augroup END
    autocmd FileType vim map ,o <Esc>o" {{{ <Esc>A
    autocmd FileType vim map ,c <Esc>o" }}}<Esc>zc
augroup END

" }}}


" {{{ black for python
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end
" }}} black for python

