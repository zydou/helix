# helix

This repository uses GitHub Actions to build the `helix` tool.

The binary releases of the [official repository](https://github.com/helix-editor/helix) are built on Ubuntu 22.04. It may cause [GLIBC issues](https://github.com/helix-editor/helix/issues/1932) on older systems. This repository builds the binary on Ubuntu 16.04.

In addition, this repo also directly downloads the `helix` binary from the official and uploads it to GitHub Release of the following architectures for convenience:

- darwin-amd64
- darwin-arm64
- linux-arm64
