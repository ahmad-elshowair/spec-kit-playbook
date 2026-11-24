# Git & PR Techniques — Condensed Reference

> Practical recipes for trunk-based development across both solo portfolio repositories and team/client codebases.

---

## 1. Core Mental Models

| Term | What It Actually Is |
| :--- | :--- |
| `commit` | An immutable snapshot on your machine, identified by a unique SHA |
| `branch` | A movable **pointer** to a commit — creating one copies nothing |
| `git fetch` | Downloads remote commits while touching **nothing** in your working tree (silent = success) |
| `git pull` | `fetch` + integrate (`--ff-only` or merge). Fast-forward slides your pointer forward with zero conflicts |
| `origin/main` vs `main` | `origin/main` is the server's branch as of your last `fetch`; `main` is your local copy |
| `rebase` | Replays your branch commits cleanly on top of a newer base commit |

---

## 2. Everyday Read-Only Checks (Always Safe)

```bash
git fetch origin && git log --oneline -5 origin/main   # inspect upstream changes without modifying local files
git status                                              # current branch and dirty files
git log --oneline -8                                    # recent local commit history
git branch -a                                           # all local and remote branches
```

**Merge-landed one-liner** *(did an upstream commit or PR land in `main`?)*:

```bash
git merge-base --is-ancestor <sha> origin/main && echo MERGED || echo NOT YET
```

---

## 3. Trunk-Based Branching & the Stacked-Branch Rule

- **`main` is always trunk:** Do not create long-lived `dev` or `develop` branches. Keep branches short-lived (one branch per ticket/spec).
- **Cut from updated `main`:**
  ```bash
  git switch main
  git pull --ff-only origin main
  git switch -c <ticket-id>-<short-slug> main
  git push -u origin <ticket-id>-<short-slug>
  ```
- **Stacked-branch rule (avoid drift):** If an earlier PR is still waiting on review, run Spec-Kit **Steps `0–7`** locally in scratch/playbooks first, then wait for that PR to merge into `main` before cutting your Step 8 implementation branch.

---

## 4. Syncing After `main` Moves & Squash-Merge Recovery

**Standard rebase (when upstream used merge commits or fast-forward):**

```bash
git switch <ticket-id>-<short-slug>
git fetch origin
git rebase origin/main
git push --force-with-lease        # ONLY after rebasing an already-pushed branch (never bare --force)
```

- `--force-with-lease` fails safely if someone else pushed new commits to your branch remotely.

**Squash-merge rescue (when an earlier stacked branch was squash-merged upstream):**

Rebasing a squash-merged parent branch causes duplicate conflict loops. Instead, cut a fresh branch off `origin/main` and replay only your new commits:

```bash
git fetch origin
git switch -c <ticket-id>-<short-slug>-v2 origin/main
git cherry-pick <sha-1> <sha-2>
```

---

## 5. Commit Hygiene (Aligned with Spec-Kit Step 8 Phases)

- Make **one atomic Conventional Commit per verified Step 8 phase**:
  - Format: `<type>(<scope>): <imperative summary>` (`≤ 50–72` chars, citing `T00X–T00Y` and `<ticket-id>`).
  - Common types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
- Keep commit bodies crisp, technical, and free of AI attribution fluff.
- **Never** use `--no-verify` to bypass pre-commit hooks or failing gates.

---

## 6. PR Workflow (Team Mode vs. Solo Mode)

- **Push ≠ PR:** Pushing uploads your branch; open the PR targeting `main` via GitHub Web UI or `gh pr create`.
- **Use `templates/pr-summary.template.md`:** Keep `Source / Local / CI / Staging / Acceptance` strictly separated and fill **Not verified** honestly.
- **Review feedback stays on the same branch:** Fix, commit, and push to the open branch — never open a second PR for review fixes.
- **Team mode:** Follow repository approval rules (e.g., 1–2 approvals; let the repo lead merge if required).
- **Solo portfolio mode:** Run the Step 9 cross-family AI diff audit + ensure CI checks are green before squash-merging to `main`.

---

## 7. Local-vs-Git Boundary (`.gitignore` vs. `.git/info/exclude`)

| Mechanism | Scope | Use For |
| :--- | :--- | :--- |
| Repo `.gitignore` | **Shared** *(tracked in Git — changing it enters PRs)* | Project build artifacts (`dist/`, `node_modules/`, `.env`) |
| `.git/info/exclude` | **Local only** *(invisible to teammates)* | Personal caches inside an app repo (`floorplan/`, `graphify-out/`, `.archify/`) |
| Sibling workspace folder | **Outside repo completely** | `.specify/`, `specs/`, `playbooks/` *(cleanest option — zero repo footprint)* |

---

## 8. Pre-Commit Identity & Safety Check

Verify Git author identity (especially if `~/.gitconfig` uses `includeIf` for work vs. personal repos) and inspect the full diff before pushing:

```bash
git config user.name && git config user.email
git diff --stat origin/main...HEAD
```

Confirm zero `.env` files, secrets, stray scratch files, or weakened/deleted tests appear in the diff.
