---
name: ship-it
description: Use when Mishi wants a new version on her phone or Mac, says "ship it" or "send it to TestFlight", or asks whether a build worked. Also for deploying web apps.
---
**Mac and iPhone apps (TestFlight):**
1. Make sure the app builds in the Simulator and the tests pass. If not, fix them or tell her.
2. Make sure `ship.json` exists at the repo root and the bundle ID is `com.wemcdonald.mishi.<appname>`.
3. Commit the finished work and push to `main`. Will's build Mac checks every 5 minutes, then builds, signs and uploads to TestFlight. That takes about 5–15 minutes, and Apple's processing takes another 10–30.
4. To check on it: `gh api repos/{owner}/{repo}/commits/main/status --jq '.statuses[] | select(.context=="coach-builder") | .state + ": " + .description'`.
   - `pending`: still building. `success`: uploaded; it will show up in the TestFlight app soon.
   - `failure`: read the newest issue titled "TestFlight build failed" (`gh issue list`, then `gh issue view <n>`). If it's a code or project problem, fix it, push, and close the issue. If it's about signing, App Store Connect, a missing app record or the build Mac, explain it to her plainly and write her a short message for Will.
   - No status after 15 minutes: Will's build Mac may be asleep or off. Tell her it's one for Will.
5. Tell her what to try in the new build.

**Web apps:** deploy to the project's host (usually GitHub Pages) and give her the link. Don't set up any paid host without Will.
