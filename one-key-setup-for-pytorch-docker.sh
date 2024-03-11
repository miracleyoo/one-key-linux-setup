#!/bin/bash

# Pre-requisite
apt update
apt install git curl wget unzip locales ffmpeg libsm6 libxext6  -y
locale-gen en_US.UTF-8

# Install Zsh
apt install -y zsh

# Activate Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"  "" --unattended

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

# Enable features
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting extract z)/' ~/.zshrc # enable git plugin
sed -i 's/#\s*\(ZSH_THEME="robbyrussell"\)/\1/' ~/.zshrc # change theme
echo 'export TERM=xterm-256color' >> ~/.zshrc # enable 256 color support
echo 'export NCCL_P2P_DISABLE=1' >> ~/.zshrc # Avoid stuck when using ddp
echo 'setopt histignorealldups' >> ~/.zshrc # ignore duplicate commands in history
echo 'setopt share_history' >> ~/.zshrc # share command history between shells
echo 'export LC_ALL=en_US.UTF-8' >> ~/.zshrc # change language settings
echo 'export LANG=en_US.UTF-8' >> ~/.zshrc # change language settings
echo 'alias dircount="find . -type f | wc -l"' >> ~/.zshrc # Add folder count alias
echo 'alias filecount="ls | wc -l"' >> ~/.zshrc # Add file count alias

# Set default shell to Zsh
chsh -s $(which zsh)

# Install Space-Vim
apt install -y vim
curl -sLf https://spacevim.org/install.sh | bash

# Tmux Setup
apt install -y tmux

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

# Install Anaconda
# wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh -O ~/anaconda.sh
# bash ~/anaconda.sh -b -p $HOME/anaconda
# eval "$($HOME/anaconda/bin/conda shell.zsh hook)"
# conda init
# conda init zsh
# rm ~/anaconda.sh

# Install Python Common Packages
# apt install -y libgl1-mesa-glx
# apt install -y libglib2.0-dev
pip install --upgrade pip
pip install -q opencv-contrib-python dotdict kornia scipy h5py pandas plotly gdown matplotlib pathlib2 numba scikit-learn scikit-image tensorboard einops kaleido nbformat seaborn
pip install -q pytorch-lightning==1.9
pip install -q ipykernel

# lightning==1.6.4 
# conda install -y pytorch-lightning==1.6.4 -c conda-forge

# Install PyG
pip install torch_geometric

# Optional PyG dependencies
pip install pyg_lib torch_scatter torch_sparse torch_cluster torch_spline_conv -f https://data.pyg.org/whl/torch-2.0.0+cu117.html
