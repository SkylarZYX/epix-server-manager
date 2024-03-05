#!/usr/bin/env bash

sessionname="mc-test"
worldname="world"
File="server-online"

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "WARNING! IF THERE ARE CURRENTLY NO RECENT BACKUPS, YOU RISK LOSING THE CURRENT WORLD PROGRESS!"
echo "Are you sure you want to restore the servers world files? (y/n)"
read warnreply

if [ "$warnreply" = "y" ]; then
	echo "continuing"
else
	if [ "$warnreply" = "n" ]; then
		exit 0
	else
		echo "invalid value, exiting"
		exit 0
	fi
fi

echo "Choose a backup directory:"
echo ""
echo "Auto Backups [1]"
echo "Manual Backups [2]"
echo ""
read bckupreply

if [ $bckupreply == 1 ] ; then
	cd Backups/auto
	echo "List of auto backups:"
	ls -l
	echo ""
	echo "Please enter the exact name of a backup listed here:"
	read backupname
	if [[ -z "$backupname" ]]; then
		echo "backup name invalid"
		exit 0
	else
		echo "continuing"
	fi
	cd ..
	cd ..
	if grep -q 't' "$File"; then
		echo "Stopping server..."
		tmux send-keys -t $sessionname 'stop' Enter
		sleep 15
		tmux kill-session -t $sessionname
        	sleep 1
		echo "Copying archive..."
		cp Backups/auto/$backupname $backupname
		echo "Removing world directory..."
		rm -r -v $worldname
		echo "Extracting backup archive in server directory..."
		tar -zxvf $backupname
		sleep 5
		echo "Removing copied backup archive from server root directory..."
		rm -v $backupname
		tmux new -d -s $sessionname
        	sleep 1
		tmux send-keys -t $sessionname './start.sh' Enter
		echo "Sent Server Start Request"
		echo "Server restore process completed!"
		exit 0
	else
		echo "Copying archive..."
                cp Backups/auto/$backupname $backupname
                echo "Removing world directory..."
                rm -r -v $worldname
                echo "Extracting backup archive in server directory..."
                tar -zxvf $backupname
                sleep 5
                echo "Removing copied backup archive from server root directory..."
                rm -v $backupname
                sleep 1
		echo "Server restore process completed!"
		exit 0
	fi
else
	if [ $bckupreply == 2 ] ; then
        	cd Backups/manual
		echo "List of manual backups:"
		ls -l
		echo ""
		echo "Please enter the exact name of a backup listed here:"
		read backupname
		if [[ -z "$backupname" ]]; then
			echo "backup name invalid"
			exit 0
		else
			echo "continuing"
		fi
		cd ..
		cd ..
		if grep -q 't' "$File"; then
			echo "Stopping server..."
			tmux send-keys -t $sessionname 'stop' Enter
			sleep 15
			tmux kill-session -t $sessionname
                	sleep 1
			echo "Copying archive..."
			cp Backups/manual/$backupname $backupname
			echo "Removing world directory..."
			rm -r -v $worldname
			echo "Extracting backup archive in server directory..."
			tar -zxvf $backupname
			sleep 5
			echo "Removing copied backup archive from server root directory..."
			rm -v $backupname
			tmux new -d -s $sessionname
			sleep 1
			tmux send-keys -t $sessionname './start.sh' Enter
			echo "Sent Server Start Request"
			echo "Server restore process completed!"
			exit 0
		else
			echo "Copying archive..."
                	cp Backups/manual/$backupname $backupname
                	echo "Removing world directory..."
                	rm -r -v $worldname
                	echo "Extracting backup archive in server directory..."
                	tar -zxvf $backupname
                	sleep 5
                	echo "Removing copied backup archive from server root directory..."
                	rm -v $backupname
                	sleep 1
			echo "Server restore process completed!"
			exit 0
		fi
	else
		echo "invalid number"
		exit 0
	fi
fi
