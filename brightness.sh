#!/bin/bash - 
#===============================================================================
#
#          FILE: brightness.sh
# 
#         USAGE: ./brightness.sh 
# 
#   DESCRIPTION: https://www.reddit.com/r/i3wm/comments/4qofyr/controling_screen_brightness/
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), <redacted>
#  ORGANIZATION: Individual
#       CREATED: 10/30/2018 18:27
# Last modified: Tue Oct 30, 2018  06:27PM
#      REVISION:  ---
#===============================================================================


if [[ $1 == -d ]]; then
    current=$(xrandr --verbose | grep -m 1 -i brightness | awk -F' ' '{ print $2 }')
    new=$(echo "$current - 0.1" | bc -l)
    xrandr --output eDP-1 --brightness 0$new
elif [[ $1 == -u ]]; then
    current=$(xrandr --verbose | grep -m 1 -i brightness | awk -F' ' '{ print $2 }')
new=$(echo "$current + 0.1" | bc -l)
    xrandr --output eDP-1 --brightness 0$new
elif [[ $1 == -m ]]; then
    xrandr --output eDP-1 --brightness 1
else
    xrandr --output eDP-1 --brightness $1
fi



