#!/bin/bash

# --- Configurable Variables ---
JF_URL="https://your.jfrog.io"
JF_USER="$1"
JF_PASS="$2"

# Images in Artifactory (repo/image:tag format)
images=(
  "docker-prod/myapp/backend:1.0.2"
  "docker-prod/myapp/frontend:1.0.2"
  "docker-prod/myapp/api:1.0.2"
)

# --- Login to JFrog ---
echo "Logging in to JFrog CLI..."
jf config add xray-server --url="$JF_URL" --user="$JF_USER" --password="$JF_PASS" --interactive=false

# --- Create output directory ---
mkdir -p reports

# --- Fetch reports for each image ---
for image in "${images[@]}"; do
  safe_name="${image//[:\/]/_}"

  echo "Fetching vulnerability report for $image"
  jf audit --spec <(cat <<EOF
{
  "files": [
    {
      "pattern": "$image"
    }
  ]
}
EOF
  ) --server=xray-server --format=json > "reports/${safe_name}_vuln.json"

  echo "Generating SBOM for $image"
  jf sbom generate "$image" --output "reports/${safe_name}_sbom.json" --format=cyclonedx --server=xray-server
done

# --- Aggregate reports into one JSON file ---
echo "Combining reports into one JSON file..."
jq -n '
  {
    vulnerability_reports: [inputs | select(.vulnerabilities)],
    sbom_reports: [inputs | select(.components)]
  }
' reports/*_*.json > aggregated_report.json

echo "All done! Combined report saved as aggregated_report.json"