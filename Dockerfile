FROM ubuntu
 
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-updates universe' >> /etc/apt/sources.list && \
    apt-get update

#Prevent daemon start during install
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl

#Supervisord
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor && mkdir -p /var/log/supervisor
CMD ["/usr/bin/supervisord", "-n"]

#SSHD
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server &&        mkdir /var/run/sshd && \
        echo 'root:root' |chpasswd

#Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc g++ build-essential vim less net-tools inetutils-ping curl git telnet nmap socat dnsutils netcat

RUN cd /tmp && \
    wget http://llvm.org/releases/3.2/llvm-3.2.src.tar.gz && \
    tar zxvf llvm-3.2.src.tar.gz && \
    cd llvm-3.2.src && \
    ./configure --enable-optimized && \
    REQUIRES_RTTI=1 make install

EXPOSE 22

#Cleanup
#RUN rm -rf /tmp/*

