#!/bin/bash

# Function to extract the docker image name from the URL
extract_image_name() {
    local url="$1"
    local repo_name="${url##*/r/}"
    echo "$repo_name"
}

read -p "Enter the Docker Hub URL: " url
result=$(extract_image_name "$url")

# Build the docker image
docker build -t result .

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Docker image '$repo_name' built successfully."
else
    echo "Failed to build the Docker image '$repo_name'."
fi
