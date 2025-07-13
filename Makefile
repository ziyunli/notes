# ABOUTME: Build automation for notes project Docker container management
# ABOUTME: Provides shortcuts for running claude and mkdocs in containerized environment

.PHONY: claudex build serve clean help

# Default target
help:
	@echo "Available commands:"
	@echo "  make claudex    - Run claude in Docker container"
	@echo "  make serve      - Run mkdocs serve with port forwarding"
	@echo "  make build      - Build Docker image"
	@echo "  make clean      - Remove Docker image"

# Build Docker image
build:
	docker build -t notes-app .

# Run claude in container with current directory mounted
claudex: build
	docker run -it --rm \
		-v $(PWD):/workspace \
		-p 8000:8000 \
		notes-app claude --dangerously-skip-permissions

# Run mkdocs serve with port forwarding
serve: build
	docker run -it --rm \
		-v $(PWD):/workspace \
		-p 8000:8000 \
		notes-app uv run mkdocs serve --dev-addr=0.0.0.0:8000

# Clean up Docker image
clean:
	docker rmi notes-app || true