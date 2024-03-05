To make the scripts work properly, use this command on all scripts: 

sed -i -e 's/\r$//' script.sh && chmod 777 script.sh

makes the shells executable and also gets rid of Windows (DOS) line endings

you may have to edit the values in the scripts so they will work properly for your server, they are located at the top of the files, i plan on doing an update where you wont have to do that and you'll just have to edit a single file

to detach from tmux sessions back to regular shell, use Ctrl + B, then D. 

Ctrl + C will possibly break the server manager, as the server will stop and the manager will not register that, so you may need to change the values in the server-online file.

server-online values:

f = server is offline

t = server is online

dependencies: 
crontab (optional for auto backups)
tar
tmux
gzip
