#!/bin/bash

for i in ~/.my/bash/*
do
	source $i
done

export HISTCONTROL=ignoreboth:ignoredupes
export HISTSIZE=10000

export EDITOR=lvim
export VISUAL_EDITOR=$EDITOR

# source files
[ -r /usr/share/bash-completion/completions ] &&
  . /usr/share/bash-completion/completions/*


if [[ -r ~/.Xdefaults ]]
then
    if [[ $TMUX == "" ]]
    then
	xrdb -merge ~/.Xdefaults
    fi
fi


if [[ -d ~/.bash.d ]]
then
    source ~/.bash.d/alias
    source ~/.bash.d/funcs
fi


test -s ~/.bash.d/.alias && . ~/.bash.d/.alias || true
test -s ~/.bash.d/.funcs && . ~/.bash.d/.funcs || true


export PATH=$PATH:/root/.local/bin:/root/go/bin
export PYTHONPATH=$(python -c "import site, os; print(os.path.join(site.USER_BASE, 'lib', 'python', 'site-packages'))"):$PYTHONPATH
export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

## Set the terminal colors ::

color00="28/29/36" # Base 00 - Black
color01="ea/51/b2" # Base 08 - Red
color02="eb/ff/87" # Base 0B - Green
color03="00/f7/69" # Base 0A - Yellow
color04="62/d6/e8" # Base 0D - Blue
color05="b4/5b/cf" # Base 0E - Magenta
color06="a1/ef/e4" # Base 0C - Cyan
color07="e9/e9/f4" # Base 05 - White
color08="62/64/83" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="f7/f7/fb" # Base 07 - Bright White
color16="b4/5b/cf" # Base 09
color17="00/f7/69" # Base 0F
color18="3a/3c/4e" # Base 01
color19="4d/4f/68" # Base 02
color20="62/d6/e8" # Base 04
color21="f1/f2/f8" # Base 06
color_foreground="e9/e9/f4" # Base 05
color_background="28/29/36" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg e9e9f4 # foreground
  put_template_custom Ph 282936 # background
  put_template_custom Pi e9e9f4 # bold color
  put_template_custom Pj 4d4f68 # selection color
  put_template_custom Pk e9e9f4 # selected text color
  put_template_custom Pl e9e9f4 # cursor
  put_template_custom Pm 282936 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background







unset PROMPT_COMMAND

# export PS1=': \[\033[01;31m\]\u\[\033[00m\]@\t $?  \[\033[01;34m\]\w\[\033[00m\]; '

function exitstatus ()
{
    if [[ $? == 0 ]]; then
        # printf "\033[0;32m😄\033[0m";
        printf "😄";
        # printf "";
    else
        # printf "\033[0;31m😥($?)\033[0m";
        printf "😥($?)";
        # printf "($?)";
    fi
}

# export PS1=':\[$(exitstatus)\] me@\h \W ; '
# export PS1="\[\033[1;32m\]\342\224\214\342\224\200\$([[ \$(/opt/vpnbash.sh) == *\"10.\"* ]] && echo \"[\[\033[1;34m\]\$(/opt/vpnserver.sh)\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\$(/opt/vpnbash.sh)\[\033[1;32m\]]\342\224\200\")[\[\033[1;37m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\w\[\033[1;32m\]]\n\[\033[1;32m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;32m\][\e[01;33m\]★ \e[01;32m\]]\\$\[\e[0m\] "


# neofetch
# screenfetch
#
bash ~/kali-setup/shell-color-scripts/randomcolors.sh

# eval "$(starship init bash)"

# eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/plague.omp.json)"
eval "$(oh-my-posh init bash --config ~/.poshthemes/gmay.omp.json)"
# theme.sh miramare
theme.sh one-dark


echo -e "\033[38;5;208m"
cat <<'EOF'
       __
      /\ \
   __ \ \ \/'\      __
 /'__'\\ \ , <    /'__'\
/\ \L\.\\ \ \\'\ /\ \L\.\_
\ \__/.\_\ \_\ \_\ \__/.\_\
 \/__/\/_/\/_/\/_/\/__/\/_/

EOF
echo -e "\033[0;00m"

## Setup pentools
export PATH="$PATH:$HOME/tools"
export PT_BASE="$HOME/tools"
export PT_ODIR="$HOME/CTF/hackthebox/scans/$HOSTNAME/"
export PT_TUN="tun0"
export PT_GDIR="$HOME/amitag/git/tools/"
export PT_TDIR="$HOME/amitag/tools/"
export PT_LPORT=8001

alias spacevim='docker run -it -v $PWD:/docs -v ~/.SpaceVim.d:/home/spacevim/.SpaceVim.d --rm spacevim/spacevim nvim /docs'
