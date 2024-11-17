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
conda install -y h5py blosc-hdf5-plugin llvm-openmp hydra-core=1.3.2 einops=0.7 -c conda-forge
pip install --upgrade pip
pip install -q pytorch-lightning==2.1.3 wandb==0.16.1 opencv-python==4.8.1.78 lpips==0.1.4 pandas==2.1.4 plotly==5.18.0 moviepy==1.0.3 tabulate==0.9.0 loguru==0.7.2 matplotlib==3.8.2 scikit-image==0.22.0 
pip install -q dotdict kornia scipy gdown pathlib2 scikit-learn tensorboard tqdm numba kaleido imageio
pip install -q ipykernel ipython
pip install -q yacs joblib natsort pytorch-gradual-warmup-lr
imageio_download_bin freeimage
