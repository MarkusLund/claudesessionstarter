# Claude Code CLI Session Trigger

Runs a daily dummy prompt (`claude -p "hi"`) in GitHub Actions to intentionally start your Claude Pro/Max 5-hour usage window at a predictable time.

## Why not the Anthropic API?

Calling `https://api.anthropic.com/v1/messages` is **API billing** and does **not** count as “Claude Code CLI usage under your Pro plan”.  
This repo uses the **Claude Code CLI** itself.

## Authentication model (important)

- **Claude Code can authenticate via**:
  - **Claude Pro/Max subscription** (preferred for this repo)
  - **Claude Console / API key** (billable)
- **If** `ANTHROPIC_API_KEY` **is present**, Claude Code will use it and you can be billed.

## Recommended: export Linux auth state for CI

On macOS, Claude Code stores credentials in Keychain; file-based token copying is unreliable.  
Instead, do a one-time login on a Linux environment (WSL/VM/container), then export:

```bash
tar -czf claude-state.tgz -C "$HOME" .claude .claude.json
base64 -w0 claude-state.tgz > claude-state.tgz.b64
```

Store the base64 output as GitHub secret: `CLAUDE_STATE_TGZ_B64`.

## Local test

```bash
docker build -t claude-trigger .
docker run --rm -e CLAUDE_STATE_TGZ_B64="$(cat claude-state.tgz.b64)" claude-trigger
```

## Notes / risks

- Tokens can expire; re-auth and update the secret when it breaks.
- Avoid logging secrets. Keep the repo private.
- If Anthropic changes storage/auth flows, you may need to re-export the state.
