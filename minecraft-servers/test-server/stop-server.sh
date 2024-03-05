#!/usr/bin/env bash

sessionname="mc-test"
File="server-online"

cd "$(dirname "${BASH_SOURCE[0]}")"

if grep -q 't' "$File"; then
	echo "Sending stop server request..."
	tmux send-keys -t $sessionname 'stop' Enter
	sleep 20
	tmux kill-session -t $sessionname
	echo "f" > $File
else
	echo "Minecraft server is already stopped!"
fi

exit 0
