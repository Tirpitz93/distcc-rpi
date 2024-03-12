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
RUN chmod +x /etc/service/distccd/run -R


EXPOSE 3632
EXPOSE 3633

#VOLUME ["/tools"]

RUN chmod +x /etc/service/distccd/run

CMD ["distccd", "--jobs", "30", "--allow","172.16.0.0/12", "--allow","192.168.0.0/16", "--allow","10.0.0.0/8", "--log-stderr", "--no-detach",  ">>/var/log/distccd.log 2>&1"]
#CMD ["sh","-c", "ls -la /etc/service/distccd/run"]