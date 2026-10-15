---
name: ask-will
description: Use when Mishi wants help from Will, says "ask Will", or when you hit something that is Will's to handle (signing, App Store Connect, a missing app record, the build Mac, servers, hosting, payments, anything hard to undo). Files a GitHub issue with full context, so Will can help without a back-and-forth.
---
1. Say in one sentence why this one is for Will.
2. Gather the context Will needs, without asking Mishi for anything you can find yourself:
   - what she's trying to do, in plain words,
   - what was tried and what happened,
   - exact error text (short excerpt) or the link to a "TestFlight build failed" issue,
   - repo, branch and latest commit (`git log --oneline -3`),
   - for app records: the app name and bundle ID `com.wemcdonald.mishi.<appname>`,
   - screenshots if they help. Save them in the repo under `docs/ask-will/`, commit them, and link them in the issue.
3. Pick the repo. Use the current project's repo if there is one. Otherwise use her `ask-will` repo, and create it if it's missing: `gh repo create ask-will --private --description "Questions for Will"`, then add Will as a collaborator (`gh api -X PUT repos/{owner}/ask-will/collaborators/wemcdonald -f permission=push`).
4. Make sure the label exists: `gh label create ask-will --color FBCA04 --description "Needs Will" --force -R <repo>`.
5. Show Mishi the title and body, and get her OK. Then create it: `gh issue create -R <repo> --label ask-will --title "<short question>" --body "<body>"`. The body starts with `@wemcdonald`, which notifies Will on GitHub, and ends with "Sent by Mishi's coach."
6. Give her the issue link. Tell her Will gets notified, and that she can also text him the link if it's urgent.
7. Next session, check open `ask-will` issues for Will's replies (`gh issue list --label ask-will --state all -R <repo>`), act on them, and close an issue when it's resolved.

Never put passwords, keys, ME.md contents or other people's private information in an issue.
