#!/usr/bin/env bash

sessionname="mc-test"
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
