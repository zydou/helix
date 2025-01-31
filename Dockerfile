FROM buildpack-deps:xenial AS build
ARG TARGET=x86_64-unknown-linux-gnu
ARG GIT_SSL_NO_VERIFY=true
ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get install -y --no-install-recommends --allow-unauthenticated software-properties-common && \
    add-apt-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends --allow-unauthenticated git && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sed 's#/proc/self/exe#\/bin\/sh#g' | bash -s -- -y

COPY src /app
WORKDIR /app

RUN mkdir -p /root/.cargo && \
    echo "[profile.release]" > /root/.cargo/config.toml && \
    echo "strip = true" >> /root/.cargo/config.toml && \
    /root/.cargo/bin/cargo run --package=helix-loader --bin=hx-loader && \
    /root/.cargo/bin/cargo build --release --locked --target "$TARGET" && \
    cp "target/$TARGET/release/hx" /usr/local/bin/hx && \
    rm -rf runtime/grammars/sources

FROM scratch
COPY --from=build /usr/local/bin/hx /hx
COPY --from=build /app/runtime /runtime
COPY --from=build /app/contrib/completion /contrib/completion
