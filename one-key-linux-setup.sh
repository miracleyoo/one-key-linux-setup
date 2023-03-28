#!/bin/bash
# Copyright (c) 2022 Zhongyang Zhang
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
#
# Author: Miracleyoo
# E-mail: mirakuruyoo@gmail.com
# Date: 2022.03.13
# Usage:
# 1. Make sure you already have curl installed by "sudo apt-get install curl".
# 2. Use command `curl -fsSL https://raw.githubusercontent.com/miracleyoo/one-key-linux-setup/master/one-key-linux-setup.sh -o minit.sh && sudo bash minit.sh`
# 3. You are all set! Here is an awesome new linux!

install_1(){
    # Build a package list here
    package_list='git curl zsh tmux vim python3-dev python3-pip python3-setuptools'

    sudo apt-get update -y
    for i in ${package_list[@]}; do
        sudo apt-get install -y $i
    done
}

antigenrc="# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle heroku

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Fish-like auto suggestions
antigen bundle zsh-users/zsh-autosuggestions

# Extra zsh completions
antigen bundle zsh-users/zsh-completions

# Extract or unzip all kinds of file with simply a 'x'
antigen bundle extract

# Simply type a 'z target_dir_name' without the whole path
antigen bundle z

# cp with progress bar (rsync)
antigen bundle cp

# suggests package name with relevant command
antigen bundle command-not-found

# Other
antigen bundle pip
antigen bundle lein
antigen bundle tmux

# Load the theme
antigen theme robbyrussell

# Tell antigen that you're done
antigen apply"

zshrc="source ~/antigen.zsh
antigen init ~/.antigenrc
# Make sure there will not be mojibake
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Set python to python3 since many os do not install python2
alias python='python3'"

bash_profile="export SHELL=/bin/zsh
exec /bin/zsh -l"

install_2(){
    cd $HOME
    curl -L git.io/antigen > antigen.zsh
    cat <<EOF  > .antigenrc
$antigenrc
EOF
    # echo $antigenrc > .antigenrc
    cat << EOF >> $HOME/.zshrc
$zshrc
EOF
    if [ "$TERM" == "xterm" ]; then
        echo "# Enable 256 color to make auto-suggestions look nice" >> $HOME/.zshrc
        echo "export TERM=xterm-256color" >> $HOME/.zshrc
    fi
    sudo chmod -R 755 $HOME/.antigen
}

install_spacevim(){
    # Mention: Need to start vim twice! First time chose mode, exit, second time install plugins
    curl -sLf https://spacevim.org/install.sh | bash
}

install_done(){
    # change zsh to default shell
    sudo chsh -s /bin/zsh
    cat << EOF >> $HOME/.bash_profile
$bash_profile
EOF
    echo -e "\n\n\n[*] ENJOY! Script written by Miracleyoo.\n\n\n"
    /bin/zsh
}

install_1
install_2
install_spacevim
install_done
