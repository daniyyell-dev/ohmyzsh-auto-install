#!/bin/bash

set -e

echo "[+] Installing zsh and dependencies..."
sudo apt update
sudo apt install -y zsh git curl wget fonts-powerline

echo "[+] Installing Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[+] Installing zsh plugins..."

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

# Zsh Completions
git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM}/plugins/zsh-completions"

echo "[+] Updating .zshrc with plugins..."
sed -i 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/' ~/.zshrc

# Append custom settings
cat <<EOF >> ~/.zshrc

# Enable plugin features
source \$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source \$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath+=("\$ZSH/custom/plugins/zsh-completions")
autoload -Uz compinit && compinit
EOF

echo "[+] Setting zsh as default shell..."
chsh -s "$(which zsh)"

echo "[+] Sourcing updated .zshrc..."
source ~/.zshrc

echo "[✓] Zsh and plugins installed successfully!"
