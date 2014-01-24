#!/bin/bash



set_forwarding () {
    TMP=`tempfile`
    if [ $? -ne 0 ]; then
        echo "could not create temp file."
        exit 1
    fi

    echo 1 > /proc/sys/net/ipv4/ip_forward
    cat /etc/sysctl.conf | grep -v 'net.ipv4.ip_forward' >${TMP}
    mv ${TMP} > /etc/sysctl.conf
    echo "net.ipv4.ip_forward = 1" >/etc/sysctl.conf
}



do_set_network_settings () {
    echo 
    echo "---> STEP: set network settings"

    set_forwarding

    echo "---> DONE"
    echo
}


#####

