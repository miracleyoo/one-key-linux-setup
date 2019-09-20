#!/bin/bash
# 
# Author: Miracleyoo
# Date: 2019.09.19

install_1(){
    # Build a package list here
    package_list='git curl zsh tmux vim python3-pip'

    sudo apt-get update -y
    for i in ${package_list[@]}; do
        sudo apt-get install -y $i
    done
    pip install thefuck
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

# When you type a command wrongly, just type 'fuck'!
antigen bundle thefuck

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
antigen apply
"

zshrc="source ~/antigen.zsh
antigen init ~/.antigenrc
# Make sure there will not be mojibake
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Set python to python3 since many os do not install python2
alias python='python3'
"

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
}

install_spacevim(){
    # Mention: Need to start vim twice! First time chose mode, exit, second time install plugins
    curl -sLf https://spacevim.org/install.sh | bash
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
install_spacevim

