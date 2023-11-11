# helix

This repository uses GitHub Actions to build the `helix` tool.

The binary releases of the [official repository](https://github.com/helix-editor/helix) are built on Ubuntu 22.04. It may cause [GLIBC issues](https://github.com/helix-editor/helix/issues/1932) on older systems. This repository builds the binary on Ubuntu 16.04 (GLIBC 2.23). Besides, this repository also builds a musl version of the binary. It can be used on any Linux system.

Specifically, this repository builds the following binaries:

- aarch64-unknown-linux-gnu
- aarch64-unknown-linux-musl
- aarch64-apple-darwin
- x86_64-unknown-linux-gnu
- x86_64-unknown-linux-musl
- x86_64-apple-darwin

Download stable release: [https://github.com/zydou/helix/releases/latest](https://github.com/zydou/helix/releases/latest)

Download nightly release: [https://github.com/zydou/helix/releases/tag/nightly](https://github.com/zydou/helix/releases/tag/nightly)
