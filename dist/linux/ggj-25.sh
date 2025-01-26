#!/bin/sh
echo -ne '\033c\033]0;Global Game Jam 2025\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ggj-25.x86_64" "$@"
