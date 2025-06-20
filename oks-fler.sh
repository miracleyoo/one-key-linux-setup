#!/bin/bash

# DEBIAN_FRONTEND=noninteractive 
# TZ=America/Los_Angeles

# Pre-requisite
apt update
DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
apt install git curl wget unzip ffmpeg libsm6 libxext6 locales -y

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
echo 'alias killpys="ps aux | grep python | awk '{print $2}' | xargs kill -9"' >> ~/.zshrc # one-key kill all python processes
# Set default shell to Zsh
chsh -s $(which zsh)

# Setup Locales
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

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

# Install Python Common Packages
conda config --set channel_priority flexible
pip install --upgrade pip
pip install -q numpy==1.26.4 numpy_groupies==0.11.2 hydra-core==1.3.2 einops==0.7 pytorch-lightning==1.9 wandb==0.16.1 opencv-python==4.8.1.78 lpips==0.1.4 pandas==2.1.4 plotly==5.18.0 moviepy==1.0.3 tabulate==0.9.0 loguru==0.7.2 matplotlib==3.8.2 scikit-image==0.22.0 h5py==3.12.1 
pip install -q dotdict kornia scipy gdown pathlib2 scikit-learn tensorboard tqdm numba kaleido imageio
pip install -q pytorch_msssim
pip install -q ipykernel jupyter ipywidgets


# # Install hdf5-blosc
# git clone https://github.com/Blosc/hdf5-blosc
# cd hdf5-blosc
# mkdir build
# cd build
# cmake ..
# make
# make install
