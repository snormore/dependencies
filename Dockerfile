FROM snormore/llvm

MAINTAINER SkyDB skydb.io 

RUN mkdir -p /usr/local/src

RUN cd /usr/local/src && \
    wget -O lmdb-master.tar.gz https://github.com/skydb/lmdb/archive/master.tar.gz && \
    tar zxvf lmdb-master.tar.gz && \
    cd lmdb-master && \
    PREFIX=/usr/local make install

