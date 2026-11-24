# `{{PROJECT_NAME}}` Constitution

## Core Principles

### I. Process
Every change arrives via a short-lived branch targeting `main` (trunk) through a pull request following the repository's PR template (`templates/pr-summary.template.md`). A task is **Done** only when all automated checks (typecheck, lint, unit/integration/E2E tests, and production build) are green and required reviews/approvals are complete.

### II. Source & Data Integrity
All external and user inputs MUST be validated at trust boundaries, persisted invariants MUST be enforced server-side, and user-supplied content MUST never be silently truncated, corrupted, or discarded without explicit UI feedback.

### III. Security & Privacy
Authorization MUST be enforced server-side on every protected endpoint and action using least privilege. Sensitive secrets, tokens, and private credentials MUST never be committed to source control, exposed to unauthenticated clients, or leaked in logs or error payloads.

### IV. Accessibility & UX
Web interfaces MUST meet WCAG 2.1 AA standards, remain fully usable at a `375px` mobile viewport floor without horizontal overflow, support complete keyboard navigation, pass automated accessibility audits (`axe`) per route, and honor `prefers-reduced-motion`.

### V. Testing & Verification
Core behavior MUST be backed by automated unit, integration, and end-to-end tests running deterministically against local fixtures or test doubles (no live third-party secrets in CI). Tests MUST never be deleted, skipped, or weakened to make a failing change appear green.

### VI. Architecture & Continuity
Follow existing module boundaries, deep-module interfaces, and API contracts as the single source of truth. Keep new dependencies minimal and explicitly justified; coordinate schema, contract, or architectural changes before implementing.

### VII. Senior-Grade Documentation & Code Hygiene
Exported contracts, public utilities, and non-obvious algorithms MUST include standardized JSDoc/docstrings. Inline comments MUST explain engineering intent and trade-offs rather than obvious mechanics and remain short and concise. Documentation MUST be updated synchronously with behavior changes, dead/commented-out code MUST be eliminated, and major section boundaries inside files may use clean sectional banners:
- **TS/JS**: `// ───── LABEL ──────────────────────────────`
- **CSS**: `/* ───── LABEL ────────────────────────────── */`
- **Shell/Python/YAML**: `# ───── LABEL ──────────────────────────────`
- **HTML/Markdown**: `<!-- ───── LABEL ────────────────────────────── -->`
- **SQL**: `-- ───── LABEL ──────────────────────────────`

---

## Technology Stack

Binding project constraints (sourced from `project-context.md`):

- **Frontend:** `{{FRONTEND_STACK}}`
- **Backend / API:** `{{BACKEND_STACK}}`
- **Database / Storage:** `{{DATABASE_STACK}}`
- **Authentication:** `{{AUTH_STACK}}`
- **Language / Strictness:** `{{LANGUAGE_STRICTNESS}}`

---

## Deployment and Quality Gates

- **Per-phase and pre-commit gate:** Every implementation phase MUST pass `{{CHECK_CMD}}`, `{{FORMAT_CMD}}`, `{{UNIT_TEST_CMD}}`, `{{E2E_CMD}}` (for UI/flow changes), and `{{BUILD_CMD}}` before committing via atomic Conventional Commits traceable to task/ticket IDs.
- **CI gates on every PR:** Automated checks MUST pass before merge.
- **Contract parity:** API/schema contract changes update the canonical spec/types synchronously.

---

## Governance

This Constitution supersedes ad-hoc practices across `{{PROJECT_NAME}}`. Future specifications cite articles by their Roman numerals (`I–VII`), which remain stable and are never renumbered.

- **Amendment Procedure:** Proposed changes MUST be drafted as a diff against this file, reviewed for cross-principle conflicts, and ratified with an incremented semantic version before merge.
- **Versioning Policy:** SemVer — **MAJOR** for principle removals or redefinitions, **MINOR** for new principles or materially expanded guidance, **PATCH** for clarifications and wording fixes.
- **Compliance Review:** Every PR and Step 9 convergence pass MUST verify compliance against the applicable articles before merge.

**Version**: `1.0.0` | **Ratified**: `{{DATE}}` | **Last Amended**: `{{DATE}}`
