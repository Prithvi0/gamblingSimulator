#!/bin/bash -x
echo "Welcome to Gambling Simulator"

# CONSTANTS
BET=1
WIN=1
LOSE=0

# VARIABLES
days=30

# FUNCTION TO CHECK AMOUNT WON OR LOST ON MONTHLY BASIS
function MonthlyLoseWin () {
	for((day=1;day<=$days;day++))
	do
		stake=100   #starting stake with $100
		halfStake=$(($stake/2))
		fullStake=$((stake+halfStake))
		lost=0
		won=0
		# CONDITION TO CHECK IF stake EQUALS TO 50% LESS OR MORE THAN THE INITIAL STAKE
		while [[ $stake -gt $halfStake && $stake -lt $fullStake ]]
		do
			gamblingResult=$((RANDOM%2))	# MAKE $1 BET SO EITHER WIN or LOSE $1
			if [[ $gamblingResult -eq $WIN ]]
			then
				stake=$((stake+BET))
				won=$((won+1))
			elif [[ $gamblingResult -eq $LOSE ]]
			then
				stake=$((stake-BET))
				lost=$((lost+1))
			fi
		done
		if [[ $won -gt $lost ]]
		then
			echo "Day:$day; Won by $won-$lost=$((won-lost))"
		else
			echo "Day:$day; Lost by $lost-$won=$((lost-won))"
		fi
	done
}
MonthlyLoseWin	# CALLING THE FUNCTION
