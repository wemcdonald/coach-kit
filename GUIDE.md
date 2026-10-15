# Mishi's Guide to Building Apps with an AI Coach

*For Mishi, from Will. October 2026.*

You're going to build your own apps: little tools that fit your life exactly, made by talking with Claude. You don't need to know how to code. You do need ideas, opinions and some patience, and you have all three.

This guide covers how it works, what to expect, and how to get set up. Your Claude will also have its own instructions (the "coach kit"), so it knows how to work with you without you having to explain.

---

## How it works

You bring the problems and the taste. Claude brings the engineering, and also acts as your **coach**: it helps you notice what's worth building, gets ideas out of your head with lots of questions, and teaches you as you go.

Claude is fast and very literal, and it forgets everything between conversations unless it's written down. So your coach keeps notes in files on your Mac, and you never have to repeat yourself.

Your job:
1. **Notice friction.** "I keep losing track of X." "Every week I do Y by hand." That's where the best personal apps come from.
2. **Say what you want**, with help from your coach's questions.
3. **Look at what gets built** and say clearly what's right and what's wrong.
4. **Keep it small.** One piece at a time, each piece working before the next starts.

## What can you build? The lightest thing that solves the problem

Your coach will suggest one of these. Lighter is better: faster to make, easier to change.

| Kind | Good for | How you use it | Effort |
|---|---|---|---|
| **Claude artifact** | Trackers, calculators, checklists, planners, small games | A page Claude hosts, opened from a link. It can save your data. | Minutes |
| **Web app** | Things you want on several devices or want to share with friends | A website. On iPhone, you can add it to your home screen like an app. | Hours to days |
| **Mac app** | Menu-bar helpers, tools that work with your files | Runs on your Mac. | Days |
| **iPhone app** | Things on the go: reminders, widgets, camera, location, Health | Arrives on your phone through TestFlight. | Days to weeks |

A good habit is to try an idea as an artifact first. If you use it every day and hit its limits, turn it into a real app. Sometimes you'll find the idea is simpler than you thought, or that you don't need an app at all.

## The loop

**Notice → Grill → Spec → Design → Build → Try → Ship → Live with it**

**1. Notice.** Tell your coach about an annoyance, a goal or an idea. Rambling is fine; voice dictation is great for this. Or say *"help me find something to build"*, and it will interview you about your week.

**2. Grill.** This is the most important step. Before building anything, your coach interviews you: **one question at a time**, each with its recommended answer, until every decision is made. It will ask things you didn't know you had opinions on: what happens when the list is empty, should it work offline, what should it feel like to open it. Thirty to fifty questions is normal for an app. When you don't care, say "use your recommendation." (The technique is called "grill me." It comes from a developer named Matt Pocock and is widely used.)

**3. Spec.** The grill ends with a short written plan, shown to you as a nicely laid-out page: what it does, the screens, and what's explicitly **not** in version 1. Read it and react in chat. Changing words is free; changing code is not. A "Later" list keeps good ideas from getting lost without sneaking them into v1.

**4. Design.** Look at pictures before any real code. Your coach makes quick mockups, often 2 or 3 versions side by side, so you can just pick one. You can also use **Claude Design**: in Claude, start a new Design (or type `/design` in the Code tab). Describe a vibe ("calm, like a paper journal"), drop in screenshots of apps you like, and iterate. When you like it, use **Send to local coding agent** to hand it over to your coach.

**5. Build in thin slices.** Each step makes something you can see and tap. *"Slice 1: the app opens and shows a list with sample data. Slice 2: you can add an item. Slice 3: items are still there after you quit."* Never "build the whole app." Say **"next slice"** to keep going.

**6. Try it.** After each slice, your coach runs the app in the iPhone Simulator (a pretend iPhone in a pane next to the chat), taps through it, takes screenshots and checks them itself before showing you. Then you try it. You can tap in the Simulator pane too. Give feedback like you would to a contractor:
- **Show, don't describe.** Take a screenshot (⌘⇧4), drag it into the chat, and point: "this button is too small," "this should say 'Today'."
- **What you did, what you expected, what happened.** "I tapped Save and expected to go back to the list. Instead nothing happened."
- **Paste error messages exactly**, even if they look like gibberish.
- **When it's right, say so.** Your coach saves a version before moving on.

**7. Ship.** Say **"ship it."** Mac apps and web apps work right away. For iPhone apps, your coach sends the code to GitHub, Will's build Mac turns it into an app, and it appears in the **TestFlight** app on your phone, usually within 30–45 minutes.

**8. Live with it.** Use it for real for a few days. Notice what bugs you. That's your next round. This step is what makes it *yours*.

## How design works

Nobody has fully figured out the best way to design apps with AI yet. This combination works well:

1. **Pictures before code.** Mockups are the cheapest place to change your mind. Ask for variations.
2. **Apple's style first, then yours.** Apps built from standard iPhone pieces (lists, tabs, sheets, the system font) look good with little effort and feel natural. Your personality goes into the colors, the words, the icons and the little moments of delight.
3. **Every screen, every state.** Your coach checks each screen when it's empty, full, with very long text, in dark mode and with extra-large text. That's where most ugly bugs hide.
4. **Your coach has eyes.** It runs the app, taps through it, screenshots it, and has a "design critic" helper review the screenshots before you see them.
5. **One screen at a time.** "Make the whole app prettier" makes your coach wander. "Make the Today screen feel calmer: more space, softer colors" works.
6. **Real phone, real life.** Some things only show up on your actual phone: whether a button is easy to reach with your thumb, whether something feels slow.

## Your coach's toolbox, in plain language

Your coach is **Claude Code**, which is the **Code** tab in the Claude desktop app, plus some files in a hidden folder on your Mac (`~/.claude`). Ask Claude to show you or change any of them.

- **Instructions (`CLAUDE.md`).** Notes Claude reads at the start of every conversation. There's one for you in general and one inside each project. When you catch yourself repeating something, say *"remember that."*
- **Skills.** Saved recipes, like "grill me," "next slice," "ship it." Type `/` to see them, or just talk normally and Claude uses them when they fit. **Make your own:** whenever you do something twice, say *"turn what we just did into a skill."* This is the most powerful habit in this guide.
- **Helper agents.** Specialists Claude hands work to, like the design critic. They keep the main conversation focused.
- **Project notes.** `SPEC.md` (the plan), `PLAN.md` (the slices) and `PROGRESS.md` (where you are). This is why you can start a fresh conversation any time without losing anything.
- **Artifacts.** Nice-looking pages Claude makes to *show* you things: specs, design options, screenshot galleries, progress. They're private to you. To show Will, share your screen or send him a screenshot.
- **GitHub.** Saves every version of your work, so you can always go back. It's also how Will sees your code and how your iPhone builds get made.
- **Connected tools.** Plug-ins that let Claude operate other programs, like the iPhone Simulator.

Will improves the coach kit over time. Say **"update my coach kit"** to get his latest version. Anything you've changed yourself is kept.

## Habits that make this work

- **Start a fresh conversation for each new slice.** Long chats get muddled. The project notes carry the memory.
- **Ask "what did you change and why?"** You'll learn a lot from the answers.
- **When your coach is going in circles** (same fix three times, getting worse), say: *"Stop. Explain the problem in plain English, list three possible causes, and tell me which you think it is."* Or go back to the last version that worked and try another approach.
- **Nothing is permanent.** Every working version is saved on GitHub. Be brave.
- **Use your other AI subscriptions on purpose:**
  - **Perplexity** for research. "What apps already do X, and what do people complain about?"
  - **Gemini** for a second opinion on your spec ("what's missing or confusing?") and for generating app icons and images.
  - **Claude** for the building. Keep each project in one place.
- **No secrets in code.** No passwords, keys or personal data. If something needs an account, a key or money, your coach will write you a note for Will.
- **Start with things only you use.** They can be messy and weird. That's fine.

## Things that need Will

Your coach knows these and will hand you a short message to send him:
- **Each new iPhone or Mac app needs a one-time setup** in Apple's App Store Connect before TestFlight works. Takes Will a minute.
- Anything that needs a server, a database, logins, payments or the App Store.
- Build errors about "signing," "provisioning" or "App Store Connect."

---

## Setup (once, ideally on a call with Will)

It takes about 2 hours, mostly downloads.

1. **Update macOS:** System Settings → General → Software Update.
2. **Install Xcode** from the Mac App Store. It's free but huge, so start it first. Open it once, accept the license, and choose **iOS** when it asks about platforms.
3. **Make a GitHub account** at github.com. Turn on two-factor authentication (Settings → Password and authentication).
4. **Install GitHub Desktop** (desktop.github.com) and sign in. It shows your saved versions visually.
5. **Install the Claude desktop app** (claude.ai/download), sign in, and open the **Code** tab. Choose your home folder when it asks for a folder. Leave permissions on the default (Claude asks before making changes).
6. **Paste this into the Code tab:**

   > Set yourself up as my development coach. Clone https://github.com/wemcdonald/coach-kit into ~/.claude/coach-kit and follow its SETUP.md. Explain each step in plain language before you do it.

   Claude will ask your permission at several points and will give you one block to paste into Terminal (for things that need your password). If anything confuses you, ask "what does this do?"
7. **Send Will your GitHub username** (your coach writes the message). He'll switch on automatic TestFlight builds and invite you to TestFlight.
8. **On your iPhone:** accept Will's email invite and install the free **TestFlight** app from the App Store.

Then say: *"Help me find something to build."*

## My ideas

*(Write your ideas here, or tell your coach and it keeps a list.)*

-
-
-
