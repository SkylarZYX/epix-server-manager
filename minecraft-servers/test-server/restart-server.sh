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
	tmux send-keys -t $sessionname 'save-all' Enter
	echo "Saving World Files..."
	sleep 5
	tmux send-keys -t $sessionname 'stop' Enter
	echo "Stopping Server..."
	sleep 15
	tmux kill-session -t $sessionname
        sleep 1
	tmux new -d -s $sessionname
        sleep 1
	tmux send-keys -t $sessionname './start.sh' Enter
	echo "Start Server Request Sent"
	sleep 1
else
	echo "server is offline!"
fi

exit 0
