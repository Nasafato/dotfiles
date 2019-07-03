#!/bin/bash

# Install oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"


current_dir=$(pwd)
files="vimrc zshrc tmux.conf"

for file in $files; do
    echo "Creating symlink to $file in home directory"
    ln -s $current_dir/$file $HOME/.$file
done
