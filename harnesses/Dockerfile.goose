FROM ubuntu-minimal
RUN apt-get update && apt-get install -y ca-certificates curl libssl3 bzip2 libgomp1 && rm -rf /var/lib/apt/lists/*
RUN ARCH="$(uname -m)" && if [ "$ARCH" = "x86_64" ]; then GOOSE_ARCH="x86_64"; elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then GOOSE_ARCH="aarch64"; else echo "unsupported arch: $ARCH" >&2; exit 1; fi && curl -fsSL -o /tmp/goose.tar.bz2 "https://github.com/block/goose/releases/download/stable/goose-${GOOSE_ARCH}-unknown-linux-gnu.tar.bz2" && tar -xjf /tmp/goose.tar.bz2 -C /tmp && install -m 0755 /tmp/goose /usr/local/bin/goose
RUN printf '%b\n' \
    '\033[38;5;28m╔══════════════════════════════════════════════════════╗\033[0m' \
    '\033[38;5;28m║\033[0m              \033[1;38;5;28mTensorlake Sandbox — Goose\033[0m              \033[38;5;28m║\033[0m' \
    '\033[38;5;28m╚══════════════════════════════════════════════════════╝\033[0m' \
    '' \
    '  Docs: \033[36mhttps://docs.tensorlake.ai/sandboxes/introduction\033[0m' \
    '  Want to add a new agent harness? Checkout: \033[36mhttps://github.com/tensorlakeai/harness-new\033[0m' \
    '' \
    '  To begin run:' \
    '  \033[30;48;5;28m  $ goose configure  \033[0m' \
    '' \
    > /etc/motd
RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

# Command to create the image in Tensorlake:
# tl sbx image create ./Dockerfile.goose -n goose-harness-new-ui