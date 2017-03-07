[![Build Status](https://travis-ci.org/derektamsen/derektamsen.github.io-hugo.svg?branch=master)](https://travis-ci.org/derektamsen/derektamsen.github.io-hugo)

# Devops Derek Source
This is the source for https://www.devopsderek.com.

## Setup
- Install latest hugo from https://github.com/spf13/hugo/releases
  `sudo apt-get install hugo`
- Install pygments to support highlighting:
  `sudo apt install python3-pygments`

## Automatic Deploy
Travis-ci should automatically deploy the static files upon successfully merging
to the master branch.

## Manually Deploying
https://gohugo.io/tutorials/github-pages-blog/#hosting-personal-organization-pages

`./deploy 'Commit Message'`

## Encrypting Travis-ci Vars
In order to encrypt the Travis-ci environment variables we will need to install
the CLI tools.

https://docs.travis-ci.com/user/encrypting-files/#Manual-Encryption

```
gem install bundler
bundle install
travis login
travis encrypt super_secret_password=foobar --add
```
