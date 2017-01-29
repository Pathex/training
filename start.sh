#!/bin/sh

# Database
# docker-compose up -d --build training-postgres-s

docker-compose build training-s

docker-compose run training-s
