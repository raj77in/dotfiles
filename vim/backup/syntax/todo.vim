" Vim script to set syntax highlighting for a todo list.

" A todo list is recognized by file names of the form *.todo,
" OR files that contain #todo as the first line of a file,
" OR files with modelines that contain ft=todo

" Header lines              - Lines starting at column 0.
" Normal priority items     - Non-header lines that start with a 'o'.
" High priority items       - .... with a '+'.
" Low priority items        - .... with a '-'.
" Items completed           - ... with a 'd' or 'D'.
" Items ignored             - ... with a 'x' or 'X'.
" Dates                     - Digits (and / and -) enclosed by < and >.
" Comments                  - Stuff enclosed in '[' and ']' or any line
"                             that is none of the above.

" See the file test.todo for sample entries.

" Author: Suresh S.
" Version: 0.2


"if exists("b:current_syntax")
  "finish
"endif
"
syn case ignore

" Dates can also be embedded.
" N/N/N or N-N-N or N/N or N-N.
syn match todoDate   "<\(\(\d\{1,4\}[-/]\)\?\d\{1,2\}[-/]\d\{1,4\}\)>" contained

" Comments embedded in todo items.
syn region todoComment   start="\["hs=s+1 end="\]"he=e-1 contained contains=todoDate

" Header lines to start sections.
syn match todoHeader1    "^\(\(\<[odxi\?]\s\)\@<!.\)*:$" contains=todoDate
syn match todoHeader2    "^\s\s*\(\([odxi\?]\s\)\@<!.\)*:$" contains=todoDate

" Normal priority items.
syn region todoNormalPri start="\(^\s*\)\@<=o\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend
" High priority items.
syn region todoHiPri     start="\(^\s*\)\@<=+\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend
" Low pri
syn region todoLowPri    start="\(^\s*\)\@<=-\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend
" Unprioritized items.
syn region todoQuestion     start="\(^\s*\)\@<=?\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend
" Items completed.
syn region todoDone      start="\(^\s*\)\@<=d\s"     end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend
" Items ignored/won't do.
syn region todoIgnore    start="\(^\s*\)\@<=[xi]\s"   end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend
" Items waiting
syn region todoWait      start="\(^\s*\)\@<=d\s"     end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=CONTAINED keepend

" Fix this to handle multi-line items.
syn match todoIgnore    "\(^\s*\)\@<=[o+\-?].*:ignore$" contains=CONTAINED
syn match todoDone      "\(^\s*\)\@<=[o+\-?].*:done$" contains=CONTAINED
syn match todoWait      "\(^\s*\)\@<=[o+\-?].*:waiting$" contains=CONTAINED
syn case match

"--------------------------------------------------------------------------
" Colors and effects.
"--------------------------------------------------------------------------

hi todoHeader1                  gui=bold cterm=bold

" Uncomment the following line if sub-headers should appear in bold:
" hi todoHeader2                  gui=bold

hi link todoQuestion            Todo
hi todoHiPri                    guifg=Red ctermfg=Red
hi todoNormalPri                guifg=Orange ctermfg=Red
hi todoDone                     guifg=Green ctermfg=LightGreen ctermbg=white
hi todoWait                     guifg=Yellow ctermfg=Green ctermbg=black
hi todoComment                  gui=Italic cterm=Italic

if &background == "dark"
    hi todoLowPri               guifg=LightCyan ctermfg=LightCyan
    hi todoIgnore               guifg=Beige ctermfg=Cyan
    hi todoDate                 guifg=LightCyan gui=bold cterm=bold ctermfg=LightCyan ctermbg=Green
else
    hi todoLowPri               guifg=Blue ctermfg=LightBlue
    hi todoIgnore               guifg=Gray ctermfg=Gray
    hi todoDate                 gui=Bold guifg=Cyan gui=bold guibg=white ctermfg=Cyan cterm=bold ctermbg=White
endif

"let b:current_syntax = "todo"

" vim: ts=18
