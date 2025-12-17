FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    bash \
    tar \
    coreutils \
  && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI (native installer)
RUN curl -fsSL https://claude.ai/install.sh | bash

WORKDIR /app
COPY entry.sh /app/entry.sh
RUN chmod +x /app/entry.sh

ENTRYPOINT ["/app/entry.sh"]


