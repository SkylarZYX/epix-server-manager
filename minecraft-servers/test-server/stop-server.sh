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
