# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is an Obsidian-to-MkDocs publishing template that converts Obsidian notes into a static website using MkDocs with the Material theme. The site is automatically deployed to GitHub Pages via GitHub Actions.

## Essential Commands

```bash
# Serve locally for development (http://localhost:8000)
uv run mkdocs serve

# Build static site in site/ directory
uv run mkdocs build

# Deploy to GitHub Pages
uv run mkdocs gh-deploy --force

# Install/update dependencies
uv sync --locked
```

## Architecture Overview

The system uses a simple pipeline:
1. **Obsidian notes** are placed in `docs/` directory
2. **MkDocs** processes the markdown files with these key plugins:
   - `mkdocs-roamlinks-plugin` - Converts Obsidian `[[wikilinks]]` to proper HTML links
   - `mkdocs-material` - Provides the Material theme with light/dark mode
   - `mkdocs-rss-plugin` - Generates RSS feeds for blog posts
3. **GitHub Actions** (`.github/workflows/ci.yml`) automatically builds and deploys on push to main/master
4. **GitHub Pages** hosts the static site at `https://[username].github.io/[repo-name]/`

## Content Organization

```
docs/                  # All publishable content
├── index.md          # Homepage
├── blog/             # Blog section
│   ├── index.md     # Blog homepage  
│   └── posts/       # Individual blog posts (with frontmatter)
└── [sections]/      # Other content sections
```

The folder structure in `docs/` automatically becomes the site navigation. Blog posts in `docs/blog/posts/` need frontmatter with date, categories, and tags for RSS feed generation.

## Key Configuration Files

- **`mkdocs.yml`** - Site configuration, theme settings, plugin configuration, markdown extensions
- **`pyproject.toml`** - Python dependencies managed by uv
- **`.github/workflows/ci.yml`** - Automated deployment workflow using uv

## Adding Content Workflow

1. Place `.md` files in appropriate folders under `docs/`
2. Use Obsidian features freely: `[[wikilinks]]`, LaTeX math (`$...$`), Mermaid diagrams
3. For blog posts, add to `docs/blog/posts/` with proper frontmatter
4. Test locally with `uv run mkdocs serve`
5. Commit and push - GitHub Actions handles deployment

## Notes

- The `mkdocs-roamlinks-plugin` has a deprecation warning about `warning_filter` but it still works
- Avoid spaces in filenames (use dashes or underscores)
- First-level heading in markdown becomes the webpage heading
- The site supports MathJax for LaTeX and Mermaid for diagrams out of the box