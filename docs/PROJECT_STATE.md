# Morgan project state

Updated 11 October 2026.

## Outcome

Osiris can ask spoken questions about the screen, hear an answer through a Mac voice, and see the original blue companion point to relevant controls. Morgan uses the existing Codex ChatGPT sign-in and has editable source in a public GitHub repository. HeyClicky remains a separate application.

## Current implementation

Morgan is the renamed Clicky Personal fork of Farza's public Clicky at upstream commit `a80fa80721a8aebe51a170a7780705024ebc6e46`. It retains the original screen capture, dictation pipeline, POINT parsing, display coordinate mapping, and cursor animation. It replaces active Claude and paid speech-provider calls with `CodexCLIClient` and native Mac speech.

The full source, assets, Xcode project, inactive original provider implementations, Worker, release scripts, and MIT license are present. Only `scripts/build-personal.sh` builds the active personal app. The original release script and Cloudflare Worker are historical upstream components, not Morgan's deployment route.

The current baseline supports:

- Shift + Control + Space push-to-talk.
- Apple Speech recognition and installed Mac text-to-speech voices.
- Live screenshots of connected displays, with Morgan's own windows excluded.
- Codex answers using the local CLI's managed ChatGPT authentication.
- Blue pointer guidance, typed questions, optional screen context, answer text, and Stop.
- Last ten text exchanges in memory during the current app session.

It has no active autonomous computer-use agent, external app integrations, scheduled routines, durable user memory, or realtime speech-to-speech pipeline. The public original is not feature-equivalent to current private HeyClicky.

## Locations

- Repository: https://github.com/OsirisMedici/morgan, private.
- Checkout: `/Users/osirismedici/Desktop/code projects/morgan`.
- Installed app: `/Applications/Morgan.app`.
- Original full-history local clone: `/Users/osirismedici/Desktop/code projects/clicky-personal`.
- Original installed product, preserved: `/Applications/HeyClicky.app`.

## Verification and acceptance

The original personal version passed a real Codex synthetic-image test, a live screen-aware typed question, Mac speech playback, Stop cancellation, and saved permission readback. Osiris then tested the voice shortcut and confirmed, "It spoke and pointed." Exact evidence is in `docs/verification/2026-10-11.md`.

The Morgan rename has its own verification record in `docs/verification/morgan-rename-2026-10-11.md`. Read its final status before claiming the renamed build has preserved every live permission or interaction.

## Future direction

Osiris's stated priority is faster, more natural voice conversations. The recommendation was to keep this project as an editable alternative and attempt a bounded performance improvement before committing to a full realtime voice project. That recommendation is not authorization to begin new feature work automatically. See `docs/ROADMAP.md`.
