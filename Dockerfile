FROM base/archlinux

MAINTAINER kbeckmann <konrad.beckmann@gmail.com>

WORKDIR /opt

ADD build.sh /opt/
RUN ./build.sh

# Ready to build and install aur packages on a clean machine
CMD /bin/bash
