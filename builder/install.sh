#!/usr/bin/env bash
# Installs the coach-builder LaunchAgent on the build Mac. Run as the user whose Xcode account
# signs the apps, from a logged-in GUI session.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
label=com.wemcdonald.coach-builder
plist="$HOME/Library/LaunchAgents/$label.plist"

for tool in gh jq xcodegen xcodebuild; do
  command -v "$tool" >/dev/null || { echo "missing $tool (brew install $tool)" >&2; exit 1; }
done
gh auth status >/dev/null 2>&1 || { echo "gh is not logged in" >&2; exit 1; }
[ -f "$HOME/.config/coach-builder/config" ] || {
  mkdir -p "$HOME/.config/coach-builder"
  cp "$here/config.example" "$HOME/.config/coach-builder/config"
  echo "wrote $HOME/.config/coach-builder/config; edit OWNERS, then run this again" >&2
  exit 1
}

chmod +x "$here/coach-builder.sh"
sed -e "s#__SCRIPT__#$here/coach-builder.sh#" -e "s#__HOME__#$HOME#" "$here/$label.plist" > "$plist"
launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$plist"
echo "installed; log: ~/Library/Logs/coach-builder.log"
