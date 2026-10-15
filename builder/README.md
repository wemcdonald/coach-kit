# builder

Runs on the build Mac. Every 5 minutes, `coach-builder.sh` looks at the GitHub repos of the owners in `~/.config/coach-builder/config`. For each repo whose `main` moved and has a `ship.json`, it:

1. clones or fetches the repo into `~/coach-builds/<owner>/<repo>` and runs `xcodegen generate` if there's a `project.yml`,
2. refuses bundle IDs outside `BUNDLE_PREFIX`,
3. archives with automatic signing (`-allowProvisioningUpdates`, the Xcode account on this Mac, build number = UTC `yyyymmddHHMM`), and exports with `destination=upload` for internal TestFlight testing only,
4. sets a `coach-builder` commit status (pending, then success or failure). On failure, it also opens an issue in the repo with the log tail and a hint. The coach's ship-it skill reads both.

Logs: `~/Library/Logs/coach-builder.log`, plus one log per build in `~/.local/state/coach-builder/`.

## Install

```bash
builder/install.sh            # first run writes ~/.config/coach-builder/config; edit OWNERS, run again
builder/coach-builder.sh --repo owner/name            # build now
builder/coach-builder.sh --repo owner/name --export   # archive + sign + export locally, no upload
```

Needs `gh` (logged in, with write access to the repos as a collaborator), `jq`, `xcodegen` and Xcode signed in to the team's account. It runs as a LaunchAgent in the Aqua session, so the Mac must be logged in to the GUI: signing uses the login keychain.

## Per new app (manual, because Apple has no API for it)

In App Store Connect: Apps → + → New App, with platform iOS (or macOS), the app's bundle ID `com.wemcdonald.mishi.<appname>`, and any SKU. Xcode registers the bundle ID itself during the first archive. If the bundle ID isn't in the list yet, run `--export` once first. Until the record exists, uploads fail with "App record ... not found", and the failure issue says so. Then add Mishi as an internal tester on the app's TestFlight tab, or use an internal group with automatic distribution.
