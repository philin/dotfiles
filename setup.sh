#!/usr/bin/env bash
#
# Philbert Lin
# Set up script for Ubuntu 12.04 Desktop
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

# Get new package releases
sudo apt-get update
sudo apt-get dist-upgrade

# Set up vim and code exploration
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sudo apt-get install -y exuberant-ctags
wget http://cscope.sourceforge.net/cscope_maps.vim --directory-prefix=/home/$USER/.vim/
vim +PluginInstall +qall

# Utility tools
sudo apt-get install -y byobu tree htop binutils build-essential

read -r -p "Install Python Web Packages? [y/N] " response1
case $response1 in
    [yY][eE][sS]|[yY])
        sudo apt-get install -y python-dev
        wget https://bootstrap.pypa.io/get-pip.py
        sudo python get-pip.py
        sudo pip install virtualenv
        ;;
esac

read -r -p "Install zsh? [y/N] " response2
case $response2 in
    [yY][eE][sS]|[yY])
        sudo apt-get install -y zsh
        curl -L http://install.ohmyz.sh | sh
        ;;
esac
