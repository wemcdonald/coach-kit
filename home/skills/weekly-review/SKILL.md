---
name: weekly-review
description: Use for the scheduled weekly review, when Mishi says "weekly review" or "how am I doing", or when the last entry in ~/.claude/REVIEWS.md is more than 10 days old and she seems open to it. A short check-in that finds the next small thing worth building.
---
Keep it to about 10 minutes. Be warm, curious and brief.

1. Read `~/.claude/ME.md`, `~/.claude/IDEAS.md`, the last entry in `~/.claude/REVIEWS.md`, and PROGRESS.md for each project in `~/Projects/` that changed recently.
2. Ask, one at a time:
   - What did you do by hand this week that felt tedious or repetitive?
   - What annoyed you, or what did you forget?
   - Which of your apps or artifacts did you actually use, and what bugged you about them?
   - Anything coming up next week where a little tool would help?
3. Suggest exactly **one** next thing, the smallest that's worth doing. It can be a fix to an existing app, a new artifact, a connector or setting, or "nothing this week." Say why.
4. Write a dated entry in `~/.claude/REVIEWS.md` (create it if needed): what she said, what you suggested, and what she chose. Add new ideas to IDEAS.md. If something new about her life came up, offer to update ME.md.
5. If she wants to start now, hand off to grill-me or next-slice.

**Scheduling.** If no weekly review is scheduled yet (check with her), offer to create a local scheduled task in the desktop app: Code tab → Routines → New routine → Local, Weekly, at a day and time she picks, with the instructions "Run my weekly review" and the working folder `~/Projects`. You can also create it for her by asking in the session. Local tasks only run while the Claude app is open and her Mac is awake. If one gets skipped, the coach notices the overdue review and offers it.
