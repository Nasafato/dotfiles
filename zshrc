# FZF is a fuzzy-finder.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

# Volta is used to install Node toolchains. Much faster than nvm.
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
# Basically, set them both to your preference.
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"

source ~/.git-completion.bash
fpath=(~/.zsh $fpath);

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export DOTFILES="$HOME/dev/dotfiles"

function edzsh {
  vim "$DOTFILES/zsh"
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

# Git aliases.
alias g=git
alias gs="git status"
alias gco="git checkout"
alias gcan="git commit --amend --no-edit"
alias gcanf="git commit --amend --no-edit && git push -f origin"
alias grb="git rebase"
alias ga="git add"
alias gl="git log --all --graph --date-order --pretty=format:'%C(yellow)%h%C(bold red)%d%Creset %s %Cgreen{%an} %Cblue%cr%Creset' --abbrev-commit"
alias glob="git log               --date-order --pretty=format:'%C(yellow)%h%C(bold red)%d%Creset %s %Cgreen{%an} %Cblue%cr%Creset' --abbrev-commit"
alias gpb="gitPushAndCreateBranch"
alias gcob='git checkout $(git branch | fzf)'

function gitPushAndCreateBranch() {
  git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

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

alias cat="bat"
alias ls="exa"

# Place this at the bottom so it changes history-incremental-search-backward.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/git.zsh
