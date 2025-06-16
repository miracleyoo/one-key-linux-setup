#!/bin/bash

## Install basic necessary commandline pkgs
brew install curl zsh git tmux wget unzip ffmpeg

## Activate Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  "" --unattended

## Install Oh-My-Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

## Enable features
echo 'export TERM=xterm-256color' >> ~/.zshrc # enable 256 color support
echo 'setopt histignorealldups' >> ~/.zshrc # ignore duplicate commands in history
echo 'setopt share_history' >> ~/.zshrc # share command history between shells
echo 'export LC_ALL=en_US.UTF-8' >> ~/.zshrc # change language settings
echo 'export LANG=en_US.UTF-8' >> ~/.zshrc # change language settings
echo 'alias dircount="find . -type f | wc -l"' >> ~/.zshrc # Add folder count alias
echo 'alias filecount="ls | wc -l"' >> ~/.zshrc # Add file count alias
echo 'alias k=kubectl' >> ~/.zshrc # Add file count alias

## Set default shell to Zsh
chsh -s $(which zsh)

## Tmux Setup
tmux_conf_file=~/.tmux.conf

cat > $tmux_conf_file <<EOF
set -g prefix \`
unbind C-b # C-b即Ctrl+b键，unbind意味着解除绑定
bind \` send-prefix # 绑定 \` 为新的指令前缀

set -g mouse on
run-shell ~/.tmux/plugins/tmux-resurrect/resurrect.tmux
set -g @resurrect-capture-pane-contents 'on' # 开启恢复面板内容功能
set -g @continuum-save-interval '5'
set -g @continuum-restore 'on' # 启用自动恢复
set-option -g history-limit 10000

# 按下R键时，重新载入 tmux 配置文件
bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
# 按下M键时，它会创建一个新的水平面板并在其中打开 vim 编辑器
bind-key M split-window -h "vim ~/.tmux.conf"
EOF

echo "Config written to $tmux_conf_file"

## Install Miniconda
curl -fsSLo ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
chmod +x ~/miniconda.sh
bash ~/miniconda.sh -b -p /opt/miniconda3
# Init conda envs
/opt/miniconda3/bin/conda init "$(basename $SHELL)"
source ~/.zshrc  # If you use bash，change to source ~/.bash_profile
