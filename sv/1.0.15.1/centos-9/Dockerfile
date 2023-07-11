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
    && dnf -y clean all

# Setup ld search path
RUN set -ex \
    && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf

# Install suitable version of boost
ENV BOOST_VERSION_D 1.75.0
ENV BOOST_VERSION_U 1_75_0
ENV BOOST_SHA256 aeb26f80e80945e82ee93e5939baebdca47b9dee80a07d3144be1e1a6a66dd6a
RUN set -ex \
    && cd ~ \
    && wget -qO boost.tgz "https://sourceforge.net/projects/boost/files/boost/$BOOST_VERSION_D/boost_$BOOST_VERSION_U.tar.gz/download" \
    && echo "$BOOST_SHA256 boost.tgz" | sha256sum -c - \
    && tar -xzf boost.tgz \
    && cd "boost_$BOOST_VERSION_U" \
    && ./bootstrap.sh --prefix=/usr/local \
    && ./b2 install

# Setup ld search path
RUN set -ex \
    && ldconfig

ENV BITCOIN_VERSION 1.0.15.1
ENV BITCOIN_URL http://download.bitcoinsv.io/bitcoinsv/1.0.15.1/bitcoin-sv-1.0.15.1.tar.gz
ENV BITCOIN_SHA256 fca4527f0fbcda860ff909173360548a73d3aa995cfbdf65cf5fc6fd6323933b

# Install bitcoin src
RUN set -ex \
    && cd /tmp \
    && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
    && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
    && tar -xzvf bitcoin.tar.gz -C /opt \
    && rm -rf /tmp/*
