#!/bin/bash -
#===============================================================================
#
#          FILE: set-wallpaper.sh
#
#         USAGE: ./set-wallpaper.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), <redacted>
#  ORGANIZATION: Individual
#       CREATED: 10/09/2018 11:30
# Last modified: Thu Dec 06, 2018  12:18PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#variety does all this, so using that now
#


while true
do
    if [[ $(pgrep variety) == "" ]]
    then
        nohup /usr/bin/variety >/tmp/variety.log 2>/tmp/variety-error.log &
    fi
    backg=$(variety --get |tail -1)
    # ~/.local/bin/wal -n -i "$backg" -g -l
    ~/.local/bin/wal -n -i "$backg"
    sleep 60
done
exit 0

f=( "~/Pictures/wallpapers" "~/Pictures/Favs" )

while true
do
    backg=$(find ${f[@]} -type f -iname \*jpg -or -name \*png |sort -R|tail -1)
    feh --bg-scale "$backg"
    ~/.local/bin/wal -n -i "$backg" -g
    sleep 120
done

