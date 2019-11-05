[![Build Status](https://travis-ci.org/derektamsen/derektamsen.github.io-hugo.svg?branch=master)](https://travis-ci.org/derektamsen/derektamsen.github.io-hugo)

# Devops Derek Source
This is the source for https://www.devopsderek.com.

## Content
### New Article
Create a new article run:
```
hugo new posts/$(date +%Y-%m-%d)-article-title.md
```

## Setup
- Install latest hugo from https://github.com/spf13/hugo/releases:
  `sudo apt-get install hugo`
- Install pygments to support highlighting:
  `sudo apt install python3-pygments`

## Automatic Deploy
Travis-ci should automatically deploy the static files upon successfully merging
to the master branch.

## Manual Deployment Setup
- Install and setup Google Firebase.
  `npm install -g firebase-tools`
- Login to Firebase:
  `firebase login`

## Manually Deploying
Before manually deploying you will need to follow the setup process for the Google Firebase Client.

`./deploy`

## Generate and Encrypt Firebase Deployment Token for Travis
In order to encrypt the firebase deployment token for Travis we will need to install
the travis CLI tools.

https://docs.travis-ci.com/user/encrypting-files/#Manual-Encryption

Install and login to travis:
```
gem install bundler
bundle install --with development
travis login
```

Generate and encrypt the firebase token for use with travis:
```
firebase login:ci
travis encrypt "<super_secret_token_from_loginci>" --add deploy.token
```
