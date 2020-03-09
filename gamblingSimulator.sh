#!/bin/bash -x
echo "Welcome to Gambling Simulator"
# ARRAY DECLARATION
declare -a Array

# CONSTANTS
BET=1
WIN=1
LOSE=0

# VARIABLES
days=30
monthEnd=100
maxWon=0
maxLost=0

# FUNCTION TO CHECK AMOUNT WON OR LOST ON MONTHLY BASIS
function MonthlyLoseWin () {
	count=0
	for((day=1;day<=$days;day++))
	do
		stake=100   					# STATING STAKE WITH $100
		halfStake=$(($stake/2))
		fullStake=$((stake+halfStake))
		tempStake=$stake
		won=0
		lost=0
		# CONDITION TO CHECK IF stake EQUALS TO 50% LESS OR MORE THAN THE INITIAL STAKE
		while [[ $stake -gt $halfStake && $stake -lt $fullStake ]]
		do
			gamblingResult=$((RANDOM%2))  		# MAKE $1 BET SO EITHER WIN or LOSE $1
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
			Array[$count]=$winDifference		# STORING WINNING VALUES IN AN ARRAY
		else
			lostDifference=$((stake-tempStake))	# STORING LOSING VALUES IN AN ARRAY
			Array[$count]=$lostDifference
		fi
		count=$((count+1))
	done
}

# FUNCTION TO PRINT LUCKIEST AND UNLUCKIEST DAY
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

# CONDITION TO CONTINUE PLAYING NEXT MONTH OR STOP GAMBLING
while [[ $monthEnd -gt 0 ]]
do
	MonthlyLoseWin		# CALLING THE FUNCTION
	LuckiestUnluckiestDay	# CALLING THE FUNCTION
	echo "${Array[@]}"	# PRINTING STORED ARRAY VALUES
	monthEnd=$tempValue
	echo "Your amount won/loss is $monthEnd"
done
