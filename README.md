# Devops Derek Source

This is the source for https://www.devopsderek.com.

## Content

### New Article

Create a new article run:

```bash
hugo new content/posts/$(date +%Y-%m-%d)-article-title.md
```

## Local Development Setup

- Install latest [hugo](https://github.com/spf13/hugo/releases) with:
  `sudo snap install hugo`

## Deploy

Cloudflare will automatically deploy this site. PR builds are enabled and will be updated when changes are pushed to the PR branch. Production is deployed automatically once a PR is merged.
