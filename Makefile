# ABOUTME: Build automation for notes project Docker container management
# ABOUTME: Provides shortcuts for running claude and mkdocs in containerized environment

.PHONY: claudex build serve clean help

# Configuration
PORT ?= 3001

# Default target
help:
	@echo "Available commands:"
	@echo "  make claudex         - Run claude in Docker container"
	@echo "  make serve [PORT=X]  - Run mkdocs serve with port forwarding (default: 3001)"
	@echo "  make build           - Build Docker image"
	@echo "  make clean           - Remove Docker image"
	@echo ""
	@echo "Examples:"
	@echo "  make serve           - Serve on http://localhost:3001"
	@echo "  make serve PORT=8000 - Serve on http://localhost:8000"

# Build Docker image
build:
	docker build -t notes-app .

# Run claude in container with current directory mounted
claudex: build
	docker run -it --rm \
		-v $(PWD):/workspace \
		-p $(PORT):$(PORT) \
		notes-app claude --dangerously-skip-permissions

# Run mkdocs serve with port forwarding
serve: build
	docker run -it --rm \
		-v $(PWD):/workspace \
		-p $(PORT):$(PORT) \
		notes-app uv run mkdocs serve --dev-addr=0.0.0.0:$(PORT)

# Clean up Docker image
clean:
	docker rmi notes-app || true