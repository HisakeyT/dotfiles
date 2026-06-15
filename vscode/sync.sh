#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_SETTING_DIR="$HOME/Library/Application Support/Code/User"

mkdir -p "$VSCODE_SETTING_DIR"

ln -sf "$SCRIPT_DIR/settings.json" "$VSCODE_SETTING_DIR/settings.json"
ln -sf "$SCRIPT_DIR/keybindings.json" "$VSCODE_SETTING_DIR/keybindings.json"
