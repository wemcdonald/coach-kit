# <App name>

<One paragraph: what this is, who it's for, and the moment Mishi uses it.>

- Kind: <artifact | web app | Mac app | iPhone app>
- Bundle ID: com.wemcdonald.mishi.<appname> (Mac and iPhone only)
- Plan and notes: SPEC.md (what and why), PLAN.md (slices), PROGRESS.md (where we are). Read all three at the start of every session.

## Build and run
- <Mac and iPhone:> `xcodegen generate` after adding or removing files. Build and run in the Simulator with MobileBuildMCP (`build_run_sim`, scheme `<Scheme>`).
- <Web:> `<command to run locally>`. Deployed at <link>.

## Shipping
- <Mac and iPhone:> pushing to main triggers a TestFlight build on Will's build Mac (see the ship-it skill). ship.json describes the build.

## Decisions and gotchas
- <Add things future sessions need to know.>
