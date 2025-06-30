#!/usr/bin/env bash
# docker-start.sh – bring up the micro-services demo stack (excluding Postgres)
#
# Usage:  ./docker-start.sh                  # normal start
#         ./docker-start.sh --build         # rebuild local images
#         ./docker-start.sh SERVICE ...     # start only selected services

set -euo pipefail

# Compose file bundle – keep Postgres out, use host Postgres for Keycloak.
COMPOSE_ARGS=(
  -f docker-compose/common.yml
  -f docker-compose/kafka_cluster.yml
  -f docker-compose/elastic_cluster.yml
  -f docker-compose/redis_cluster.yml
  -f docker-compose/monitoring.yml
  -f docker-compose/zipkin.yml
  -f docker-compose/keycloak_authorization_server.yml  # talks to host Postgres
  -f docker-compose/services.yml
)

# Start the stack (forward any extra CLI arguments).
exec docker compose "${COMPOSE_ARGS[@]}" up -d "$@" 