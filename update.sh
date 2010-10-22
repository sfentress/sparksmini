#!bin/bash
#
# This is the update script for the SPARKS local server. It should be symbolically linked to the user's home directory
# by typing
#    ln -s update.sh ~/update
#
# From now on, the user can run the update script directly after logging in, by simply typing
#    . update


# Update git repository:

echo
echo "Updating SPARKS content"
echo
cd /var/www/sparks
git reset --hard
git pull
cd ~
echo "Done updating SPARKS content"


# Update issue files with fancy logo
rm /etc/issue
rm /etc/issue.net
cat >/etc/issue <<- _EOF_
         
                          _        
     ___ _ __   __ _ _ __| | _____ 
    / __| '_ \ / _` | '__| |/ / __|
    \__ \ |_) | (_| | |  |   <\__ \
    |___/ .__/ \__,_|_|  |_|\_\___/
        |_|
        
    Your local SPARKS server is now running!
    
    Go to 
    
           http://localhost:8888
    
    To see the local SPARKS website
_EOF_
ln /etc/issue /etc/issue.net


# relink update script
rm update
ln /var/www/sparks/update.sh update


echo
echo "All updates complete"