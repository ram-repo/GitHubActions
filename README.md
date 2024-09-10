# GitHub Actions & Workflow Concepts

1. **Workflow**  
   - An automated process defined by a YAML file.
   - Triggered by events like `push`, `pull_request`, or `schedule`.

2. **Job**  
   - A set of steps that run on the same runner.
   - Can run sequentially or in parallel.

3. **Step**  
   - Individual tasks within a job.
   - Can run shell commands or use actions.

4. **Runner**  
   - A server (GitHub-hosted or self-hosted) that runs jobs.
   - Examples: `ubuntu-latest`, `macos-latest`, `windows-latest`.

5. **Events**  
   - Trigger workflows.
   - Common events: `push`, `pull_request`, `schedule`, `workflow_dispatch`.

6. **Actions**  
   - Predefined reusable tasks.
   - Example: `actions/checkout`, `actions/setup-node`.

7. **Secrets**  
   - Encrypted variables for sensitive data (e.g., API keys).
   - Accessed using `${{ secrets.SECRET_NAME }}`.

8. **Environment Variables**  
   - Store configuration or runtime information.
   - Accessed using `${{ env.VAR_NAME }}`.

9. **Matrix Builds**  
   - Run jobs with multiple configurations (e.g., different OS, Node.js versions).

10. **Caching**  
    - Cache dependencies to speed up workflows (e.g., `actions/cache`).

11. **Triggers**  
    - Define when workflows run (e.g., `on: push`, `on: pull_request`).

12. **Conditional Execution**  
    - Use `if` statements to control step execution based on conditions.

13. **Artifacts**  
    - Store and share data (e.g., test results, build outputs) between jobs or workflows.

14. **Parallel and Sequential Jobs**  
    - Run jobs concurrently or define dependencies using the `needs` keyword.

15. **Self-hosted Runners**  
    - Custom runners you manage to run workflows.
