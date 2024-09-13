
# Predefined Reusable Tasks in GitHub Actions

GitHub Actions provides several **predefined reusable actions** from the marketplace that can help streamline common tasks in workflows, like checking out code, setting up environments, and running tests. Below are some of the most commonly used predefined reusable tasks, such as `actions/checkout` and `actions/setup-node`.

## Common Predefined Reusable Actions

### 1. `actions/checkout`
This action checks out your repository, allowing subsequent steps in the workflow to use the files from the repo. It is almost always the first step in any workflow that deals with code.

```yaml
- name: Checkout repository
  uses: actions/checkout@v2
```

### 2. `actions/setup-node`
This action sets up a specific version of Node.js in your workflow. It’s useful for JavaScript/Node.js-based projects.

```yaml
- name: Set up Node.js
  uses: actions/setup-node@v2
  with:
    node-version: '14'  # Specify the Node.js version you need
```

### 3. `actions/cache`
This action is used to cache dependencies between workflow runs. This can drastically speed up builds by reusing previously downloaded packages (e.g., npm packages or Python dependencies).

```yaml
- name: Cache node modules
  uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

### 4. `actions/upload-artifact`
This action uploads files (artifacts) from your workflow run, which can be downloaded later. It is useful for saving build logs, test reports, or build artifacts (e.g., binaries).

```yaml
- name: Upload build artifact
  uses: actions/upload-artifact@v2
  with:
    name: build-output
    path: ./dist  # Directory or file to upload
```

### 5. `actions/download-artifact`
This action downloads previously uploaded artifacts for use in a different job or workflow.

```yaml
- name: Download build artifact
  uses: actions/download-artifact@v2
  with:
    name: build-output
    path: ./dist  # Where to download the artifact
```

### 6. `actions/setup-python`
This action sets up a specific version of Python for your workflow.

```yaml
- name: Set up Python
  uses: actions/setup-python@v2
  with:
    python-version: '3.8'  # Specify the Python version you need
```

### 7. `actions/setup-java`
This action sets up a specific version of Java (JDK) for your workflow.

```yaml
- name: Set up Java
  uses: actions/setup-java@v3
  with:
    java-version: '11'
    distribution: 'adopt'  # Available distributions: adopt, zulu, temurin, etc.
```

### 8. `actions/setup-go`
This action sets up a specific version of Go in your workflow for Go projects.

```yaml
- name: Set up Go
  uses: actions/setup-go@v3
  with:
    go-version: '1.17'  # Specify the Go version you need
```

### 9. `actions/setup-dotnet`
This action sets up a specific version of the .NET SDK for your workflow.

```yaml
- name: Set up .NET
  uses: actions/setup-dotnet@v3
  with:
    dotnet-version: '6.x'  # Specify the .NET version you need
```

### 10. `actions/checkout-submodules`
If your repository contains Git submodules, this action checks out the main repository and all its submodules.

```yaml
- name: Checkout repository and submodules
  uses: actions/checkout@v2
  with:
    submodules: true
    fetch-depth: 0  # Required for checking out submodules
```

### 11. `docker/build-push-action`
This action builds and pushes Docker images. It's useful for container-based workflows.

```yaml
- name: Build and push Docker image
  uses: docker/build-push-action@v2
  with:
    context: .
    tags: user/repository:tag  # Replace with your Docker image name and tag
```

## Example: Complete Workflow Using Predefined Actions

Here’s an example of a complete GitHub Actions workflow using several predefined reusable tasks:

```yaml
name: CI Workflow

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Checkout code from repository
      - name: Checkout repository
        uses: actions/checkout@v2

      # Cache node modules to speed up builds
      - name: Cache node modules
        uses: actions/cache@v3
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-

      # Set up Node.js version 14
      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      # Install dependencies
      - name: Install dependencies
        run: npm install

      # Run tests
      - name: Run tests
        run: npm test

      # Upload test results as an artifact
      - name: Upload test results
        uses: actions/upload-artifact@v2
        with:
          name: test-results
          path: ./test-results  # Directory where test results are stored
```

## Additional Popular Predefined Actions

- **`actions/github-script`**: Allows you to write custom JavaScript scripts directly within your workflows.
  ```yaml
  - name: Run custom GitHub script
    uses: actions/github-script@v5
    with:
      script: |
        const issue = await github.rest.issues.create({
          owner: context.repo.owner,
          repo: context.repo.repo,
          title: 'New Issue',
          body: 'This is a custom issue created via GitHub Script'
        })
  ```

- **`stefanprodan/git-tags-action`**: Automatically tags a Git commit based on SemVer.
  ```yaml
  - name: Git Tag
    uses: stefanprodan/git-tags-action@v1
    with:
      github_token: ${{ secrets.GITHUB_TOKEN }}
  ```

These actions can make it easier to automate workflows and reduce manual setup by using predefined, reusable tasks. You can also explore more reusable actions from the [GitHub Marketplace](https://github.com/marketplace?type=actions).
