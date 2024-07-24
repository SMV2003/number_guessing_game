#!/usr/bin/bash
PSQL="psql --username=postgres --dbname=number_guess --port=5433 -t --no-align -c"
echo Enter your username:
read USERNAME

USERID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
if [[ -z $USERID ]]
then
    echo Welcome, $USERNAME! It looks like this is your first time here.
    ADD_USER=$($PSQL "INSERT INTO users(username) VALUES ('$USERNAME')")
    USERID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
else
     GAMES="$($PSQL "SELECT COUNT(game_id) FROM games WHERE user_id=$USERID")"
     MIN_GUESSES="$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USERID")"
     echo Welcome back, $USERNAME! You have played $GAMES games, and your best game took $MIN_GUESSES guesses. 
fi
RNDNUM=$(( $RANDOM%1000+1 ))
GUESS=0
PGUESS=0
echo Guess the number between 1-1000:$RNDNUM
read GUESS
if [[ ! $GUESS =~ ^[0-9]+$ ]] 
        then
            echo That is not a integer guess again:
            read $GUESS
            PGUESS=$(($PGUESS + 1))
        fi
PGUESS=$(($PGUESS + 1))
while [[ $GUESS -ne $RNDNUM ]]
do
    if [[ $GUESS -gt $RNDNUM ]]
    then
        echo "It's lower than that, guess again:"
        PGUESS=$(($PGUESS + 1))
        read GUESS
        if [[ ! $GUESS =~ ^[0-9]+$ ]] 
        then
            echo That is not a integer guess again:
            read $GUESS
            PGUESS=$(($PGUESS + 1))
        fi
    elif [[ $GUESS -lt $RNDNUM ]]
    then
        echo "It's higher than that, guess again:"
        PGUESS=$(($PGUESS + 1))
        read GUESS
        if [[ ! $GUESS =~ ^[0-9]+$ ]] 
        then
            echo That is not a integer guess again:
            read $GUESS
            PGUESS=$(($PGUESS + 1))
        fi
    else
    echo correct!
    fi 
done

echo You guessed it in $PGUESS tries. The secret number was $RNDNUM.