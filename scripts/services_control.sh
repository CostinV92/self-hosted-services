#!/bin/bash

# Save the current working directory
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

COMMAND=""
SERVICE=""

usage() {
  echo "Usage: "$0" [service] <up|down|restart>"
  exit 1
}

err() {
  echo "$1"
  exit 1
}

parse_args() {
  argsc="$1"
  if [[ "$argsc" == "1" ]]; then
    COMMAND="$2"
  elif [[ "$argsc" == "2" ]]; then
    SERVICE="$2"
    COMMAND="$3"
  else
    usage
  fi

  if [[ "$COMMAND" != "up" && "$COMMAND" != "down" && "$COMMAND" != "restart" ]]; then
    usage
  fi
}

make_env() {
  service_name="$1"

  "$BASE_DIR/scripts/make_env.sh" "$service_name"
  if [[ "$?" != "0" ]]; then
    err "Failed to generate env files"
  fi
}

cd_and_up() {
  cd "$1"
  if [[ "$?" != "0" ]]; then
    err "Failed to cd to "$1""
  fi

  local cmd="$2"

  service_name="$(basename "$1")"
  echo "Trying to "$cmd" "$service_name""

  if [[ "$cmd" == "up" ]]; then
    make_env "$service_name"
  fi

  case "$cmd" in
    "up") docker compose up -d ;;
    "restart") docker compose restart ;;
    "down") docker compose down ;;
  esac
}

up_all_services() {
  # Loop through all directories in the current directory
  for dir in "$BASE_DIR"/*/; do
    # Check if it's a directory
    if [[ ! -d "$dir" ]]; then
      continue
    fi

    # If this is a service directory
    if [[ ! -f "$dir/compose.yml" ]]; then
      continue
    fi

    cd_and_up "$dir" "$COMMAND"
  done
}

up_service() {
  service_dir="$BASE_DIR/$1"
  # If this is a service directory
  if [[ ! -f "$service_dir/compose.yml" ]]; then
    err "service "$1" not found"
  fi

  cd_and_up "$service_dir" "$COMMAND"
}

main() {
  parse_args "$#" "$@"
  if [[ "$SERVICE" == "" ]]; then
    up_all_services
  else
    up_service "$SERVICE" "$COMMAND"
  fi
}

main "$@"
