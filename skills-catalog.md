# Two-Layer Skills Catalog

> **Golden Budget Rule:** Default budget is **≤ 3 heavy domain skills per step or Step 8 phase**, governed by the **3-Question Skill Admission Filter** below. Injecting 8–10 skills into every turn wastes system tokens and dilutes focus.

Split skills into **Layer 1 (Universal Core)** used across all projects and **Layer 2 (App-Type Packs)** toggled on once in `project-context.md` and attached **only** to the phase that touches that layer.

---

## The 3-Question Skill Admission Filter (`Policy WHAT` vs. `Playbook HOW`)

Treat `constitution.md` as **Layer 0** (always-on policy — **WHAT** must hold). Before adding any skill to a step or Step 8 phase, add it **if and only if**:

1. **Not enforced by Constitution or deterministic CI** (`tsc`, `eslint`, `vitest`, `axe`, `prettier`) — skip skills that only repeat an existing invariant.
2. **Not overlapping another loaded skill** in that step or phase — pick one reviewer or design skill, never stack duplicates.
3. **Needed for deep procedural `HOW` or framework-specific patterns in *this exact phase*** — e.g., Article IV mandates WCAG 2.1 AA (**WHAT**), so skip `accessibility` in Step 6 (`Tasks`), but load it in Step 8 UI (**HOW**).

> **Soft Guardrail Note:** Default to `≤ 3` heavy domain skills per step/phase. Loading `4` is fine when every skill is strictly orthogonal (and tiny ~40-line style/commit skills like `caveman-commit` barely count); needing `5+` is a Single-Responsibility signal to **split the phase** rather than stuff the prompt.

---

## Layer 1 — Universal Core Skills (Every Project, `≤ 2–3` per Step)

| Step | Core Skills | Purpose |
| :--- | :--- | :--- |
| **0. Pre-Spec Audit** | `caveman-explore` *(+ `graphify` on large/unfamiliar repos)* | Compressed `file:line` exploration without context bloat |
| **1. Constitution** | `best-practices` | Baseline security, compatibility, and code quality invariants |
| **2. Specify** | `domain-modeling` *(optional — complex domain terms only)* | Sharpens glossary, boundaries, and ubiquitous language |
| **3. Clarify** | `grilling` *(optional — vague requirements only)* | Forces hard trade-off and edge-case questions early |
| **4. Checklist** | *(None — keep prompt lean)* | Pure conversion of locked FR/SC + Constitution |
| **5. Plan** | `codebase-design`, `ponytail` *(+ `safe-refactor` or `migration` when applicable)* | Deep modules, smallest complete change, reversible transitions |
| **6. Tasks** | *(None — keep prompt lean)* | Pure dependency-ordered task slicing |
| **7. Analyze** | `spec-review-best-practices`, `caveman-review` | Concise 1-line findings per parity or structure gap |
| **8. Implement** | `tdd` *(or `surgical-patch` for small bugs)*, `ponytail`, `caveman-commit` | Test-first, minimal diff, clean Conventional Commits |
| **9. Converge** | `speckit-code-review` *(or `ponytail-review`)*, `verify-and-stop`, `pr` | Diff audit + fresh gate proof + structured PR body |

---

## Layer 2 — App-Type Skill Packs (Toggled Per Project in `project-context.md`)

Only enable packs that match your project's actual stack, and attach each skill **only to its matching Step / Step 8 phase**.

| App Requirement | Skill Pack | Attach Only To... |
| :--- | :--- | :--- |
| **Web Frontend / UI** *(React, Vite, Next.js)* | `accessibility`, `frontend-design` *(or `design-taste-frontend` / `polish` / `harden`)*, `core-web-vitals`, `web-design-guidelines`, plus stack match (`vercel-react-best-practices`, `vercel-composition-patterns`, `tailwind-design-system`, `mui`, `shadcn`) | Step 2 (UX/a11y criteria), Step 8 **UI phase**, Step 9 UI review |
| **Backend / API / Database** *(Node, Express, Postgres)* | `nodejs-backend-patterns`, `error-handling-patterns`, `typescript-advanced-types`, `database-migration`, `neon-postgres`, `neon-postgres-egress-optimizer` *(or `supabase` / `supabase-postgres-best-practices`)* | Step 5 (API/DB plan), Step 8 **Backend/DB phase** |
| **Auth & Security** *(Login, RBAC, 2FA, Cookies)* | `security-audit`, `better-auth-best-practices`, `better-auth-security-best-practices`, `email-and-password-best-practices`, `organization-best-practices`, `two-factor-authentication-best-practices` | Step 1/5 (security invariants), Step 8 **Auth phase**, Step 9 security audit |
| **E2E / Browser QA & Debugging** *(Playwright, DevTools)* | `webapp-testing`, `chrome-devtools`, `a11y-debugging`, `cookie-debugging`, `diagnosing-bugs`, `investigate-first` | Step 8 **Testing/QA phase**, bugfix investigations |
| **Cloud / CI / AI Features** *(Optional)* | `github-actions-templates`, `vercel-cli`, `deployments-cicd`, `env-vars`, `vercel-functions`, `ai-sdk`, `ai-gateway`, `mcp-builder`, `gemini-api-dev` | Only on repos deploying to Vercel, configuring GH Actions, or building AI/MCP features |

---

## Step 8 Phase-Splitting Example (Keeping `≤ 3` Skills/Turn)

Instead of loading 10 skills for all of Step 8, split implementation into separate phase sessions:

| Step 8 Phase | Active Skills (`≤ 3`) | Focus |
| :--- | :--- | :--- |
| **Phase A — DB / API** | `tdd`, `nodejs-backend-patterns`, `caveman-commit` | Schema, validation, endpoints, unit/integration tests |
| **Phase B — Frontend UI** | `accessibility`, `mui` *(or `tailwind-design-system`)*, `ponytail` | Components, state, responsive + keyboard polish |
| **Phase C — E2E & QA** | `webapp-testing`, `a11y-debugging`, `verify-and-stop` | Playwright journeys, axe checks, regression proof |

---

## Two Generic App Configuration Examples

### Example A — Classic Full-Stack App (`React + MUI + Express + Postgres + Custom JWT + Playwright`)
- **Enable in `project-context.md`:**
  - Web UI: `accessibility`, `mui`
  - Backend/DB: `nodejs-backend-patterns`, `database-migration`, `error-handling-patterns`
  - Security: `security-audit`
  - Testing: `webapp-testing`, `a11y-debugging`
- **Skip completely:** `better-auth-*`, `neon-postgres`, `tailwind-design-system`, `shadcn`, `vercel-*`.

### Example B — Modern Serverless SaaS (`Next.js + Tailwind + shadcn + Better Auth + Neon + Vercel`)
- **Enable in `project-context.md`:**
  - Web UI: `vercel-react-best-practices`, `tailwind-design-system`, `shadcn`, `accessibility`
  - Auth: `better-auth-best-practices`, `better-auth-security-best-practices`
  - Backend/DB: `neon-postgres`, `neon-postgres-egress-optimizer`
  - Cloud: `vercel-cli`, `deployments-cicd`
- **Skip completely:** `mui`, `nodejs-backend-patterns`, `supabase`.
