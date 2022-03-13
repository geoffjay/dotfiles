# vim:ft=zsh:set ts=2 sw=2:

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

append_path() {}

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/crdc/.zshrc'

autoload -Uz compinit
compinit

# source plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source config
if [ -d "$HOME/.bash.d" ]; then
  for file in "$HOME"/.bash.d/*; do
    [ -f $file ] && source $file
  done
fi

# TODO: move this into .d files
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
