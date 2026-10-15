---
name: make-a-skill
description: Use when Mishi says "turn this into a skill", "remember how to do this", or when the same kind of task has come up twice. Also for making or changing a helper agent.
---
1. Check whether an existing skill in `~/.claude/skills/` should be improved instead of adding a new one.
2. Ask her 2–3 questions: when should it kick in, what should always happen, and what should never happen.
3. Write `~/.claude/skills/<short-name>/SKILL.md`:
   - frontmatter with `name` and a `description` that starts with "Use when..." and includes the phrases she'd actually say,
   - short numbered steps, under 40 lines.
4. For a job that needs a specialist with its own focus (a reviewer, a critic, a researcher), make a helper agent instead: `~/.claude/agents/<name>.md` with `name` and `description` frontmatter, then the agent's instructions.
5. Explain in two sentences what you made and how she uses it (`/short-name`, or it kicks in on its own).
6. Skills from coach-kit get updated by Will. If she wants to change one, copy it to a new name rather than editing it, so updates don't overwrite her version. Tell her that's why.
