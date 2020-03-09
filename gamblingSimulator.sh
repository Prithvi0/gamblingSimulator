#!/bin/bash -x
echo "Welcome to Gambling Simulator"

# CONSTANTS
BET=1
WIN=1
LOSE=0

# VARIABLES
days=30
count=0

declare -a Array
# FUNCTION TO CHECK AMOUNT WON OR LOST ON MONTHLY BASIS
function MonthlyLoseWin () {
	for((day=1;day<=$days;day++))
	do
		stake=100   #starting stake with $100
		halfStake=$(($stake/2))
		fullStake=$((stake+halfStake))
		tempStake=$stake
		won=0
		lost=0
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

		if [[ $stake -gt $tempStake ]]
		then
			winDifference=$((stake-tempStake))
			Array[$count]=$winDifference
		else
			lostDifference=$((stake-tempStake))
			Array[$count]=$lostDifference
		fi
		count=$((count+1))
done
}
MonthlyLoseWin # CALLING THE FUNCTION

function LuckiestUnluckiestDay () {
	tempValue=0
	# CALCULATING LUCKIEST AND UNLUCKIEST DAY
	for((day=0;day<$days;day++))
	do
		tempValue=$(($tempValue+"${Array[$day]}"))
		# CONDITION TO CHECK THE MAXIMUM WON AND CONSIDER IT AS LUCKIEST DAY
		if [[ $maxWon -le $tempValue ]]
		then
		   maxWon=$tempValue
		   luckyDay=$((day+1))
		fi
		# CONDITION TO CHECK THE MAXIMUM LOST AND CONSIDER IT AS UNLUCKIEST DAY
		if [[ $maxLost -ge $tempValue ]]
		then
		   maxLost=$tempValue
		   unluckyDay=$((day+1))
		fi
	done
	echo "Luckiestday:$luckyDay; Won:$maxWon"
	echo "Unluckiestday:$unluckyDay; Lost:$maxLost"
}
LuckiestUnluckiestDay	# CALLING THE FUNCTION
