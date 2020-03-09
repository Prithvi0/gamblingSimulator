#!/bin/bash -x
echo "Welcome to Gambling Simulator"

# CONSTANTS
BET=1
WIN=1
LOSE=0

# VARIABLES
stake=100							# START WITH A STAKE OF $100
halfStake=$((stake/2))
fullStake=$((stake+halfStake))

# CONDITION TO CHECK IF stake EQUALS TO 50% LESS OR MORE THAN THE INITIAL STAKE
while [[ $stake -gt $halfStake && $stake -lt $fullStake ]]
do
	gamblingResult=$((RANDOM%2))				# MAKE $1 BET SO EITHER WIN or LOSE $1
	if [[ $gamblingResult -eq $WIN ]]
	then
		stake=$((stake+BET))
	elif [[ $gamblingResult -eq $LOSE ]]
	then
		stake=$((stake-BET))
	fi
done

# IF WON OR LOST 50% OF THE STAKE, GAMBLER WOULD RESIGN FOR THE DAY
if [[ $stake -gt $halfStake ]]
then
	echo "You Won, resign for the day."
else
	echo "You Lost, resign for the day."
fi
