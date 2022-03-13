#!/bin/bash

#
# XXX: for now this is just to test setup in codespaces environments
#

__cmd_check() {
  command -v "$1" &>/dev/null
}

__ansible() {
  if [[ "$CODESPACES" == "true" ]]; then
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
  fi

  ansible-galaxy collection install community.general

  make dotfiles
  make setup
}

# __starship() {
#   sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes --bin-dir="$HOME/.local/bin"
#   echo "eval \"\$(starship init bash)\"" >> $HOME/.bash.d/10-prompt
# }

# __vim() {
#   git clone git@github.com:geoffjay/dotvim.git ~/.config/nvim
# }

# __cs_prepare() {
#   sudo apt install -y \
#     neovim \
#     tmux
# }

__prepare() {
  mkdir -p $HOME/.venv
  mkdir -p $HOME/.local/bin
  mkdir -p $HOME/.local/etc
  mkdir -p $HOME/.bash.d

  # TODO: move to playbook
  # __starship
  # __vim
}

__prepare
__ansible
