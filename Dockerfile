FROM archlinux/base

WORKDIR /opt

RUN yes | pacman -Syyu && \
    pacman --noconfirm -S base-devel wget sudo vi && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    chown docker:docker /opt && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo -u docker bash -c "\
        wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay-bin.tar.gz && \
        tar xf yay-bin.tar.gz && \
        (cd yay-bin && yes | makepkg -s --skippgpcheck) && \
        (cd yay-bin && sudo pacman --noconfirm -U *.pkg.tar.xz) && \
        yay --noconfirm -S asp \
    "

USER docker

# Ready to build and install aur packages on a clean machine
CMD /bin/bash
