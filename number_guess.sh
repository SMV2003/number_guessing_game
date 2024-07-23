#!/usr/bin/bash
PSQL="psql --username=postgres --dbname=number_guess --port=5433 -t --no-align -c"
echo Enter your username:
read USERNAME

USERID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
if [[ -z $USERID ]]
then
    echo Welcome, $USERNAME! It looks like this is your first time here.
else
     echo Welcome back $USERNAME! with id $USERID
fi
