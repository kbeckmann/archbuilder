FROM base/archlinux

MAINTAINER kbeckmann <konrad.beckmann@gmail.com>

WORKDIR /opt

# Update and install packages
RUN yes | pacman -Syyu
RUN pacman --noconfirm -S base-devel wget sudo vi

# Add passwordless sudo for user docker
RUN useradd -m docker && echo "docker:docker" | chpasswd
RUN chown docker:docker /opt
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER docker

# Install cower
RUN wget https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
RUN tar xf cower.tar.gz
RUN cd cower && yes | makepkg -s --skippgpcheck
RUN cd cower && sudo pacman --noconfirm -U *.pkg.tar.xz

# Install pacaur
RUN cower -d pacaur
RUN cd pacaur && yes | makepkg -s
RUN cd pacaur && sudo pacman --noconfirm -U *.pkg.tar.xz

# Ready to builld and install aur packages on a clean machine
CMD /bin/bash
