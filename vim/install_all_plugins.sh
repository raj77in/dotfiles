#!/bin/bash - 
#===============================================================================
#
#          FILE: install_all_plugins.sh
# 
#         USAGE: ./install_all_plugins.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), 
#  ORGANIZATION: Individual
#       CREATED: 11/20/2022 11:20
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

repos=( "https://github.com/vim-scripts/bash-support.vim.git"
"https://github.com/psf/black"
"https://github.com/vim/colorschemes"
"https://github.com/vim-scripts/c.vim.git"
"https://github.com/ekalinin/Dockerfile.vim.git"
"https://github.com/caglartoklu/ftcolor.vim.git"
"https://github.com/PotatoesMaster/i3-vim-syntax"
"https://github.com/vim-scripts/MultipleSearch.git"
"https://github.com/scrooloose/nerdtree.git"
"https://github.com/vim-scripts/rest.vim.git"
"https://github.com/tmhedberg/SimpylFold"
"https://github.com/bridgeutopia/snipmate-snippets.git"
"https://github.com/ervandew/supertab.git"
"https://github.com/tomtom/tlib_vim.git"
"https://github.com/ginatrapani/todo.txt-cli.git"
"https://github.com/vim-scripts/todo.vim.git"
"https://github.com/MarcWeber/vim-addon-mw-utils.git"
"https://github.com/tomasiser/vim-code-dark"
"https://github.com/flazz/vim-colorschemes.git"
"https://github.com/ryanoasis/vim-devicons"
"https://github.com/Vimjas/vim-python-pep8-indent.git"
"http://fedorapeople.org/cgit/wwoods/public_git/vim-scripts.git/"
"https://github.com/jacquesbh/vim-showmarks.git"
"https://github.com/garbas/vim-snipmate.git"
"https://github.com/raj77in/vim_colorschemes.git"
"https://github.com/mivok/vimtodo.git" )

VIMP="$HOME/.vim/pack/my-plugins/start/"
[[ ! -d "$VIMP" ]] && mkdir -p "$VIMP"
cd "$VIMP" || exit 1 
for i in "${repos[@]}"
do
    git clone "$i"
done

cd "$HOME/.vim" || exit
echo "bash support plugin does not like the template in any other path :)"
cp  .vim/pack/my-plugins/start/bash-support.vim/bash-support/templates/  bash-support/templates/Templates
