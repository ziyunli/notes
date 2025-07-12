FROM archlinux:latest

# Update system and install base dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    git \
    curl \
    wget \
    vim \
    neovim \
    sudo \
    openssh \
    ca-certificates

# Install development tools
RUN pacman -S --noconfirm \
    python \
    python-pip \
    nodejs \
    npm \
    pnpm \
    yarn \
    go \
    jq \
    tmux \
    htop \
    tree \
    unzip \
    protobuf \
    zip

# Install useful tools
RUN pacman -S --noconfirm \
    ast-grep \
    github-cli \
    fd \
    ripgrep

# Create a regular user with UID 1000
RUN useradd -m -u 1000 -G wheel -s /bin/bash user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to user for installations
USER user
WORKDIR /home/user

# Install Rust as user
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/user/.cargo/bin:${PATH}"

# Switch back to root for system packages
USER root

# Clean package cache
RUN pacman -Scc --noconfirm

# Switch back to user
USER user

# Install Claude Code globally (user has npm permissions via sudo)
RUN sudo npm install -g @anthropic-ai/claude-code

# Set working directory
WORKDIR /workspace

# Set shell to bash
SHELL ["/bin/bash", "-c"]

CMD ["claude", "--dangerously-skip-permissions"]