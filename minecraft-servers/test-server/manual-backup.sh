#!/usr/bin/env bash

updatevars () {
        javacommand=`sed -n 's/^javacommand=\(.*\)/\1/p' < server-info`
        servername=`sed -n 's/^servername=\(.*\)/\1/p' < server-info`
        sessionname=`sed -n 's/^sessionname=\(.*\)/\1/p' < server-info`
        worldname=`sed -n 's/^worldname=\(.*\)/\1/p' < server-info`
}
updatevars

File="server-online"

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "List of manual backups:"
cd Backups/manual
ls -l
echo ""
echo "Please enter your backup name:"
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
	tmux send-keys -t $sessionname 'save-all' Enter
	echo "Saving World Files..."
	sleep 5
	tmux send-keys -t $sessionname 'stop' Enter
	echo "Stopping Server..."
	sleep 10
	tmux kill-session -t $sessionname
	echo "Starting to archive..."
	tar -czvf Backups/manual/"${backupname}_$(date "+%Y-%m-%d").tar.gz" $worldname
	echo "Backup Process Complete!"
	tmux new -d -s $sessionname
	sleep 1
	tmux send-keys -t $sessionname './start.sh' Enter
	echo "Start Server Request Sent"
	sleep 1
else
	echo "Starting to archive..."
        tar -czvf Backups/manual/"${backupname}_$(date "+%Y-%m-%d").tar.gz" $worldname
        echo "Backup Process Complete!"
        sleep 1
fi

exit 0
