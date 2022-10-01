#!/bin/bash
# initializer for my profile

DOTENV_BASE_PATH=$HOME/dotenv

echo "Loading profile"

export PATH=$PATH:$DOTENV_BASE_PATH/bin

source $DOTENV_BASE_PATH/git
source $DOTENV_BASE_PATH/shortcuts
source $DOTENV_BASE_PATH/ruby
source $DOTENV_BASE_PATH/net

export PS1="$(pwd | grep -o '[^/]*$')$(current_branch_with_color) $ "