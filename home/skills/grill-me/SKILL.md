---
name: grill-me
description: Use before building any new project or significant feature, or when Mishi says "grill me". Interviews her until the plan is complete, then writes SPEC.md.
---
Interview Mishi relentlessly about the plan until you share a complete understanding.

Rules:
- Ask exactly one question at a time, with your recommended answer.
- Don't ask what you can find out yourself, from files, docs or research.
- Walk every branch of the decision tree: who it's for, the core moment of use, the screens, the data, empty and error states, what it should feel like, and what's out of scope.
- Ask about feelings and purpose as well as features: "what would make you stop using it?", "what should it feel like to open it?"
- About every 10 questions, summarize what's decided so far.
- Size the grill to the project: about 5 questions for an artifact, 20–50 for an app.
- Don't write code until she agrees the plan is complete.

At the end, write SPEC.md in the project folder (create `~/Projects/<name>/` if needed) with these sections: Purpose, Main flows, Screens, Data, Decisions, Not in v1, Later. Show it to her as an artifact for review.
