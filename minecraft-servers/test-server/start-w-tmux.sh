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

if grep -q 'f' "$File"; then
	echo "Starting Server..."
	tmux new -d -s $sessionname
	sleep 2
	tmux send-keys -t $sessionname './start.sh' Enter
	echo "Sent Server Start Request"
	echo "t" > $File
else
	echo "Minecraft server is already running!"
fi

exit 0
