#!/bin/bash
# A script with config updates, that gets called automatically 
# from update.sh *after the git repository has been updated*. 
# This way one call to .update will both update the git repo and 
# run any new commands.

cd ~

# Update issue files with fancy logo
echo "Updating issue file"
rm /etc/issue
rm /etc/issue.net
ln /var/www/sparks/scripts/issue /etc/issue
ln /etc/issue /etc/issue.net

# link the index page
rm /var/www/index.html
ln -s /var/www/sparks/index.html /var/www/index.html


# relink update script
rm /usr/local/bin/update
ln /var/www/sparks/update.sh /usr/local/bin/update
chmod 755 /usr/local/bin/update