# Docker-Bitcoin-Src

Included in this repo are docker images for building the Bitcoin SV node implementation from source.

These Docker images provide the Bitcoin SV node source code and suitable environments for
building the `bitcoind`, `bitcoin-cli` and `bitcoin-tx` programs for different Linux platforms.

To see the available versions/tags, please visit the [Docker Hub page](https://hub.docker.com/r/bitcoinsv/bitcoin-sv-src/).

### Usage

For example, to build version 1.0.14 of the Bitcoin SV node software from source on Ubuntu Focal Fossa (20.04 LTS):

```
$ docker run -it --rm --name bitcoinsv-src bitcoinsv/bitcoin-sv-src:1.0.14-ubuntu-focal bash
# cd /opt/bitcoin-sv-1.0.14/
# ./autogen.sh
# ./configure
# make
```

Change the Bitcoin SV node version number and the target OS platform name to build whichever version of the node
on whichever version of Linux you require.

Once it has finished building, the `bitcoind`, `bitcoin-cli` and `bitcoin-tx` binaries can be
found under the `src` directory.

Configuration files and code in this repository are distributed under the [MIT license](/LICENSE).

### Contributing

All files are generated from templates in the root of this repository. Please do not edit any of the generated 
Dockerfiles directly.

* To add a new version, update [versions.yml](/versions.yml), then run `make update`.

If you would like to build and test containers for all versions (similar to what happens in CI), run `make`.
