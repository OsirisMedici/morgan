# Morgan rename verification, 11 October 2026

- Built Morgan 0.1.1 with the existing Swift command-line build. The original concurrency and deprecation warnings remain; there were no compiler errors.
- Bundle display name, bundle name, executable, menu-bar label, panel title, spoken introduction, and assistant prompts were renamed to Morgan.
- Retained the legacy `com.osiris.clickypersonal` identifier and preference keys. The local ad-hoc signature changed, so macOS reset the permissions; the installed app displayed its four permission controls.
- Installed `/Applications/Morgan.app` and verified its code signature. Preserved the prior app recoverably at `/Users/osirismedici/Desktop/code projects/clicky-personal/build/backups/Clicky Personal.app.backup`.
- The renamed app's smoke test passed POINT parsing, a real Codex screenshot request that located the Crop button at 1040,115 in five seconds, and native Mac speech playback. See `morgan-smoke-test.log`.
- HeyClicky's executable SHA-256 remained `970569210a71cf1f39790f7d0fc02af2a1d64bacf0259d4741f0fa63e53dbb31` before and after installation.
- Current source contained no credential-pattern matches. Two older upstream commits contained such strings. The private project starts with a clean source snapshot and preserves the original clone locally rather than pushing that old history.

Live microphone, global shortcut, and screenshot use require restoring the four macOS grants for Morgan. The previous personal version's live acceptance remains in `2026-10-11.md`. Repository privacy and remote commit verification are recorded after the push completes.
