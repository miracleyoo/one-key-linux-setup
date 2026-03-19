#!/bin/bash

## Pre-requisite
sudo apt update
sudo apt install git curl wget unzip ffmpeg libsm6 libxext6 locales vim python3-neovim -y
locale-gen en_US.UTF-8

## Install Zsh
sudo apt install -y zsh

## Install build essential
sudo apt install -y build-essential linux-libc-dev cmake

## Activate Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  "" --unattended

## Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

## Enable features
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting extract z)/' ~/.zshrc # enable git plugin
sed -i 's/#\s*\(ZSH_THEME="robbyrussell"\)/\1/' ~/.zshrc # change theme
echo 'export TERM=xterm-256color' >> ~/.zshrc # enable 256 color support
echo 'setopt histignorealldups' >> ~/.zshrc # ignore duplicate commands in history
echo 'setopt share_history' >> ~/.zshrc # share command history between shells
echo 'export LC_ALL=en_US.UTF-8' >> ~/.zshrc # change language settings
echo 'export LANG=en_US.UTF-8' >> ~/.zshrc # change language settings
echo 'alias dircount="find . -type f | wc -l"' >> ~/.zshrc # Add folder count alias
echo 'alias filecount="ls | wc -l"' >> ~/.zshrc # Add file count alias

## Set default shell to Zsh
chsh -s $(which zsh)
zsh

## Tmux Setup
sudo apt install -y tmux
tmux_conf_file=~/.tmux.conf

# Add necessary tmux configs
cat > $tmux_conf_file <<EOF
set -g prefix \`
unbind C-b # C-b means Ctrl+b key, unbind means remove binding
bind \` send-prefix # Bind \` as the new command prefix

set -g mouse on
run-shell ~/.tmux/plugins/tmux-resurrect/resurrect.tmux
set -g @resurrect-capture-pane-contents 'on' # Enable pane content restore feature
set -g @continuum-save-interval '5'
set -g @continuum-restore 'on' # Enable auto restore
set-option -g history-limit 10000

# When pressing R, reload tmux configuration file
bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
# When pressing M, it will create a new horizontal pane and open vim editor in it
bind-key M split-window -h "vim ~/.tmux.conf"
EOF

echo "Config written to $tmux_conf_file"

## Install Latest Miniconda
arch=$(uname -m)

# Map architecture to Miniconda URL su
case "$arch" in
  x86_64|aarch64|s390x|ppc64le|armv7l) suffix="$arch" ;;
  i386|i486|i586|i686) suffix="x86" ;;
  *) echo "Unsupported architecture: $arch"; exit 1 ;;
esac

url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${suffix}.sh"

wget "$url" -O miniconda.sh
bash miniconda.sh -b -p "$HOME/miniconda3"
"$HOME/miniconda3/bin/conda" init



