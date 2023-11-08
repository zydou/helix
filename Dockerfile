FROM buildpack-deps:xenial AS build
ARG VERSION=23.10
ARG TARGET=x86_64-unknown-linux-gnu
WORKDIR /app
ENV GIT_SSL_NO_VERIFY=true
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends git && \
    sh -c "$(curl -sSLfk https://sh.rustup.rs)" -- --profile minimal --default-toolchain stable -y --no-modify-path --target "$TARGET"

RUN curl -sSLfk -o src.tar.gz "https://github.com/helix-editor/helix/archive/refs/tags/$VERSION.tar.gz" && \
    tar -xzf src.tar.gz --strip-components=1 && \
    /root/.cargo/bin/cargo run --package=helix-loader --bin=hx-loader && \
    rm rust-toolchain.toml src.tar.gz && \
    mkdir -p /root/.cargo && \
    echo "[profile.release]" > /root/.cargo/config.toml && \
    echo "strip = true" >> /root/.cargo/config.toml && \
    /root/.cargo/bin/cargo build --release --locked --target "$TARGET" && \
    cp "target/$TARGET/release/hx" /usr/local/bin/hx && \
    rm -rf runtime/grammars/sources

FROM scratch
COPY --from=build /usr/local/bin/hx /hx
COPY --from=build /app/runtime /runtime
COPY --from=build /app/contrib/completion /contrib/completion
