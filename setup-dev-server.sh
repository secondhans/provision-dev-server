#!/bin/bash  


echo -n "---> checking if this is a Debian installation ... "
if [ -f /etc/debian_version ]; then
    echo "yes. Invoking ./setup-dev-debian.sh"
    ./setup-dev-debian.sh
    exit 0
else
    echo "no"
fi
