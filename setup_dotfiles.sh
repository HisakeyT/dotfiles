#!/bin/bash

set -e

echo "Setting up dotfiles..."

# create directories for wezterm
mkdir -p ~/.config/wezterm
# create directories for mise
mkdir -p ~/.config/mise

# make symbolic links
ln -sf "$PWD/shell/zshrc" ~/.zshrc
ln -sf "$PWD/config/starship.toml" ~/.config/starship.toml
ln -sf "$PWD/config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua
ln -sf "$PWD/config/wezterm/keybinds.lua" ~/.config/wezterm/keybinds.lua
ln -sf "$PWD/.gitconfig" ~/.gitconfig
ln -sf "$PWD/config/mise/config.toml" ~/.config/mise/config.toml
ln -sf "$PWD/config/mise/default-gems" ~/.default-gems

# install packages via Homebrew
if command -v brew >/dev/null 2>&1; then
  brew bundle --file=.Brewfile
else
  echo "Homebrew not found. Please install Homebrew first."
fi

echo "Dotfiles setup complete!"
