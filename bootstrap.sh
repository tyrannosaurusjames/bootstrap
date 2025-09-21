#!/usr/bin/env bash

set -eou pipefail

SETUP_PATH="$HOME/.local/share/setup-ubuntu"

# install git
sudo apt update && sudo apt install -y git

# generate SSH key
if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
    read -r -p "Enter SSH key comment (your email): " EMAIL
    ssh-keygen -t ed25519 -C "$EMAIL" -N "" -f ~/.ssh/id_ed25519
fi

# Prompt to add SSH key to GitHub settings
cat ~/.ssh/id_ed25519.pub
echo 'Add this key to your GitHub SSH public keys'
read -n1 -s -r -p $'Press any key to continue...\n'

# clone install repo
git clone git@github.com:tyrannosaurusjames/setup-ubuntu.git "$SETUP_PATH"

# start install
bash "$SETUP_PATH/install.sh"
