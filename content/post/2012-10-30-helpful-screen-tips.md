+++
date = "2012-10-30T00:08:00-08:00"
description = "Screen is a great command to know when working on linux and unix systems. Screen allows long commands to stay running if you become disconnected from a server or if you want to disconnect."
draft = false
tags = ["screen", "linux"]
title = "helpful screen tips"

+++

Screen is a great command to know when working on linux and unix systems. Screen allows long commands to stay running if you become disconnected from a server or if you want to disconnect.

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
Once you are in a screen session you can disconnect from it and keep your existing commands running

- Press <kbd><kbd>CTRL</kbd>+<kbd>A</kbd></kbd>
- Then press <kbd><kbd>D</kbd></kbd> for detach

### Leaning more
Screen is quite powerful. If you would like to learn more you can use the built-in help functions.

##### In-screen help
- Press <kbd><kbd>CTRL</kbd>+<kbd>A</kbd></kbd>
- Then press <kbd><kbd>?</kbd></kbd> to bring up the onscreen help menu.

##### You can also view the manpages for screen
```sh
$ man screen
```
