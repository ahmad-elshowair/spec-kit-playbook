# Tools Playbook — Conditional Plug-in Gates

> **Core Rule:** **Spec-Kit + AI Roster** is the mandatory spine on every feature. **Graphify**, **EGM**, **Floorplan**, and **Archify** are **conditional plug-in gates** — never run all four on a small ticket.

---

## 1. Core Spine + 4 Plug-in Matrix

| Tool | Core Niche | Spec-Kit Attachment | Run When | Skip When | Git Hygiene |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Graphify** | Persistent AST + doc/media knowledge graph (`query` / `path` / `explain`) | **Step 0** *(Pre-Spec Audit)* | Medium/large or unfamiliar repo, or scattered `docs/` + `specs/` (Profile `L`) | Tiny single-purpose repo or already-familiar files (Profile `S`) | Keep `graphify-out/` untracked |
| **EGM** *(Elephant-Goldfish Model)* | Zero-context pre-code design critique (`Blocker / Major / Nit` + doc drift) | **Pre-Step 5** *(after `specify`/`clarify`)* | Greenfield app, major auth/DB overhaul, or stale `docs/` drift (Profile `L`) | Routine feature tickets or small bugfixes (Profile `S`/`M`) | Keep scratch design reviews untracked unless sharing |
| **Floorplan** | Interactive `Screen → HTTP Call → Route → DB` full-stack map + Health Check | **Steps 8 & 9** *(Post-slice + PR prep)* | Full-stack web apps after UI + API slices land (Profile `M`/`L`) | Pure library, CLI, or static docs change (Profile `S`) | Keep `floorplan/` untracked; share via `--export` HTML |
| **Archify** | Browser-verified standalone HTML/SVG/WebM diagrams (10 types: ERD, sequence, architecture) | **Step 5** *(Design)* & **Step 9** *(PR/Docs)* | Designing tricky DB tables/auth flows, or exporting portfolio/README diagrams | Routine CRUD with zero schema/architecture changes | Keep `.archify/` untracked; copy only curated visuals to `docs/diagrams/` |

---

## 2. Tool-by-Tool Triggers & Usage

### A. Graphify (Step 0 — Context Compression)
- **What it solves:** Replaces repetitive grep loops with an AST + knowledge graph (`0` LLM tokens for deterministic AST structure) so Step 0 audits stay small and exact.
- **When to trigger:** Onboarding onto an unfamiliar codebase, or Profile `L` repos where code, `docs/`, and `specs/` are spread across many folders.
- **Typical workflow:**
  1. Generate/update `graphify-out/` from the target codebase root using the `graphify` skill.
  2. Query blast radius (`query`, `path`, `explain`) to populate the **Verified Evidence Base (`E1–En`)** with exact `file:line` citations before running Step 2 (`/speckit-specify`).

### B. EGM — Elephant-Goldfish Model (Pre-Step 5 — Adversarial Design Gate)
- **What it solves:** Structurally enforces the Two-Brain Rule before any code is written — an "Elephant" author builds context while zero-memory "Goldfish" reviewers hunt for `Blocker`, `Major`, and `Nit` flaws plus `docs/` drift.
- **When to trigger:** Profile `L` greenfield architectures, security/auth cutovers, or data-model redesigns.
- **Install reference *(if not already installed locally)*:** `https://github.com/google/elephant-goldfish-model`

### C. Floorplan (Steps 8 & 9 — Full-Stack Wiring + Health Check)
- **What it solves:** Zero-dependency Node.js `scan.mjs` / `build.mjs` / `refresh.mjs` scripts parse imports and match frontend HTTP requests to backend routes, producing an interactive zoomable map (`floorplan/index.html`) with **Screens**, **Recent Work**, and automated **Health Checks** (missing auth checks, permissive CORS, leaked secrets, >1,000-LOC files).
- **When to trigger:** Profile `M` and `L` full-stack features right after UI + API slices land in Step 8, and before opening the Step 9 PR.
- **Key commands:**
  - First scan / incremental refresh via `floorplan` skill (`scan.mjs` → `build.mjs`, or `refresh.mjs` after feature commits).
  - Export a clean, path-scrubbed shareable HTML map:
    ```bash
    node floorplan/serve.mjs --export app-floorplan.html
    ```
- **Optional local install *(Clone + Symlink for Antigravity & ZCode)*:**
  ```bash
  mkdir -p ~/.local/share/agent-tools
  git clone https://github.com/haydenschmitty/floorplan.git ~/.local/share/agent-tools/floorplan
  ln -sfn ~/.local/share/agent-tools/floorplan/skills/floorplan ~/.agents/skills/floorplan
  ln -sfn ~/.local/share/agent-tools/floorplan/skills/floorplan ~/.zcode/skills/floorplan
  ```

### D. Archify (Steps 5 & 9 — Curated Visual Diagrams)
- **What it solves:** Turns code or specs into polished, browser-verified standalone HTML / SVG / WebM diagrams (ERDs, sequence flows, system boundaries) for design alignment and portfolio/PR storytelling.
- **When to trigger:**
  - **Step 5:** Visualizing complex state lifecycles, database ERDs, or auth token/cookie handshakes before writing tasks.
  - **Step 9:** Generating a clean architecture or sequence diagram to attach to a PR or copy into `docs/diagrams/`.
