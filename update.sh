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
echo

# Run newly-updated update file
echo "Running any newly-updated scripts"
bash /var/www/sparks/more-updates.sh


echo
echo "All updates complete"