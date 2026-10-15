---
name: new-project
description: Use when starting a new app or web project once its SPEC.md is agreed. Sets up the folder, the Xcode or web project, git, a private GitHub repo with Will as collaborator, and the project notes.
---
1. Work in `~/Projects/<name>/` (lowercase, dashes).
2. **Mac or iPhone app:** copy `~/.claude/coach-kit/templates/project.yml` and fill in the app name. Its bundle ID must be `com.wemcdonald.mishi.<appname>`. Create a minimal SwiftUI app under `<AppName>/`, with SwiftUI previews for sample data. Add `<AppName>/Assets.xcassets/` containing a top-level `Contents.json` (`{"info":{"author":"xcode","version":1}}`) and a copy of `templates/AppIcon.appiconset`. TestFlight rejects apps without an icon. Offer to make her a real icon later (Gemini is good at this). Replace `icon-1024.png` with a 1024×1024 PNG that has no transparency. Run `xcodegen generate`, build in the Simulator and fix errors. Copy `templates/ship.json` and fill in the scheme and platform.
   **Web app:** the simplest structure that fits (a single `index.html`, or `npm create vite@latest` with React). Add a GitHub Pages deploy only when she wants it online.
3. Copy `templates/gitignore` to `.gitignore`, then `git init`.
4. `gh repo create <name> --private --source . --push`, then add Will: `gh api -X PUT repos/{owner}/<name>/collaborators/wemcdonald -f permission=push`.
5. Write the project `CLAUDE.md` from `templates/project-CLAUDE.md`.
6. Write PLAN.md as thin vertical slices from SPEC.md, each ending in something she can see. Show it as an artifact.
7. Commit and push. **For a Mac or iPhone app, write Mishi a message for Will** (she sends it herself) asking him to create the app in App Store Connect with bundle ID `com.wemcdonald.mishi.<appname>`. TestFlight uploads fail until he does. Apple doesn't allow creating apps through its API.
8. Tell her the next step is slice 1.
