# Token Hygiene & Cost Control

> Model choice is only half the optimization. These five habits cut another **40–60% of token spend** while reducing rework loops.

---

## 1. Hard Context Resets Between Steps & Step 8 Phases

Never run Steps `1 → 9` inside one giant chat thread. Every new turn re-sends the entire conversation history (quadratic input-token cost) and pollutes attention with stale drafts.

- Your Spec-Kit files on disk (`spec.md`, `plan.md`, `tasks.md`, `project-context.md`) **are** your compressed memory.
- Open a **fresh chat session** at every Spec-Kit step and at every Step 8 implementation phase boundary.

---

## 2. Apply the 3-Question Skill Admission Filter (`Policy WHAT` vs. `Playbook HOW`)

Loading 8–10 skills simultaneously injects thousands of system tokens into every turn of a long coding loop and dilutes instruction focus. Instead of stuffing prompts, admit a skill **if and only if** it passes all three checks in [skills-catalog.md](../skills-catalog.md):

1. Not already enforced by `constitution.md` (`Policy WHAT`) or deterministic CI.
2. Not overlapping another loaded skill in that step/phase.
3. Needed for deep procedural `HOW` or framework-specific patterns in **this exact phase**.

- Default to a soft cap of **`≤ 3` heavy domain skills** per step/phase (`4` is fine when every skill is strictly orthogonal; tiny ~40-line style/commit skills barely count).
- Needing **`5+` skills** in one Step 8 phase is a Single-Responsibility signal to **split the phase** rather than overload one prompt.

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
- Use **`Low` / `Fast`** (`T4 Clerk` in [ai-roster.md](../ai-roster.md)) for mechanical steps (`4 Checklist`, `6 Tasks`, tracker updates).
- **2-Strike Escalation Rule:** If a `T3 Builder` fails the same test or bug twice, stop burning tokens in retry loops — hand the exact failing output + diff to your `T1 Rescue` model in [ai-roster.md](../ai-roster.md) for **1 diagnostic turn**, apply the fix, then drop back down.

---

## 5. Tune From Real Data (Cost & Rework Telemetry Log)

Every feature playbook ends with a **Cost & Rework Telemetry Log** (`Step | Tool / Model Used | Effort | Turns / Notes | Rework Needed?`).

After shipping **3–5 features**, review the log:
- If a `T4` or `T3` model caused rework on a specific step → bump that step's tier or effort in [ai-roster.md](../ai-roster.md).
- If a `High`/`XHigh` step consistently finished in 1 clean turn with zero rework → try stepping effort down one notch to preserve quota.
