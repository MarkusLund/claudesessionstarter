# Using this repo in a fork

This workflow is designed to be fork-friendly, but **forks do not inherit GitHub Actions secrets or GitHub App installs**. You need to set those up in your fork.

## 1) Fork and enable Actions

1. Fork this repository.
2. In your fork, open the `Actions` tab and enable workflows if GitHub prompts you to.
3. If you intend to use the scheduled triggers: confirm schedules are enabled for the fork (GitHub often disables scheduled workflows on forks by default until you explicitly enable them).

## 2) Install the Claude GitHub App for your fork

You must have **Claude Code installed locally** to do this.

1. Clone your fork locally.
2. In a terminal, `cd` into the repo.
3. Start Claude Code in this repo (however you normally launch it).
4. Inside Claude Code, run:

   `/install-github-app`

5. Follow the prompts to install/authorize the Claude GitHub App for your fork.
6. If `/install-github-app` isn’t available, install the app manually at `https://github.com/apps/claude` instead (then proceed to add `ANTHROPIC_API_KEY` below).

## 3) Add the required GitHub secret

The workflow expects a repository secret named:

- `ANTHROPIC_API_KEY`

Add it in your fork:

1. GitHub repo → `Settings`
2. `Secrets and variables` → `Actions`
3. `New repository secret`
4. Name: `ANTHROPIC_API_KEY`
5. Value: paste your Anthropic API key

## 4) Run it

- Manual run: `Actions` → `Trigger Claude Code Session` → `Run workflow`
- Scheduled run: wait for the next cron window after enabling schedules in your fork

## Common fork gotchas

- **No secrets in forks:** secrets are not copied when you fork. If `ANTHROPIC_API_KEY` is missing, the workflow will fail.
- **Schedules disabled:** if the workflow never runs on schedule, check the fork’s `Actions` settings and whether scheduled workflows are enabled.
- **Wrong times:** the workflow’s schedule logic is written for `Europe/Oslo`. If you want a different timezone, update the `TZ=Europe/Oslo` checks and the cron hour candidates in `.github/workflows/trigger-claude-cli.yml`.
