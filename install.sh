#!/bin/bash

# some housing keeping stuff
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# some colors to script look cool
RED='\033[0;31m'
LRED='\033[1;31m'
NC='\033[0m' # No Color
BROWN='\033[0;33m'
GREEN='\033[1;32m'

function check_return_code {
  if [ $? -eq 0 ]; then
    echo -e "${GREEN} Succeeded${NC}"
  else
    fail "Failed."
  fi
}

function fail {
  echo -e "${LRED} $1 ${NC}"
}

function fail_and_exit {
  fail $1
  exit 1
}

function install_bash_config {
  echo -n "Installing bash config..."
  ln -s $DIR/.bashrc ~/.bashrc
  check_return_code $?
}

function install_vim_config {
  echo "Installing vim..."
  echo -n "Linking vimrc..."
  ln -s $DIR/.vimrc ~/.vimrc
  check_return_code $?

  if [ ! -d "~/.vim" ]; then
    echo -n "Creating ~/.vim directory"
    mkdir ~/.vim
    mkdir ~/.vim/colors
    check_return_code $?
  fi
  echo "Clonning vundle..."
  if [ ! -d "~/.vim/bundle" ]; then
    echo -n "Creating ~/.vim/bundle directory"
    mkdir ~/.vim/bundle
    check_return_code $?
  fi
  command -v git > /dev/null 2>&1 || {
    fail_and_exit "need git; install git and try again...";
  }

  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  check_return_code $?

  echo "Downloading wombat color theme"
  git clone https://github.com/anuragpeshne/wombat256.vim /tmp/wombat
  cp -r /tmp/wombat/colors/* ~/.vim/colors
  check_return_code $?
  echo -e "${GREEN} Vim installed${NC}"
}

function install_vim_plugins {
  echo "Installing Vim plugins"
  vim +PluginInstall +qall
  check_return_code $?

  echo "Installing You Complete Me"
  cd ~/.vim/bundle/YouCompleteMe
  ./install.sh
  echo -e "${GREEN} You Complete Me (Vim auto-completion installed${NC})"
  check_return_code $?
}

function install_tmux_config {
  echo -n "Creating soft link for tmux config..."
  ln -s $DIR/.tmux.conf ~/.tmux.conf
  check_return_code $?
}

function install_emacs_config {
  # install spacemacs or custom emacs.d
  while true; do
    read -p "Install (S)pacemacs or (C)ustom .emacs.d (S/C)?" sc
    case $sc in
      [Ss]* ) echo "Cloning spacemacs repo..."
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d;
        check_return_code $?
        echo "Creating softlink for .spacemacs..."
        ln -s $DIR/.spacemacs ~/.spacemacs
        check_return_code $?
        break;;
      [Cc]* ) echo -n "Creating soft link for '.emacs.d'..."
        ln -s $DIR/.emacs.d ~/.emacs.d
        check_return_code $?
        break;;
      * ) echo "Please answer S or C.";;
    esac
  done
}

# actual installation begins
declare -a config_installers=("install_bash_config" "install_vim_config"
  "install_vim_plugins" "install_tmux_config" "install_emacs_config")

for installation in "${config_installers[@]}"
do
  while true; do
    read -p "$installation. (Y)es/(N)o?" yn
    case $yn in
      [Yy]* ) $installation
        break;;
      [Nn]* ) break;;
      *) echo "Please answer Y or N.";;
    esac
  done
done
