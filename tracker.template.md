# `{{PROJECT_NAME}}` — Spec-Kit Tracker

> **Last Updated:** `{{DATE}}`
> **Legend:** ⬜ Pending · 🔄 In Progress · ✅ Done · ⏭️ Skipped · 🔁 Superseded
> **Progress:** Spec-Kit steps complete (`0–9` per feature, adjusted by Size Profile `S / M / L`)

---

## Master Spec Tracker

| Order | ID | Feature | Profile | Priority | Est | Status | Progress | Playbook |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- | :---: | :--- |
| 1 | `FEAT-001` | `{{Example feature}}` | `M` | `P1` | `6 h` | ⬜ Pending | `0/10` | `[feat-001-example.md](./playbooks/feat-001-example.md)` |

---

## Workspace & External Dependency Notes

- **Workspace Layout:** Reference [project-context.md](./project-context.md) for repo paths, stack, and binding quality gates.
- **Trunk Discipline:** Run Steps `0–7` in local scratch if waiting on an upstream PR; cut the Step 8 implementation branch only from an up-to-date `main` (see [guides/git-and-pr-techniques.md](./guides/git-and-pr-techniques.md)).
- **External Blockers / Cutovers:**
  - *(Record upstream backend dependencies, pending PRs, or migration gates here.)*

---

## Per-Spec Step Trackers

### `{{TICKET_ID}}` — `{{FEATURE_TITLE}}` (`Profile M`)

| Step | Workflow | Status | Completed | Notes |
| :---: | :--- | :--- | :--- | :--- |
| `0` | Pre-Spec Audit *(+ Graphify if L)* | ⬜ Pending | — | |
| `1` | `/speckit-constitution` | ⬜ Pending | — | |
| `2` | `/speckit-specify` | ⬜ Pending | — | |
| `3` | `/speckit-clarify` *(+ EGM if L)* | ⬜ Pending | — | |
| `4` | `/speckit-checklist` | ⬜ Pending | — | |
| `5` | `/speckit-plan` *(+ Archify if needed)* | ⬜ Pending | — | |
| `6` | `/speckit-tasks` | ⬜ Pending | — | |
| `7` | `/speckit-analyze` | ⬜ Pending | — | |
| `8` | `/speckit-implement` *(+ Floorplan if M/L)* | ⬜ Pending | — | |
| `9` | `/speckit-converge` *(+ PR Summary)* | ⬜ Pending | — | |

> **Session Summary (`YYYY-MM-DD`):** *(Append 1–3 lines here at the end of each work session recording exact commit SHA, gate results, and next action.)*
