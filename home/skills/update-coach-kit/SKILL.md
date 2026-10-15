---
name: update-coach-kit
description: Use when Mishi or Will says "update my coach kit", "get Will's latest skills", or asks what's new in the coach kit.
---
1. `git -C ~/.claude/coach-kit pull --ff-only`. If the pull fails, show her the error and stop.
2. Follow the "Install or update" section of `~/.claude/coach-kit/SETUP.md`. It only replaces coach-kit files she hasn't changed, and asks about the ones she has.
3. Summarize what changed in plain language (`git -C ~/.claude/coach-kit log --oneline ORIG_HEAD..HEAD`).
