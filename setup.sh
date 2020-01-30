#!/usr/bin/env bash
#
# Philbert Lin
# Set up script for Ubuntu 12.04 or Mac OS X (10.10+)
#
# Do these first in shell
# $ export http_proxy=
# $ export https_proxy=
# $ sudo apt-get install -y git
#
# Get dotfiles
# $ git clone https://github.com/philin/dotfiles.git
# $ chmod +x ~/dotfiles/setup.sh
# $ ~/dotfiles/setup.sh

# symlink config files
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.screenrc ~/.screenrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim

# Get new package releases
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get update
    sudo apt-get dist-upgrade
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # download brew if doesn't exist
    if ! hash brew 2>/dev/null; then
        echo "Downloading brew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
fi

# Set up vim and code exploration
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install -y exuberant-ctags
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install ctags
fi

(cd ~/.vim && curl http://cscope.sourceforge.net/cscope_maps.vim -o cscope_maps.vim)

vim +PluginInstall +qall

# Utility tools
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install -y byobu tree htop binutils build-essential
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install byobu
    brew install tree
    brew install macvim
    brew install hub
fi

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
        if [[ "$OSTYPE" == "linux-gnu" ]]; then
            sudo apt-get install -y zsh
        fi
        curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
        ;;
esac
