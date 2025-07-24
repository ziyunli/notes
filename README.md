# Notes

## Development Commands

```bash
# Install dependencies
uv sync

# Serve locally with hot reload
uv run mkdocs serve

# Build static site
uv run mkdocs build

# Deploy to GitHub Pages manually
uv run mkdocs gh-deploy --force
```

### Docker Container & Makefile Commands

The project includes a Docker setup and Makefile for containerized development:

```bash
# Run Claude Code in container with current directory mounted
make claudex

# Run mkdocs serve in container with port forwarding (http://localhost:8000)
make serve

# Build Docker image
make build

# Remove Docker image
make clean

# Show available commands
make help
```

The Makefile provides convenient shortcuts for Docker operations. Both `claudex` and `serve` commands automatically:
- Mount the current directory to `/workspace`
- Forward port 8000 for mkdocs development server
- Use the `notes-app` Docker image with uv and all dependencies pre-installed

**Manual Docker commands:**

```bash
# Build the container
docker build -t notes-app .

# Run Claude Code
docker run -it --rm -v $(PWD):/workspace -p 8000:8000 notes-app

# Run mkdocs serve with port forwarding
docker run -it --rm -v $(PWD):/workspace -p 8000:8000 notes-app uv run mkdocs serve --dev-addr=0.0.0.0:8000
```

## Acknowledgments

Based on the [obsidian-publish-mkdocs](https://github.com/jobindjohn/obsidian-publish-mkdocs) template.
