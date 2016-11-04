#!/bin/bash
admin=youremail@yourdomain.com

location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $location/rdiff_simulator.sh > /tmp/rdiff-backup-simulator-email

# Force it to send the email for testing. Comment this if not needed.
#error=1

if [ "$error" != "0" ]; then
  echo "Error Code $error"
	echo "Emailing Error Report to $admin"
  `which mail` -s "rdiff-backup error on $(hostname)" $admin < /tmp/rdiff-backup-simulator-email
  echo ""
fi
cat /tmp/rdiff-backup-simulator-email
rm /tmp/rdiff-backup-simulator-email
