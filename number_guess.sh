#!/usr/bin/bash
PSQL="psql --username=postgres --dbname=number_guess --port=5433 -t --no-align -c"
echo Enter your username:
read USERNAME

USERID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
if [[ -z $USERID ]]
then
    echo Welcome, $USERNAME! It looks like this is your first time here.
else
     GAMES="$($PSQL "SELECT COUNT(game_id) FROM games WHERE user_id=$USERID")"
     MIN_GUESSES="$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USERID")"
     echo Welcome back, $USERNAME! You have played $GAMES games, and your best game took $MIN_GUESSES guesses. 
fi
