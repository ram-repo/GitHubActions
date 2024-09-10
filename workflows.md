## GitHub Actions workflow
- A GitHub Actions workflow is a configurable automated process that runs one or more jobs in a GitHub repository. Workflows are defined in YAML files and are triggered by specified events, such as code pushes, pull requests, or manual triggers. Each workflow file can define a series of jobs that run in parallel or sequentially, performing tasks like building, testing, and deploying code.

## Calling Another Workflow
- You can call another workflow within your workflow file using the workflow_call event. This is useful for creating reusable workflows that can be called from other workflows, promoting consistency and reducing duplication.

## Reusable Workflow

For a detailed example of a reusable workflow, see the file [reusable-workflow.yml](.github/workflows/reusable-workflow.yml).

## Main Workflow

To see how the reusable workflow is called from another workflow, refer to [main-workflow.yml](.github/workflows/main-workflow.yml).

## Key Points
* Modularity: Reusable workflows help keep your CI/CD configurations modular and maintainable.
* Consistency: By using reusable workflows, you ensure that common processes (like deployments) are consistent across different workflows.
* Inputs: You can pass inputs to reusable workflows to customize their behavior based on the context in which they are called.
