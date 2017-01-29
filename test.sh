#!/bin/sh

# Database
# docker-compose up -d --build training-postgres-s

docker-compose build training-test-s

docker-compose run training-test-s

docker-compose down
