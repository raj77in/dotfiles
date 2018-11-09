#!/bin/bash - 
#===============================================================================
#
#          FILE: lock.sh
# 
#         USAGE: ./lock.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), <redacted>
#  ORGANIZATION: Individual
#       CREATED: 11/09/2018 11:38
# Last modified: Fri Nov 09, 2018  11:44AM
#      REVISION:  ---
#===============================================================================


tf='/tmp/a.jpg'

bi=$(/usr/bin/variety --get|tail -1)

convert $bi -font Liberation-Sans \
    -pointsize 26 -fill white -gravity center \
    -annotate +0+160 "Type Password to Unlock" lock.png \
    -gravity center -composite $tf

i3lock -b -i "$tf" -p win -e -f
