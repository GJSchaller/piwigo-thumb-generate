# Make a login in Piwigo named "cron" and set a strong password, chage the text REDACTED (one instance on Line 13) in this script to the password
#
# Change the text "(Path-To-Piwigo)" (three instances on lines 13, 15, and 28) with the full URL of your Piwigo install
#
# The following settings assume you are running the script from /usr/local/www/scripts, change path as needed
#
# Nightly CRON job (run as www): 1 0 * * * /usr/local/www/scripts/piwigo-thumb-generate.sh

set -e

cd /usr/local/www/scripts

wget --keep-session-cookies --save-cookies cookies.txt --delete-after --post-data="username=cron&password=REDACTED" "http://(Path-To-Piwigo)/ws.php?format=json&method=pwg.session.login"

wget --load-cookies cookies.txt -nv -O missing.json "http://(Path-To-Piwigo)/ws.php?format=json&method=pwg.getMissingDerivatives"

while [ `wc -c missing.json | awk '{print $1}'` -gt 50 ]
do
  sed -e 's/[\\\"]//g' \
  -e 's/{stat:ok,result:{next_page:[0-9]*,urls:\[//' \
  -e 's/{stat:ok,result:{urls:\[//' \
  -e 's/\]}}/\n/' \
  -e 's/,/\n/g' \
  -e 's/\&b=[0-9]*//g' missing.json | \
  while read line ; do
    wget -nv -O /dev/null $line
  done
  wget --load-cookies cookies.txt -nv -O missing.json "http://(Path-To-Piwigo)/ws.php?format=json&method=pwg.getMissingDerivatives"
done

rm cookies.txt
rm missing.json
