#!/bin/bash
set -e

# Load environment variables
if [ -f .env ]; then
  source .env
else
  echo ".env file not found!"
  exit 1
fi

# Check required env vars
if [[ -z "$N8N_API_URL" || -z "$N8N_API_KEY" ]]; then
  echo "N8N_API_URL or N8N_API_KEY is not set"
  exit 1
fi

# Export all workflows
WORKFLOWS=$(curl -s -H "Authorization: Bearer $N8N_API_KEY" "$N8N_API_URL/workflows" | jq -c '.data[]')

for wf in $WORKFLOWS; do
  id=$(echo $wf | jq -r '.id')
  category=$(echo $wf | jq -r '.tags[0] // "uncategorized"')
  mkdir -p "funnels/$category"
  # Strip credentials before saving
  curl -s -H "Authorization: Bearer $N8N_API_KEY" "$N8N_API_URL/workflows/$id" \
    | jq 'del(.nodes[].credentials, .nodes[].parameters.secret, .connections)' \
    > "funnels/$category/workflow_${id}.json"
done
