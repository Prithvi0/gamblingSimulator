#!/bin/bash -x
echo "Welcome to Gambling Simulator"

# START WITH A STAKE OF $100 EVERYDAY AND BET OF $1 EVERY GAME.

# CONSTANTS
STAKE=100
BET=1
WIN=1
LOSE=0

# MAKE $1 BET SO EITHER WIN or LOSE $1
gamblingResult=$((RANDOM%2))
if [[ $gamblingResult -eq $WIN ]]
then
	STAKE=$((STAKE+BET))
	echo "Won"
elif [[ $gamblingResult -eq $LOSE ]]
then
	STAKE=$((STAKE-BET))
	echo "Lost"
fi
