# GitHub Actions Workflows for Main Branch

This document outlines the three key GitHub Actions workflows for managing infrastructure, application deployment, and cleanup processes in the main branch.

---

## Workflow Diagram

![Workflow Diagram](docs/workflow-diagram.jpeg)  
*(Ensure the image is uploaded to the `docs` folder in your repository.)*

---

## 1. Infrastructure and Application Deployment Workflow
### **Purpose:**  
This workflow provisions infrastructure, deploys Kubernetes, and installs all applications.

### **Trigger:**  
- **Scheduled Cron Job** → Runs every **Monday**.

### **Steps:**  
1. **Create Infrastructure & Deploy Kubernetes**  
   - A new Kubernetes (K8s) cluster is provisioned.  
   - The instance runs for **5 days**.  

2. **Upload Artifacts**  
   - Uploads required artifacts to a storage location (e.g., S3).  
   - Uploads admin configuration to **S3**.  

3. **Deploy All Applications**  
   - Installs and configures all necessary applications in the Kubernetes cluster.  

---

## 2. Data Fabric Deployment Workflow
### **Purpose:**  
This workflow ensures that Data Fabric is deployed and updated whenever changes are made to the **Umbrella Helm chart**.

### **Trigger:**  
- **Triggered by changes in the Umbrella Helm chart.**

### **Steps:**  
1. **Deploy Data Fabric**  
   - Deploys the initial Data Fabric setup.  

2. **Setup Pre-requisites**  
   - Ensures that all dependencies and configurations are in place before deployment.  

3. **Uninstall Previous Data Fabric Version**  
   - Removes the old deployment to avoid conflicts.  

4. **Deploy Latest Data Fabric Changes**  
   - Installs the latest version of Data Fabric from the updated Helm chart.  

---

## 3. Infrastructure Cleanup Workflow
### **Purpose:**  
Cleans up resources by tearing down Kubernetes infrastructure and removing unused artifacts.

### **Trigger:**  
- **Scheduled Cron Job** → Runs every **Saturday at 12 AM**.

### **Steps:**  
1. **Destroy Kubernetes Infrastructure**  
   - Terminates the Kubernetes cluster and associated resources.  

2. **Clean Up S3**  
   - Deletes unused or temporary files from **S3** to optimize storage.  

---

## Summary of Workflow Triggers
| Workflow                         | Trigger Condition          | Execution Time |
|----------------------------------|---------------------------|---------------|
| Infra & App Deployment          | Scheduled Cron Job        | Every Monday |
| Data Fabric Deployment          | Changes in Umbrella Helm  | On Change    |
| Infra Cleanup                   | Scheduled Cron Job        | Every Saturday at 12 AM |

---

## Enhancements & Future Improvements
- Implement **notifications** (Slack, email) for workflow status updates.  
- Optimize **cost management** by dynamically scaling resources based on demand.  
- Introduce **error handling and rollback mechanisms** in case of failures.  

---