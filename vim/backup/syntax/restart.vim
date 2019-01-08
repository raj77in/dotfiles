" Vim syntax file
" Language:     Juliet's todo files
" Maintainer:   Juliet Kemp 
" Last Change:  Sept 14, 2011
" Version:      1

if exists("b:current_syntax")
  finish
endif

"setlocal iskeyword+=:
highlight restartstart   ctermfg=green guifg=green
highlight restartkill    ctermfg=Cyan guifg=Cyan
highlight restartkillfail    ctermfg=red guifg=red
highlight restartmanual  ctermfg=blue guifg=blue
syn match restartkill   ".\+ KILLED .\+"
syn match restartkillfail   ".\+ KILLFAIL .\+"
syn match restartstart      ".\+ STARTED .\+"
syn match restartmanual      ".\+MANUAL-.\+"

let b:current_syntax = "restart"

