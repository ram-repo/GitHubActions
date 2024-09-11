# Runners and Workflow Examples

In GitHub Actions, a runner is a server that runs your workflows when triggered. There are two types of runners:

- **GitHub-hosted runners**: GitHub provides these, and they run in a virtual environment. They come pre-configured with many tools and software.
- **Self-hosted runners**: These are machines you manage yourself, which can run jobs from GitHub Actions.

Here’s an example of how to set up a simple workflow in GitHub Actions using GitHub-hosted runners.

## Example 1: Simple Python CI with Pytest

This example will run tests using `pytest` on every push and pull request.

### Steps:
1. Create a directory called `.github/workflows/` in your repository.
2. Inside that directory, create a file called `python-app.yml` (or any other name you prefer).
3. Add the following content to the `python-app.yml` file:

```yaml
name: Python application test

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install pytest

    - name: Run tests
      run: |
        pytest
```

## Explanation:

- **on**: Defines the events that trigger the workflow. In this case, it's triggered on push and pull requests to the `main` branch.
- **runs-on**: Specifies the type of runner. We use `ubuntu-latest`, which is a GitHub-hosted runner.
- **steps**: These are individual tasks in the job:
  - **Checkout code**: Pulls the latest code from the repository.
  - **Set up Python**: Configures the specified version of Python (in this case, Python 3.9).
  - **Install dependencies**: Installs the required packages listed in `requirements.txt` and `pytest`.
  - **Run tests**: Executes the tests using `pytest`.

## Example 2: Adding Matrix Testing

Matrix testing allows you to run tests across multiple Python versions.

```yaml
name: Python application test with matrix

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        python-version: ['3.7', '3.8', '3.9', '3.10']

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install pytest

    - name: Run tests
      run: |
        pytest
```
