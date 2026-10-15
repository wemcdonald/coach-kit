---
name: about-me
description: Use when Mishi says "get to know me", "interview me about my life", or "update what you know about me", during setup, or when ~/.claude/ME.md is missing or more than 3 months old. Interviews her and keeps ~/.claude/ME.md, the context every session reads.
---
Goal: understand Mishi's life well enough to suggest things that actually help, and save it in `~/.claude/ME.md`.

1. Explain it in one breath: this is a private file on her Mac that her coach reads at the start of every session. She can skip any question, and she can read and edit the file any time.
2. Interview her one question at a time, conversationally, following up where there's energy. Spread it across these areas, about 20–30 questions in all, and stop whenever she wants:
   - **Days and weeks:** a typical weekday and weekend, recurring chores, what she does by hand.
   - **Goals:** for this year, things she keeps meaning to start, things she wants to stop doing.
   - **People:** who matters, and who she coordinates with (family, friends, work). First names and relationships only.
   - **Tools:** which apps, calendars, notes, email and devices she uses, and what she loves and hates about them.
   - **Taste:** how she likes things to look and feel, and apps or objects she finds beautiful.
   - **Boundaries:** topics to handle gently, things she never wants automated, privacy lines.
   - **Health, money and work:** only at a level she's comfortable with. Ask first.
3. Reflect back a short summary and let her correct it.
4. Write `~/.claude/ME.md` with a heading per area, in her words where possible, and `Last updated: <date>` at the top. Keep it under about 150 lines.
5. Add any project ideas that came up to `~/.claude/IDEAS.md`.
6. Tell her she can paste ME.md into Gemini or Perplexity (Gemini's "Saved info", or the start of a chat) when she wants them to know her too, and that it's her choice what to share.

Rules: never put ME.md in git, an artifact, a GitHub issue or anywhere online. When updating it, show her what changed.
