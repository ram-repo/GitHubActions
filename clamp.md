# Clamp Test Runner – Nightly Build Execution

## Overview
The **Clamp Test Runner** is a cron job triggered by a nightly build. It automates infrastructure deployment, service validation, and test execution, ensuring that the latest **Dev Stable** changes meet quality standards before promotion.

## Workflow

### 1. Triggering the Test Suite
- A **cross-job trigger** starts the execution of the test suite.
- The pipeline fetches the latest **Dev Stable** version of all services and prepares for deployment.

### 2. Execution Stages

#### Stage 1: Deploy Infrastructure & Kubernetes
- Provision infrastructure and Kubernetes clusters.
- Deploy all services using the **Dev Stable** tag, including:
  - **ArgoCD Foundation**
  - **Data Fabric**
- Verify successful deployments before proceeding.

#### Stage 2: Smoke & Performance Testing
- Execute the following test suites:
  - **Smoke Tests** – Ensure basic functionality and stability.
  - **Performance Tests** – Validate system efficiency under load.
- Archive reports and publish results to the **Q Server**.
- If all test cases pass:
  - Generate **Bhedha Reports**.
  - Publish the reports to the **Q Test Server**.
  - Promote the **Stable tag** to **PT Stable**.

#### Stage 3: Infrastructure Teardown
- Destroy deployed infrastructure and free up resources.
- Clean up test environments to ensure fresh deployments in the next run.

## Artifacts & Reports
- **Test Reports:** Archived and published to the Q Server.
- **Bhedha Reports:** Generated and uploaded if tests pass.
- **Stable Tag Update:** If successful, the **Stable tag** is moved to **PT Stable**.

## Failure Handling
- If any stage fails, the process stops and reports are generated for debugging.
- Failed tests trigger alerts for investigation and resolution.

## Automation & CI/CD Integration
- This workflow is fully automated within the CI/CD pipeline.
- A nightly **cron job** ensures continuous validation and promotion of stable builds.