let g:session_yank_file="~/.vim_yank"
map <silent> <Leader>y :call Session_yank()<CR>
vmap <silent> <Leader>y y:call Session_yank()<CR>
vmap <silent> <Leader>Y Y:call Session_yank()<CR>
nmap <silent> <Leader>p :call Session_paste("p")<CR>
nmap <silent> <Leader>P :call Session_paste("P")<CR>

function Session_yank()
  new
  call setline(1,getregtype())
  put
  silent exec 'wq! ' . g:session_yank_file
  exec 'bdelete ' . g:session_yank_file
endfunction

function Session_paste(command)
  silent exec 'sview ' . g:session_yank_file
  let l:opt=getline(1)
  silent 2,$yank
  if (l:opt == 'v')
    call setreg('"', strpart(@",0,strlen(@")-1), l:opt) " strip trailing endline ?
  else
    call setreg('"', @", l:opt)
  endif
  exec 'bdelete ' . g:session_yank_file
  exec 'normal ' . a:command
endfunction

