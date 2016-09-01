#!/bin/bash

# some housing keeping stuff
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# some colors to script look cool
RED='\033[0;31m'
LRED='\033[1;31m'
NC='\033[0m' # No Color
BROWN='\033[0;33m'
GREEN='\033[1;32m'

# actual installation begins

echo -n "Installing bash config..."
ln -s DIR/.bash.rc ~/.bash.rc
echo -e "${GREEN} installed${NC}"

echo "Installing vim..."
ln -s DIR/.vimrc ~/.vimrc
if [ ! -d "~/.vim" ]; then
  mkdir ~/.vim
  mkdir ~/.vim/colors
  echo "~/.vim directory created"
fi
echo "Clonning vundle..."
if [ ! -d "~/.vim/bundle" ]; then
  mkdir ~/.vim/bundle
  echo "~/.vim/bundle directory created"
fi
command -v git > /dev/null 2>&1 || { 
  echo "need git; install git and try again...";
  exit 1;
}

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install wombat color too
git clone https://github.com/anuragpeshne/wombat256.vim /tmp/wombat
cp -r /tmp/wombat/colors/* ~/.vim/colors
echo -e "${GREEN} Vim installed${NC}"

echo -n "Creating soft link for tmux config..."
ln -s DIR/.tmux.config ~/.tmux.config
echo -e "${GREEN} done${NC}"

echo -n "Creating soft link for '.emacs.d'..."
ln -s DIR/.emacs.d ~/.emacs.d
echo -e "${GREEN} done${NC}"
