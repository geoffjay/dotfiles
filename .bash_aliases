#!/bin/bash

# aliases
alias dh='df -h'
alias duh='du -h --max-depth=1'
alias dux='du -hx --max-depth=1'
alias la='ls -alh'
alias ll='ls -l --group-directories-first'
alias pc='ps -fC'
alias px='ps aux'
alias killz='kill -KILL'
alias lps='lp -o cpi=12 -o lpi=8 -o landscape -o sides=two-sided-short-edge -o page-left=36 -o page-right=36 -o page-top=36 -o page-bottom=36'
alias ssx='ssh -X'

# typo driven aliases
alias exity='exit'
alias Grep='grep'

# simplify sourcing bash profile
alias e='. ~/.bashrc'

# vim style
alias :q='exit'
alias :e='vim'

# coding helpers
ls_vala() {
    a=$1
    if [[ "$1" == */ ]]; then
        a=`echo "${1%?}"`
    fi
    wc -l $a/*.vala
}
alias lv=ls_vala

find_grep() {
    find $1 -type f -iname $2 -exec grep -H $3 {} \;
}
alias fsearch=find_grep

# git
alias gistory='history | grep git'
alias git-graph='git log --pretty=format:"%h : %s" --graph'

# remote access
alias nmap-ssh='nmap -p 22 --open -sV'

rdp() {
    xfreerdp /u:gjohn /size:$1 +clipboard /v:$2
}

alias rdp-rsmax='rdp 1920x1048'
alias rdp-lsmax='rdp 1920x1024'
