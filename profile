#!/bin/bash
# initializer for my profile

BASE=$HOME/.env

echo "Loading profile"

export PATH=$PATH:$BASE/bin

source $BASE/git
source $BASE/shortcuts
source $BASE/ruby

# export PS1="\[\e[33;0m\]\u@\h [\W]\$(parse_git_branch)\n$ \[\e[0m\]"
export PS1="[\W]\$(parse_git_branch)\n$ \[\e[0m\]"

export GOPATH=$HOME/golib
export PATH=$PATH:$GOPATH/bin
