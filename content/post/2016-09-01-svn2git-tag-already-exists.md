+++
author = "Derek Tamsen"
comments = true
date = "2016-09-01T00:10:42-07:00"
draft = false
image = ""
menu = ""
share = true
tags = ["svn", "subversion", "git", "svn2git", "vcs"]
title = "svn2git: Tag Already Exists"

+++

If you find yourself migrating a repository from subversion to git you may run into a couple issues. One common issue I ran into was where an engineer updated a tag. When converting a repository with a modified tag, `svn2git`[^svn2gitrepo] will stop and return an error message stating that a duplicate tag is present.

Fortunately, this is an easy issue to correct. You simply need to delete the tag and rerun the conversion. This works because `svn2git` is replaying the commit history from oldest to newest against the new git repository. After removing the older tag, re-running `svn2git` will apply the next tag creation.

Delete the old tag in the new git repository:
```
git tag -d 1.4
```

Then, perform the svn2git rebase to create the next version of the tag:
```
svn2git --rebase
```

If you have multiple updates to a subversion tag this can be run for each instance until the final tag creation is created.

This situation can occur due to the differences between subversion and git. [^gitsvncomparison] Subversion treats tags the same as branches: each are simply full copies. This means a tag is just a branch which allows updates to be committed. Git on the other hand handles tags and branches differently. In git a tag is just frozen reference to a commit sha and therefore cannot be updated in the same manner. The tag reference in git is one of the ways git is more efficient over subversion.

The ability to restrict commits to subversion tags is possible and recommend. Updates to tags can be restricted with a [pre-commit hook](https://gist.github.com/derektamsen/7e7c24e0ea18f26a3ab8737f767b0b9d).

[^svn2gitrepo]: [nirvdrum/svn2git](https://github.com/nirvdrum/svn2git)
[^gitsvncomparison]: [kernel.org git svn Comparison](https://git.wiki.kernel.org/index.php/GitSvnComparison)
