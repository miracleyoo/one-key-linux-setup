#!/bin/bash

# DEBIAN_FRONTEND=noninteractive 
# TZ=America/Los_Angeles

# Pre-requisite
sudo apt update
DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
sudo apt install git curl wget unzip ffmpeg libsm6 libxext6 -y
locale-gen en_US.UTF-8

# Install Zsh
sudo apt install -y zsh
# zsh

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
echo 'export TORCH_HOME=/local/mnt2/workspace2/zhongyan/torch_home' >> ~/.zshrc # change torch home (pkg install path)
echo 'export PIP_CACHE_DIR=/local/mnt2/workspace2/zhongyan/pip_home' >> ~/.zshrc # change torch home (pkg install path)
echo 'alias dircount="find . -type f | wc -l"' >> ~/.zshrc # Add folder count alias
echo 'alias filecount="ls | wc -l"' >> ~/.zshrc # Add file count alias
echo 'alias killpys="ps aux | grep python | awk '{print $2}' | xargs kill -9"' >> ~/.zshrc # one-key kill all python processes
# Set default shell to Zsh
chsh -s $(which zsh)
source ~/.zshrc

# Install Space-Vim
sudo apt install -y vim
curl -sLf https://spacevim.org/install.sh | bash

# Tmux Setup
sudo apt install -y tmux

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
wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p /local/mnt2/workspace2/zhongyan/anaconda
eval "$(/local/mnt2/workspace2/zhongyan/anaconda/bin/conda shell.zsh hook)"
conda init
conda init zsh
rm ~/anaconda.sh

# Install Python Common Packages
conda install numpy pillow matplotlib scikit-image
conda install -c anaconda scikit-image pandas cython
conda install -c conda-forge tqdm tensorboardx umap-learn
pip install --upgrade pip
pip install -q dotdict kornia gdown tensorboardx opencv-python opencv-contrib-python face-recognition dlib pillow einops ipykernel thop
 
# Install Pytorch
# pip install torch torchvision torchaudio
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

# Install Pytorch3d
wget https://github.com/facebookresearch/pytorch3d/archive/refs/tags/v0.7.7.tar.gz
tar -xvzf v0.7.7.tar.gz
cd pytorch3d-0.7.7
pip install -e .
