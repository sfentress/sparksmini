 === README ===

This directory contains all the code needed to run SPARKS activities and report student action to a student server.

The application expects to be run from within a server, and a sample configuration file for an Apache server is provided in /proxy. This is necessary because the application expects to access two applications running elsewhere via urls:

	* /sparks/qucsator should return the location of the QUCS server (currently running on CC's servers, to be replaced by offline version soon)
	* /postData should return the location of the student server, e.g. http://127.0.0.1:49377

By using proxies we can avoid making assumptions about the locations of the servers in the application code.

 == Serving via an Apache server ==

To serve the activities via Apache, first copy the file apache.conf.sample to apache.conf and modify the location of the DocumentRoot as necessary. Then start the Apache server using

	apachectl -f "`pwd`/proxy/apache.conf" -k start

You can now access the activities at http://localhost:1234

You can later stop the server with

  apachectl -f "`pwd`/proxy/apache.conf" -k stop

Alternatively, a more permenant solution is to add a new virtual host at e.g. http://sparks.local, which will always be running when the computer is started. To do this, add the following line to Apache's hosts file (e.g. at /etc/hosts)

	127.0.0.1 sparks.local

Then rename the file http-vhosts.conf.sample to http-vhosts.conf, modify the location of the DocumentRoot and Directory as necessary, and place it in Apache's "extra" folder (e.g. at /etc/apache2/extra/). If there is already such a file, just add the section defining sparks.local (lines 24-44). Restart Apache with

	apachectl graceful

You can now find the Sparks content at http://sparks.local