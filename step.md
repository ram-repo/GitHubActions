## step:
* A step is an individual task or action that is executed as part of a job in a workflow. 
* Steps run sequentially and can either use predefined actions from the GitHub Actions marketplace or execute shell commands directly.

Here’s a breakdown of how you can create steps for different tasks like running a shell script, running SonarQube for code analysis, and building a Docker image.

## Example GitHub Actions Workflow:
```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Step 1: Checkout code
      - name: Checkout repository
        uses: actions/checkout@v3

      # Step 2: Run a shell script
      - name: Run shell script
        run: |
          echo "Running shell script"
          ./your-shell-script.sh

      # Step 3: Run SonarQube for code analysis
      - name: SonarQube Scan
        uses: SonarSource/sonarcloud-github-action@v2.2
        with:
          sonarToken: ${{ secrets.SONAR_TOKEN }}
          projectKey: your-project-key
          organization: your-organization-key
        env:
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      # Step 4: Build and push a Docker image
      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push Docker image
        run: |
          docker build -t your-image-name:latest .
          docker tag your-image-name:latest your-dockerhub-username/your-image-name:latest
          docker push your-dockerhub-username/your-image-name:latest
```

## Explanation:
### Checkout Repository:
* The first step uses the actions/checkout@v3 action to check out the repository’s code into the runner.

### Run Shell Script:
* The run command is used to execute shell commands. In this case, it runs a custom shell script called your-shell-script.sh.

### Run SonarQube Scan:
* The SonarQube scan uses SonarSource/sonarcloud-github-action. The sonarToken, projectKey, and other details are passed using secrets and environment variables.

### Docker Build and Push:
* First, the docker/login-action@v2 is used to log in to Docker Hub with your credentials.
Then, a docker build, tag, and push are done in sequence to build the Docker image and push it to Docker Hub.

### Key Points:
* Secrets (like DOCKER_USERNAME, DOCKER_PASSWORD, SONAR_TOKEN, etc.) are stored securely in GitHub under Settings > Secrets.
* run is used to execute shell commands or scripts directly.
* Predefined actions (like actions/checkout or docker/login-action) help you integrate services like Git, Docker, and SonarQube easily.






