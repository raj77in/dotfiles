" Vim syntax file
" Language:     Juliet's todo files
" Maintainer:   Juliet Kemp 
" Last Change:  Sept 14, 2011
" Version:      1

if exists("b:current_syntax")
  finish
endif

"setlocal iskeyword+=:
highlight rwC   ctermfg=red guifg=red
highlight rwE   ctermfg=red guifg=BlueViolet
highlight rwW   ctermfg=red guifg=MediumVioletRed
highlight rwI   ctermfg=green guifg=LightBlue
highlight rwD   ctermfg=black guifg=DimGrey
highlight rwA   ctermfg=black guifg=Cyan
syn match rwC   ".\+|C|.\+"
syn match rwE   ".\+|E|.\+"
syn match rwW   ".\+|W|.\+"
syn match rwI   ".\+|I|.\+"
syn match rwD   ".\+|D|.\+"
syn match rwA   ".\+|A|.\+"

let b:current_syntax = "rwlogs"

