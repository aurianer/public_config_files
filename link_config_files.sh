#!/bin/bash

set -ux

function append_to_config() {
    what_to_link=${2:-common_$1}
    grep $what_to_link ~/.$1 > /dev/null
    already_appended=$?
    if [[ $already_appended != 0 ]]; then
        echo "if [ -f ~/.$what_to_link ]; then . ~/.$what_to_link; fi" >> ~/.$1
    fi
}

function check_if_exist_and_link() {
    if [[ ! -f ~/.$1.bkp ]]; then
        mv ~/.$1 ~/.$1.bkp
    fi
    if [[ ! -f ~/.$1 ]]; then
        ln -s $cloned_dir/.$1 ~/.$1
    fi
}

cloned_dir=$PWD
pushd ~

# link all config files
check_if_exist_and_link vimrc
check_if_exist_and_link vim
check_if_exist_and_link gitconfig
check_if_exist_and_link common_bashrc
check_if_exist_and_link common_alias

# Append sourcing common_bashrc in bashrc if not already there
append_to_config bashrc
append_to_config alias

popd
