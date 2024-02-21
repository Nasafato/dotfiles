# FZF is a fuzzy-finder.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

# Volta is used to install Node toolchains. Much faster than nvm.
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Users/agou/Library/Application\ Support/fnm:$PATH"
export PATH="$HOME/.scripts:$PATH"
export FNM_COREPACK_ENABLED=true
eval "$(fnm env --use-on-cd)"


# https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
# Basically, set them both to your preference.
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias cat="bat"
alias ls="eza"

# I have no idea, to be honest, but look it up in zshmodules manual.
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath);
# Scans paths in fpath for files starting with _ and loads corresponding script
# as a function file.
# compinit initializes the shell's autocomplete functionality
# The -U flag suppresses alias expansion when the function is loaded.
# The -z flag marks the function to be autoloaded using zsh style.
autoload -Uz compinit && compinit

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export DOTFILES="$HOME/dev/dotfiles"

function edzsh {
  vim "$DOTFILES/zshrc"
}

function edtmux {
  vim "$DOTFILES/tmux.conf"
}

function edvim() {
  vim "$DOTFILES/init.vim"
}

function eddf() {
  cd $DOTFILES && vim "$DOTFILES"
}

alias cdw="cd $HOME/work/web"
alias cdd="cd $HOME/dev/dotfiles"

bindkey '^R' history-incremental-search-backward

# Git
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats 'on branch %b'
setopt PROMPT_SUBST
PROMPT='% in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '

function sn {
  volta install node@"$1"
  volta install npm@bundled
}


# Place this at the bottom so it changes history-incremental-search-backward.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/git.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fnm


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/alangou/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/alangou/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/alangou/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/alangou/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# fnm
export PATH="/Users/alangou/Library/Application Support/fnm:$PATH"
eval "`fnm env`"
