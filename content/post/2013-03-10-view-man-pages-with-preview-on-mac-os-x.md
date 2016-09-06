+++
date = "2013-03-10T15:43:00-08:00"
draft = false
tags = ["Mac OS X", "man", "preview"]
title = "View Man Pages with Preview on Mac OS X"
description = "I am always looking for better ways to integrate the unix components into Mac OS X. I recently came across a great way to connect the `man` pages to a more visual mode in OS X."

+++

I am always looking for better ways to integrate the unix components into Mac OS X. I recently came across a great way to connect the `man` pages to a more visual mode in OS X. Sure, you could always use `xman` as a visual multi window view for the `man` pages, screen, or some other multi window handler. However, I was not impressed with the x window environment on OS X because it requires a lot of modification to leverage the fonts and the rendering engine of the OS.

I settled on a solution that uses preview. Preview provides an easy solution to get great fonts and rendering native to the OS without much work from a shell script. Preview also allows for other functionality like bookmarks, highlighting, pagination, saving, etc.


The script is rather simple. It is essential opening the `man` page in the background and piping the pages to `groff`. `Groff` then outputs a postscript file of the `man` page which is then opened with preview. The script goes in your `~/.bash_profile` as function that you call as a program in place of `man`. I have modified the original function slightly so it supports passing in the `man` page section as well.

The default usage of `pman` will mirror `man`. If you only pass it one argument it will display the `man` page. If you pass it two arguments it will treat the first one as the `man` page section and the second the `man` page you would like to view.

I would like to give [Macworld](http://www.macworld.com/article/1054155/manpages.html "Open Unix manual pages in OS X 10.4's Preview") credit for this as that is where I originally found the tip.

## Editing your bash profile and adding the function
- Edit your `~/.bash_profile`.

```sh
vi ~/.bash_profile
```

- Insert the following function someplace in your `~/.bash_profile`:

```sh
pman() {
    man -t ${@} | open -f -a /Applications/Preview.app/
}
```

- Source your `~/.bash_profile` to load the new function.

```sh
. ~/.bash_profile
```

## Viewing man pages with preview
Viewing man pages with preview is now as simple as using `pman` instead of `man`. _It may take a few seconds for the `man` page to open depending on the speed of your machine._

## Some Examples:

- View man pages for manual:
```sh
pman man
```

- View man pages for chroot
```sh
pman chroot
```

- View chroot(2)
```sh
pman 2 chroot
```

## View the manual page for ls
```sh
pman ls
```

{{% figure src="/images/pman_ls.png" title="pman example with ls" %}}
