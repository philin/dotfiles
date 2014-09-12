#!/usr/bin/env bash
# Philbert Lin
# Set up script for Ubuntu Desktop
#
# Do these first in shell
# $ export http_proxy=
# $ export https_proxy=
# $ sudo apt-get install -y git
#
# Get dotfiles
# $ git clone https://github.com/philin/dotfiles.git
# $ chmod ~/dotfiles/setup.sh
# $ .dotfiles/setup.sh

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.screenrc ~/.screenrc

# Set up vim and code exploration
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sudo apt-get install -y exuberant-ctags
wget http://cscope.sourceforge.net/cscope_maps.vim --directory-prefix=~/.vim/
vim +PluginInstall +qall

# Utility tools
sudo apt-get install -y byobu tree

