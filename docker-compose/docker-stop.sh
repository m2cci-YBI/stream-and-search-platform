#!/usr/bin/env bash
# docker-stop.sh – stop and remove the demo stack containers (leaves data volumes intact)
#
# Usage:  ./docker-stop.sh                # stop everything
#         ./docker-stop.sh -v             # also remove anonymous volumes

set -euo pipefail

COMPOSE_ARGS=(
  -f docker-compose/common.yml
  -f docker-compose/kafka_cluster.yml
  -f docker-compose/elastic_cluster.yml
  -f docker-compose/redis_cluster.yml
  -f docker-compose/monitoring.yml
  -f docker-compose/zipkin.yml
  -f docker-compose/keycloak_authorization_server.yml
  -f docker-compose/services.yml
)

# Stop containers and optionally prune anonymous volumes.
if [[ "${1:-}" == "-v" ]]; then
  shift
  docker compose "${COMPOSE_ARGS[@]}" down --remove-orphans --volumes "$@"
else
  docker compose "${COMPOSE_ARGS[@]}" down --remove-orphans "$@"
fi 