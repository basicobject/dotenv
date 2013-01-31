#!/bin/bash
# initializer for my profile

BASE=$HOME/.env

echo "Loading profile"

export PATH=$PATH:$BASE/bin

source $BASE/git
source $BASE/shortcuts

function git_branch_name(){
    git_head=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo "["${git_head#refs/heads/}"]"
}

export PS1="\u@\W \$(git_branch_name)\$ \n ->"


