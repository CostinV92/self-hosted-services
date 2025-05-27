#!/bin/bash

# Save the current working directory
BASE_DIR="$(pwd)"
echo $BASE_DIR
command=$1

if [[ "$command" == "" ]]; then
  echo "Usage: $0 <up|down>"
  exit 1
fi

run_command() {
  cd $1
  local cmd=$2

  if [[ "$cmd" == "up" ]]; then
    docker compose up -d
  elif [[ "$cmd" == "down" ]]; then
    docker compose down
  fi
}

# Loop through all directories in the current directory
for dir in "$BASE_DIR"/*/; do
  # Check if it's a directory
  if [[ -d "$dir" ]]; then
    # If this is a service directory
    if [[ -f "$dir/compose.yml" ]]; then
      echo "service in $dir $command"

      run_command $dir $command
    fi
  fi
done
