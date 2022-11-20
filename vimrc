" vundle is not required now. using vim inbuild package mechanism to load
" plugins.
" if has("user_commands")
  " set rtp+=~/.vim/bundle/vundle/
  " call vundle#rc()
  " Load 'vundles'
  " source ~/.vim/vundles.vim
" endif

for f in split(glob('~/.vim/vimrc.d/*.vim'), '\n')
    " echo 'sourcing' f
    exe 'source' f
endfor
"
" source ~/.vim/vimrc.d/vimrc_amix.dk.vim
" source ~/.vim/vimrc.d/vimrc_bridgeutopiadotfiles.vim
" source ~/.vim/vimrc.d/vimrc_c.vim
" source ~/.vim/vimrc.d/vimrc_extra.vim
" source ~/.vim/vimrc.d/vimrc_spf13.vim
" source ~/.vim/vimrc.d/vimrc_ft.vim
" source ~/.vim/vimrc.d/vimrc_amit_plugin.vim
" source ~/.vim/vimrc.d/vimrc_amit_funcs.vim
" source ~/.vim/vimrc.d/vimrc_amit_autocmd.vim
" source ~/.vim/vimrc.d/vimrc_amit.vim
" source ~/.vim/vimrc.d/vimrc_amit_stl.vim

let g:BASH_AuthorName   = 'Amit Agarwal'
let g:BASH_Email        = ''
let g:BASH_Company      = 'Individual'
