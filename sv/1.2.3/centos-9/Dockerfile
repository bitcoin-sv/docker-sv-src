FROM quay.io/centos/centos:stream9

# Install packages
ENV TZ=Europe/London
RUN set -ex \
    && dnf -y install 'dnf-command(config-manager)' \
	&& dnf -y config-manager --set-enabled crb \
    && dnf -y install epel-release epel-next-release \
	&& dnf -y install gcc-c++ libtool make wget which autoconf automake openssl-devel libevent-devel libdb-devel libdb-cxx-devel \
    && dnf -y install miniupnpc-devel cppzmq-devel \
    && dnf -y install python3 python3-ecdsa python3-zmq \
    && dnf -y install diffutils util-linux \
    && dnf -y install gperftools-devel \
    && dnf -y clean all

# Install boost from distribution, if required
RUN set -ex \
    && dnf -y install boost-devel \
    && dnf -y clean all

# Setup ld search path
RUN set -ex \
    && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf

# Install suitable version of boost

# Setup ld search path
RUN set -ex \
    && ldconfig

ENV BITCOIN_VERSION 1.2.3
ENV BITCOIN_URL http://download.bitcoinsv.io/bitcoinsv/1.2.3/bitcoin-sv-1.2.3.tar.gz
ENV BITCOIN_SHA256 d6edbd871daf68fabedc1bc1541b3c4e87460150fecb26f76f52ba0f4f1ab6b0

# Install bitcoin src
RUN set -ex \
    && cd /tmp \
    && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
    && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
    && tar -xzvf bitcoin.tar.gz -C /opt \
    && rm -rf /tmp/*
