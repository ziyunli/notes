FROM alpine:latest

# Update system and install base dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache \
    alpine-sdk \
    git \
    curl \
    wget \
    vim \
    neovim \
    sudo \
    openssh \
    ca-certificates \
    bash \
    shadow

# Install development tools
RUN apk add --no-cache \
    python3 \
    py3-pip \
    nodejs \
    npm \
    yarn \
    go \
    jq \
    tmux \
    htop \
    tree \
    unzip \
    protobuf \
    zip \
    tzdata

# Install ripgrep and fd
RUN apk add --no-cache \
    ripgrep \
    fd

# Install pnpm globally
RUN npm install -g pnpm

# Install github-cli from edge repository
RUN apk add --no-cache github-cli --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

# Create a regular user with UID 1000
RUN adduser -D -u 1000 -s /bin/bash user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to user for installations
USER user
WORKDIR /home/user
# Switch back to root for global npm install
USER root

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Install gemini-cli
RUN npm install -g @google/gemini-cli

# Switch back to user
USER user

# Install uv for the user
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/home/user/.local/bin:${PATH}"

# Set working directory
WORKDIR /workspace

# Copy project files
COPY --chown=user:user pyproject.toml uv.lock* ./

# Install project dependencies
RUN uv sync --locked || uv sync

# Expose port 8000 for mkdocs serve
EXPOSE 8000

# Set shell to bash
SHELL ["/bin/bash", "-c"]

CMD ["claude", "--dangerously-skip-permissions"]
