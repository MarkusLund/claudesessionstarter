#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${CLAUDE_STATE_TGZ_B64:-}" ]]; then
  echo "Error: Missing CLAUDE_STATE_TGZ_B64"
  exit 1
fi

# Ensure Claude is on PATH (native installer default)
export PATH="$HOME/.local/bin:$PATH"

# Restore Claude state (auth + settings)
tmp="$(mktemp)"
printf '%s' "$CLAUDE_STATE_TGZ_B64" | base64 --decode > "$tmp"
tar -xzf "$tmp" -C "$HOME"
rm -f "$tmp"

# Sanity check
claude --version

# Send minimal dummy prompt
# --max-turns 1 reduces agentic “extra turns” in non-interactive mode.
claude -p --model haiku "Say only hi to me."

echo "Dummy prompt sent successfully."


