#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp "$DIR/prepare-commit-msg.sample.py" "$PWD/.git/hooks/prepare-commit-msg"
chmod a+x "$PWD/.git/hooks/prepare-commit-msg"

cp "$DIR/.pivrc.sample" "$HOME/.pivrc/${PWD##*/}.sample"
