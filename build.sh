#!/bin/bash

if [ $(id -u) == "0" ]; then
    yes | pacman -Syyu
    pacman --noconfirm -S base-devel wget sudo vi
    useradd -m docker && echo "docker:docker" | chpasswd
    chown docker:docker /opt
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

    sudo -u docker $0
else
    # Install cower
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
    tar xf cower.tar.gz
    (cd cower && yes | makepkg -s --skippgpcheck)
    (cd cower && sudo pacman --noconfirm -U *.pkg.tar.xz)

    # Install pacaur
    cower -d pacaur
    (cd pacaur && yes | makepkg -s)
    (cd pacaur && sudo pacman --noconfirm -U *.pkg.tar.xz)
fi

