---
layout: post
title: "Secure SSH 删除knows_hosts"
description: ""
category: "markdown"
tags: [chromebook ssh]
---

SSH HOST换了IP地址，Secure SSH就上不去了。解决方法：
1. 启动 Secure Shell 扩展
2. 在 Secure Shell 扩展的 Tab 界面下，按下 “Ctrl+Shift+J” 打开 “Javascript 控制台” 工具
3. 输入如下命令：
> term_.command.removeAllKnownHosts()
true
4. OK！known_hosts 记录清除完毕！

摘自<http://www.tuicool.com/articles/EfqURv>
