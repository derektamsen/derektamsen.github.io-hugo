---
title: "Helpful Screen Tips"
date: "2012-10-30T00:08:00-08:00"
draft: false
summary: "Screen is a great command to know when working on linux and unix systems. Screen allows long commands to stay running if you become disconnected from a server or if you want to disconnect."
description: "Screen is a great command to know when working on linux and unix systems. Screen allows long commands to stay running if you become disconnected from a server or if you want to disconnect."
toc: true
readTime: true
autonumber: false
math: false
tags: ["screen", "linux"]
showTags: false
hideBackToTop: false
aliases: ["/blog/2012/10/30/helpful-screen-tips"]
---

Screen may not be installed by default depending on what distribution you are using. In order to use it you will need to install it on the system you are working on. The installation process is usually pretty simple.

## In centos you can find it in the base repository.
```sh
$ sudo yum install screen
```

## Ubuntu/Debian
```sh
$ sudo apt-get install screen
```

### Starting a new screen session
```sh
$ screen -a
```

### Detach any active tty and attach to an existing screen session
```sh
$ screen -DR
```

### Listing screen sessions is pretty simple
```sh
$ screen -ls
```

### Disconnect from a session
Once you are in a screen session you can disconnect from it and keep your existing commands running:

1. Press `CTRL+A`
2. Then press `D` for detach

### Leaning more
Screen is quite powerful. If you would like to learn more you can use the built-in help functions.

##### In-screen help
1. Press `CTRL+A`
2. Then press `?` to bring up the onscreen help menu.

##### You can also view the manpages for screen
```sh
$ man screen
```
