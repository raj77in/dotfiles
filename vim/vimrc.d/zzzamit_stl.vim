function! FN_ColorSchemeName() abort
    let name = exists('g:colors_name') ? g:colors_name : ""
    if &background == 'dark'
        let name .= "(d)"
    elseif &background == 'light'
        let name .= "(l)"
    endif
    return name
endfunction
"
"Status line settings.
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

function! SlSpace()
    if exists("*GetSpaceMovement")
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunc

" function! SetColors()
    " hi User1 guifg=#eea040 guibg=#222222 ctermfg=28
    " hi User2 guifg=#dd3333 guibg=#222222 ctermfg=55
    " hi User3 guifg=#ff66ff guibg=#222222
    " hi User4 guifg=#a0ee40 guibg=#222222
    " hi User5 guifg=#eeee40 guibg=#222222


    hi User1 guifg=#ffdad8  guibg=#880c0e "ctermfg=220 ctermbg=244
    hi User2 guifg=#000000  guibg=#F4905C "ctermfg=16 ctermbg=196
    hi User3 guifg=#292b00  guibg=#f4f597
    hi User4 guifg=#112605  guibg=#aefe7B
    hi User5 guifg=#051d00  guibg=#7dcc7d
    hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
    hi User8 guifg=#ffffff  guibg=#5b7fbb
    hi User9 guifg=#ffffff  guibg=#810085
    hi User0 guifg=#ffffff  guibg=#094afe
" endfunc

" call SetColors()

set statusline+=[amit]
set statusline=%*
set laststatus=2 statusline+=%02n:\
"set statusline+=%c "cursor column
set statusline+=%2*%#error#
set statusline+=%3*%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"set statusline+=%{g:colors_name}
set statusline+=%5*%{FN_ColorSchemeName()}
set statusline+=%7*\ %f "tail of the filename
set statusline+=\ %h "help file flag
set statusline+=%= "left/right separator
set statusline+=%3*\ %l/%c "cursor line/total lines
set statusline+=%1*%m "modified flag
set statusline+=%2*%{&paste?'[paste]':''}
set statusline+=%4*\ %P "percent through file
set statusline+=%r "read only flag
set statusline+=%2*%{SlSpace()}
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%{StatuslineTabWarning()}
set statusline+=%{StatuslineTrailingSpaceWarning()}
" set statusline+=%#warningmsg#
set statusline+=%1*ft:\ %y
" set statusline+=%y "filetype
set statusline+=%4*%b "decimal byte
set statusline+=\x%02B  "HexaDecimal byte
" set statusline+=%{Tlist_Get_Tagname_By_Line()}
" set statusline+=%([%{Tlist_Get_Tagname_By_Line()}]%)
" set statusline+=%{TlistShowTag}
set statusline+=wc:%{WordCount()},
set statusline+=ln:%l/%L\ lines,\ %P


"
" It's useful to show the buffer number in the status line.
" set laststatus=2 statusline+=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" set statusline+=%(\ FN:\ %{cfi#get_func_name()}%)
" au FileType cpp set statusline+=%(\ FNC:\ %{cfi#get_func_name(c)}%)
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%{VimBuddy()}
"
let g:pstl=&statusline

"http://www.reddit.com/r/vim/comments/gexi6/a_smarter_statusline_code_in_comments/
hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

function! MyStatusLine(mode)
    " :call SetColors()
    let statusline=g:pstl
    "if a:mode == 'Enter'
        "let statusline.="%#StatColor#"
        "let statusline.="[Enter]"
    "endif
    "let statusline.="\(%n\)\ %f\ "
    if a:mode == 'Enter'
        let statusline.="%*"
    endif
    let statusline.="%#Modified#%m"
    if a:mode == 'Leave'
        "let statusline.="%*%r"
        let statusline.="[Normal]"
    elseif a:mode == 'Enter'
        "let statusline.="%r%*"
        let statusline.="[Enter]"
    endif
    if ( &ft == "cpp" ) 
        let statusline.="FN: "
        let statusline.=cfi#get_func_name('c')
    endif
    "let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

" au WinEnter,BufEnter * setlocal statusline=%!MyStatusLine('Enter')
" au WinLeave,BufLeave * setlocal statusline=%!MyStatusLine('Leave')
" set statusline=%!MyStatusLine('Leave')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=orange ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#e454ba ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#e454ba ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
au InsertLeave * hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black
