#/bin/bash

current_dir=$(pwd)
files="vimrc zshrc tmux.conf gitconfig"

if which -s brew; then
    echo "brew already installed; skipping"
else
    echo "installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

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

curl -fsSL https://fnm.vercel.app/install | bash

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


if hash tmux 2>/dev/null; then
    echo "tmux already installed; skipping"
else
    echo "Installing tmux"
    brew install tmux
fi

if hash nvim 2>/dev/null; then
    echo "nvim already installed; skipping"
else
    echo "Installing nvim"
    brew install nvim
    echo "alias vim = nvim" >> ~/.zshrc
    mkdir -p ~/.config/nvim
    ln -s $current_dir/vimrc ~/.config/nvim/init.vim
fi

if hash rg 2>/dev/null; then
    echo "ripgrep already installed; skipping"
else
    echo "Installing ripgrep"
    brew install ripgrep
fi


if test -f ~/.nvm; then
    echo "nvm installed,; skipping"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi


if [[ $(python -m pip show pynvim) ]]; then
    echo "pynvim already installed; skipping"
else
    python -m pip install --user --upgrade pynvim
fi
