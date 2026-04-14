#!/bin/env bash

echo -e "\e[32mInstalling/updating gruvbox colorscheme...\e[0m"
# For more details, see https://github.com/morhetz/gruvbox/wiki/Installation
mkdir -p ~/.vim/pack/default/start/
GRUVBOX_TARGET_DIR="$HOME/.vim/pack/default/start/gruvbox"
if [ -d "$GRUVBOX_TARGET_DIR/.git" ]; then
  git -C "$GRUVBOX_TARGET_DIR" pull
else
  git clone https://github.com/morhetz/gruvbox.git "$GRUVBOX_TARGET_DIR"
fi
