#!/bin/bash

# Save the current working directory
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

SERVICE=""

usage() {
  echo "Usage: "$0" [service]"
  exit 1
}

err() {
  echo "$1"
  exit 1
}

parse_args() {
  argsc="$1"
  if [[ "$argsc" == "1" ]]; then
    SERVICE="$2"
  elif [[ "$argsc" == "0" ]]; then
    SERVICE=""
  else
    usage
  fi
}

make_env_service() {
  service_name="$1"
  service_dir="$BASE_DIR/$service_name"

  # Check if it's a directory
  if [[ ! -d "$service_dir" ]]; then
    echo "Service "$service_name" not found"
    return
  fi

  # If this is a service directory
  if [[ ! -f "$service_dir/compose.yml" || ! -f "$service_dir/.env.local" ]]; then
    echo "Service "$service_name" is not a valid service"
    return
  fi

  echo "Creating .env for "$service_name""
  cat "$BASE_DIR/.env.global" "$service_dir/.env.local" > "$service_dir/.env"
}

make_env_all() {
  # Loop through all directories in the current directory
  for dir in "$BASE_DIR"/*/; do
    # Check if it's a directory
    if [[ ! -d "$dir" ]]; then
      continue
    fi

    # If this is a service directory
    if [[ ! -f "$dir/compose.yml" || ! -f "$dir/.env.local" ]]; then
      continue
    fi

    make_env_service $(basename "$dir")
  done
}

main() {
  # Ensure .env.global exists
  if [[ ! -f "$BASE_DIR/.env.global" ]]; then
    err "Error: .env.global not found in "$BASE_DIR""
  fi

  parse_args "$#" "$@"
  if [[ "$SERVICE" == "" ]]; then
    make_env_all
  else
    make_env_service "$SERVICE"
  fi
}

main "$@"
