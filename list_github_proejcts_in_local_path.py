import os


def list_git_projects_recursively(base_dir):
    print("-------")
    git_projects = []
    for root, dirs, files in os.walk(base_dir):
        if '.git' in dirs:
            # Get the relative path from the base directory to the git project
            relative_path = os.path.relpath(root, base_dir)
            git_projects.append(relative_path)
            # Remove '.git' from dirs so that we don't go into the .git directory
            dirs.remove('.git')
    # Sort the list of git projects alphabetically
    git_projects.sort()
    # Print the sorted list of git projects
    for project in git_projects:
        print(project)


if __name__ == "__main__":
    # Set the path to your parent repository
    base_directory = "/Users/aniketrajput/Desktop/Aniket/aniket_work/production_work"

    list_git_projects_recursively(base_directory)