#!/bin/bash

current_dir=$(pwd)
files="vimrc zshrc tmux.conf gitconfig"

# Install oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

# Install git completion
# https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
zsh_dir=$HOME/.zsh
mkdir -p $zsh_dir
cd $zsh_dir
curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh



for file in $files; do
    echo "Creating symlink to $file in home directory"
    ln -s $current_dir/$file $HOME/.$file
done
