FROM ubuntu:jammy

# Install packages
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget libatomic1 python3 software-properties-common \
    && apt-get install -qq --no-install-recommends g++ build-essential libtool autotools-dev automake pkg-config bsdmainutils \
    && apt-get install -qq --no-install-recommends libssl-dev libevent-dev libdb-dev libdb++-dev libminiupnpc-dev libzmq3-dev \
    && apt-get install -qq --no-install-recommends python3-zmq python3-ecdsa python3-bip32utils \
    && apt-get install -qq --no-install-recommends libgoogle-perftools-dev \
	&& rm -rf /var/lib/apt/lists/*

# Install boost from distribution, if required
RUN set -ex \
    && apt-get update \
    && apt-get install -qq --no-install-recommends libboost-system-dev \
    && apt-get install -qq --no-install-recommends libboost-filesystem-dev \
    && apt-get install -qq --no-install-recommends libboost-chrono-dev \
    && apt-get install -qq --no-install-recommends libboost-program-options-dev \
    && apt-get install -qq --no-install-recommends libboost-test-dev \
    && apt-get install -qq --no-install-recommends libboost-thread-dev \
    && rm -rf /var/lib/apt/lists/*
# Install suitable version of boost

# Setup ld search path
RUN set -ex \
    && ldconfig

ENV BITCOIN_VERSION 1.2.1
ENV BITCOIN_URL http://download.bitcoinsv.io/bitcoinsv/1.2.1/bitcoin-sv-1.2.1.tar.gz
ENV BITCOIN_SHA256 8834625c17ef3472b18b7948ee8e7b57948e34b9ab9f0b1663dd9d447170ff27

# Install bitcoin src
RUN set -ex \
    && cd /tmp \
    && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
    && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
    && tar -xzvf bitcoin.tar.gz -C /opt \
    && rm -rf /tmp/*
