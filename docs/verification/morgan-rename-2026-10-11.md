# Morgan rename verification, 11 October 2026

- Built Morgan 0.1.1 with the existing Swift command-line build. The original concurrency and deprecation warnings remain; there were no compiler errors.
- Bundle display name, bundle name, executable, menu-bar label, panel title, spoken introduction, and assistant prompts were renamed to Morgan.
- Retained the legacy `com.osiris.clickypersonal` identifier and preference keys. The local ad-hoc signature changed, so macOS reset the permissions; the installed app displayed its four permission controls.
- Installed `/Applications/Morgan.app` and verified its code signature. Preserved the prior app recoverably at `/Users/osirismedici/Desktop/code projects/clicky-personal/build/backups/Clicky Personal.app.backup`.
- The renamed app's smoke test passed POINT parsing, a real Codex screenshot request that located the Crop button at 1040,115 in five seconds, and native Mac speech playback. See `morgan-smoke-test.log`.
- HeyClicky's executable SHA-256 remained `970569210a71cf1f39790f7d0fc02af2a1d64bacf0259d4741f0fa63e53dbb31` before and after installation.
- Current source contained no credential-pattern matches. Two older upstream commits contained such strings. The project starts with a clean source snapshot and preserves the original clone locally rather than pushing that old history.

Live microphone, global shortcut, and screenshot use require restoring the four macOS grants for Morgan. The previous personal version's live acceptance remains in `2026-10-11.md`. Osiris requested stopping further app tests and pushing all code, then changed repository visibility to public and requested a profile pin. Remote visibility and pushed-commit readback are recorded after publication completes.

The installed assistant introduced itself in its panel as "i’m morgan, your friendly companion who lives in your menu bar." No further app tests or permission changes were attempted after Osiris asked to stop testing.

## Publication readback

- Created `OsirisMedici/morgan`, pushed the complete current source and documentation, then changed it to public at Osiris's explicit request.
- GitHub API reported `private: false`, `visibility: public`, `disabled: false`, and default branch `main`.
- The remote branch SHA matched local source/documentation commit `232d5a5ac15a66c1b2df2ea559cfa5315e79e6cf` before this publication record was added.
- The repository page showed Public and the uploaded file tree. Its Pin control changed to Unpin after the requested action.
- Reloading OsirisMedici's profile showed Morgan in the sixth pin slot alongside the five existing projects.
- Source assets, original code, personal provider changes, architecture research, build instructions, decisions, comparison, roadmap, and verification records are included. Compiled apps and credentials are excluded.

No further software tests were run after Osiris requested stopping them. Morgan's rebuilt local binary still needs its macOS permission grants restored before full voice/screen use.
