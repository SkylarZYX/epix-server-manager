To make the scripts work properly, use this command on all scripts: 
sed -i -e 's/\r$//' script.sh && chmod 777 script.sh
makes the shells executable and also gets rid of Windows (DOS) line endings

you may have to edit the values in the scripts so they will work properly for your server, they are located at the top of the files, i plan on doing an update where you wont have to do that and you'll just have to edit a single file

dependencies: 
crontab (optional for auto backups)
tar
tmux
gzip
