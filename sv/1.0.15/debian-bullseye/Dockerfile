FROM debian:bullseye

# Install packages
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN set -ex \
    && apt-get update \
    && apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget libatomic1 python3 \
    && apt-get install -qq --no-install-recommends g++-10 build-essential libtool autotools-dev automake pkg-config bsdmainutils \
    && apt-get install -qq --no-install-recommends libssl-dev libevent-dev libdb-dev libdb++-dev libminiupnpc-dev libzmq3-dev \
    && apt-get install -qq --no-install-recommends python3-zmq python3-ecdsa python3-bip32utils \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10 \
    && rm -rf /var/lib/apt/lists/*

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

ENV BITCOIN_VERSION 1.0.15
ENV BITCOIN_URL http://download.bitcoinsv.io/bitcoinsv/1.0.15/bitcoin-sv-1.0.15.tar.gz
ENV BITCOIN_SHA256 aa0cfb4dc78606a3b9adf007531562aa0681071b23b1a940385f35a4a526f49e

# Install bitcoin src
RUN set -ex \
    && cd /tmp \
    && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
    && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
    && tar -xzvf bitcoin.tar.gz -C /opt \
    && rm -rf /tmp/*
