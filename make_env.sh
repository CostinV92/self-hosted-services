#!/bin/bash

# Save the current working directory
BASE_DIR="$(pwd)"

# Ensure .env.global exists
if [[ ! -f "$BASE_DIR/.env.global" ]]; then
  echo "Error: .env.global not found in $BASE_DIR"
  exit 1
fi

# Loop through all directories in the current directory
for dir in "$BASE_DIR"/*/; do
  # Check if it's a directory
  if [[ -d "$dir" ]]; then
    LOCAL_ENV="$dir/.env.local"
    OUTPUT_ENV="$dir/.env"

    # If .env.local exists in the subdirectory
    if [[ -f "$LOCAL_ENV" ]]; then
      echo "Creating .env in $dir"

      # Merge .env.global and .env.local into .env
      cat "$BASE_DIR/.env.global" "$LOCAL_ENV" > "$OUTPUT_ENV"
    fi
  fi
done