# AI Roster — Tool, Model & Effort Map

> **Single Control Panel:** Feature prompts reference **Roles** (`Architect`, `Auditor`, `Builder`, `Clerk`) and look up concrete tools, models, and effort levels here. Upgrading `GLM-5.4 → GLM-5.5` or `Gemini 4 → Gemini 5` is a **1-line edit** in this file.

---

## 1. The 4 Cognitive Tiers

Optimize **total delivery cost** (tokens + rework loops + review time), not raw token price.

| Tier | Role | Cognitive Job | Target Token Share |
| :--- | :--- | :--- | :--- |
| **T1** | **Architect** | High-leverage decisions where one flaw cascades into hundreds of lines of rework | ~10–15% |
| **T2** | **Auditor** | Adversarial critique, edge-case hunting, spec↔plan↔code parity (`Author ≠ Auditor`) | ~10–15% |
| **T3** | **Builder** | Bounded TDD implementation inside an already-locked plan + deterministic gates | ~60–65% |
| **T4** | **Clerk** | Mechanical transforms, checklists, task slicing, doc/tracker sync, large-context scans | ~10–15% |

---

## 2. Where Antigravity `Orchestrator` Fits Best

**`Orchestrator`** runs a two-phase loop inside one session: a strong Planner reads and decides, then hands exact edits/commands to a fast Execution Worker (`Flash`).

- **Use `Orchestrator`** when a step needs **both judgment and multi-file edits/commands**:
  - **Step 1** (verifying and applying an approved PATCH to an existing constitution)
  - **Step 8** (tight multi-file UI/refactor phases built inside Antigravity where Plan-then-Execute safety matters)
  - **Step 9** (running final release gates, fixing small review findings, syncing `tasks.md` and `tracker.md`)
- **Skip `Orchestrator`** when a step is pure reasoning or pure mechanical conversion:
  - Pure design/critique (`Steps 2, 3, 5, 7`) → use a direct flagship model (`High` / `XHigh`) to avoid handoff overhead.
  - Pure structured conversion (`Steps 4, 6`) → use direct `Gemini Flash` (or `GLM-5.3`) for speed and minimal cost.

---

## 3. Master Roster (Steps `0 → 9`)

| Step | Tier | Best Tool | Best Model | Effort Level | Orchestrator / Alternative & Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0. Pre-Spec Audit** | `T4 / Long-Context` | Antigravity | `Gemini 4 Neon / Hydrogen` | **`Medium`** | Use `Gemini Flash (Low)` if **Graphify** already indexed the repo; bump to `High` on messy monorepos. |
| **1. Constitution** | `T1` (new)<br>`T4` (patch) | Antigravity | **New repo:** `Claude Opus 5.5`<br>**Verify & Patch:** `Orchestrator` | **New:** `High`<br>**Patch:** `Default` | `Orchestrator` cleanly verifies and applies approved PATCH edits; use `XHigh` only for strict greenfield compliance rules. |
| **2. Specify** | `T1` *(Author)* | Antigravity | `Claude Opus 5.5` | **`High`** | Bump to `XHigh` for complex multi-role, payment, or security specs. |
| **3. Clarify** | `T2` *(Auditor)* | Antigravity | `Gemini 4 Neon / Hydrogen` | **`XHigh`** | Deliberate family switch (`Claude → Gemini`); add **EGM** on Profile L / greenfield. |
| **4. Checklist** | `T4` *(Clerk)* | Antigravity *(or ZCode)* | `Gemini Flash` *(or `GLM-5.3`)* | **`Low`** | Mechanical conversion of locked FR/SC — never needs `Orchestrator` or `High`. |
| **5. Plan** | `T1` *(Architect)* | Antigravity | `Claude Opus 5.5` *(or `Gemini 4 Neon / Hydrogen` for UI-heavy)* | **`XHigh`** | Bump to **`Max`** only on Profile L greenfield, auth, or DB migrations; `High` for simple Profile S. |
| **6. Tasks** | `T4` *(Clerk)* | Antigravity *(or ZCode)* | `Gemini Flash` *(or `GLM-5.3`)* | **`Low`** | Mechanical slicing of locked `plan.md`. |
| **7. Analyze** | `T2` *(Auditor)* | Antigravity | `Gemini 4 Neon / Hydrogen` *(opposite Step 5 family)* | **`High`** | Cross-artifact parity check (`spec ↔ plan ↔ tasks`); bump to `XHigh` on Profile L / multi-service contracts. |
| **8. Implement** *(split by phase)* | `T3` *(Builder)* + `T1` Rescue | **ZCode** *(offloads quota)*<br>or **Antigravity** | **A. Core/API/DB/E2E (ZCode):** `GLM-5.4`<br>**B. Multi-file UI/Refactor (Agy):** `Orchestrator` *(or `Gemini 4 Argon`)*<br>**C. Unit tests/lint (ZCode):** `GLM-5.3`<br>**D. 2-Strike Rescue (Agy):** `Claude Opus 5.5` | **GLM-5.4:** Thinking on complex, standard on CRUD<br>**Orchestrator:** `Default`<br>**Argon:** `Medium` / `High`<br>**GLM-5.3:** Fast / `Low`<br>**Rescue:** **`XHigh` / `Max`** *(1 turn)* | Use ZCode `GLM-5.4` / `5.3` to protect Antigravity quota; use `Orchestrator` for tight multi-file UI/refactor phases. |
| **9. Converge** | `T2` Review + `T4` Docs | Antigravity | **Diff & Security Review:** `Claude Opus 5.5`<br>**Gates + Docs/Tracker:** `Orchestrator` *(or `Gemini Flash`)* | **Review:** `High` *(`XHigh` for security/auth)*<br>**Docs:** `Low` | Automatically enforces **Author (`ZCode GLM`) ≠ Reviewer (`Antigravity Opus`)**. |

---

## 4. Four Operating Rules

1. **The Two-Brain Rule (`Author ≠ Auditor`):** Never use the same model family to critique a spec, plan, or diff that wrote it (`Claude → Gemini`, `ZCode GLM → Antigravity Opus`). Cross-family review eliminates shared blind spots for zero extra cost.
2. **Reserve `XHigh` / `Max` for 3 Leverage Moments:** Spend top-end reasoning only on **Step 3 (`Clarify`)**, **Step 5 (`Plan`)**, and **Step 8D (`2-Strike Rescue`) / Step 9A (`Security/Auth Review`)**. Never burn `XHigh`/`Max` on checklists, task lists, or tracker updates.
3. **2-Strike Escalation Rule:** If a Step 8 builder fails the same bug or test twice, **stop looping** — hand the exact error + git diff to `Claude Opus 5.5 (XHigh/Max)` for **1 diagnostic turn**, apply the fix, and drop back to your T3 builder.
4. **1-Line Upgrade Rule & Effort Label Note:** Prompts never hardcode model strings; they reference this file. Note how effort levels map across tools:
   - **Antigravity UI:** Uses picker labels such as `(High)` / `(XHigh)` (and `Default` for `Orchestrator`).
   - **Claude / CLI relays:** Support `low` / `medium` / `high` / `xhigh` / `max`.
   - **ZCode:** Controls reasoning/thinking mode directly inside the ZCode app or `~/.zcode/cli/config.json`.
