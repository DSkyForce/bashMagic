#!/bin/sh
# Origin: https://github.com/DSkyForce/bashMagic
# Author: Dandong Yin
#
# The "open" command on OSX is useful, but sometimes it's annoying enter
# the APP's full name after the "-a" option. After running this script,
# your "-a" option is smart to scan the names of apps under /Applications
# directory, transform them to lower case letters and escape the space
# for you. Just hit <tab> for smart auto-completion after "-a ".

_apps() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    COMPREPLY=()
    if [ "$prev" == "-a" ]; then
        c=0
        while read line; do
            COMPREPLY[$c]=$line
            c=$[$c + 1]
        done <<<"$(compgen -W "`ls /Applications/ | sed -n '/.app/p' | sed     's/\(.*\).app.*/"\1"/g' | tr A-Z a-z`" -- "${cur}" | sed 's/ /\\ /g' )"
    fi
}
complete -o filenames -o default -F _apps open