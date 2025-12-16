FROM ubuntu:noble

# Install packages
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN echo 'Acquire::Retries "100";' > /etc/apt/apt.conf.d/99custom
RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget libatomic1 python3 software-properties-common \
    && apt-get install -qq --no-install-recommends g++ libtool autotools-dev automake pkg-config bsdmainutils \
    && apt-get install -qq --no-install-recommends build-essential \
    && apt-get install -qq --no-install-recommends libssl-dev \
    && apt-get install -qq --no-install-recommends libevent-dev \
    && apt-get install -qq --no-install-recommends libdb-dev \
    && apt-get install -qq --no-install-recommends libdb++-dev \
    && apt-get install -qq --no-install-recommends libminiupnpc-dev \
    && apt-get install -qq --no-install-recommends libzmq3-dev \
    && apt-get install -qq --no-install-recommends libgoogle-perftools-dev \
    && apt-get install -qq --no-install-recommends python3-zmq \
    && apt-get install -qq --no-install-recommends python3-ecdsa \
    && apt-get install -qq --no-install-recommends python3-bip32utils \
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

ENV BITCOIN_VERSION 1.2.0
ENV BITCOIN_URL http://download.bitcoinsv.io/bitcoinsv/1.2.0/bitcoin-sv-1.2.0.tar.gz
ENV BITCOIN_SHA256 a56913aa14380da398c3418b2964f47bb4f04440badbefa0a152ab1579ce8511

# Install bitcoin src
RUN set -ex \
    && cd /tmp \
    && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
    && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
    && tar -xzvf bitcoin.tar.gz -C /opt \
    && rm -rf /tmp/*
