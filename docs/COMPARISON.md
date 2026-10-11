# Morgan and HeyClicky

Checked 11 October 2026. Installed versions at the initial comparison were HeyClicky 1.0.53 and Clicky Personal 0.1.0, now renamed Morgan.

Both provide the basic experience of asking about the screen, hearing an answer, and seeing where to look. The personal version's working teaching loop does not establish parity with the current private product.

| Area | HeyClicky | Morgan baseline |
| --- | --- | --- |
| Voice | Published realtime voice, selectable voices, and speed controls | Mac dictation, complete Codex answer, then Mac speech |
| Guidance | Published drawings and step-by-step walkthroughs | Screenshot context and a blue pointing cursor |
| Memory | Published persistent preferences and project context | Ten text exchanges in RAM, cleared at quit |
| Actions | Published agents, app integrations, and routines | Explanation and pointing; action tools disabled |
| Editing | Private current product | Editable source in Osiris's private repo |
| Maintenance | Vendor updates and fixes | Local builds and project-owned maintenance |
| Cost | Pro advertises $20/month with unlimited talk and capped agent messages | Existing Codex allowance, with no separate speech-provider subscription |

HeyClicky claims come from its [changelog](https://www.heyclicky.com/changelog) and [pricing](https://www.heyclicky.com/). Morgan's behavior is established by the active source and `docs/verification/2026-10-11.md`.

Osiris selected faster, more natural voice conversations as the main priority. The recommendation was to keep Morgan as an editable alternative and limit the next investment to one focused performance experiment, measuring whether it improves the experience before attempting a full realtime voice project.

Morgan currently starts a fresh Codex CLI process per question and waits for the complete answer before speaking. Persistent inference and speaking complete sentences during generation are possible experiments. They do not automatically reproduce a realtime speech-to-speech system or establish that the existing subscription includes any newly chosen voice API.

No head-to-head voice latency or voice-quality benchmark was run. The five-second synthetic-image result measured Codex answer duration in one test, not first audible reply or comparative speed.
