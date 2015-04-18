---
layout: post
title: "Kindle 3 lauchpad 配置文件"
description: ""
category: "Kindle"
tags: []
---

自从有了平板，Chromebook, 我的Kindle 3的使用机会是越来越少了。之前在Kindle 3上捣鼓的一些配置，尤其是一些特别实用的快捷键都忘记了。下面就贴出lauchpad的快捷键配置。

# fbreader.ini
    [Actions]
    ;; run FBReader
    F B = !/mnt/us/FBReader/goqt.sh FBReader &
    ;; run fbKindle
    F R = !/mnt/us/fbKindle/goqt.sh FBReader &

# kpdf.ini
    [Actions]
    # start kindlepdfviewer with filebrowser in /mnt/us/documents
    P D = !/mnt/us/kindlepdfviewer/kpdf.sh /mnt/us/documents
    # start kindlepdfviewer with last document
    P P = !/mnt/us/kindlepdfviewer/kpdf.sh
    # start kindlepdfviewer without framework in /mnt/us/documents
    P K = !/mnt/us/kindlepdfviewer/kpdf.sh --framework_stop /mnt/us/documents
    # start kindlepdfviewer without framework on last read document
    P L = !/mnt/us/kindlepdfviewer/kpdf.sh --framework_stop
    # restart amazon framework - when it got irritated
    P R = !/etc/init.d/framework restart

# launchpad.ini
    ;;;
    ;;; when started, the kindle launchpad just transparently scans keypad and
    ;;; fiveway keystrokes until the user presses and releases the hot sequence
    ;;; Introducer key. Then the launchpad enters the hotkey mode: it captures
    ;;; all system input, engages the interval timer to trigger after specified
    ;;; HotInterval milliseconds and starts collecting further keystrokes in an internal
    ;;; hotkey sequence buffer.
    ;;; When the hotkey interval timer triggers or the Trailer key is pressed, the system
    ;;; input capture gets released, and an attempt to execute collected hotkey action
    ;;; is made. Available hotkey actions are controlled by contents of the [Action]
    ;;; section below

    ; Kindle input key symbolic names are used to specify the hotkey sequence introducer
    ; and trailer keys. See keydefs.ini for details
    [Settings]
    Introducer = Shift
    Trailer = Enter
    HotInterval = 700
    ScriptDirectory = ./scripts
    KeyboardInput = /dev/input/event0
    FivewayInput = /dev/input/event1
    InterKeyDelay = 300

    ;;; hotkey actions are defined below as <key_sequence> = <action_command>
    ;;; one action definition per text line.
    ;;;
    ;;; <key_sequence> is a blank separated list of key symbolic names. See keydefs.ini for details.
    ;;; <action_command> describes the action to execute on a particular hotkey sequence.
    ;;; Currently three type of action supported depending on the first character of the
    ;;; command string:
    ;;;  '!' -- shell command. The <action_command> string excluding the leading '!' is sent to the
    ;;;         system shell, exactly as it was typed from the console.
    ;;;  '@' -- Kindle Framework script. The <action_command> string excluding the leading '@' is interpreted
    ;;;         as a name of a special script containing command information obeying format of
    ;;;         the known hotkeys package. The main purpose of these scripts is to simplify
    ;;;         entering special symbols into kindle Framework search box
    ;;;  '#' -- Kindle Framework key sequence. Similar to the above, but doesn't require
    ;;;         external script.
    ;;;   all other command strings are interpreted as a sequence of a send_key commands. The contents of these
    ;;;   commands gets interpreted and sent as a sequence of simulated keystrokes to the input subsystem.
    ;;;   Such commands consist of the space-separated tokens, which can be symbolic key names and/or
    ;;;   ascii strings enclosed in quotes (")
    ;;;
    ;;;   Note: to correctly accept  kindle key sequence starting with a special
    ;;;         symbol, the Framework search box should be brought up, if not already.
    ;;;         Press the 'Del' key on Kindle in order to bring the search box up
    ;;;

    [Actions]
    ;
    ; hotkey sequence definitions below are provided for reference only.
    ; uncomment corresponding line(s) and restart the Program in order to enable
    ; these definitions
    ;

    ;Dot = @SHIFT-DOT.sh
    ;Slash = @SHIFT-SLASH.sh
    ;;0 = @SHIFT-0.sh
    ;;1 = @SHIFT-1.sh
    ;;2 = @SHIFT-2.sh
    ;;3 = @SHIFT-3.sh
    ;;4 = @SHIFT-4.sh
    ;;5 = @SHIFT-5.sh
    ;;6 = @SHIFT-6.sh
    ;;7 = @SHIFT-7.sh
    ;;8 = @SHIFT-8.sh
    ;;9 = @SHIFT-9.sh
    ;
    ;;P = #')'
    ;;O = #'('
    ;;I = #'*'
    ;;U = #'&'
    ;;Y = #'^'
    ;;T = #'%'
    ;;R = #'$'
    ;;E = #'#'
    ;;W = #'@'
    ;;Q = #'!'
    ;;Dot = #','
    ;;Slash = #'?'
    ;
    ;;D = #';' "debugOn"
    ;;N = #"`usbNetwork"
    ;;X = "just a string"


# mplayer.ini
    [Actions]

    ## Launch the playlist, see mplayer/playlist
    M L = !/mnt/us/mplayer/control.sh playlist

    ## Play everything in the music directory
    M A = !/mnt/us/mplayer/control.sh playall

    ## Play everything in the music directory, in random order (Shuffle)
    M R = !/mnt/us/mplayer/control.sh playrand

    M Space = !/mnt/us/mplayer/control.sh pause
    M S = !/mnt/us/mplayer/control.sh stop
    M P = !/mnt/us/mplayer/control.sh prev
    M N = !/mnt/us/mplayer/control.sh next

myts.l.ini
    [Actions]
    T A = !/mnt/us/myts/myts.sh kill
    T T = !/mnt/us/myts/myts.sh 1
    T Y = !/mnt/us/myts/myts.sh 2
    T U = !/mnt/us/myts/myts.sh 3

rce.ini
    [RemoteCommandEntry]

    ;; comment out AutoEnable and enableRCE definitions below
    ;; in order to tully disable the RCE feature

    AutoEnable = No
    enableRCE = start RCE
    disableRCE = stop RCE

    Interface = usb0
    MulticastGroup = 239.1.2.3
    Port = 10000


# record.ini
    [Actions]
    A S = !RECDIR=records; [ -d "/mnt/us/$RECDIR" ] || mkdir -p "/mnt/us/$RECDIR"; arecord -qN /mnt/us/$RECDIR/$(date +'%Y-%m-%d_%H-%M-%S').wav &
    A E = !pkill -f arecord

# servicecmds.ini
    [Actions]
    ;; reread hotkey sequence database
    Shift Space = !kill -HUP `pidof launchpad` &
    ;; install custom updates
    Shift I = !/mnt/us/launchpad/customupdate.sh
    ;; Sleep/show screensaver
    Shift S = !powerd_test -p
    ;; restart Amazon Kindle framework
    Shift A = !/etc/init.d/framework restart &
    ;; kick/continue mistakenly stopped Amazon Kindle framework
    Shift C = !kill -CONT `pidof cvm` &
    ;; Reboot
    Shift R = !shutdown -r now &
    ;; Shutdown
    Shift H = !shutdown -h now &



# usbnet.ini
    [Actions]
    Shift N = !/test/bin/usbnetwork
