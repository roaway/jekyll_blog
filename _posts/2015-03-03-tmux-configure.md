---
layout: post
title: "Tmux配置"
description: ""
category: "GNU/Linux"
tags: [linux,shell,Tmux]
---

Tmux是Linux终端多路复用器，类似于GNU Screen，功能远比后者强大，现在已成为我在Chromebook linux环境下每天必用的工具。

以下我的Tmux配置文件

    ~/.tmux.conf

    set -g prefix ^a
    unbind ^b
    bind a send-prefix

    bind - splitw -v
    bind | splitw -h

    bind k selectp -U
    bind j selectp -D
    bind h selectp -L
    bind l selectp -R


    bind ^k resizep -U 10
    bind ^j resizep -D 10
    bind ^h resizep -L 10
    bind ^l resizep -R 10

    bind ^u swapp -U
    bind ^d swapp -D

    bind m command-prompt "splitw -h 'exec man %%'"
    bind @ command-prompt "splitw -h 'exec perldoc -f %%'"
    bind-key u capture-pane \; save-buffer /tmp/tmux-buffer \; new-window -n "urlview" '$SHELL -c "urlview < /tmp/tmux-buffer"'

    set -g status-bg black
    set -g status-fg yellow

    bind-key r      source-file ~/.tmux.conf\; display-message "~/.tmux.conf is reloaded"
    bind-key a      send-key C-a   # `Ctrl-a a` sends `Ctrl-a`
    bind-key n      command-prompt 'rename-window %%'
    bind-key N      command-prompt 'rename-session %%'
    bind-key -r <   swap-window -t :-
    bind-key -r >   swap-window -t :+

    set-window-option -g mode-mouse on
    set-option -g mouse-select-pane on

    #urxvt tab like window switching (-n: no prior escape seq)
    bind -n S-down new-window
    bind -n S-left prev
    bind -n S-right next
    bind -n C-left swap-window -t -1
    bind -n C-right swap-window -t +1

    set -g set-titles on
    set -g set-titles-string "#T"


需注意的是，对于 <code>bind-key r      source-file ~/.tmux.conf\; display-message "~/.tmux.conf is reloaded"</code>之类的一个语句多个命令的情况，命令分隔符需要转义，例如“\;“，否则会出现“can't establish current session“的错误。

    {% highlight bash %}
    #If not running interactively, do not do anything
    [[ $- != *i* ]] && return
    [[ -z "$TMUX" ]] && exec *mux* default
    {% endhighlight %}
上面脚本中的*mux* 是Tmux布局配置辅助程序 [Tmuxinator](https://github.com/tmuxinator/tmuxinator "Tmuxinator")提供的命令。Tmuxinator采用ruby语言编写，使用Yaml语言进写布局（layout）配置，可以用<code> sudo gem install tmuxinator </code>安装。

用户可以使用tmux命令编写脚本文件，以下是一个在网上找到的很实用例子。

    {% highlight bash %}
    #!/bin/sh
    #
    # name     : tmuxenï¼ tmux environment made easy
    # author   : Xu Xiaodong xxdlhy@gmail.com
    # license  : GPL
    # created  : 2012 Jul 01
    # modified : 2012 Jul 02
    #

    cmd=$(which tmux) # tmux path
    session=codefun   # session name

    if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
    fi

    $cmd has -t $session

    if [ $? != 0 ]; then
    $cmd new -d -n vim -s $session "vim"
    $cmd splitw -v -p 20 -t $session "pry"
    $cmd neww -n mutt -t $session "mutt"
    $cmd neww -n irssi -t $session "irssi"
    $cmd neww -n cmus -t $session "cmus"
    $cmd neww -n zsh -t $session "zsh"
    $cmd splitw -h -p 50 -t $session "zsh"
    $cmd selectw -t $session:5
    fi

    $cmd att -t $session

    exit 0
    {% endhighlight %}

这种配置方式不需要安装额外的程序，但是需要记忆Tmux复杂的内部命令，不易掌握，而且不能灵活配置多种布局。而使用Tmuxinator可以方便设置多种布局。经过比较，我决定采用Tmuxinator布局方式。

      mux new default

以上命令新建一个名为“default“的布局配置文件。其中new使用“n“作为简写，类似的编辑命令*edit*可以用 * e *代替。

以上.bashrc脚本，表示打开Bash shell时，自动运行Tmux，并执行default布局方式。

使用<code> mux e default </code>编辑配置文件 。我的default文件内容如下：

    # ~/.tmuxinator/default.yml

    {% highlight yaml %}
    name: default
    root: ~/
    windows:
      - editor:
          layout: main-horizontal
          panes:
            - emacs
            - #bash
      - mail:
          layout: main-horizontal
          panes:
             - mutt
             {% endhighlight %}
以上配置 ，新建两个窗口，Editor窗口上下分成两个窗格，一个运行emacs, 一个运行bash。另外一个窗口打出mutt，显示电子邮件。


以下文件可以参考：

1. <https://wiki.archlinux.org/index.php/Tmux>
2. <https://linuxtoy.org/archives/from-screen-to-tmux.html>
