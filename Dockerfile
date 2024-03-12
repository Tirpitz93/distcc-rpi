FROM debian:bookworm-slim
MAINTAINER Mike Weaver ""
LABEL description="distcc pi arm cross bash -compiler node"

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y \
    distcc  \
    build-essential  \
    gdb-multiarch \
    g++-arm-linux-gnueabihf  \
    gcc-arm-linux-gnueabihf \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu

RUN mkdir /etc/service/distccd -p
ADD distccd.sh /etc/service/distccd/run 

EXPOSE 3632

#VOLUME ["/tools"]

RUN chmod +x /etc/service/distccd/run && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
