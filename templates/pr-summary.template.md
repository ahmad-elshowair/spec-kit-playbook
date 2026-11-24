## Summary

{{One-to-three-sentence summary of what this PR changes and why.}}

- **Product / Repo:** `{{PROJECT_NAME}}`
- **Ticket / Spec:** `{{TICKET_ID}}` (`{{SPEC_DIR}}`)
- **Size Profile:** `{{PROFILE}}` *(S / M / L)*

## Changes

- {{Concise bullet summarizing change 1}}
- {{Concise bullet summarizing change 2}}
- {{Concise bullet summarizing change 3}}

## Verification & Evidence

> Keep verification layers strictly separated and report exact observed denominators on the final commit SHA.

- **Commit SHA tested:** `<git-rev-parse-short-sha>`
- **Source / Static Checks:**
  - `{{CHECK_CMD}}` → *(pass/fail + summary)*
  - `{{FORMAT_CMD}}` → *(pass/fail)*
  - `{{BUILD_CMD}}` → *(pass/fail)*
- **Local Deterministic Tests:**
  - Unit / Integration (`{{UNIT_TEST_CMD}}`) → *(`X/Y` passing)*
  - E2E / Accessibility (`{{E2E_CMD}}`) → *(`X/Y` passing across configured browsers/viewports)*
- **CI:** *(pending / green link — do not mark green until observed)*
- **Staging / Preview:** *(tested URL & journey, or `Not run — local only`)*
- **Acceptance:** *(criteria AC-1..AC-N verified)*

**Not verified:**
- {{Explicitly list anything not checked — e.g., production deploy, third-party live webhook, Safari WebKit, or staging acceptance post-merge.}}

## Deployment, Data & Rollback Notes

- **Migrations / Schema changes:** {{None | describe reversible migration steps}}
- **Env vars / Config:** {{None | list new keys without secret values}}
- **Telemetry / Data lifecycle:** {{None | describe events, retention, or storage cleanup}}
- **Rollback plan:** {{e.g., Revert PR commit; no destructive schema changes.}}

## Checklist

- [ ] The change works as described and matches `{{SPEC_DIR}}/spec.md`.
- [ ] All required static checks, tests, and builds pass on the final commit SHA (zero weakened or deleted tests).
- [ ] Documentation, contracts, and types reflect the implemented behavior.
- [ ] No secrets, `.env` values, credentials, or personal scratch files (`.specify/`, `specs/`, `playbooks/`) are included in the diff.
- [ ] Server-side authorization, input validation, accessibility (`375px` + keyboard), and failure/retry paths are verified.
- [ ] Required review / approval bar is satisfied (Team mode: reviewer approval; Solo mode: cross-family Step 9 audit complete).
