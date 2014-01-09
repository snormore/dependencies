FROM snormore/llvm

MAINTAINER SkyDB skydb.io 

RUN mkdir -p /usr/local/src

# golang
RUN cd /usr/local/src && \
    wget https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.2.linux-amd64.tar.gz

ENV PATH $PATH:/usr/local/go/bin

# LMDB
RUN cd /usr/local/src && \
    wget -O lmdb-master.tar.gz https://github.com/skydb/lmdb/archive/master.tar.gz && \
    tar zxvf lmdb-master.tar.gz && \
    cd lmdb-master && \
    make && \
    PREFIX=/usr/local make install

