#!/bin/bash

### --- System Packages ---
sudo apt update
sudo apt install -y \
    git curl wget unzip ffmpeg libsm6 libxext6 locales \
    vim python3-neovim zsh tmux

sudo locale-gen en_US.UTF-8

### --- Oh-My-Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

### --- Zsh Plugins ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
mkdir -p "$ZSH_CUSTOM/plugins"

declare -A plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["fast-syntax-highlighting"]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
)

for name in "${!plugins[@]}"; do
    [ ! -d "$ZSH_CUSTOM/plugins/$name" ] && \
        git clone --depth=1 "${plugins[$name]}" "$ZSH_CUSTOM/plugins/$name"
done

### --- Update .zshrc ---
ZSHRC="$HOME/.zshrc"

# Replace plugins line
sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting extract z)/' "$ZSHRC"

# Ensure theme enabled
sed -i 's/#\s*\(ZSH_THEME="robbyrussell"\)/\1/' "$ZSHRC"

# Append config block only once
if ! grep -q "# >>> custom zsh settings >>>" "$ZSHRC"; then
cat >> "$ZSHRC" <<'EOF'

# >>> custom zsh settings >>>
export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export WORKSPACE=/prj/qct/datasets_internal_3dMD_body1/users
export WORKDIR="$WORKSPACE/zzy"

setopt histignorealldups
setopt share_history

alias dircount="find . -type f | wc -l"
alias filecount="ls | wc -l"
alias work="cd $WORKDIR"

# Print out Core Server Info
print_info() {
    echo "Host Name: $(hostname)"
    echo "Ubuntu version: $(lsb_release -d | cut -f2)"
    echo "CUDA version: $(nvcc --version | grep release | sed 's/.*release //' | cut -d',' -f1)"
    echo "GCC version: $(gcc --version | head -n1)"
}

# <<< custom zsh settings <<<
EOF
fi

# Set default shell to Zsh
chsh -s $(which zsh)

# Tmux Setup
sudo apt install -y tmux
tmux_conf_file=~/.tmux.conf

### --- Tmux Configuration ---
TMUX_CONF="$HOME/.tmux.conf"

cat > "$TMUX_CONF" <<EOF
set -g prefix \`
unbind C-b
bind \` send-prefix

set -g mouse on
run-shell ~/.tmux/plugins/tmux-resurrect/resurrect.tmux
set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-save-interval '5'
set -g @continuum-restore 'on'
set-option -g history-limit 10000

bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
bind-key M split-window -h "vim ~/.tmux.conf"
EOF

echo "✔ Environment initialized successfully!"
