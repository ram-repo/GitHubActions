# 🔄 Helm Chart Build Promotion Workflow

This document outlines the automated process for **Helm chart build promotion**, ensuring controlled and seamless deployment across environments.

---

## 1️⃣ Developer Updates & Push to Git  
Developers update the **application Helm chart** and push changes to the repository.

### 🔹 Process:
- Modify `Chart.yaml`:
  - **Version bump** (major, minor, patch)
  - **Dependencies update**
  - **Metadata changes** (description, maintainers, etc.)
- Commit and push changes to the **Git repository**.

---

## 2️⃣ Pipeline Trigger  
A CI/CD pipeline is automatically triggered upon detecting changes.

### 🔹 Process:
- **Trigger Events:**  
  - Code push (main/feature branches)  
  - Pull requests  
- **Automation:** Ensures continuous integration and builds.

---

## 3️⃣ Build & Publish Helm Chart  
The pipeline **validates, builds, and publishes** the Helm chart.

### 🔹 Process:
1. **Build Helm Chart:** Packages the chart into a deployable artifact.
2. **Lint & Validate:** Ensures best practices and YAML syntax correctness.
3. **Version Check:**  
   - ✅ If the version **is new**, publish the chart to **Artifactory**.  
   - ❌ If the version **exists**, the build **fails** (prevents overwriting).  
4. **Tagging:** A new `build-buildnumber` tag is created.

---

## 4️⃣ Vulcan Tag Update  
The pipeline updates the **Vulcan tag** to reflect the latest Helm chart version.

### 🔹 Purpose:
- Maintains version control for promotion across environments.
- Ensures consistency in the pipeline.

---

## 5️⃣ Build Promotion Across Environments  
After publishing the Helm chart, a **promotion process** ensures controlled deployment.

### 🔹 Process:
1. **Promote from Dev → Stable → PT:**  
   - The chart version is validated before promotion.
   - **Automation** ensures only validated builds proceed.
2. **Version Tagging:**  
   - **New promotion tags** (`dev`, `stable`, `pt`) are created.
   - Tags are pushed to **Git and Artifactory**.
3. **Umbrella Helm Chart Update:**  
   - The umbrella chart is updated with the latest promoted versions.
   - A **new version tag** is created for tracking.

---

## 6️⃣ Daily Automation (Vulcan Stage)  
A **cron job** updates and promotes Helm charts automatically.

### 🔹 Process:
1. **Scheduled Execution:** Runs daily.
2. **Version Updates:** Updates the umbrella Helm chart.
3. **Tagging & Publishing:**  
   - Creates a new **Vulcan tag**.  
   - Publishes to **Git & Artifactory**.

---

## 7️⃣ Final Umbrella Helm Chart Workflow  
Triggers upon changes in the **umbrella Helm chart**, ensuring **DataFabric versioning**.

### 🔹 Process:
- **Detects updates** in the umbrella chart.
- **Creates a new DataFabric version tag**.
- **Publishes to Artifactory**, making it available for deployment.

---

## 🎯 Key Benefits of Build Promotion  
✅ **Ensures only validated builds move to higher environments**  
✅ **Prevents accidental overwrites with strict version checks**  
✅ **Automated tagging for better traceability**  
✅ **Controlled promotion from Dev → Stable → PT**  
✅ **Daily automation ensures up-to-date Helm charts**  

---

## 📌 Summary  
This workflow ensures an **automated, validated, and controlled** Helm chart promotion process across multiple environments, maintaining consistency and reliability.