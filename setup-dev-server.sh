#!/bin/bash  

MYHOME=${HOME}

BASE=`pwd`
DEFAULT_DIR=${BASE}"/defaults"
DISTRO_DIR=${BASE}"/distros"
FINALIZE_DIR=${BASE}"/finalize"
BIN_DIR=${BASE}"/bin"



install_default_configs () {
    cp ${DEFAULT_DIR}/vimrc ${MYHOME}/.vimrc

    cat ${DEFAULT_DIR}/bashrc | while read LINE; do
        grep "$LINE" ${MYHOME}/.bashrc &>/dev/null
        if [ $? -ne 0 ]; then
            echo "${LINE}" >>${MYHOME}/.bashrc
        fi
    done
}



fix_git_settings () {
    git config --global user.name "Second Hans"
    git config --global user.email knikkerr@gmail.com
    git config --global credential.helper 'cache --timeout=7200'
}



install_binaries () {
    if [ ! -d ${MYHOME}/bin ]; then
        mkdir ${MYHOME}/bin
    fi

    cp -a ${BIN_DIR}/* ${MYHOME}/bin
}



pre_setup_steps () {
    echo "---> STEP: pre-setup steps"

    install_default_configs
    fix_git_settings
    install_binaries

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
        debian       ) ${DISTRO_DIR}/setup-dev-debian.sh;;
        *            ) echo "unknown distro!";;
    esac
}



post_setup_steps () {
    echo "---> STEP: post-setup steps"
    echo "you can manually install/finalize the following scripts:"
    find finalize/ -type f -executable

    echo "---> DONE"
    echo
}


### MAIN

pre_setup_steps
distro_specific_setup
post_setup_steps
