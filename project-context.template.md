# Project Context — `{{PROJECT_NAME}}`

> **Single Source of Truth:** Copy this file to `project-context.md` once per project. All Spec-Kit prompts reference this file instead of repeating stack, paths, and quality gates in every prompt.

---

## 1. Project Identity

- **Project Name:** `{{PROJECT_NAME}}`
- **Mode:** `{{PROJECT_MODE}}` *(Solo Portfolio | Team Repository)*
- **Role / Lane:** `{{ROLE}}` *(e.g., Full-Stack Engineer | Frontend Lead | Solo Builder)*
- **Default Size Profile:** `{{DEFAULT_PROFILE}}` *(S | M | L)*

---

## 2. Workspace & Boundary Paths

- **Application Repo Path:** `{{APP_REPO_PATH}}` *(e.g., `../my-app`)*
- **Spec-Kit Root (`.specify/` & `specs/`):** `{{SPECKIT_ROOT_PATH}}` *(recommended: sibling root outside app repo, or `.git/info/exclude` inside repo)*
- **Playbooks Path:** `{{PLAYBOOKS_PATH}}` *(e.g., `./playbooks`)*
- **Boundary Rule:** Never copy `.specify/`, `specs/`, `playbooks/`, `floorplan/`, `graphify-out/`, or `.archify/` into tracked app PRs.

---

## 3. Technology Stack

- **Frontend:** `{{FRONTEND_STACK}}` *(e.g., React 19 + TypeScript + Vite)*
- **Styling / UI Kit:** `{{UI_STACK}}` *(e.g., Tailwind CSS + shadcn/ui | MUI)*
- **Backend / Runtime:** `{{BACKEND_STACK}}` *(e.g., Express / Hono / Next.js API)*
- **Database / Storage:** `{{DATABASE_STACK}}` *(e.g., PostgreSQL / Neon / SQLite / R2)*
- **Auth:** `{{AUTH_STACK}}` *(e.g., Better Auth | Custom JWT + HttpOnly Cookies | Clerk)*
- **Language Strictness:** `{{LANGUAGE_STRICTNESS}}` *(e.g., TypeScript strict mode)*

---

## 4. Binding Quality Gates (Deterministic Checks)

Replace with exact repo scripts run at every Step 8 phase boundary and in Step 9:

- **Static / Integrity Check:** `{{CHECK_CMD}}` *(e.g., `pnpm typecheck && pnpm lint`)*
- **Format Check:** `{{FORMAT_CMD}}` *(e.g., `pnpm format:check`)*
- **Unit / Integration Tests:** `{{UNIT_TEST_CMD}}` *(e.g., `pnpm test`)*
- **End-to-End Tests:** `{{E2E_CMD}}` *(e.g., `pnpm test:e2e`)*
- **Production Build:** `{{BUILD_CMD}}` *(e.g., `pnpm build`)*

---

## 5. Constitution Reference

- **Path:** `{{CONSTITUTION_PATH}}` *(e.g., `.specify/memory/constitution.md`)*
- **Current Version:** `{{CONSTITUTION_VERSION}}` *(e.g., `1.0.0`)*
- **Core Articles:** `{{CONSTITUTION_ARTICLES}}` *(e.g., `Articles I–VII`)*

---

## 6. Active Layer 2 Skill Packs (Check Only What This App Uses)

> Reference [skills-catalog.md](./skills-catalog.md). Keep **`≤ 3` skills total per step or Step 8 phase**.

- **Web Frontend / UI *(Steps 2, 8-UI, 9)*:**
  - [ ] `accessibility`
  - [ ] `frontend-design` / `design-taste-frontend` / `polish` / `harden`
  - [ ] `core-web-vitals` / `web-design-guidelines`
  - [ ] Stack pack: `{{UI_STACK_SKILLS}}` *(e.g., `mui` or `tailwind-design-system` + `shadcn` + `vercel-react-best-practices`)*
- **Backend / API / DB *(Steps 5, 8-Backend)*:**
  - [ ] `nodejs-backend-patterns`
  - [ ] `error-handling-patterns`
  - [ ] `typescript-advanced-types`
  - [ ] `database-migration`
  - [ ] DB host pack: `{{DB_HOST_SKILLS}}` *(e.g., `neon-postgres`, `neon-postgres-egress-optimizer`)*
- **Auth & Security *(Steps 1, 5, 8-Auth, 9)*:**
  - [ ] `security-audit`
  - [ ] Better Auth pack: `better-auth-best-practices`, `better-auth-security-best-practices`, `email-and-password-best-practices`, `organization-best-practices`, `two-factor-authentication-best-practices`
- **E2E / Browser QA & Debugging *(Step 8-QA, bugfixes)*:**
  - [ ] `webapp-testing`
  - [ ] `chrome-devtools` / `a11y-debugging` / `cookie-debugging`
  - [ ] `diagnosing-bugs` / `investigate-first`
- **Cloud / CI / AI Features *(Optional)*:**
  - [ ] `github-actions-templates`
  - [ ] Vercel pack: `vercel-cli`, `deployments-cicd`, `env-vars`, `vercel-functions`
  - [ ] AI / MCP pack: `ai-sdk`, `ai-gateway`, `mcp-builder`, `gemini-api-dev`

---

## 7. Active Tool Plug-in Gates (Defaults by Profile)

- [ ] **Graphify** *(Step 0 — Profile `L` or unfamiliar/large repos)*
- [ ] **EGM** *(Pre-Step 5 — Profile `L` greenfield or high-risk specs)*
- [ ] **Floorplan** *(Steps 8 & 9 — Profile `M` / `L` full-stack web apps)*
- [ ] **Archify** *(Steps 5 & 9 — ERDs, auth sequences, PR/portfolio diagrams)*

---

## 8. Local `ai-roster.md` Overrides *(Optional)*

Leave blank to use [ai-roster.md](./ai-roster.md) defaults verbatim, or list project-specific swaps:

- *(Example: `Step 8 UI → Gemini 4 Argon (High)` or `Step 1 → Skip (constitution already v1.0.0)`)*
