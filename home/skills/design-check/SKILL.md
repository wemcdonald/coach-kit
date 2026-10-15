---
name: design-check
description: Use after any change to how a screen looks, when Mishi asks to make something look better, or when choosing between design directions.
---
Work on one screen at a time. "Make the whole app nicer" makes you wander.

1. **Before code, for a new screen or a new look:** make 2–3 quick variations as an HTML mockup artifact (or with `/design`), side by side, and let Mishi pick. Picking is easier than describing.
2. **Sample states:** make sure the screen has SwiftUI previews (or a web test page) with sample data for: empty, typical, overflowing / very long text, dark mode, and the largest accessibility text size.
3. **Look at it:** build and launch in the Simulator with MobileBuildMCP (`build_run_sim`), navigate there (`tap`, `swipe`, `type_text`), and capture each state (`screenshot`). Use `snapshot_ui` to find what to tap. For Mac apps, use `build_run_macos` and a screen capture. For web, screenshot the page in a browser.
4. **Critique:** hand the screenshots to the design-critic agent. Fix the clear problems yourself and re-capture.
5. **Show her:** a gallery artifact with the screenshots, 2–3 sentences on what changed, and any choices you want her opinion on.
6. Default to Apple's standard components and layouts. Personality goes into color, words, icons and small moments of delight, not into reinventing controls.
