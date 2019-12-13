+++
author = "Derek Tamsen"
comments = true
date = "2016-08-27T16:40:44-07:00"
draft = false
tags = ["vagrant", "rsync"]
title = "Publish Vagrant Boxes with rsync"
description = "The built in `vagrant push` command allows you to post your boxes publicly to Atlas. However, what if you want to publish boxes to an internal or private server over `ssh`?"

+++

The built in `vagrant push` command allows you to post your boxes publicly to [Atlas](https://atlas.hashicorp.com/boxes/search). However, what if you want to publish boxes to an internal or private server over `ssh`?

Fortunately, the push command can be redefined. Out of the box it is possible to use other methods that allow publishing boxes to both [Heroku](https://www.heroku.com/) and via FTP/SFTP. Vagrant also allows using a custom shell script with [local-exec](https://www.vagrantup.com/docs/push/local-exec.html) to publish your boxes.

Local-Exec enables us to write a simple script to publish boxes with rsync or scp. This will enable you to `vagrant push` to an internal webserver via rsync.

Simply add the following example to you project's `Vagrantfile`:
```ruby
config.push.define "local-exec" do |push|
  push.inline = <<-UPLOAD
    rsync -Pav tmp/*.box user@boxhost.example.com:/var/www/boxes/
  UPLOAD
end
```

Now, when you run `vagrant push` in your project, vagrant will rsync all of the box files in `tmp/` to `/var/www/boxes/` on your web server, `boxhost.example.com`.
