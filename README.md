Originally from: https://freeandthings.wordpress.com/2015/08/20/generate-missing-photo-sizes-in-piwigo/

This has been modified and works with Piwigo 14, which I have running in a FreeBSD jail on a TrueNAS system.

+++

Make a login in Piwigo named "cron" and set a strong password, chage the text REDACTED (one instance on Line 13) in this script to the password

Change the text "(Path-To-Piwigo)" (three instances on lines 13, 15, and 28) with the full URL of your Piwigo install

The following settings assume you are running the script from /usr/local/www/scripts, change path as needed

Nightly CRON job (run as www): 1 0 * * * /usr/local/www/scripts/piwigo-thumb-generate.sh
