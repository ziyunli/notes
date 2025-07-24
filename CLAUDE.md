# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a collaborative note-taking and knowledge management system where Yun Sama collects notes from articles and books, shares thoughts and comments, and Claude Code (Claudia) assists in organizing and categorizing the content. The system uses Obsidian-to-MkDocs publishing to convert notes into a static website with automatic deployment to GitHub Pages.

## Quick Start

1. **Install dependencies** (requires [uv](https://github.com/astral-sh/uv))
   ```bash
   uv sync
   ```

2. **Add your notes** - Place the notes you want to publish in the `docs/` folder

3. **Preview locally**
   ```bash
   uv run mkdocs serve
   ```
   Visit http://localhost:8000 to see your site

4. **Deploy** - Push to GitHub and the site will automatically deploy to GitHub Pages
   ```bash
   git add .
   git commit -m "Add my notes"
   git push
   ```

The site is automatically deployed via GitHub Actions and available at your GitHub Pages URL.

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

## Available Tools

### Gemini CLI
Claude Code can use Gemini as a secondary LLM for assistance with various tasks. When using Gemini:
- Always inform the user what task is being delegated to Gemini
- Share Gemini's response with the user
- Use for tasks like getting alternative perspectives, fact-checking, or brainstorming

### GitHub CLI (gh)
Use GitHub CLI for repository management tasks:
- Creating and managing issues: `gh issue create/list/view`
- Pull requests: `gh pr create/list/merge`
- Repository info: `gh repo view`
- Releases: `gh release create/list`

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
.
├── docs/                 # Your notes go here
│   ├── index.md         # Homepage
│   ├── blog/            # Blog section
│   │   ├── index.md     # Blog homepage
│   │   └── posts/       # Blog posts
│   └── ...              # Your other notes/sections
├── mkdocs.yml           # MkDocs configuration
├── pyproject.toml       # Python dependencies
└── .github/
    └── workflows/
        └── ci.yml       # GitHub Actions workflow
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

## Blog Post Requirements

When creating blog posts in `docs/blog/posts/`, follow these requirements:

### File Naming
Blog post files should include the date in the filename using the format: `YYYY-MM-DD-post-title.md`
Example: `2025-07-03-hello-world.md`

### Frontmatter Requirements
Every blog post must include the following frontmatter:

```yaml
---
date: YYYY-MM-DD  # Always use the current system date
categories:
  - CategoryName  # Include exactly ONE category
tags:
  - tag1         # Include 1-3 relevant tags
  - tag2
  - tag3
---
```

### Categories and Tags Guidelines
- **Categories**: Choose ONE best matching category. Use existing categories when possible:
  - General
  - Technical
  - Tutorial
  - Project
  - Personal
  - Create new categories only when existing ones don't fit

- **Tags**: Select 1-3 specific tags that describe the content. Prefer existing tags but create new ones when needed. Common tags include:
  - introduction
  - tutorial
  - announcement
  - update
  - tips
  - tools

### Additional Optional Fields
- `authors`: List of authors
- `description`: Brief post description

The RSS plugin requires proper frontmatter to generate feeds correctly.

## Supported Features

- **Wikilinks**: `[[My Note]]` → automatic link to `My Note.md`
- **Math**: `$E = mc^2$` for inline, `$$...$$` for blocks
- **Diagrams**: Mermaid diagrams in code blocks
- **Task Lists**: `- [ ] Todo item`
- **Footnotes**: `Text[^1]` and `[^1]: Footnote`

## Customization

### Site Configuration

Edit `mkdocs.yml` to customize:
- Site name and description
- Theme colors
- Navigation structure
- Enabled plugins

### Theme Colors

In `mkdocs.yml`, modify the palette section:
```yaml
theme:
  palette:
    - scheme: default
      primary: pink    # Change primary color
      accent: indigo   # Change accent color
```

## Collaborative Note-Taking Workflow

### Claude Code's Role
As Claude Code (or Claudia), you are the primary assistant in this knowledge management system. Your responsibilities include:

1. **Content Categorization**: Analyze daily notes from articles/books and organize them into appropriate topics
2. **Topic Extraction**: Identify common threads across different notes and create topic pages
3. **Cross-Linking**: Use Obsidian `[[wikilinks]]` to connect related concepts and enable backlinks
4. **Suggestion Provider**: Offer content suggestions while respecting the original voice

### Critical Guidelines

1. **PRESERVE ORIGINAL CONTENT**:
   - Keep all thoughts, comments, and quotations EXACTLY AS PROVIDED
   - Never modify, paraphrase, or "improve" the user's original text
   - Only organize and categorize - do not edit content

2. **Organization Structure**:
   - Blog posts (`docs/blog/posts/`): Daily reading notes with thoughts/comments
   - Topic folders (`docs/topics/`): Extracted themes and concepts
   - Use descriptive folder and file names for topics

3. **Linking Strategy**:
   - Always use `[[Topic Name]]` format for internal links
   - Create bidirectional connections between blog posts and topic pages
   - Ensure backlinks work properly by using consistent naming

4. **Categorization Process**:
   - Read the daily notes carefully
   - Identify key themes, concepts, or ideas
   - Create or update topic pages with relevant excerpts
   - Link back to the original blog post for context

### Example Workflow

1. User creates a blog post with notes from a book
2. Claude Code identifies themes (e.g., "productivity", "philosophy")
3. Creates/updates topic pages: `docs/topics/productivity.md`, `docs/topics/philosophy.md`
4. Adds relevant excerpts to topic pages with `[[2025-07-03-book-notes]]` backlinks
5. Updates the blog post with links to topics: `Related topics: [[productivity]], [[philosophy]]`

## Notes

- The `mkdocs-roamlinks-plugin` has a deprecation warning about `warning_filter` but it still works
- Avoid spaces in filenames (use dashes or underscores)
- First-level heading in markdown becomes the webpage heading
- The site supports MathJax for LaTeX and Mermaid for diagrams out of the box
