#!/bin/bash
# Author: Miracleyoo
# Date: 2019.09.19

install_1(){
    # Build a package list here
    package_list='git curl zsh tmux vim python3-pip'

    sudo apt-get update -y
    for i in ${package_list[@]}; do
        sudo apt-get install -y $i
    done
}

antigenrc="
source \$HOME/antigen.zsh
    
# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle <<EOBUNDLES
    # Bundles from the default repo (robbyrussell's oh-my-zsh)
    git
    heroku

    # Syntax highlighting bundle.
    zsh-users/zsh-syntax-highlighting

    # Fish-like auto suggestions
    zsh-users/zsh-autosuggestions

    # Extra zsh completions
    zsh-users/zsh-completions

    # Extract or unzip all kinds of file with simply a 'x'
    extract

    # When you type a command wrongly, just type 'fuck'!
    thefuck

    # Simply type a 'j target_dir_name' without the whole path
    autojump

    # cp with progress bar (rsync)
    cp

    # suggests package name with relevant command
    command-not-found

    # Other
    pip
    lein
    tmux

EOBUNDLES

# Load the theme
antigen theme robbyrussell

# Tell antigen that you're done
antigen apply
"

zshrc="
# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"
# Make sure there will not be mojibake
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
# Set python to python3 since many os do not install python2
alias python="python3"
"

install_2(){
    cd $HOME
    curl -L git.io/antigen > antigen.zsh
    echo $antigenrc > .antigenrc
    echo "source \$HOME/.antigenrc" >> $HOME/.zshrc
    echo $zshrc >> $HOME/.zshrc
}

install_done(){
    # change zsh to default shell
    sudo chsh -s /bin/zsh
    /bin/zsh
    echo "[*] ENJOY! Script from Miracleyoo."
}

install_1
install_2
install_done
