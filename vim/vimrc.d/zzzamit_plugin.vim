
" {{{ Indent Guides
"Indent Guides settings
let g:indent_guides_auto_colors = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
" }}}

" {{{ PowerLine
"Powerline Settings
let g:Powerline_theme = 'skwp'
let g:Powerline_colorscheme = 'skwp'
let g:Powerline_stl_path_style = 'short'
let g:Powerline_symbols = 'fancy'
" }}}

" {{{ PDV - php comment
"PDV -- php comment
autocmd FileType php imap <C-o> <Esc>:set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i
let g:pdv_cfg_Author = "Amit Agarwal <<redacted>>"
" }}}

" {{{ JS settings
"vim-javascript settings
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" undotree settings.
" nnoremap <S-F5> :UndotreeToggle<cr>
" " }}}

" {{{ undotree
" undotree settings.
let vimpager_use_gvim = 0
let vimpager_passthrough = 1
let vimpager_disable_x11 = 1
" let vimpager_scrolloff = 5
" }}}


" {{{ netrw
" netrw options
let g:netrw_sort_sequence = '[\/]$,\.php,\.phtml,*,\.info$,\.swp$,\.bak$,\~$'
"
"{{{html options
let html_use_css = 1
"}}}

if 1                    " only if has arithmetic evaluation
        " netrw settings
        let g:netrw_banner      = 1
        let netrw_alto          = 1
        let netrw_altv          = 1
        let netrw_liststyle     = 1
         let netrw_keepdir     = 0
        let netrw_longlist      = 1
        let netrw_mousemaps     = 0
        let netrw_noretmap      = 1     " disable going back by double clicking
        let netrw_timefmt       = '%a %d %b %Y %T'

        " syntax settings for shell syntax
        let is_bash             = 1 " our 'sh' Bourne shell is alias to bash
        let sh_fold_enabled     = 7 " enable all kinds of syntax folding
        " list files, it's the key setting, if you haven't set,
        " you will get a blank buffer
        "let g:netrw_list_cmd = "plink HOSTNAME ls -Fa"

        " if you haven't add putty directory in system path, you should
        " specify scp/sftp command.  For examples:

        "let g:netrw_sftp_cmd = "d:\\dev\\putty\\PSFTP.exe"
        "let g:netrw_scp_cmd = "d:\\dev\\putty\\PSCP.exe"
        let g:netrw_fastbrowse  = 1
        let g:netrw_browse_split = 3
        " let g:netrw_liststyle= 4
        let g:netrw_list_hide = '.\(pyc\|pyo\|o\)$'
        let g:netrw_preview = 1
        let g:netrw_retmap= 1
        nmap <silent> <LocalLeader>bb <Plug>NetrwReturn
        " autocmd VimEnter * :Lexplore
endif

" absolute width of netrw window
" let g:netrw_winsize = -28

" do not display info on the top of window
" let g:netrw_banner = 0

" tree-view
" let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
" let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
" let g:netrw_browse_split = 4


" Closetag settings
" let g:closetag_html_style=1


"{{{html options
let html_use_css = 1
"}}}

"{{{ CSV Plugin
autocmd BufNewFile,Bufread *.csv call CSVSELECT()
"}}}
"
" }}} netrw close

" {{{ Autoclose
" Autoclose disable mapping space..
let b:AutoCloseExpandSpace=0
" ACP SnipMate completion
let g:acp_behaviorSnipmateLength = 2
let g:acp_behaviorPerlOmniLength = 2
let g:acp_behaviorSnipmateLength = 1
" " }}}
"
" {{{ Perl support 
let g:Perl_MapLeader=','
let g:Perl_Author='Amit Agarwal'
let g:Perl_Perltidy='on'
let g:Perl_PerlTags='on'
let g:Perl_MenuHeader='yes'
"}}} perl-support


" {{{ Supertab with snipmate

let g:SuperTabDefaultCompletionType = "context"

" }}}

" {{{ Rainbow Parentheses
"Better Rainbow Parentheses
"let g:rbpt_colorpairs = [
    "\ ['brown',       'RoyalBlue3'],
    "\ ['Darkblue',    'SeaGreen3'],
    "\ ['darkgray',    'DarkOrchid3'],
    "\ ['darkgreen',   'firebrick3'],
    "\ ['darkcyan',    'RoyalBlue3'],
    "\ ['darkred',     'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['brown',       'firebrick3'],
    "\ ['gray',        'RoyalBlue3'],
    "\ ['black',       'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['Darkblue',    'firebrick3'],
    "\ ['darkgreen',   'RoyalBlue3'],
    "\ ['darkcyan',    'SeaGreen3'],
    "\ ['darkred',     'DarkOrchid3'],
    "\ ['red',         'firebrick3'],
    "\ ]
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"" }}}

"{{{ Setting for syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" }}}

" {{{ Setting for nerdtree
let NERDTreeShowHidden=1
let NERDChristmasTree=1
let NERDTreeHighlightCursorline=1
let NERDTreeHijackNetrw=1
let NERDTreeShowLineNumbers=1
" let NERDTreeStatusline=""
let NERDTreeWinSize=20
" let NERDTreeShowLineNumbers=1
" let NERDTreeStatusline='%t'
let NERDTreeMapOpenInTab='\r'
let NERDTreeShowBookmarks=1


" Setting for nerdtree
let NERDTreeShowHidden=1
let NERDChristmasTree=1
let NERDTreeHighlightCursorline=1
let NERDTreeHijackNetrw=1
let NERDTreeShowLineNumbers=1
" let NERDTreeStatusline=""
let NERDTreeWinSize=20
" let NERDTreeShowLineNumbers=1
" let NERDTreeStatusline='%t'
let NERDTreeMapOpenInTab='\r'
let NERDTreeShowBookmarks=1
" }}}

" {{{Settings for MultiSearch plugin
" let g:MultipleSearchColorSequence=10
let g:MultipleSearchMaxColors=10
let g:MultipleSearchColorSequence='red,yellow,blue,green,magenta,cyan,gray,brown'
" Thanks to Manuel Picaza for the following mapping to :Search the word under
" the cursor.
" nnoremap <silent> <Leader>*
"" }}}

" {{{ ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags and Taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = "/usr/bin/ctags" " Location of my ctags
let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 0 " split to the left side of the screen
let Tlist_Compart_Format = 1 " show small meny
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 1 " Do not close tags for other files
let Tlist_Enable_Fold_Column = 1 " Do not show folding tree
let Tlist_Show_One_File = 1 " only display the tag of current file

set tags=./tags,../tags,./../../tags,./**/tags,~/.tags/tags  " which tags files CTRL-] will search

" }}}
"
" {{{
" showmarks - https://github.com/jacquesbh/vim-showmarks
autocmd BufNewFile,Bufread * :DoShowMarks

" }}}
"

" {{{ Python settings

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

let python_highlight_all=1


" }}}
"
" {{{ bash-support
"
let g:BASH_TemplateOverriddenMsg= 'yes'
let g:BASH_FormatDate            = '%D'
let g:BASH_FormatTime            = '%H:%M'
let g:BASH_FormatYear            = 'year %Y'
let g:BASH_AuthorName   = 'Amit Agarwal'
let g:BASH_Email        = '<redacted>'
let g:BASH_Company      = 'Mobileum India Pvt Ltd.'
let g:BASH_LocalTemplateFile = '/root/.vim/pack/my-plugins/start/bash-support.vim/bash-support/templates/Templates'
" let g:BASH_Templates = '/root/.vim/pack/my-plugins/start/bash-support.vim/bash-support/templates/Templates'
" }}}
"
"
" {{{ ftcolor

let g:ftcolor_plugin_enabled = 1
let g:ftcolor_redraw = 1
let g:ftcolor_color_mappings = {}
let g:ftcolor_default_color_scheme = [ 'wal' ]
let g:ftcolor_color_mappings.basic = ['ibmedit']
let g:ftcolor_color_mappings.vb = ['ibmedit']
let g:ftcolor_color_mappings.pas = 'borland'
let g:ftcolor_color_mappings.java = ['eclipse', 'light']
let g:ftcolor_color_mappings.cs = ['blueshift']
let g:ftcolor_color_mappings.vimwiki = ['molokai']
let g:ftcolor_color_mappings.python = ['mellow']
let g:ftcolor_color_mappings.py = ['mellow']
let g:ftcolor_color_mappings.gnuplot = ['CandyPaper']
" let g:ftcolor_color_mappings.sh = ['PaperColor', 'dark']
let g:ftcolor_color_mappings.sh = ['nazca']
" let g:ftcolor_color_mappings.sh = ['vibrantFin']
" let g:ftcolor_color_mappings.pl = ['CloudsMidnight']
" let g:ftcolor_color_mappings.perl = ['Dark2']
let g:ftcolor_color_mappings.perl = ['flattown']
let g:ftcolor_color_mappings.spec = ['AllHallowsEveCustom']
let g:ftcolor_color_mappings.vim = ['skittles_berry']
let g:ftcolor_color_mappings.todo = ['3dglasses']
let g:ftcolor_color_mappings.xml = ['flattown']
let g:ftcolor_color_mappings.ant = ['AllHallowsEveCustom']
let g:ftcolor_color_mappings.cfg = ['darth']
let g:ftcolor_color_mappings.yaml = ['zmrok']
let g:ftcolor_color_mappings.rst = ['cobalt2']
let g:ftcolor_color_mappings.ruby = ['darth']


" }}} ftcolor
"
" {{{ exVim plugins and setup
" let g:exvim_custom_path='~/exvim/'
" source ~/.vim_ex/.vimrc

" }}}


" {{{ YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}
"
" {{{ File Header
let g:fileheader_auto_add=1
let g:fileheader_author="Amit Agarwal"

" }}} File Header
"
" {{{ black
let g:ale_fixers = {}
let g:ale_fixers.python = ['black']
let b:ale_fix_on_save = 0
let filepath = expand('%:p:h')
if match(filepath, 'some-project-name') != -1
    let b:ale_fix_on_save = 1
endif
" }}} black
