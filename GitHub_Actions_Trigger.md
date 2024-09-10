# GitHub Actions Trigger Examples

### 1. **Trigger on Push**
Triggers a workflow when code is pushed to specific branches.

```yaml
on:
  push:
    branches:
      - main
      - dev
```

### 2. **Trigger on Pull Request**
Runs the workflow when a pull request is opened, synchronized, or reopened.

```yaml
on:
  pull_request:
    branches:
      - main
```

### 3. **Trigger on Tag Push**
Triggers the workflow when a tag is pushed.

```yaml
on:
  push:
    tags:
      - 'v*.*.*'  # Matches tags like v1.0.0, v2.1.3, etc.
```

### 4. **Trigger on Schedule (Cron Job)**
Runs the workflow on a schedule. The cron expression here represents every day at midnight UTC.

```yaml
on:
  schedule:
    - cron: "0 0 * * *"
```

### 5. **Trigger Manually (Workflow Dispatch)**
Allows manually triggering the workflow via the GitHub UI with optional input parameters.

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy to'
        required: true
        default: 'production'
```
### 6. **Trigger on Release Creation**
Runs the workflow when a new release is published.

```yaml
on:
  release:
    types:
      - published
```
### 7. **Trigger on Issue or Comment Creation**
Triggers the workflow when a new issue or comment is created.

```yaml
on:
  issues:
    types:
      - opened
  issue_comment:
    types:
      - created
```
### 8. ***Trigger on Branch or Tag Creation***
Runs the workflow when a new branch or tag is created.

```yaml
on:
  create:
    branches:
      - 'feature/*'
    tags:
      - 'v*.*.*'
```
### 9. **Trigger on Workflow File Changes**
Triggers the workflow when changes are made to workflow configuration files.

```yaml
on:
  push:
    paths:
      - '.github/workflows/**'
```
### 10. **Trigger on Multiple Events**
You can specify multiple events that trigger the workflow.

```yaml
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:
```
