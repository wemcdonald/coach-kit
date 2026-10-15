# Coach kit setup — instructions for Claude

You are setting up Mishi's Mac so you can be her development coach. She is not a developer.
Before each step, say in one or two plain sentences what it does and why. Do the steps in order.
Check each one before moving on. If a step fails twice, stop, explain it plainly, and write her
a short message she can send Will.

This repo is cloned at `~/.claude/coach-kit`. If it isn't, clone it there first:
`git clone https://github.com/wemcdonald/coach-kit ~/.claude/coach-kit`.

## 1. Check the basics

- macOS 26 or later: `sw_vers -productVersion`.
- Xcode installed: `xcodebuild -version`. If it's missing, ask her to install Xcode from the Mac App Store, open it once, accept the license, and choose the iOS platform when asked. Wait for her.
- If `xcode-select -p` doesn't point inside Xcode.app, she runs `sudo xcode-select -s /Applications/Xcode.app` in Terminal (it needs her password).
- iOS Simulator installed: `xcrun simctl list runtimes | grep iOS`. If there's no iOS runtime: Xcode → Settings → Components → iOS → Get.

## 2. Tools that need her password (she runs this in Terminal)

You can't type her password, so give her this block to paste into Terminal (Applications → Utilities → Terminal). Tell her what to expect: Homebrew asks for her Mac password (nothing shows while she types; that's normal), and GitHub opens a browser window with a code to confirm.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
brew install gh jq xcodegen node
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git
curl -fsSL https://claude.ai/install.sh | bash
```

If she doesn't have a GitHub account yet, walk her through "Set up GitHub" in GUIDE.md first (setup step 3). The `gh auth login` line shows a one-time code in Terminal and opens github.com/login/device: she checks the code matches and clicks Authorize.

When she's done, check: `/opt/homebrew/bin/brew --version`, `gh auth status`, `xcodegen --version`, `node --version`, and `~/.local/bin/claude --version` (or `claude --version`). Skip anything that's already installed.

## 3. Git identity

Commits need a name and email. Use her GitHub identity, with GitHub's private noreply address so her email stays private:

```bash
login=$(gh api user --jq .login); id=$(gh api user --jq .id); name=$(gh api user --jq '.name // .login')
git config --global user.name "$name"
git config --global user.email "$id+$login@users.noreply.github.com"
git config --global init.defaultBranch main
```

## 4. Install or update the coach files

Copy these from `~/.claude/coach-kit/home/` into `~/.claude/`:
- `coach/COACH.md` → `~/.claude/coach/COACH.md`
- each `skills/<name>/` → `~/.claude/skills/<name>/`
- each `agents/<name>.md` → `~/.claude/agents/<name>.md`

`~/.claude/coach-kit-installed.txt` records the `shasum -a 256` of every file you installed, one `<hash>  <path>` line per file. For each file:
- the destination doesn't exist: copy it.
- the destination's hash matches the recorded one (she hasn't changed it): replace it.
- the destination differs from the recorded hash (she or her coach changed it): show her the difference in plain words, and ask whether to keep hers, take Will's, or keep both (save Will's under a new skill name).

Then rewrite `coach-kit-installed.txt` with the new hashes. Never delete her own skills or agents.

## 5. Her instructions file

If `~/.claude/CLAUDE.md` doesn't exist, create it:

```markdown
@~/.claude/coach/COACH.md
@~/.claude/ME.md

# My preferences
<!-- Things I've told my coach to remember. My coach adds to this; Will's updates never touch it. -->
```

If it exists, make sure its first two lines are `@~/.claude/coach/COACH.md` and `@~/.claude/ME.md`, and leave the rest alone.
Create these if they don't exist: `~/.claude/ME.md` (`# About me` plus "Not filled in yet. Ask my coach to interview me."), `~/.claude/IDEAS.md` (`# My ideas`), `~/.claude/REVIEWS.md` (`# Weekly reviews`) and `~/Projects/`.

## 6. Simulator tools (MCP)

```bash
claude mcp add MobileBuildMCP -s user \
  -e MOBILEBUILDMCP_ENABLED_WORKFLOWS=simulator,ui-automation,macos,project-discovery \
  -- npx -y mobilebuildmcp@latest mcp
claude mcp list
```

This lets you build her apps, run them in the Simulator, tap through them and take screenshots. Optional: Xcode's own tools. In Xcode → Settings → Intelligence, turn on "Allow external agents to use Xcode tools", then run `claude mcp add xcode -s user --transport stdio -- xcrun mcpbridge`.

## 7. Check everything

Tell her to start a **new** Code session (skills, agents and MCP servers load at session start). In the new session, check:
- `/` shows the skills about-me, ask-will, design-check, find-a-project, grill-me, make-a-skill, new-project, next-slice, ship-it, show-me, update-coach-kit and weekly-review,
- the agents design-critic and plain-reviewer are available,
- the MobileBuildMCP tools are connected (`claude mcp list` shows it ✓ Connected).

Then do a small test: create a throwaway SwiftUI app from `templates/` in a temporary folder, build it for the Simulator with MobileBuildMCP, launch it, take a screenshot, and show it to her. Delete the folder afterwards.

## 8. Wrap up

1. Publish `~/.claude/coach-kit/GUIDE.md` as a nicely designed artifact titled "My App Coach Guide", so she has her own copy to read. Keep all its content.
2. Show her a short summary artifact of what you set up, in plain language.
3. Ask her for the Apple ID email on her iPhone (Settings → her name). Then write her the setup message for Will from GUIDE.md ("What to ask Will for"), filled in with that email and her GitHub username (`gh api user --jq .login`). Tell her what the two Apple emails will look like when they come.
4. Offer the about-me interview now or soon. It's what makes your suggestions personal.
5. Offer to schedule her weekly review (see the weekly-review skill), at a day and time she picks.
6. Then offer find-a-project, or to grill her on an idea from her guide's "My ideas" list.
