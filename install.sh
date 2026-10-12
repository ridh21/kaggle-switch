#!/usr/bin/env bash
# Installer for people who do not use Homebrew.
# Usage: curl -fsSL https://raw.githubusercontent.com/ridh21/kaggle-switch/main/install.sh | bash

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/ridh21/kaggle-switch/main"
PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"

mkdir -p "$BIN_DIR"
curl -fsSL "$REPO_RAW/bin/kgs" -o "$BIN_DIR/kgs"
chmod +x "$BIN_DIR/kgs"
echo "Installed kgs to $BIN_DIR/kgs"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "Add $BIN_DIR to your PATH:  export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac

echo 'To enable "kgs use", add this to your ~/.zshrc:  eval "$(kgs shell-init)"'
