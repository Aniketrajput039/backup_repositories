# Repository Consolidation Process

This repository consolidates multiple GitHub repositories into a single parent repository using a script. Below are the steps and considerations for executing this process.

## Prerequisites

Before running the script, ensure you have:

- Cloned all individual repositories locally.
- Organized them under a common parent directory (`base_dir`).
- Generated a GitHub personal access token (`access_token`) with appropriate permissions for repository creation and modification.

## Steps

### Step 1: Prepare the Script

- **Script:** `backup_repositories.sh`
- **Purpose:** This script changes the remote URLs of multiple repositories to a single parent repository, creates new repositories on GitHub if needed, and pushes all branches to the new parent repository.

### Step 2: Finding GitHub Projects

#### Script: `list_git_projects_recursively.py`

This Python script is designed to recursively search for directories containing Git repositories within a specified base directory (`base_directory`). It identifies directories that include a `.git` subdirectory, indicating the presence of a Git repository.

#### Usage

1. **Set the Base Directory:**
   - Modify the `base_directory` variable in the script to point to your parent directory where Git repositories are located.

2. **Execute the Script:**
   - Run the script using Python to generate a list of Git projects.

#### Example

```bash
python list_git_projects_recursively.py
```
#### Output

The script `list_git_projects_recursively.py` outputs a sorted list of paths to directories containing Git repositories. Each path represents a local Git project relative to the `base_directory`.

**Instructions for Integration:**

1. Run the `list_git_projects_recursively.py` script to generate the list of Git projects.
2. Copy and paste the sorted list of paths directly into the `repos_keys` array in your `backup_repositories.sh` script.
3. Ensure each path is correctly represented in the `repos_keys` array to include all desired Git repositories for consolidation.


### Step 2: Configure Variables

- **Variables:**
  - `repos_keys`: Array containing local paths of individual repositories relative to `base_dir`.These paths represent the names and nested structures of your local repositories. For example, amagi/analytics-datapipeline-orchestration specifies a repository located at base_dir/amagi/analytics-datapipeline-orchestration.
  - `repo_url`: Base URL of the parent repository on GitHub.
  - `base_dir`: Base directory where all individual repositories are located locally.
  - `access_token`: GitHub personal access token for API authentication.
  - `api_url`: GitHub API endpoint for creating repositories.

### Step 3: Execute the Script

- Navigate to the directory containing `backup_repositories.sh`.
- Run the script using `./backup_repositories.sh`.

### Step 4: Script Execution Details

- The script iterates through each repository path (`repos_keys`).
- For each repository:
  - If needed, it creates a new repository on GitHub with a prefixed name.
  - Changes the remote URL of the local repository to the new GitHub repository.
  - Pushes all branches and tags to the new remote repository.

### Step 5: Monitoring and Verification

- Monitor script execution for any errors or warnings.
- Check the GitHub repository (parent repository) to verify all branches and code are correctly pushed.

### Step 6: Cleanup

- After successful execution, review and delete unnecessary local repositories or backups as needed.

## Example Usage

```bash
./backup_repositories.sh
```


