#!/bin/env bash

echo -e "\e[32mInstalling/updating alacritty themes...\e[0m"
mkdir -p ~/.config/alacritty/themes
ALACRITTY_THEME_TARGET_DIR="$HOME/.config/alacritty/themes"
if [ -d "$ALACRITTY_THEME_TARGET_DIR/.git" ]; then
  git -C "$ALACRITTY_THEME_TARGET_DIR" pull
else
  git clone https://github.com/alacritty/alacritty-theme  "$ALACRITTY_THEME_TARGET_DIR"
fi
