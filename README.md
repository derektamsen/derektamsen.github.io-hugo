[![Netlify Status](https://api.netlify.com/api/v1/badges/9b367bd4-26af-4c2e-8703-48a3530344a8/deploy-status)](https://app.netlify.com/sites/devopsderek/deploys)

# Devops Derek Source

This is the source for https://www.devopsderek.com.

## Content

### New Article

Create a new article run:

```bash
hugo new posts/$(date +%Y-%m-%d)-article-title.md
```

## Local Development Setup

- Install latest [hugo](https://github.com/spf13/hugo/releases) with:
  `sudo snap install hugo`

## Deploy

Netlify will automatically deploy this site. PR builds are enabled and will be updated when changes are pushed to the PR branch. Production is deployed automatically once a PR is merged.
