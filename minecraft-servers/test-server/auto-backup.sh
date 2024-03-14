#!/usr/bin/env bash

updatevars () {
        javacommand=`sed -n 's/^javacommand=\(.*\)/\1/p' < server-info`
        servername=`sed -n 's/^servername=\(.*\)/\1/p' < server-info`
        sessionname=`sed -n 's/^sessionname=\(.*\)/\1/p' < server-info`
        worldname=`sed -n 's/^worldname=\(.*\)/\1/p' < server-info`
}
updatevars

File="server-online"

if grep -q 't' "$File"; then
	tmux send-keys -t $sessionname "say <AUTO BACKUP> $sessionname is going to temporarily shut down in one minute for a weekly automated backup! Please leave the game!" Enter
	sleep 60
	tmux send-keys -t $sessionname 'save-all' Enter
	sleep 8
	tmux send-keys -t $sessionname 'stop' Enter
	sleep 20
	tmux kill-session -t $sessionname
	sleep 1
	cd "$(dirname "${BASH_SOURCE[0]}")"
	sleep 1
	tar -czvf Backups/auto/"${worldname}_$(date "+%Y-%m-%d").tar.gz" $worldname
	echo "Automatic Backup Process Complete!"
	sleep 5
	tmux new -d -s $sessionname
        sleep 1
	tmux send-keys -t $sessionname './start.sh' Enter
	sleep 60
	tmux send-keys -t $sessionname 'say <AUTO BACKUP> Auto backup is complete!' Enter
	sleep 1
else
	echo "The minecraft server is currently offline, to preserve space, there will be no automatic backup this time."
fi

exit 0
