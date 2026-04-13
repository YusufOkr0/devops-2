#!/usr/bin/env bash
set -euo pipefail

# Idempotent deploy script run on EC2.
# Responsibilities:
#  - Ensure we're in the compose project directory
#  - Pull the latest image from Docker Hub
#  - Restart the compose stack

APP_DIR="${APP_DIR:-$HOME/school-management}"
COMPOSE_FILE="${COMPOSE_FILE:-docker-compose.yml}"
IMAGE="${IMAGE:-yusufokr0/school-management-2:latest}"

if [[ ! -d "$APP_DIR" ]]; then
  echo "ERROR: APP_DIR '$APP_DIR' does not exist. Create it and place docker-compose.yml there." >&2
  exit 1
fi

cd "$APP_DIR"

if [[ ! -f "$COMPOSE_FILE" ]]; then
  echo "ERROR: '$APP_DIR/$COMPOSE_FILE' not found." >&2
  exit 1
fi

echo "Pulling image: $IMAGE"
docker pull "$IMAGE"

echo "Restarting stack in $APP_DIR"
# Prefer docker compose (v2) but fall back to docker-compose (v1)
if docker compose version >/dev/null 2>&1; then
  docker compose -f "$COMPOSE_FILE" down
  docker compose -f "$COMPOSE_FILE" up -d
else
  docker-compose -f "$COMPOSE_FILE" down
  docker-compose -f "$COMPOSE_FILE" up -d
fi

echo "Done."
