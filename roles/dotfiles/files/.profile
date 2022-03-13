# FIXME: this gets picked up by .bashrc but some environment is
#  needed here so that i3 picks it up.

if [[ -f /etc/profile ]]; then
  . /etc/profile
fi

# set profile environment
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/usr/bin/vim
export TERMINAL=/usr/bin/kitty

# nodejs
export PATH="$HOME/.node_modules/bin:$PATH"

# other
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
