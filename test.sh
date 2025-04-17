curl -u "your-username:your-apikey" -H "Content-Type: application/json" \
  -d '{"component_name": "docker://docker-local/image1:1.0.0"}' \
  https://your-jfrog-domain/xray/api/v1/component | \
  jq -r '
    {
      image: "docker-local/image1:1.0.0",
      licenses: (
        [.component_licenses[]? 
          | {name: .license.name, url: (.license.more_info_url[0] // "N/A")}
        ] | unique
      )
    }
  '