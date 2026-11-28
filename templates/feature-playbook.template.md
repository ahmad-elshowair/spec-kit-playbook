# `{{TICKET_ID}}` — `{{FEATURE_TITLE}}`

- **Project:** `{{PROJECT_NAME}}` (see [project-context.md]({{PROJECT_CONTEXT_PATH}}))
- **Ticket / Feature ID:** `{{TICKET_ID}}`
- **Size Profile:** `{{PROFILE}}` *(S = Fast Track | M = Full-Stack Standard | L = Greenfield / High-Risk)*
- **Branch Name:** `{{BRANCH_NAME}}`
- **Spec Directory:** `{{SPEC_DIR}}/`
- **Created:** `{{DATE}}`
- **Active Plug-in Gates:** `{{ACTIVE_PLUGINS}}`
- **Prerequisites / Scope Warnings:** *(Note any upstream PRs, frozen API contracts, or external blockers before cutting the Step 8 branch.)*

---

## 1. Artifact Map & AI Execution Matrix

> **Rules:**
> 1. Open a **fresh chat session** wherever `New Chat?` is **Yes** — disk artifacts (`spec.md`, `plan.md`, `tasks.md`) are your compressed memory.
> 2. Look up concrete tools, models, and effort levels by Role in [ai-roster.md](../ai-roster.md).
> 3. **Reviewer Rule:** Items inside `checklists/` are reviewer-owned (`[ ]` / `[x]`); no generation step toggles them.

| Step | Roster Role | New Chat? | Plug-in | Output | Status |
| :---: | :--- | :---: | :--- | :--- | :--- |
| `0` | `T4 / Long-Context` | **Yes** | Graphify *(if L)* | `Evidence Base` (`E1–En` below) | {{STEP0_STATUS}} |
| `1` | `T1 (New) / T4 (Patch)` | **Yes** | — | `.specify/memory/constitution.md` | {{STEP1_STATUS}} |
| `2` | `T1 (Author)` | **Yes** | — | `{{SPEC_DIR}}/spec.md` | {{STEP2_STATUS}} |
| `3` | `T2 (Auditor ≠ Step 2)` | **Yes** | EGM *(if L)* | `## Clarifications` in `spec.md` | {{STEP3_STATUS}} |
| `4` | `T4 (Clerk)` | **Yes** | — | `{{SPEC_DIR}}/checklists/` | {{STEP4_STATUS}} |
| `5` | `T1 (Architect)` | **Yes** | Archify *(if schema/auth)* | `{{SPEC_DIR}}/plan.md` (+ `research.md`) | {{STEP5_STATUS}} |
| `6` | `T4 (Clerk)` | **Yes** | — | `{{SPEC_DIR}}/tasks.md` | {{STEP6_STATUS}} |
| `7` | `T2 (Auditor ≠ Step 5)` | **Yes** | — | Parity audit (may amend plan/tasks) | {{STEP7_STATUS}} |
| `8` | `T3 (Builder) + T1 Rescue` | **Yes / Phase** | Floorplan *(if M/L)* | Branch `{{BRANCH_NAME}}` + `tasks.md` | {{STEP8_STATUS}} |
| `9` | `T2 (Reviewer ≠ Step 8) + T4 Docs` | **Yes** | Floorplan / Archify | PR summary + tracker `Done` | {{STEP9_STATUS}} |

---

## 2. Verified Evidence Base (`E1–En`)

> Populate during **Step 0** using exact `file:line` citations. Never invent requirements or unverified file paths.

- **`E1` — Entrypoints & Existing Behavior:** `<path/to/file>:<line>` — *(summary)*
- **`E2` — Data / API Contract:** `<path/to/contract>:<line>` — *(summary)*
- **`E3` — Security / Auth & Validation Boundaries:** `<path/to/auth>:<line>` — *(summary)*
- **`E4` — Test Harness & Fixtures:** `<path/to/tests>:<line>` — *(summary)*

---

## 3. Active Skills Plan (3-Question Admission Filter)

> Governed by the **3-Question Skill Admission Filter** (`Policy WHAT` vs. `Playbook HOW`) in [skills-catalog.md](../skills-catalog.md) — default `≤ 3` heavy domain skills per step/phase (`4` only if strictly orthogonal; `5+` = split the phase). Copy active Layer 2 skills from [project-context.md]({{PROJECT_CONTEXT_PATH}}) here before running prompts.

- **Step 0 (Audit):** `caveman-explore` *(+ `graphify` if Profile L)*
- **Step 1 (Constitution):** `best-practices`
- **Step 2 (Specify):** `domain-modeling` *(optional)* + *(≤ 2 UI/UX skills from Layer 2 if applicable)*
- **Step 3 (Clarify):** `grilling` *(optional)*
- **Step 5 (Plan):** `codebase-design`, `ponytail` *(+ 1 Backend/Auth/Migration skill if applicable)*
- **Step 7 (Analyze):** `spec-review-best-practices`, `caveman-review`
- **Step 8 — Phase A (Backend / DB):** `tdd`, `ponytail`, `caveman-commit` *(swap in `nodejs-backend-patterns` / `security-audit` per phase focus, staying within the filter)*
- **Step 8 — Phase B (Frontend / UI):** `accessibility`, `ponytail`, `<ui-stack-skill>`
- **Step 8 — Phase C (E2E / QA):** `webapp-testing`, `a11y-debugging`, `verify-and-stop`
- **Step 9 (Converge):** `speckit-code-review`, `verify-and-stop`, `pr`

---

## Step 0: Pre-Spec Audit *(Evidence Base)*

> **Roster:** `T4 / Long-Context` (see [ai-roster.md](../ai-roster.md)) · **Plug-in:** Graphify if Profile `L` · **New Chat:** Yes

```prompt
Read {{PROJECT_CONTEXT_PATH}} and inspect the codebase for {{TICKET_ID}} ({{FEATURE_TITLE}}).

Invoke skills (3-Question Admission Filter):
$caveman-explore

Produce a Verified Evidence Base (E1–En) with exact file:line citations only:
1. Entrypoints, components, routes, and state stores touched by {{FEATURE_TITLE}}.
2. Existing contracts, schemas, validation rules, and error/retry paths.
3. Existing unit/integration/E2E test fixtures and quality gate commands.
4. Any scope fences, frozen contracts, or external dependencies to respect.
Do not edit application code.
```

**Compliance Check:** Every claim cites an observed `file:line`; zero edits to app code.

---

## Step 1: `/speckit-constitution`

> **Roster:** `T1 (New repo)` or `T4 (Verify/Patch)` (see [ai-roster.md](../ai-roster.md)) · **New Chat:** Yes

```prompt
/speckit-constitution

Read {{PROJECT_CONTEXT_PATH}} and inspect our existing constitution (or starter in templates/constitution.starter.md).

Invoke skills (3-Question Admission Filter):
$best-practices

For {{TICKET_ID}} ({{FEATURE_TITLE}}):
1. Verify all Articles I–VII remain valid with stable Roman numerals and zero structural drift.
2. Confirm Technology Stack and Quality Gates match {{PROJECT_CONTEXT_PATH}}.
3. Propose a PATCH only if wording needs sync — apply edits ONLY after explicit user approval.
```

**Compliance Check:** Articles I–VII intact; no unapproved edits; unrelated files untouched.

---

## Step 2: `/speckit-specify`

> **Roster:** `T1 (Author)` (see [ai-roster.md](../ai-roster.md)) · **New Chat:** Yes

```prompt
/speckit-specify

Read {{PROJECT_CONTEXT_PATH}} and the Evidence Base (E1–En) in this playbook.
Target spec directory: {{SPEC_DIR}}/

Invoke skills (3-Question Admission Filter):
$domain-modeling

Specify {{TICKET_ID}} — {{FEATURE_TITLE}}:
1. Write crisp user stories, testable Functional Requirements (FR-1..N), and measurable Success Criteria (SC-1..N).
2. Explicitly define Out-of-Scope fences and edge-case/error behaviors grounded in E1–En.
3. Include accessibility (WCAG 2.1 AA, 375px floor, keyboard) and security/privacy requirements from the constitution.
```

**Compliance Check:** Spec contains zero implementation guesswork; out-of-scope boundaries explicit; FR/SC testable.

---

## Step 3: `/speckit-clarify`

> **Roster:** `T2 (Auditor — opposite family from Step 2)` (see [ai-roster.md](../ai-roster.md)) · **Plug-in:** EGM if Profile `L` · **New Chat:** Yes

```prompt
/speckit-clarify

Read {{PROJECT_CONTEXT_PATH}} and {{SPEC_DIR}}/spec.md.

Invoke skills (3-Question Admission Filter):
$grilling

Audit {{SPEC_DIR}}/spec.md with fresh eyes (Author ≠ Auditor):
1. Surface ambiguous requirements, missing failure/retry states, authorization gaps, and data-lifecycle edge cases.
2. Ask up to 5 high-leverage clarification questions with recommended answers.
3. Record settled answers into `## Clarifications` inside {{SPEC_DIR}}/spec.md.
```

**Compliance Check:** High-risk ambiguities resolved before planning; `## Clarifications` persisted in `spec.md`.

---

## Step 4: `/speckit-checklist`

> **Roster:** `T4 (Clerk)` (see [ai-roster.md](../ai-roster.md)) · **New Chat:** Yes

```prompt
/speckit-checklist

Read {{PROJECT_CONTEXT_PATH}}, our constitution, and {{SPEC_DIR}}/spec.md.
Generate binary `[ ]` reviewer verification gates inside {{SPEC_DIR}}/checklists/ covering functional behavior, edge cases, security/authz, accessibility, and documentation parity.
```

**Compliance Check:** Checklist items are binary and testable; reviewer-owned `[ ]` markers left unchecked.

---

## Step 5: `/speckit-plan`

> **Roster:** `T1 (Architect)` (see [ai-roster.md](../ai-roster.md)) · **Plug-in:** Archify if schema/auth changes · **New Chat:** Yes

```prompt
/speckit-plan

Read {{PROJECT_CONTEXT_PATH}}, our constitution, and {{SPEC_DIR}}/spec.md.

Invoke skills (3-Question Admission Filter):
$codebase-design
$ponytail

Produce {{SPEC_DIR}}/plan.md (and research.md if needed):
1. Design the smallest complete architecture reusing existing repo helpers, contracts, and patterns.
2. Define exact file seams, API/DB contracts, error handling, and test strategy (unit + integration + E2E).
3. Break execution into verification-gated phases with explicit acceptance checks before advancing.
```

**Compliance Check:** Plan avoids overbuilding/duplication; contract parity explicit; phase gates match `project-context.md`.

---

## Step 6: `/speckit-tasks`

> **Roster:** `T4 (Clerk)` (see [ai-roster.md](../ai-roster.md)) · **New Chat:** Yes

```prompt
/speckit-tasks

Read {{SPEC_DIR}}/spec.md and {{SPEC_DIR}}/plan.md.
Generate a dependency-ordered {{SPEC_DIR}}/tasks.md with numbered tasks (`T001–T0NN`) grouped into the phases from plan.md, noting exact target files and deterministic verification commands per phase.
```

**Compliance Check:** Every `T00X` maps cleanly to `plan.md` phases and `FR`/`SC` requirements.

---

## Step 7: `/speckit-analyze`

> **Roster:** `T2 (Auditor — opposite family from Step 5)` (see [ai-roster.md](../ai-roster.md)) · **New Chat:** Yes

```prompt
/speckit-analyze

Read {{PROJECT_CONTEXT_PATH}}, {{SPEC_DIR}}/spec.md, {{SPEC_DIR}}/plan.md, {{SPEC_DIR}}/tasks.md, and {{SPEC_DIR}}/checklists/.

Invoke skills (3-Question Admission Filter):
$spec-review-best-practices
$caveman-review

Perform a cross-artifact parity audit:
1. Verify 100% FR/SC/Constitution coverage across spec ↔ plan ↔ tasks ↔ checklists (zero orphan requirements).
2. Hunt for contract mismatches, security/a11y omissions, or over-engineered layers.
3. Report crisp 1-line findings by severity and apply approved amendments to plan.md / tasks.md before coding.
```

**Compliance Check:** Zero `CRITICAL`/`HIGH` parity gaps remain before branching for Step 8.

---

## Step 8: `/speckit-implement` *(Phased + Gated)*

> **Roster** (see [ai-roster.md](../ai-roster.md)):
> - `T3 Builder — Core/API/DB/E2E`
> - `T3 Builder — Multi-file UI/Refactor`
> - `T3/T4 — Unit tests & lint`
> - `T1 Rescue — 2-Strike Escalation (1 turn only)`
> - **New Chat:** Yes, **one fresh session per phase**

```prompt
/speckit-implement

Read {{PROJECT_CONTEXT_PATH}}, {{SPEC_DIR}}/plan.md, and {{SPEC_DIR}}/tasks.md.
Execute ONLY Phase <N> (`T00X–T00Y`) from `{{SPEC_DIR}}/tasks.md` on branch `{{BRANCH_NAME}}` (cut from an up-to-date `main`).

Invoke skills for THIS phase ONLY (3-Question Admission Filter):
$<phase-skill-1>
$<phase-skill-2>
$caveman-commit

Rules:
1. Follow TDD / minimal diff; preserve existing helpers and unrelated comments.
2. Run ALL binding quality gates from {{PROJECT_CONTEXT_PATH}} after completing the phase.
3. 2-Strike Escalation: if the same bug or test fails twice, STOP looping and hand exact error + diff to your T1 Rescue model (see ai-roster.md) for 1 diagnostic turn.
4. On GREEN: mark `T00X–T00Y` complete in tasks.md, propose one concise Conventional Commit message (`<type>(<scope>): <summary>` referencing `T00X–T00Y` and `{{TICKET_ID}}`), and STOP for approval before committing.
```

**Compliance Check:**
- All deterministic gates green at every phase boundary; zero weakened/deleted tests.
- If Profile `M` or `L`, run **Floorplan** `refresh.mjs` + Health Check after UI + API phases land.
- `.specify/`, `specs/`, and `playbooks/` remain outside the target app PR.

---

## Step 9: `/speckit-converge`

> **Roster** (see [ai-roster.md](../ai-roster.md)):
> - `T2 (Reviewer — opposite family from Step 8)` for Diff & Security Review (`Author ≠ Reviewer`)
> - `T4 (Gates, Tracker & Docs)` for final gate run, tracker sync, and PR summary
> - **New Chat:** Yes

```prompt
/speckit-converge

Read {{PROJECT_CONTEXT_PATH}}, {{SPEC_DIR}}/tasks.md, {{SPEC_DIR}}/checklists/, and templates/pr-summary.template.md.

Invoke skills (3-Question Admission Filter):
$speckit-code-review
$verify-and-stop
$pr

Converge {{SPEC_DIR}}/:
1. Audit the full branch diff (`git diff main...HEAD`) for correctness, security, accessibility, minimal scope, and constitution compliance.
2. Re-execute every binding quality gate and checklist verification fresh on the exact final commit SHA (record exact denominators).
3. Update tracker.md and this playbook's Artifact Map, Session Log, and Telemetry Log.
4. Draft the final PR summary using templates/pr-summary.template.md, separating SOURCE / LOCAL / CI / STAGING / ACCEPTANCE and listing anything Not Verified honestly.
```

**Compliance Check:** All checklist items re-verified on exact final commit SHA; PR summary strictly honest; tracker updated.

---

## Journal

### Decisions
- `{{DATE}}` — Initialized `{{TICKET_ID}}` (`Profile {{PROFILE}}`) from `feature-playbook.template.md`.

### Session Log
- `{{DATE}}` — Playbook generated (`{{BRANCH_NAME}}`).

### Cost & Rework Telemetry Log

> Track across 3–5 features, then inspect in [guides/token-hygiene.md](../guides/token-hygiene.md) to tune `ai-roster.md`.

| Step | Tool / Model Used | Effort | Turns / Notes | Rework Needed? |
| :---: | :--- | :--- | :--- | :--- |
| `0` | | | | |
| `1` | | | | |
| `2` | | | | |
| `3` | | | | |
| `4` | | | | |
| `5` | | | | |
| `6` | | | | |
| `7` | | | | |
| `8` | | | | |
| `9` | | | | |

### Open Questions
- *(Record unresolved questions for Step 3 `/speckit-clarify` here.)*

### Next Action
Start **Step 0** (or **Step 2** if `Profile S`) in a fresh chat session using the prompt above.
