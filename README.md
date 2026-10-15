# coach-kit

Turns Claude Code (the Code tab in the Claude desktop app) into a development coach for someone who isn't a developer and wants to build personal Mac, iPhone and web apps.

- **[GUIDE.md](GUIDE.md)**: the guide for the person, covering how the loop works, design, habits and setup.
- **[SETUP.md](SETUP.md)**: instructions Claude follows to set itself up on their Mac.
- **[home/](home/)**: what gets installed into `~/.claude`. That's the coach personality (`coach/COACH.md`), the skills (grill-me, find-a-project, new-project, next-slice, design-check, ship-it, make-a-skill, show-me, update-coach-kit) and the helper agents (design-critic, plain-reviewer).
- **[templates/](templates/)**: an XcodeGen project, `ship.json`, `.gitignore`, a project `CLAUDE.md` and a placeholder app icon.
- **[builder/](builder/)**: the build-Mac side. A LaunchAgent polls the person's GitHub repos and uploads every new `main` commit to TestFlight.

## Start

In the Claude desktop app's Code tab:

> Set yourself up as my development coach. Clone https://github.com/wemcdonald/coach-kit into ~/.claude/coach-kit and follow its SETUP.md. Explain each step in plain language before you do it.

The coach is written for one person (Mishi) and one build Mac (Will's), with team and bundle-ID values in `home/coach/COACH.md`, `templates/project.yml` and `builder/config.example`. Fork and change those to use it for someone else.

Ideas borrowed from the community: the one-question-at-a-time interview ("grill me") from [mattpocock/skills](https://github.com/mattpocock/skills), screenshot-driven SwiftUI iteration, and tracer-bullet vertical slices.
