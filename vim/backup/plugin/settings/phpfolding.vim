" Desc: phpfolding
" ------------------------------------------------------------------
" au FileType php map <F5> <Esc>:EnableFastPHPFolds<Cr>
au FileType php map <F6> <Esc>:EnablePHPFolds<Cr>
au FileType php map <F7> <Esc>:DisablePHPFolds<Cr>
au FileType php setlocal foldmethod=manual
" au FileType php EnableFastPHPFolds
"php syntax options {{{
let php_sql_query = 1 "for SQL syntax highlighting inside strings
let php_htmlInStrings = 1 "for HTML syntax highlighting inside strings
"php_baselib = 1 "for highlighting baselib functions
"php_asp_tags = 1 "for highlighting ASP-style short tags
"php_parent_error_close = 1 "for highlighting parent error ] or )
"php_parent_error_open = 1 "for skipping an php end tag, if there exists an open ( or [ without a closing one
"php_oldStyle = 1 "for using old colorstyle
"php_noShortTags = 1 "don't sync <? ?> as php
let php_folding = 1 "for folding classes and functions
" }}}

