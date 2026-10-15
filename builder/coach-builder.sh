#!/usr/bin/env bash
# Polls GitHub for new commits on main in the app repos of the configured owners, and builds and
# uploads each changed app to TestFlight from this Mac. It reports back on GitHub: a commit status
# ("coach-builder") on every build, and an issue with the log tail when a build fails.
#
# A repo opts in by having ship.json at its root on main:
#   {"platform": "ios", "project": "Habit.xcodeproj", "scheme": "Habit"}
#   platform is "ios" or "macos". "project" may be omitted when project.yml (XcodeGen) exists.
#
#   builder/coach-builder.sh                  # one polling pass (what launchd runs)
#   builder/coach-builder.sh --repo o/r       # build o/r main now, even if already built
#   builder/coach-builder.sh --repo o/r --export   # archive + export locally, no upload
#
# Config: ~/.config/coach-builder/config (shell syntax), for example:
#   OWNERS="mishi-github-name"        # space-separated GitHub owners whose repos to watch
#   TEAM=TKTHN75H76                   # Apple team ID
#   BUNDLE_PREFIX=com.wemcdonald.mishi
# Signing is automatic with the Xcode account signed in on this Mac (-allowProvisioningUpdates),
# so this must run in the logged-in GUI session (see the LaunchAgent plist next to this script).
set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

CONFIG="$HOME/.config/coach-builder/config"
STATE="$HOME/.local/state/coach-builder"
WORK="$HOME/coach-builds"
LOCK="$STATE/lock"

[ -f "$CONFIG" ] || { echo "missing $CONFIG" >&2; exit 1; }
# shellcheck source=/dev/null
. "$CONFIG"
: "${TEAM:?TEAM not set}" "${BUNDLE_PREFIX:?BUNDLE_PREFIX not set}"
OWNERS="${OWNERS:-}"

ONLY=""
MODE=upload
while [ $# -gt 0 ]; do
  case "$1" in
    --repo) ONLY="$2"; shift 2 ;;
    --export) MODE=export; shift ;;
    *) echo "usage: $0 [--repo owner/name] [--export]" >&2; exit 2 ;;
  esac
done

mkdir -p "$STATE" "$WORK"
# One pass at a time: launchd fires every few minutes and a build can take longer than that.
if ! mkdir "$LOCK" 2>/dev/null; then
  if [ -n "$(find "$LOCK" -maxdepth 0 -mmin +90 2>/dev/null)" ]; then rm -rf "$LOCK"; mkdir "$LOCK"; else exit 0; fi
fi
trap 'rm -rf "$LOCK"' EXIT

log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $*"; }

set_status() { # repo sha state description
  gh api -X POST "repos/$1/statuses/$2" -f state="$3" -f context=coach-builder \
    -f description="${4:0:140}" >/dev/null || log "could not set status on $1"
}

report_failure() { # repo sha logfile
  local repo=$1 sha=$2 logfile=$3 title body
  title="TestFlight build failed (${sha:0:7})"
  body="$(printf 'The automatic TestFlight build of `%s` failed on Will'"'"'s build Mac.\n\n' "$sha"
    printf 'Coach: summarize this for Mishi in plain language. Fix it if it is a code or project problem. If it is about signing, App Store Connect, a missing app record or the build Mac itself, tell Mishi it is for Will.\n\n'
    if grep -qiE 'no suitable application records|app record|Could not find an app|bundle identifier.*(not available|not found)' "$logfile"; then
      printf '**Likely cause:** there is no app in App Store Connect for this bundle ID yet. Will needs to create it (Apps, then +, then New App).\n\n'
    fi
    printf '<details><summary>Last 80 lines of the build log</summary>\n\n```\n'
    grep -vE '^\s*$' "$logfile" | tail -n 80
    printf '\n```\n</details>\n')"
  gh issue create -R "$repo" --title "$title" --body "$body" >/dev/null \
    || log "could not open issue on $repo"
}

build_repo() { # repo sha
  local repo=$1 sha=$2 dir="$WORK/$1" logfile ship platform project scheme dest number
  logfile="$STATE/$(echo "$repo" | tr / _)-${sha:0:7}.log"
  : > "$logfile"
  log "building $repo @ ${sha:0:7} ($MODE)"
  [ "$MODE" = upload ] && set_status "$repo" "$sha" pending "Building for TestFlight on Will's Mac"

  {
    if [ -d "$dir/.git" ]; then
      git -C "$dir" fetch --quiet origin main || return 1
    else
      mkdir -p "$(dirname "$dir")"
      gh repo clone "$repo" "$dir" -- --quiet || return 1
    fi
    git -C "$dir" checkout --quiet --force "$sha" || return 1
    git -C "$dir" clean -fdxq -e build/ || return 1

    ship="$dir/ship.json"
    platform="$(jq -r '.platform // "ios"' "$ship")"
    scheme="$(jq -r '.scheme // empty' "$ship")"
    project="$(jq -r '.project // empty' "$ship")"
    [ -n "$scheme" ] || { echo "ship.json has no scheme"; return 1; }
    if [ -f "$dir/project.yml" ]; then
      (cd "$dir" && xcodegen generate --quiet) || return 1
      [ -n "$project" ] || project="$(cd "$dir" && ls -d ./*.xcodeproj | head -n 1)"
    fi
    [ -n "$project" ] && [ -d "$dir/$project" ] || { echo "Xcode project '$project' not found"; return 1; }
    case "$platform" in
      ios) dest='generic/platform=iOS' ;;
      macos) dest='generic/platform=macOS' ;;
      *) echo "unknown platform '$platform' in ship.json"; return 1 ;;
    esac

    # Refuse bundle IDs outside the agreed prefix, so a typo can't create an app in the wrong place.
    local bundle
    bundle="$(xcodebuild -project "$dir/$project" -scheme "$scheme" -configuration Release \
      -destination "$dest" -showBuildSettings 2>/dev/null \
      | sed -nE 's/^ *PRODUCT_BUNDLE_IDENTIFIER = (.*)$/\1/p' | head -n 1)"
    case "$bundle" in
      "$BUNDLE_PREFIX".*) echo "bundle ID: $bundle" ;;
      *) echo "bundle ID '$bundle' does not start with $BUNDLE_PREFIX. — set PRODUCT_BUNDLE_IDENTIFIER to $BUNDLE_PREFIX.<app-name>"; return 1 ;;
    esac

    number="$(date -u +%Y%m%d%H%M)"
    local out="$dir/build/coach-$number"
    mkdir -p "$out"
    cat > "$out/ExportOptions.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>method</key><string>app-store-connect</string>
  <key>destination</key><string>$MODE</string>
  <key>testFlightInternalTestingOnly</key><true/>
  <key>signingStyle</key><string>automatic</string>
  <key>teamID</key><string>$TEAM</string>
  <key>uploadSymbols</key><true/>
  <key>manageAppVersionAndBuildNumber</key><false/>
</dict>
</plist>
PLIST

    xcodebuild -project "$dir/$project" -scheme "$scheme" -configuration Release \
      -destination "$dest" -archivePath "$out/App.xcarchive" -allowProvisioningUpdates \
      -derivedDataPath "$dir/build/DerivedData" \
      DEVELOPMENT_TEAM="$TEAM" CODE_SIGN_STYLE=Automatic CURRENT_PROJECT_VERSION="$number" \
      archive || return 1
    xcodebuild -exportArchive -archivePath "$out/App.xcarchive" \
      -exportOptionsPlist "$out/ExportOptions.plist" -exportPath "$out/export" \
      -allowProvisioningUpdates || return 1
    echo "build $number done ($MODE)"
    echo "BUILD_NUMBER=$number"
  } >>"$logfile" 2>&1 || return 1
}

repos() {
  if [ -n "$ONLY" ]; then echo "$ONLY"; return; fi
  local owner
  for owner in $OWNERS; do
    gh api --paginate "user/repos?affiliation=owner,collaborator,organization_member&per_page=100" \
      --jq ".[] | select(.owner.login == \"$owner\" and .archived == false) | .full_name"
  done | sort -u
}

# Accept collaborator invites from the watched owners, so new app repos are visible without Will
# clicking through each invitation email.
for owner in $OWNERS; do
  for inv in $(gh api user/repository_invitations --jq ".[] | select(.inviter.login == \"$owner\") | .id" 2>/dev/null); do
    gh api -X PATCH "user/repository_invitations/$inv" --silent && log "accepted repo invite $inv from $owner"
  done
done

for repo in $(repos); do
  sha="$(gh api "repos/$repo/commits/main" --jq .sha 2>/dev/null)" || continue
  statefile="$STATE/$(echo "$repo" | tr / _).sha"
  if [ -z "$ONLY" ] && [ "$(cat "$statefile" 2>/dev/null)" = "$sha" ]; then continue; fi
  if ! gh api "repos/$repo/contents/ship.json?ref=$sha" --silent 2>/dev/null; then
    echo "$sha" > "$statefile"   # not an app repo (yet); look again on its next commit
    continue
  fi
  logfile="$STATE/$(echo "$repo" | tr / _)-${sha:0:7}.log"
  if build_repo "$repo" "$sha"; then
    number="$(sed -nE 's/^BUILD_NUMBER=//p' "$logfile" | tail -n 1)"
    log "ok $repo build $number"
    [ "$MODE" = upload ] && set_status "$repo" "$sha" success "Uploaded build $number. In TestFlight in ~15-30 min."
  else
    log "FAILED $repo @ ${sha:0:7}, log: $logfile"
    if [ "$MODE" = upload ]; then
      set_status "$repo" "$sha" failure "Build failed. See the newest 'TestFlight build failed' issue."
      report_failure "$repo" "$sha" "$logfile"
    else
      tail -n 40 "$logfile"
    fi
  fi
  [ "$MODE" = upload ] && echo "$sha" > "$statefile"
done
# Keep two weeks of logs and archives.
find "$STATE" -name '*.log' -mtime +14 -delete 2>/dev/null || true
find "$WORK" -path '*/build/coach-*' -maxdepth 4 -type d -mtime +14 -exec rm -rf {} + 2>/dev/null || true
