#!/bin/bash

# List of your repositories and their new GitHub URLs
repos_keys=(

    "amagi/analytics-datapipeline-orchestration"
    "amagi/analytics-datapipeline-transform"
    "amagi/analytics-infra"
    "amagi/analytics-management-backend"
    "amagi/analytics-management-backend/analytics-datapipeline-orchestration"
    "cacofonix"
    "habu"
    "habu/unhygienix"
    "habu_spark_generc_framework/spar"
    "leolabs-cdm-work/loupe"
    "mactores/dw-xiba"
    "mactores/ecom-dw-bqetl"
    "mactores/ecom-dw-clients"
    "o11y-smaas-flink"
    "pyspark-rds-archival"
    "rds-tiering-glue-tf"
    "spark_generic_framework/spark_generic_framework"
    "teragonia/dw-dbt"
    "teragonia/dw-dbt-discovery"
    "toplyne-data-poc"
    "toplyne/EMR_POC"
    "toplyne/airflow"
    "unimpedimenta"
)

repo_url="https://github.com/Aniketrajput039"

base_dir="/Users/aniketrajput/Desktop/velotio_production_work/production_work"

access_token="ADD_TOKEN_HERE"

# GitHub API URL (endpoint for creating repositories)
api_url="https://api.github.com/user/repos"

for ((i = 0; i < ${#repos_keys[@]}; i++)); do
  repo="${repos_keys[$i]}"

  # Prepend "pw_velotio_" to the repository name
  # Check if the path contains "/" or "-"
  if [[ "$repo" =~ "/" || "$repo" =~ "-" ]]; then
    # Replace "/" with "__" and "-" with "_" using parameter expansion
    prefixed_repo="pw_velotio_$(echo "${repo//\//__}" | tr '-' '_')"
  else
    # Prepend "pw_velotio_" for paths without "/" or "-"
    prefixed_repo="pw_velotio_$repo"
  fi

  repo_path="$base_dir/$repo"

  cd "$repo_path" || { echo "Failed to navigate to $repo_path"; continue; }


  # Construct the request body for creating a repository with the prefix
  repo_data="{\"name\":\"$prefixed_repo\", \"private\": true}"

  # Use curl to send a POST request to the GitHub API with authentication
  curl -s -X POST -H "Authorization: token $access_token" -d "$repo_data" "$api_url"

  # Check for successful response (remove this line if not interested in response)
  curl_status=$?
  if [ $curl_status -eq 0 ]; then
    echo "Successfully created repository: $prefixed_repo"
  else
    echo "Error creating repository: $prefixed_repo (check API response)"
  fi

  # Overwrite the existing 'origin' remote with the new URL
  git remote set-url origin "https://github.com/Aniketrajput039/$prefixed_repo.git"

  # Push all branches to the remote repository
  git push -u origin --all
done