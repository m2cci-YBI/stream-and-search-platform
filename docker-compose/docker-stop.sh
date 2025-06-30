#!/usr/bin/env bash
# docker-stop.sh – stop and remove the demo stack containers (leaves data volumes intact)
#
# Usage:  ./docker-stop.sh                # stop everything
#         ./docker-stop.sh -v             # also remove anonymous volumes

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

COMPOSE_ARGS=(
  -f "$SCRIPT_DIR/common.yml"
  -f "$SCRIPT_DIR/kafka_cluster.yml"
  -f "$SCRIPT_DIR/elastic_cluster.yml"
  -f "$SCRIPT_DIR/redis_cluster.yml"
  -f "$SCRIPT_DIR/monitoring.yml"
  -f "$SCRIPT_DIR/zipkin.yml"
  -f "$SCRIPT_DIR/keycloak_authorization_server.yml"
  -f "$SCRIPT_DIR/services.yml"
)

# Stop containers and optionally prune anonymous volumes.
if [[ "${1:-}" == "-v" ]]; then
  shift
  docker compose "${COMPOSE_ARGS[@]}" down --remove-orphans --volumes "$@"
else
  docker compose "${COMPOSE_ARGS[@]}" down --remove-orphans "$@"
fi 