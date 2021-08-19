# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

DEFAULT_USER=$USER
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export VISUAL="nvim"
export EDITOR="nvim"
set -o emacs
# bindkey -v

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey -r '^P'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND="rg --smart-case --files --hidden -g '!{.git,node_modules}/'"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude .git"
export FZF_DEFAULT_OPTS='--height 20% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Load Git completion
zstyle ':completion:*:*:git:*' script $HOME/.zsh/git-completion.bash
fpath=($HOME/.zsh $fpath)

autoload -Uz compinit && compinit
alias vim=nvim

# FZF 
# Preview https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#ctrl-t
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

alias gs="git status"
alias gacp="git add ./src && git add ./public && git cia && git push -f origin"

is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

# source ~/.zshrc.front

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" --no-use # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# front-only
# alias cdf="cd $HOME/dev/front/front"
# alias cdfc="cd $HOME/dev/front/front-client"
# alias cdfw="cd $HOME/dev/front/front-website"

# alias cdbc="cd $HOME/dev/coursera/bitcoin-and-cryptocurrency"
# agora only
alias cda="cd $HOME/dev/agora/web"

alias python="python3"
export PATH="/Users/alangou/Library/Python/3.7/bin:$PATH"

# alias aws='docker run --rm -it amazon/aws-cli'
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

export DENO_INSTALL="/Users/alangou/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
