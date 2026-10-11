# Proposed next work

Osiris's priority is faster, more natural voice conversations. These are proposals for future requests, not work already completed or automatically authorized by the rename.

## First, measure the experience

Compare Morgan and HeyClicky on the same small set of real questions. Measure time from releasing the shortcut to the first audible reply, separately from total answer duration. Include simple questions, screen navigation, and a follow-up. Ask Osiris which voice he prefers. The existing five-second synthetic-image result is Codex answer duration, not a head-to-head voice latency benchmark.

## A bounded performance experiment

Evaluate a persistent Codex process through the documented app-server interface so each question does not launch a fresh CLI process. Preserve managed authentication, tool restrictions, interruption behavior, local request cleanup, and separation from the existing Codex desktop app's sessions.

Evaluate speaking complete sentences as answer text arrives. POINT tags and formatting must stay out of speech, and Stop must cancel both inference and audio. Confirm improvement by measuring first audible reply rather than inferring it from faster network callbacks.

Official integration reference: https://learn.chatgpt.com/docs/app-server. Confirm the installed CLI's current schema before implementing; the interface can change.

## Voice preferences

Offer selection among installed Mac voices and a speech-rate control. Let Osiris choose after listening. Adding controls does not establish that Mac text-to-speech matches a realtime conversational voice model.

## Defer larger expansion

Realtime speech-to-speech, persistent personal memory, autonomous agents, integrations, and routines are separate product decisions. First identify a specific workflow Morgan should improve. Do not assume existing Codex subscription authentication covers a new speech API, or introduce paid providers without an explicit decision.

For current HeyClicky comparison evidence, see its published changelog at https://www.heyclicky.com/changelog and pricing at https://www.heyclicky.com/. Those are vendor claims, not measured parity results for Morgan.
