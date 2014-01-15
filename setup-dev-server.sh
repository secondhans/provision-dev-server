#!/bin/bash  

DEFAULT_DIR=`pwd`"/defaults"



install_default_configs () {
    cp ${DEFAULT_DIR}/vimrc ~/.vimrc
}





pre_setup_steps () {
    echo "---> STEP: pre-setup steps"

    install_default_configs

    echo "---> DONE"
    echo
}





distro_specific_setup () {
    echo "---> STEP: starting distro specific install"
    echo -n "checking if this is a Debian installation ... "
    DISTRO="unknown"

    if [ -f /etc/debian_version ]; then
        echo "yes."
        DISTRO="debian"
    else
        echo "no"
    fi

    case "${DISTRO}" in
        debian       ) ./setup-dev-debian.sh;;
        *            ) echo "unknown distro!";;
    esac
}



post_setup_steps () {
    echo "---> STEP: post-setup steps"

    echo "---> DONE"
    echo
}


### MAIN

pre_setup_steps
distro_specific_setup
post_setup_steps
