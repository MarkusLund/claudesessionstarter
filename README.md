# Claude Code Session Trigger (GitHub Actions)

**TL;DR:**  
Run **Claude Code** in a terminal in this repo, run `/install-github-app`, then tweak `.github/workflows/trigger-claude-cli.yml` to your needs.

This repo is a minimal template for running **Claude Code** on a schedule via **GitHub Actions**.

It includes a single workflow that demonstrates:

- Scheduled execution at specific times in **Norway time (Europe/Oslo)**, including DST handling (CET/CEST)
- Invoking `anthropics/claude-code-action` with a prompt and CLI args
- Storing the required API key as a GitHub Actions secret

## What it does

The workflow in `.github/workflows/trigger-claude-cli.yml` runs on a schedule (and manually via `workflow_dispatch`).
Because GitHub cron schedules are UTC-only, the workflow includes **both CET and CEST cron entries** and then decides at runtime which ones should actually run based on the current `Europe/Oslo` offset.

Out of the box, the example prompt is intentionally trivial (`"hi, only answer hi"`). You should replace it with whatever you want Claude Code to do.

## Schedule (default)

The default schedule is written for `Europe/Oslo`:

- **Mon–Wed + Fri–Sun:** runs at **05:00**, **10:00**, and **15:00** Norway time
- **Thu:** runs at **09:00** Norway time only (intended as an “early reset” window)

To make this work across CET/CEST, the workflow registers multiple UTC cron candidates and then skips the “wrong season” runs in the first step.

## Prerequisites

- A GitHub repository with GitHub Actions enabled
- **Claude Code installed on your machine**
- The **Claude GitHub App** installed for the repository (see “Forks / setup” below)
- A GitHub Actions secret named `ANTHROPIC_API_KEY`

## Quick start

1. Install the Claude GitHub App for this repo (or your fork):

   - Open Claude Code in this repo and run: `/install-github-app`
   - Follow the prompts to install/authorize the GitHub App for the repository and configure required secrets
   - You must be a repo admin to install the app / add secrets
   - If `/install-github-app` isn’t available, install the app manually at `https://github.com/apps/claude` and then add `ANTHROPIC_API_KEY` as a repository secret

2. Verify the API key secret in GitHub:

- When you run `/install-github-app`, the setup flow will create the required `ANTHROPIC_API_KEY` secret for you automatically using the key you provide.
- You normally **don’t** need to add this secret manually. Just confirm it exists in your GitHub repo under: `Settings` → `Secrets and variables` → `Actions`.
- Only if you skipped `/install-github-app` and installed the Claude GitHub App manually should you create `ANTHROPIC_API_KEY` yourself and paste in your Anthropic API key (from the Anthropic Console).

3. Trigger a run:
   - Go to the repo’s `Actions` tab → `Trigger Claude Code Session` → `Run workflow`

## Customizing behavior

Open `.github/workflows/trigger-claude-cli.yml` and edit:

- `on.schedule`: change the cron entries/timing policy
- `with.prompt`: what Claude Code should do
- `with.claude_args`: CLI flags (tool permissions, model, max turns, etc.)

## Using this in a fork

See `docs/FORKS.md` for fork-specific setup details (Actions scheduling, installing the GitHub App, and configuring secrets).
