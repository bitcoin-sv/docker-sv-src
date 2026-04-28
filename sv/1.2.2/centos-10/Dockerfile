FROM quay.io/centos/centos:stream10

# Install packages
ENV TZ=Europe/London
RUN set -ex \
    && dnf -y install 'dnf-command(config-manager)' \
	&& dnf -y config-manager --set-enabled crb \
    && dnf -y install epel-release \
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

ENV BITCOIN_VERSION 1.2.2
ENV BITCOIN_URL http://download.bitcoinsv.io/bitcoinsv/1.2.2/bitcoin-sv-1.2.2.tar.gz
ENV BITCOIN_SHA256 43e5d120b31d84b02177b5ee6e98917e16f301d9427d8e4229e70af95c329569

# Install bitcoin src
RUN set -ex \
    && cd /tmp \
    && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
    && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
    && tar -xzvf bitcoin.tar.gz -C /opt \
    && rm -rf /tmp/*
