---
title: "Bulk Delete Messages from Postfix Queue"
date: "2013-11-10T16:41:00-08:00"
draft: false
summary: "Have you have ever had a script or application accidentally send thousands of messages through your postfix queue? With this simple tip you no longer need to wait for those messages to be processed through the Postfix queue. This one liner is also helpful if you have a lot of differed messages in the Postfix queue you would like to discard."
description: "Have you have ever had a script or application accidentally send thousands of messages through your postfix queue? With this simple tip you no longer need to wait for those messages to be processed through the Postfix queue. This one liner is also helpful if you have a lot of differed messages in the Postfix queue you would like to discard."
toc: true
readTime: true
autonumber: false
math: false
tags: ["smtp", "postfix", "linux"]
showTags: false
hideBackToTop: false
aliases: ["/blog/2013/11/10/bulk-delete-messages-from-postfix-queue"]
---

You can simply use standard linux tools to awk through your Postfix queue and drop those unwanted messages. You will need access to `sudo`, `postqueue`, and `postsuper` to list the queue and drop the unwanted messages from postfix.

## Dropping Messages To/From a Specific Address
_The usual caution: This will permanently drop the filtered messages from you postfix queue. You may want to see the output before piping it to postsuper._

```sh
sudo postqueue -p |\
  grep 'someaddress@example.com' |\
  cut -d ' ' -f1 |\
  tr -d '*' |\
  sudo postsuper -d -
```

### Command Overview
1. List all of the messages that are currently in the postfix queue with `postqueue -p`
2. Pipe the output to `tail -n +2` skipping the first 2 lines of output.
3. Next, pipe the output to `awk` which looks for the address "someaddress@example.com".
4. `tr` then removes both "*" and "!" from the awk'd output.
5. Finally, `postsuper -d -` drops the message from the queue by using the message id.
