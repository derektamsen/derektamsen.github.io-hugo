+++
categories = ["tar", "nc", "linux", "file transfer"]
date = "2013-04-08T00:56:00-08:00"
description = "When transferring files between systems usually `rsync` or `scp` are all that is needed. Sometimes, there are difficult edge cases. For example using `rsync` to transfer many files spread across 1000s of directories quickly. Recently, I needed to move several TB worth of files in varying size spread across 1000s of directories. I found that `rsync` spent most of the time traversing directories and not copying the data. I turned to the webs to find a better solution. The excellent solution I found had an old school feel using `tar` and netcat (`nc`)."
draft = false
keywords = ["tar", "nc", "linux", "file transfer"]
title = "quickly transfer files between servers"

+++

When transferring files between systems usually `rsync` or `scp` are all that is needed. Sometimes, there are difficult edge cases. For example using `rsync` to transfer many files spread across 1000s of directories quickly. Recently, I needed to move several TB worth of files in varying size spread across 1000s of directories. I found that `rsync` spent most of the time traversing directories and not copying the data. I turned to the webs to find a better solution. The excellent solution I found had an old school feel using `tar` and netcat (`nc`).

The solution seemed too simple to work efficiently especially considering how slow `rsync` had been at transferring the files. I was quite wrong, really wrong. During my first attempt `rsync` had been using about 20% - 40% of a 1Gb network link. With `tar | nc` I was now seeing 80% - 95% usage on the 1Gb link.

The only issue I have with using `tar | nc` was with doing incremental updates. There is probably a way by using tar to do an incremental backup but for my usage `rsync` was acceptable once the initial copy was completed.

## How to Use This Awesomeness
- On the source server you will be running `tar | pv | pigz | nc`.
    - `tar`: archives the directory.
    - `pv`: is simply used to calculate the size remaining to transfer.
    - `pigz`: is a parallel gzip compression utility.
    - `nc`: sends the data to the recieving system that connects to TCP port "9999".
        - _`nc` does not have any authentication or encryption. I do not recommend using this over the Internet without stunnel or a vpn._
        - You will also need to ensure the TCP port 9999 is open between the source and destination.

- Open the port and set the directory on the source server
```sh
tar -c /some/dir/to/copy | pv --size 'du -sb /some/dir/to/copy | cut -f1' | pigz -5 | nc -l 9999
```

- On the destination server, simply change to the directory you want the files in. Then, connect to the source server. This is basically reversing what is happening in step 1.
    - `nc`: connects to the source_server on TCP port 9999.
    - `gunzip`: decompresses the data from `pigz` from the source server.
    - `tar`: unarchives the data to disk.

- Connect to the source server and start the transfer
```sh
cd /some/dir/to/store/files
nc source_server 9999 | gunzip | tar xvf -
```

## What is happening
Essentially, netcat is providing a way to extend the stdout from the source server to the destination server. Netcat is connecting the stdout from the source system to the stdin on the receiving system. The above is basically the same thing as stringing commands together with `|` and leveraging stdout.

## Credit
Thanks to Andrew's [post](http://andrew.tumblr.com/post/2316602611 "Combining tar, pigz, and netcat") for the inspiration and saving me a few days.
