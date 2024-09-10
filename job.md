## GitHub Actions Job:
A job is a set of steps that are executed on the same runner. Jobs are used to define a specific task or set of tasks to run in your workflow. Each job runs in its own environment, and you can configure the environment using a runner or a container.

### Key Concepts:
* Steps: Individual tasks or commands that are executed within a job. Steps can be actions or shell commands.
* Runner: The server where the job's steps are executed. GitHub provides hosted runners, or you can use self-hosted runners.
* Dependencies: Jobs can depend on the completion of other jobs. For example, you might want to run a deployment job only if tests pass.

## Example of Job for nodejs:
```yaml
name: CI # name of the workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '16'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

```

### **Use Cases**:
### Continuous Integration (CI):

* Build and Test: Automatically build your project and run tests whenever code is pushed or a pull request is created. This ensures that code changes don’t break existing functionality.
Code Quality Checks: Run linters or static code analysis tools to ensure code quality and adhere to style guidelines.
* Continuous Deployment (CD): Deploy to Staging: Automatically deploy your application to a staging environment for further testing and validation.
Deploy to Production: Deploy to production servers after passing tests and quality checks, often triggered by a manual approval step.
* Automation: Automate Issue Management: Automatically label issues or pull requests based on their content or other criteria.
Automate Releases: Create GitHub releases, update version numbers, or publish artifacts when a new tag is pushed.
* Custom Workflows: Scheduled Jobs: Run tasks on a schedule, like running database backups or generating reports.
Multi-Stage Workflows: Run different jobs for different parts of your CI/CD pipeline, like testing, building, and deploying, in a controlled sequence.


### In GitHub Actions, you can control whether jobs run sequentially or in parallel by configuring dependencies between jobs.
### 1. Running Jobs in Parallel
* By default, jobs in a GitHub Actions workflow run in parallel unless specified otherwise. For example, if you have multiple jobs without any dependencies, they will all run at the same time:
```yaml
name: CI

on: [push]

jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job1 steps
        run: echo "Job 1 running"

  job2:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job2 steps
        run: echo "Job 2 running"

```

### 2. Running Jobs Sequentially
* To make jobs run sequentially, you need to define dependencies between them using the needs keyword. This makes sure that one job only starts after the jobs it depends on have completed successfully.

* Example where job2 runs only after job1 has completed:
```yaml
name: CI

on: [push]

jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job1 steps
        run: echo "Job 1 running"

  job2:
    runs-on: ubuntu-latest
    needs: job1
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job2 steps
        run: echo "Job 2 running after Job 1"

```
### 3. Chaining Jobs
* You can chain multiple jobs to create a sequence of tasks. For instance, if you have three jobs where job3 should run only after job2 and job2 should run only after job1, you can set it up like this:

```yaml
name: CI

on: [push]

jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job1 steps
        run: echo "Job 1 running"

  job2:
    runs-on: ubuntu-latest
    needs: job1
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job2 steps
        run: echo "Job 2 running after Job 1"

  job3:
    runs-on: ubuntu-latest
    needs: job2
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Run job3 steps
        run: echo "Job 3 running after Job 2"
```
