# n8n Workflow Export Automation

This repository demonstrates automated export and versioning of n8n workflows using Bash, Git, and GitHub Actions.

## Features

- Exports all active workflows from n8n via API
- Saves each workflow in structured folders by funnel/category
- Removes sensitive data before commit
- Commits and pushes only changed files

## Usage

1. Copy `.env.template` to `.env` and fill in your n8n API URL and token.
2. Make sure you have `jq` and `curl` installed.
3. Run `bash export_n8n.sh` locally or rely on the scheduled GitHub Action.
4. Workflows are saved in `funnels/<category>/workflow_<id>.json`.

## GitHub Actions

The workflow in `.github/workflows/export_n8n.yml` runs the export every 4 hours and pushes changes automatically.

## Security

- Secrets and credentials are stripped before saving.
- `.env` is gitignored.
