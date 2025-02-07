# Helm Chart CI/CD Workflow

This document outlines the automated CI/CD process for building, testing, and publishing Helm charts, ensuring a seamless deployment pipeline.

---

## 1. Developer Updates  
Developers update the application Helm repository and push changes to the Git repository.

### 🔹 Process:
- Modify `Chart.yaml` to update:
  - **Versioning** (major, minor, or patch)
  - **Dependencies**  
  - **Metadata changes** (description, maintainers, etc.)
- Commit and push changes to the Git repository.

---

## 2. Pipeline Triggered  
A CI/CD pipeline starts automatically when changes are pushed.

### 🔹 Process:
- **Trigger Events:**  
  - Push to main or feature branches  
  - Pull requests  
- **Automation:** Ensures a continuous integration and delivery workflow.

---

## 3. Build & Publish Helm Chart  
The pipeline validates, builds, and publishes the Helm chart if the version is new.

### 🔹 Process:
1. **Build:** The Helm chart is packaged into a deployable artifact.
2. **Lint Checks:** Ensures compliance with Helm best practices.
3. **Version Validation:**
   - If the **version exists**, the build **fails** (prevents overwriting).
   - If the **version is new**, the chart is published to **Artifactory**.

---

## 4. Vulcan Tag Update  
The pipeline updates the **Vulcan tag** to reflect the new Helm chart version.

### 🔹 Purpose:
- Maintains correct versioning across pipeline stages.
- Ensures traceability in version control.

---

## 5. Daily Automation (Vulcan Stage)  
A scheduled **cron job** automates updates to the **umbrella Helm chart**.

### 🔹 Process:
1. **Cron Job Execution:** Runs daily at a scheduled time.
2. **Umbrella Chart Update:** Syncs with the latest application versions.
3. **Version Tagging:**  
   - Creates a new **version tag**.  
   - Pushes it to the Git repository for tracking.

---

## 6. Umbrella Helm Chart Workflow  
Triggers on updates to the **umbrella Helm chart**, creating a **DataFabric version tag**.

### 🔹 Process:
- **Workflow Trigger:** Detects changes in the umbrella Helm chart.
- **Tag Creation:** Generates a new **DataFabric version tag**.
- **Publishing:** Pushes the new version to **Artifactory** for deployment.

---

## 🎯 Key Benefits
✅ Fully automated Helm chart versioning and publishing  
✅ Pre-validation with linting to ensure best practices  
✅ Versioning enforcement to prevent accidental overwrites  
✅ Continuous integration with automated triggers  
✅ Traceability with version tagging and Artifactory publishing  

---

## 📌 Summary  
This workflow guarantees an efficient, automated, and controlled Helm chart lifecycle from development to deployment.  