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
alias fluent='/opt/ansys_inc/v130/fluent/bin/fluent'
alias lps='lp -o cpi=12 -o lpi=8 -o landscape -o sides=two-sided-short-edge -o page-left=36 -o page-right=36 -o page-top=36 -o page-bottom=36'
alias ssx='ssh -X'
alias upgrayedd='sudo apt-get update && sudo apt-get upgrade'

# create different vim modes
alias vimpl='vim -c ':set shiftwidth=2' -c ':set tabstop=2''

# typo driven aliases
alias exity='exit'
alias Grep='grep'

# more
alias processing-android='/opt/processing/android/processing'

# path aliases
alias its='cd /mnt/public/files/Infrastructure/Computer\ System'

# simplify sourcing bash profile
alias e='. ~/.bashrc'

# vim style
alias :q='exit'
alias :e='vim'

# cfd stuff that I don't need
alias OF16='. /opt/OpenFOAM/OpenFOAM-1.6-ext/etc/bashrc'
alias OF20='. /opt/OpenFOAM/OpenFOAM-2.0.x/etc/bashrc'
alias netgen='/opt/OpenFOAM/netgen-4.9.14-svn/bin/./start_netgen'
alias engrid='/opt/OpenFOAM/engrid-1.2.0/./start_engrid'
alias paraview='/opt/OpenFOAM/paraview-3.10.0/bin/./paraview'
alias gmsh='/opt/OpenFOAM/gmsh-2.4.2/bin/./gmsh'
alias fluent='/opt/ansys_inc/v130/fluent/bin/fluent'

# git
alias gistory='history | grep git'
alias git-graph='git log --pretty=format:"%h : %s" --graph'
#alias git-clone='git clone ssh://rev/srv/repos/git/$GITPROJ/.git && git checkout -b dev'

# administration
alias nmap-ssh='nmap -p 22 --open -sV 10.0.0.0/23'
alias rdp='rdesktop -g1440x900'
alias rdp-rsmax='rdesktop -g1920x1044'
alias rdp-lsmax='rdesktop -g1920x1020'
