FROM archlinux/base

MAINTAINER kbeckmann <konrad.beckmann@gmail.com>

WORKDIR /opt

RUN yes | pacman -Syyu && \
    pacman --noconfirm -S base-devel wget sudo vi && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    chown docker:docker /opt && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo -u docker bash -c "\
        wget https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz && \
        tar xf cower.tar.gz && \
        (cd cower && yes | makepkg -s --skippgpcheck) && \
        (cd cower && sudo pacman --noconfirm -U *.pkg.tar.xz) && \
        cower -d yay && \
        (cd yay && yes | makepkg -s) && \
        (cd yay && sudo pacman --noconfirm -U *.pkg.tar.xz) && \
        yay --noconfirm -S asp && \
        yay --noconfirm -R go \
    "

USER docker

# Ready to build and install aur packages on a clean machine
CMD /bin/bash
