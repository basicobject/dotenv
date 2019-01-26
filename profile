#!/bin/bash
# initializer for my profile

BASE=$HOME/.env

echo "Loading profile"

export PATH=$PATH:$BASE/bin

source $BASE/git
source $BASE/shortcuts
source $BASE/ruby
source $BASE/net

export PS1="[\W]\$(parse_git_branch)\nλ \[\e[0m\]"
# export PS1="[\033[1;30m\W\033[0m]\$(parse_git_branch) [\033[1;30m\@\033[0m] \n\033[1;31mλ \033[0m\[\e[0m\]"
export GOPATH=$HOME/Work/go
export PATH=$PATH:$GOPATH/bin

alias cdc='cd ~/Work/Chillr/chillr-api'
alias cdt='cd ~/Work/tc_pay'
