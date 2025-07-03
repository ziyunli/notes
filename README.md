# Obsidian to MkDocs Publishing System

An extended implementation of the [obsidian-publish-mkdocs](https://github.com/jobindjohn/obsidian-publish-mkdocs) template for publishing [Obsidian](https://obsidian.md/) notes as a beautiful static website using [MkDocs](https://www.mkdocs.org/) and [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/).

## Features

- 🎨 **Beautiful Material Design** - Clean, modern theme with light/dark mode toggle
- 🔗 **Obsidian Wikilinks** - Automatic conversion of `[[wikilinks]]` to proper HTML links
- 📝 **Blog Support** - Built-in blog functionality with RSS feed generation
- 🔍 **Full-Text Search** - Search across all your published notes
- 📐 **Math & Diagrams** - LaTeX math rendering and Mermaid diagram support
- 🚀 **Automated Deployment** - GitHub Actions automatically publishes to GitHub Pages
- 📦 **Modern Python Tooling** - Uses `uv` for fast, reliable dependency management

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

## Project Structure

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

## Adding Content

### Regular Notes

Simply place `.md` files in the `docs/` directory. The folder structure becomes your site navigation:

```
docs/
├── projects/
│   ├── project1.md
│   └── project2.md
└── notes/
    ├── daily/
    │   └── 2024-01-03.md
    └── ideas.md
```

### Blog Posts

Add blog posts to `docs/blog/posts/` with frontmatter:

```markdown
---
date: 2024-01-03
categories:
  - Tutorial
  - MkDocs
tags:
  - obsidian
  - publishing
---

# My Blog Post Title

Your content here...
```

### Supported Features

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

## Requirements

- Python 3.12+
- [uv](https://github.com/astral-sh/uv) package manager
- Git

## Troubleshooting

**Site not appearing on GitHub Pages?**
- Ensure GitHub Pages is enabled in repository settings
- Check that the `gh-pages` branch exists
- Wait a few minutes for the deployment to complete

**Wikilinks not working?**
- Ensure the linked file exists in the `docs/` folder
- Check that filenames match exactly (case-sensitive)
- Avoid spaces in filenames

**Local preview not working?**
- Ensure all dependencies are installed: `uv sync`
- Check that you're in the correct directory
- Try clearing MkDocs cache: `rm -rf .cache/`

## License

This template is released under the CC0 1.0 Universal license. See [LICENSE](LICENSE) for details.

## Acknowledgments

Based on the [obsidian-publish-mkdocs](https://github.com/jobindjohn/obsidian-publish-mkdocs) template.