# Morgan

A personal Mac assistant, based on [Farza's Clicky](https://github.com/farzaa/clicky), starting at `a80fa80721a8aebe51a170a7780705024ebc6e46`. The complete current upstream source is retained. This repository starts with a clean snapshot because older public Git history contains credential strings. The original full-history clone remains locally at `/Users/osirismedici/Desktop/code projects/clicky-personal`. This is the public original, not the newer private HeyClicky app.

## Intended experience

Hold **Shift + Control + Space**, ask about the screen, and release. Apple Speech transcribes the question. The installed Codex CLI answers using its existing ChatGPT sign-in, and the original blue companion points to the returned coordinates. A Mac voice reads the answer. Typed questions and a voice test are available from the menu bar.

This build keeps `/Applications/HeyClicky.app` separate. Morgan retains the legacy bundle identifier `com.osiris.clickypersonal` and preference keys from Clicky Personal for continuity. HeyClicky has a separate identity. macOS may still require permission reapproval after a rebuild because the local signature changes. It starts only when opened and does not register a login item. The menu bar icon is a cursor with rays.

## Build and run

Use `scripts/build-personal.sh` with Apple's Command Line Tools. Full Xcode is unnecessary for this build. The script compiles the existing Swift sources and additions into `build/morgan/Morgan.app`, then signs it locally. Open the installed `/Applications/Morgan.app`.

The original Xcode project, upstream providers, Worker, release scripts, assets, and MIT license remain in the source repository. The original README is preserved at `docs/upstream/README.md`. The original release script is not the personal build script and is not used to publish this app.

## Active services

- `CodexCLIClient.swift` starts `codex exec` per question, with `--ephemeral`, a read-only sandbox, user config ignored, and shell, apps, plugins, web search, and delegation disabled. The app supplies only the current images and last ten text exchanges. Temporary image and output files are removed when each request completes. The app never reads or copies the Codex token. Inherited API-key variables are removed so they cannot silently change the billing route.
- `AppleSpeechTranscriptionProvider.swift` is selected by the bundle configuration. Recognition uses on-device mode when the selected language supports it; otherwise Apple's framework may use its service. Speech recognition and microphone access require the user's macOS grants.
- `MacVoiceClient.swift` uses `AVSpeechSynthesizer` and installed Mac voices. Speaking uses no speech-service key.
- `CompanionManager.swift` coordinates input, capture, ten-exchange memory, Codex output, POINT parsing, display coordinate mapping, voice, interruption, and errors.
- `CompanionPanelView.swift` provides permission controls, typed questions, optional screen context, a voice test, answer text, and a stop button.
- `ClickyAnalytics.swift` retains the original hook names as no-ops. The personal build has no PostHog connection or email signup.

Questions consume the existing Codex plan allowance. This is not unlimited model access. The CLI is already signed in with ChatGPT on this Mac; verify future auth changes with `codex login status`.

## Verification

The app executable accepts `--self-test`. It checks POINT parsing, sends a generated practice screen with a purple Crop button through the real Codex client, verifies the returned location, and awaits completion of native speech playback. No personal screen or microphone recording is used by this smoke test.

Live screen capture, dictation, and the global shortcut need separate permissions for this app. In its panel, grant Microphone, Speech recognition, Screen recording, and Accessibility. macOS may require quitting and reopening the app after Screen recording is granted. Click **Test Mac voice**, then hold Shift + Control + Space over an ordinary app and ask where a visible control is. Release and check both the spoken answer and pointer. Press the shortcut again or **Stop** to interrupt.

The first installed version was accepted on 11 October 2026. See `docs/verification/2026-10-11.md` for the exact automated checks, saved permission states, and user-confirmed voice/pointing test.

## Limits

This fork implements the earlier screenshot-based teaching companion. It does not include the latest private HeyClicky autonomous agents or integrations. Using Mac speech may change recognition accuracy and voice quality. Codex CLI startup adds latency per question. The app is locally signed rather than Apple-notarized; rebuilding may cause macOS to require permission grants again.

## Continue work

- Public repository: https://github.com/OsirisMedici/morgan
- Local checkout: `/Users/osirismedici/Desktop/code projects/morgan`
- Installed application: `/Applications/Morgan.app`
- Start with `docs/PROJECT_STATE.md` for the current scope, `docs/DECISIONS.md` for rationale, and `docs/ROADMAP.md` for proposed next work.
- The original architectural research is in `docs/research/clicky-how-it-works.md`.

Source and documentation belong in Git. Compiled apps, build caches, API credentials, environment secrets, and Codex auth storage stay outside the repository.
