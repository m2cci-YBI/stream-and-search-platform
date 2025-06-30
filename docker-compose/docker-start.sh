#!/usr/bin/env bash
# docker-start.sh – bring up the micro-services demo stack (excluding Postgres)
#
# Usage:  ./docker-start.sh                  # normal start
#         ./docker-start.sh --build         # rebuild local images
#         ./docker-start.sh SERVICE ...     # start only selected services

set -euo pipefail

# resolve directory of this script so paths work regardless of cwd
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Compose file bundle – keep Postgres out, use host Postgres for Keycloak.
COMPOSE_ARGS=(
  -f "$SCRIPT_DIR/common.yml"
  -f "$SCRIPT_DIR/kafka_cluster.yml"
  -f "$SCRIPT_DIR/elastic_cluster.yml"
  -f "$SCRIPT_DIR/redis_cluster.yml"
  -f "$SCRIPT_DIR/monitoring.yml"
  -f "$SCRIPT_DIR/zipkin.yml"
  -f "$SCRIPT_DIR/keycloak_authorization_server.yml"  # talks to host Postgres
  -f "$SCRIPT_DIR/services.yml"
)

# Start the stack (forward any extra CLI arguments).
exec docker compose "${COMPOSE_ARGS[@]}" up -d "$@" 