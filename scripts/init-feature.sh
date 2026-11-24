#!/usr/bin/env bash
set -euo pipefail

# ───── USAGE & CLI HELPERS ──────────────────────────────
usage() {
  cat <<'EOF'
Usage: init-feature.sh <ticket-id> <slug> [S|M|L] [--out <dir>]

Generate a pre-configured feature playbook from templates/feature-playbook.template.md.

Arguments:
  <ticket-id>   Alphanumeric ticket/feature identifier (e.g., FEAT-001, BUG-14)
  <slug>        Lowercase hyphenated slug (e.g., user-profiles, auth-timeout)
  [S|M|L]       Size Profile: S (Small), M (Medium, default), L (Large)

Options:
  --out <dir>   Output directory (default: <repo-root>/playbooks)
  -h, --help    Show this help message
EOF
}

die() {
  printf 'Error: %s\n' "$1" >&2
  exit 1
}

# ───── ARGUMENT PARSING ─────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_FILE="${REPO_ROOT}/templates/feature-playbook.template.md"
OUT_DIR="${REPO_ROOT}/playbooks"

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --out)
      [[ $# -ge 2 ]] || die "--out requires a directory argument"
      OUT_DIR="$2"
      shift 2
      ;;
    --out=*)
      OUT_DIR="${1#*=}"
      [[ -n "${OUT_DIR}" ]] || die "--out requires a non-empty directory"
      shift
      ;;
    -*)
      die "Unknown option: $1 (run with --help for usage)"
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

[[ ${#POSITIONAL[@]} -ge 2 ]] || { usage >&2; die "Both <ticket-id> and <slug> are required"; }
[[ ${#POSITIONAL[@]} -le 3 ]] || { usage >&2; die "Too many positional arguments"; }

TICKET_ID="${POSITIONAL[0]}"
SLUG="${POSITIONAL[1]}"
RAW_PROFILE="${POSITIONAL[2]:-M}"

# ───── VALIDATION & TOKEN NORMALIZATION ─────────────────
[[ "${TICKET_ID}" =~ ^[A-Za-z0-9_-]+$ ]] || die "Invalid <ticket-id> '${TICKET_ID}'. Use letters, digits, '-' or '_'."
[[ "${SLUG}" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || die "Invalid <slug> '${SLUG}'. Use lowercase letters, digits, and single hyphens."

PROFILE="$(printf '%s' "${RAW_PROFILE}" | tr '[:lower:]' '[:upper:]')"
case "${PROFILE}" in
  S|M|L) ;;
  *) die "Invalid profile '${RAW_PROFILE}'. Must be S, M, or L." ;;
esac

[[ -f "${TEMPLATE_FILE}" ]] || die "Template not found: ${TEMPLATE_FILE}"

LOWER_ID="$(printf '%s' "${TICKET_ID}" | tr '[:upper:]' '[:lower:]')"
FEATURE_TITLE="$(printf '%s' "${SLUG}" | awk -F'-' '{
  for (i = 1; i <= NF; i++) {
    $i = toupper(substr($i, 1, 1)) substr($i, 2)
  }
  printf "%s", $1
  for (i = 2; i <= NF; i++) printf " %s", $i
}')"

TODAY="$(date +%Y-%m-%d)"
BRANCH_NAME="${LOWER_ID}-${SLUG}"
SPEC_DIR="specs/${BRANCH_NAME}"
PROJECT_CONTEXT_PATH="../project-context.md"

# ───── PROFILE DEFAULTS (STEPS & PLUG-INS) ──────────────
STEP0_STATUS="⬜ Pending"
STEP1_STATUS="⬜ Pending"
STEP2_STATUS="⬜ Pending"
STEP3_STATUS="⬜ Pending"
STEP4_STATUS="⬜ Pending"
STEP5_STATUS="⬜ Pending"
STEP6_STATUS="⬜ Pending"
STEP7_STATUS="⬜ Pending"
STEP8_STATUS="⬜ Pending"
STEP9_STATUS="⬜ Pending"

case "${PROFILE}" in
  S)
    STEP0_STATUS="⏭️ Skipped (Profile S)"
    STEP1_STATUS="⏭️ Skipped (Profile S)"
    STEP3_STATUS="⏭️ Skipped (Profile S)"
    STEP4_STATUS="⏭️ Skipped (Profile S)"
    STEP6_STATUS="⏭️ Skipped (Profile S)"
    STEP7_STATUS="⏭️ Skipped (Profile S)"
    ACTIVE_PLUGINS="None (Profile S)"
    ACTIVE_STEPS_SUMMARY="2, 5, 8, 9"
    FIRST_STEP="Step 2 (/speckit-specify)"
    ;;
  M)
    ACTIVE_PLUGINS="Floorplan (Step 8/9), Archify (if schema/auth changes)"
    ACTIVE_STEPS_SUMMARY="0–9 (Full Spine)"
    FIRST_STEP="Step 0 (Pre-Spec Audit)"
    ;;
  L)
    ACTIVE_PLUGINS="Graphify (Step 0), EGM (Pre-Step 5), Archify (Step 5/9), Floorplan (Step 8/9)"
    ACTIVE_STEPS_SUMMARY="0–9 (Full Spine + All Gates)"
    FIRST_STEP="Step 0 (Pre-Spec Audit + Graphify)"
    ;;
esac

# ───── RENDER OUTPUT SAFELY (NO OVERWRITE) ──────────────
mkdir -p "${OUT_DIR}"
OUT_FILE="${OUT_DIR%/}/${BRANCH_NAME}.md"
[[ ! -e "${OUT_FILE}" ]] || die "Target file already exists: ${OUT_FILE} (refusing to overwrite)"

awk \
  -v ticket_id="${TICKET_ID}" \
  -v slug="${SLUG}" \
  -v title="${FEATURE_TITLE}" \
  -v profile="${PROFILE}" \
  -v dt="${TODAY}" \
  -v branch="${BRANCH_NAME}" \
  -v spec_dir="${SPEC_DIR}" \
  -v plugins="${ACTIVE_PLUGINS}" \
  -v ctx_path="${PROJECT_CONTEXT_PATH}" \
  -v s0="${STEP0_STATUS}" \
  -v s1="${STEP1_STATUS}" \
  -v s2="${STEP2_STATUS}" \
  -v s3="${STEP3_STATUS}" \
  -v s4="${STEP4_STATUS}" \
  -v s5="${STEP5_STATUS}" \
  -v s6="${STEP6_STATUS}" \
  -v s7="${STEP7_STATUS}" \
  -v s8="${STEP8_STATUS}" \
  -v s9="${STEP9_STATUS}" \
'
function replace_all(str, pat, rep,    pos, out, plen) {
  out = ""
  plen = length(pat)
  while ((pos = index(str, pat)) > 0) {
    out = out substr(str, 1, pos - 1) rep
    str = substr(str, pos + plen)
  }
  return out str
}
{
  line = $0
  line = replace_all(line, "{{TICKET_ID}}", ticket_id)
  line = replace_all(line, "{{SLUG}}", slug)
  line = replace_all(line, "{{FEATURE_TITLE}}", title)
  line = replace_all(line, "{{PROFILE}}", profile)
  line = replace_all(line, "{{DATE}}", dt)
  line = replace_all(line, "{{BRANCH_NAME}}", branch)
  line = replace_all(line, "{{SPEC_DIR}}", spec_dir)
  line = replace_all(line, "{{ACTIVE_PLUGINS}}", plugins)
  line = replace_all(line, "{{PROJECT_CONTEXT_PATH}}", ctx_path)
  line = replace_all(line, "{{STEP0_STATUS}}", s0)
  line = replace_all(line, "{{STEP1_STATUS}}", s1)
  line = replace_all(line, "{{STEP2_STATUS}}", s2)
  line = replace_all(line, "{{STEP3_STATUS}}", s3)
  line = replace_all(line, "{{STEP4_STATUS}}", s4)
  line = replace_all(line, "{{STEP5_STATUS}}", s5)
  line = replace_all(line, "{{STEP6_STATUS}}", s6)
  line = replace_all(line, "{{STEP7_STATUS}}", s7)
  line = replace_all(line, "{{STEP8_STATUS}}", s8)
  line = replace_all(line, "{{STEP9_STATUS}}", s9)
  print line
}
' "${TEMPLATE_FILE}" > "${OUT_FILE}"

printf 'Created playbook: %s\n' "${OUT_FILE}"
printf 'Profile:          %s (Active Steps: %s)\n' "${PROFILE}" "${ACTIVE_STEPS_SUMMARY}"
printf 'Plug-in Gates:    %s\n' "${ACTIVE_PLUGINS}"
printf 'Next Step:        Start %s in a fresh chat session.\n' "${FIRST_STEP}"
