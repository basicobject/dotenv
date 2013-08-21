#!/bin/bash
# initializer for my profile

BASE=$HOME/.env

echo "Loading profile"

export PATH=$PATH:$BASE/bin

source $BASE/git
source $BASE/shortcuts

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1="\[\e[33;0m\]\u@\h [\W]\$(parse_git_branch)\n$ \[\e[0m\]"

