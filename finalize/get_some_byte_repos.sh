#!/bin/bash

PHOME=`grep PROJECT_HOME ~/.bashrc | cut -d'=' -f 2`

REPOS="https://github.com/ByteInternet/docker-bytedb-fixture
https://github.com/ByteInternet/docker-servicepanel
https://github.com/ByteInternet/bytedb-python"



sanity_check () {
    if [ -z "$PHOME" ]; then
        echo "couldn't find PROJECT_HOME in ~/.bashrc. Aborting"
        exit 1
    fi
}



install_repos () {
    pushd . &>/dev/null
    cd $PHOME

    for R in $REPOS; do
        git clone ${R}
    done

    popd &>/dev/null
}



### MAIN
sanity_check
install_repos
