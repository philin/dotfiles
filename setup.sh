#!/bin/sh
#
# export http_proxy=
# export https_proxy=
# sudo apt-get install -y git
#
# Get dotfiles
# git clone https://github.com/philin/dotfiles.git
#
# Then run ./setup.sh

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.screenrc ~/.screenrc

# Set up vim and code exploration
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sudo apt-get install -y exuberant-ctags
wget http://cscope.sourceforge.net/cscope_maps.vim ~/.vim/.
vim +PluginInstall +qall

