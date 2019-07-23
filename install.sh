#!/bin/bash

current_dir=$(pwd)
files="vimrc zshrc tmux.conf gitconfig"

if which -s zsh; then
    echo "zsh is already installed; skipping"
else
    echo "installing zsh"
    brew install zsh zsh-completions
fi

current_shell=$(dscl . -read ~/ UserShell | sed 's/UserShell: //')
if test "$current_shell" != "/bin/zsh"; then
    echo "Current shell is $current_shell; setting it as zsh"
    chsh -s /bin/zsh
fi


# Install oh-my-zsh
if test -d $HOME/.oh-my-zsh; then
    echo "$HOME/.oh-my-zsh already exists; skipping"
else
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
fi

# Install git completion
# https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
zsh_dir=$HOME/.zsh
mkdir -p $zsh_dir
cd $zsh_dir

if test -f git-completion.bash; then
    echo "git-completion.bash exists; skipping"
else
    echo "downloading git-completion.bash"
    curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

if test -f _git; then
    echo "_git exists; skipping"
else
    echo "downloading git-completion.zsh into _git"
    curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
fi


for file in $files; do
    mv $HOME/.$file $HOME/.$file.old

    echo "Creating symlink to $file in home directory"
    ln -s $current_dir/$file $HOME/.$file
done



