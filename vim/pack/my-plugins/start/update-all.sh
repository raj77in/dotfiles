#!/bin/bash - 
#===============================================================================
#
#          FILE: udpate-all.sh
# 
#         USAGE: ./udpate-all.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Amit Agarwal (aka), <redacted>
#  ORGANIZATION: Mobileum
#       CREATED: 10/01/2018 13:05
# Last modified: Mon Oct 01, 2018  01:11PM
#      REVISION:  ---
#===============================================================================

ls -1|grep -v $0|while read line
do
    echo "$line"
    cd "$line"
    echo $PWD
    git reset --hard HEAD
    git clean -f -d
    git pull
    #git update
    cd -
done

