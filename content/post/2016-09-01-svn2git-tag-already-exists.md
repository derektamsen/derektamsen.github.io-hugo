+++
author = "Derek Tamsen"
comments = true
date = "2016-09-01T00:10:42-07:00"
draft = false
image = ""
menu = ""
share = true
tags = ["svn", "git", "svn2git"]
title = "svn2git Tag Already Exists"

+++

This also works if someone may have done something in svn that they were not supposed (update a tag).

1. If you get an error message that you have a duplicate tag simply delete the original tag.
```
git tag -d 1.4
```

2. Then perform the svn2git rebase.
```
svn2git --rebase
```
