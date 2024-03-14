**Epix Server Manager v1.1**

you have to edit the values at the top of the mc-srvs script with your minecraft server directories to get it to register!

to get the server running with your server jar, edit the server info by pressing 8 in the mc-manage manager and you should be able to change the java command, you also can change the world name for backup scripts to register it, and server.properties once that is created. tmux sessison name can be changed as well to prevent session mix-ups when running multiple servers.

to detach from tmux sessions back to regular shell, use Ctrl + B, then D. 

**troubleshooting:**

Ctrl + C will possibly break the server manager, as the server will stop and the manager will not register that, so you may need to change the values in the server-online file.

server-online values:

f = server is offline

t = server is online

If the scripts do not want to run, make sure they are executable!
Use this command in the directory that mc-srvs and your minecraft servers directories are located at: chmod 775 mc-srvs && find . -name "*.sh" -exec chmod 775 {} \;

the command will recursively change the scripts to be executable with chmod.

**dependencies:**
crontab (optional for auto backups)
gzip
nano
tar
tmux
