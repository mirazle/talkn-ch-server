#!/bin/bash

base_path="common/ch-configs"

# Function to start docker-compose for each service
start_docker_compose() {
  local compose_file=$1
  echo "Starting service with $compose_file"
  docker-compose -f $compose_file up -d
}

# Start the redis service
# redis_compose_file="$base_path/compose.redis.yml"
# if [ -f "$redis_compose_file" ]; then
#   start_docker_compose "$redis_compose_file"
# else
#   echo "Redis compose file not found: $redis_compose_file"
#   exit 1
# fi

# Start the root service
start_docker_compose "$base_path/compose.server.yml"

# Find and start all other services
find $base_path -name "compose.server.yml" -not -path "$base_path/compose.server.yml" | while read -r compose_file; do
  start_docker_compose "$compose_file"
done

echo "All services have been started."
