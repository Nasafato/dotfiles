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
