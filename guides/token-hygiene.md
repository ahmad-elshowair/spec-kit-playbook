# Token Hygiene & Cost Control

> Model choice is only half the optimization. These five habits cut another **40–60% of token spend** while reducing rework loops.

---

## 1. Hard Context Resets Between Steps & Step 8 Phases

Never run Steps `1 → 9` inside one giant chat thread. Every new turn re-sends the entire conversation history (quadratic input-token cost) and pollutes attention with stale drafts.

- Your Spec-Kit files on disk (`spec.md`, `plan.md`, `tasks.md`, `project-context.md`) **are** your compressed memory.
- Open a **fresh chat session** at every Spec-Kit step and at every Step 8 implementation phase boundary.

---

## 2. Cap Loaded Skills (`≤ 3` per Turn)

Loading 8–10 skills simultaneously injects thousands of system tokens into every turn of a long coding loop and distracts the model.

- Keep **Layer 1 (Universal Core)** lean (`0–3` skills per step).
- Attach **Layer 2 (App-Type Packs)** only to the specific Step 8 phase that touches that layer (see [skills-catalog.md](../skills-catalog.md)).

---

## 3. Shift Checks From LLMs to Deterministic Scripts (`$0`)

Never pay an LLM to verify things deterministic tools catch in seconds for free:

- Formatting, linting, typechecking (`prettier`, `eslint`, `tsc --noEmit`)
- Unit, integration, and E2E suites (`vitest`, `playwright`, `axe`)
- Static AST/endpoint mapping (`Graphify` AST pass, `Floorplan` `scan.mjs` / `build.mjs`)

Run deterministic gates **first**, then paste only concise failing outputs into an AI turn when needed.

---

## 4. Effort Level Discipline & 2-Strike Escalation

- **Reserve `XHigh` / `Max`** for the three highest-leverage moments in [ai-roster.md](../ai-roster.md):
  1. Step 3 (`/speckit-clarify`)
  2. Step 5 (`/speckit-plan`)
  3. Step 8D (`2-Strike Rescue`) and Step 9A (`Security/Auth Diff Review`)
- Use **`Low` / `Fast`** (`Gemini Flash` / `GLM-5.3`) for mechanical steps (`4 Checklist`, `6 Tasks`, tracker updates).
- **2-Strike Escalation Rule:** If a Step 8 builder (`GLM-5.4`/`5.3` or `Orchestrator`) fails the same test or bug twice, stop burning tokens in retry loops — hand the exact failing output + diff to `Claude Opus 5.5 (XHigh/Max)` for **1 diagnostic turn**, apply the fix, then drop back down.

---

## 5. Tune From Real Data (Cost & Rework Telemetry Log)

Every feature playbook ends with a **Cost & Rework Telemetry Log** (`Step | Tool / Model Used | Effort | Turns / Notes | Rework Needed?`).

After shipping **3–5 features**, review the log:
- If a `Low`/`T4` or `T3` model caused rework on a specific step → bump that step's tier or effort in [ai-roster.md](../ai-roster.md).
- If a `High`/`XHigh` step consistently finished in 1 clean turn with zero rework → try stepping effort down one notch to preserve quota.
