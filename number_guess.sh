#!/usr/bin/bash
PSQL="psql --username=postgres --dbname=postgres --port=5433 -t --no-align -c"
echo Enter your username:
read USERNAME