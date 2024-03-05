#!/usr/bin/env bash

servername="MCTEST"
sessionname="mc-test"

menu () {
	echo "$servername"
	echo "Options:"
	echo ""
	echo "Start Server [1]"
	echo "Restart Server [2]"
	echo "Stop Server [3]"
	echo "Enter Server Console [4]"
	echo "List Backups [5]"
	echo "Perform a manual backup [6]"
	echo "Restore server world files [7]"
	echo "Edit server.properties [8]"
	echo "Exit Options Menu [9]"
	echo ""
	echo "Please enter an option number [#]"
	read srvno

	if [ $srvno == 1 ] ; then
        	./start-w-tmux.sh
		menu
	else
        	if [ $srvno == 2 ] ; then
                	./restart-server.sh
			menu
        	else
                	if [ $srvno == 3 ] ; then
                        	./stop-server.sh
				menu
                	else
                        	if [ $srvno == 4 ] ; then
                                	tmux attach-session -t $sessionname
					menu
                        	else
                                	if [ $srvno == 5 ] ; then
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
							cd ..
							cd ..
							menu
						else
							if [ $bckupreply == 2 ] ; then
								cd Backups/manual
								echo "List of manual backups:"
								ls -l
								cd ..
								cd ..
								menu
							else
								echo "invalid value"
								menu
							fi
						fi
					else
						if [ $srvno == 6 ] ; then
							./manual-backup.sh
							menu
						else
							if [ $srvno == 7 ] ; then
								./restore-server.sh
								menu
							else
								if [ $srvno == 8 ] ; then
									nano server.properties
									menu
								else
									if [ $srvno == 9 ] ; then
										exit 0
									else
										echo "invalid number!"
										menu
									fi
								fi
							fi
						fi
					fi
                        	fi
                	fi
        	fi
	fi
}

menu
