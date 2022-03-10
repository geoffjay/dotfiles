# vim:set ts=2 sw=2:
# vim:set ft=sh

#
# XXX: for now this is just to test setup in codespaces environments
# XXX: consider doing everything with ansible, custom tooling seems unnecessary
#

__starship() {
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes --bin-dir="$HOME/.local/bin"
  echo "eval \"\$(starship init bash)\"" >> $HOME/.bash.d/10-prompt
}

__vim() {
  git clone git@github.com:geoffjay/dotvim.git ~/.config/nvim
}

__cs_prepare() {
  sudo apt install -y \
    neovim \
    tmux
}

__env() {
  # this will be moved to rc, here for testing
  export PATH=$PATH:$HOME/.local/bin
}

__prepare() {
  mkdir -p $HOME/.local/bin
  mkdir -p $HOME/.local/etc
  mkdir -p $HOME/.bash.d

  __starship
  __vim
}

#
# FIXME: clean this up to handle linux/darwin
#

__env
__prepare

if [[ "$CODESPACES" == "true" ]]; then
  __cs_prepare
fi
