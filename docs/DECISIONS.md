# Morgan decisions

## Name and repository

Osiris selected Morgan on 11 October 2026 and explicitly requested renaming Clicky Personal, creating a private GitHub repository, and pushing its complete code and documentation. The repository name is `OsirisMedici/morgan`. Osiris subsequently changed the visibility request to public and asked to pin it on his GitHub profile. This later instruction supersedes the initial private-repository request.

The repository begins with a clean current source snapshot. A scan found no credential-pattern matches in current tracked source, but two earlier upstream commits contain credential strings. Those old commits are not pushed. The original full-history clone stays locally for provenance, and the original README, MIT license, and source research preserve attribution.

## Application identity

The visible application name, bundle folder, executable, menu-bar tooltip, window title, spoken introduction, and assistant prompt are Morgan. The internal bundle identifier stays `com.osiris.clickypersonal`, and existing preference keys stay unchanged. This preserves preference continuity without changing HeyClicky's identity. Because local ad-hoc code signatures change when the binary is rebuilt, macOS can still require permission reapproval.

## Authentication and cost

Morgan launches the supported installed Codex CLI and relies on its managed ChatGPT sign-in. It does not read, copy, publish, or bundle the credential. Inherited API-key variables are removed from the child environment to avoid silently switching the billing route. Questions consume the existing Codex plan allowance, so this is not unlimited or cost-free model capacity.

The current process is ephemeral and uses a read-only sandbox. Shell tools, app connectors, plugins, web search, and delegation are disabled. Morgan's current job is explanation and pointing. New action-taking capabilities require a separately designed workflow and user authorization.

## Local speech and data

Mac speech synthesis is local. Apple Speech recognition uses on-device recognition when supported by the selected locale; the framework may otherwise use Apple's service. Screenshots and question text are sent to Codex when screen context is requested. Temporary local request files are removed after completion. Local cleanup does not assert anything about OpenAI's server-side retention policies.

The original email signup and PostHog telemetry are inactive in this build. Conversation memory contains ten text exchanges in RAM and resets when the app quits.

## Separation from HeyClicky

Morgan's files, build output, preferences, and source checkout belong to this project. Preserve `/Applications/HeyClicky.app`; do not replace its app bundle, change its login or subscription, or claim parity with its private feature set.
