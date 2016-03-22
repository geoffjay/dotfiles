###
# ~/.bashrc

platform='unknown'
unamestr=`uname`

if [[ $unamestr == 'Linux' ]]; then
  platform='linux'
elif [[ $unamestr == 'MINGW64_NT-6.1' ]]; then
  platform='windows'
fi

#
# Linux specific environment setup
#

if [[ $platform == 'linux' ]]; then
  # source global definitions
  [ -f /etc/bashrc ] && source /etc/bashrc

  # enable global tab completion
  [ -f /etc/bash_completion ] && source /etc/bash_completion

  # load defaults for X applications
  if which xrdb &>/dev/null; then
    if [ -n "$DISPLAY" ]; then
      xrdb -load ~/.Xdefaults
    fi
  fi
fi

#
# Generic environment setup
#

[ -f ~/.bash_profile ] && source ~/.bash_profile
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# source custom bash signature
case "$-" in
  # only do if there's an interactive shell
  *i*) [ -f ~/.bash_sig ] && source ~/.bash_sig ;;
  *)   ;;
esac

# -------- variable and color setup -------- #

export EDITOR=vim

export HISTCONTROL=ignoredups       # don't put duplicates in history
export HISTCONTROL=$HISTCONTROL:ignoreboth  # and ignore same sucessive entries

# add home application path
export PATH=~/bin:~/sbin:$PATH:/usr/sbin

# add Google SDK/NDK to path if it's available
if [ -d /opt/google/adt-bundle-linux ]; then
  export PATH=/opt/google/adt-bundle-linux/sdk/tools:$PATH
  export PATH=/opt/google/adt-bundle-linux/sdk/platform-tools:$PATH
#  export PATH=/opt/google/adt-bundle-linux/ndk:$PATH
fi

# add eclipse to path
if [ -d /opt/google/adt-bundle-linux/eclipse ]; then
  export PATH=/opt/google/adt-bundle-linux/eclipse:$PATH
fi

# add appengine
if [ -d /opt/google/appengine ]; then
  export PATH=/opt/google/appengine:$PATH
fi

# add cloud sql command line tool
if [ -d /opt/google/sqltool ]; then
  export PATH=/opt/google/sqltool:$PATH
fi

if [ -d /opt/processing ]; then
  export PATH=/opt/processing:$PATH
fi

export PATH=~/.local/bin:$PATH

# Android SDK path for Studio
export PATH=~/Android/Sdk/tools:$PATH

export PATH=/opt/anaconda3/bin:$PATH
export PATH=/opt/arduino/arduino:$PATH

# fluent/gambit/ansys vars
export LM_LICENSE_FILE=7241@licenseserver
export FLUENTLM_LICENSE_FILE=1055@licenseserver

# development related
export MALLOC_CHECK_=0            # fix g_strfreev on etch systems
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/

PERL_MB_OPT="--install_base \"/home/gjohn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/gjohn/perl5"; export PERL_MM_OPT;

# colored man pages
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
if [ `grep 'Ubuntu|Debian' /proc/version` ]; then
  if [ `which shopt` 1>&/dev/null ]; then
    shopt -s checkwinsize
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-*color|rxvt*)
    color_prompt=yes
    ;;
  *)
    color_prompt=no
    ;;
esac

# force a color prompt, should figure out how this actually works
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# functions to show git dirty state
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | \
    sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function dir_chomp {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != ${p//\/} ]]&&(($s>$2))
    do
      p=${p#/}
      [[ $p =~ \.?. ]]
      b=$b/${BASH_REMATCH[0]}
      p=${p#*/}
      ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

function dir_collapse {
    d=`pwd | perl -ne '@a=split(/\//, $_); foreach(@a[1..$#a]) { print "/".substr($_, 0, 1); }'`
    echo $d
}

# load git branch prompt script
source ~/.git-prompt.sh

# set the prompt
if [ "$color_prompt" = yes ]; then
#  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

PS1="\n\[\e[32;1m\]\
\[\e[34;1m\]\u\[\e[35;1m\]@\[\e[37;1m\]\h\[\e[32;1m\]::\
\[\e[37;1m\]\$(dir_collapse)\[\e[32;1m\]\n\
\[\e[37;1m\]\$(__git_ps1)\[\e[32;1m\] :: \[\e[0m\]"

else
  PS1='${debian_chroot:+($debian_chroot)}$ '
fi

unset color_prompt force_color_prompt

export TERM=xterm-256color

# -------- personal command aliases and additional color settings -------- #

# enable color support for some common commands
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# end of ~/.bashrc
###

# added by travis gem
[ -f /home/gjohn/.travis/travis.sh ] && source /home/gjohn/.travis/travis.sh

# vim: set ts=2 sw=2:
