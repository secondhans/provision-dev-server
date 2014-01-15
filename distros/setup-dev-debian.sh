#!/bin/bash  


APT_REQUIREMENTS="apt-transport-https debian-keyring apt-file"

DEFAULT_PACKAGES="virtualenvwrapper gcc devscripts cowdancer cdebootstrap libtool quilt dpatch git-buildpackage debootstrap colordiff lxc-docker"




setup_repositories () {
    #echo "deb https://get.docker.io/ubuntu docker main" | sudo tee /etc/apt/sources.list.d/docker.list
    echo "deb http://get.docker.io/ubuntu docker main" | sudo tee /etc/apt/sources.list.d/docker.list
}


setup_keyrings () {
    # debian
    gpg --keyring /usr/share/keyrings/debian-archive-keyring.gpg  --export | gpg --no-default-keyring --keyring /var/data/keyrings/debian/trustedkeys.gpg --import

    # docker - http://docs.docker.io/en/latest/installation/ubuntulinux/
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
}


setup_apt_requirements () {
    apt-get install -y --force-yes $APT_REQUIREMENTS
    apt-file update
}


pre_install_packages () {
    setup_apt_requirements
    setup_repositories
    setup_keyrings
    apt-get update -y
}

post_install_packages () {
    apt-get autoremove -y
}

install_packages () {
    echo "---> STEP: install packages"

    for F in /etc/apt/apt.conf /etc/apt/apt.conf.d/11proxy; do 
        if [ -f ${F} ]; then
            echo "removing ${F} because it mucks things up"
            rm -f ${F}
        fi
    done

    pre_install_packages
    apt-get install -y $DEFAULT_PACKAGES
    post_install_packages

    echo "---> DONE"
    echo 
}


post_message () {
    echo
}


### MAIN
install_packages
post_message

