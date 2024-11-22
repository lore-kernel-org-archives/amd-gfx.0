Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C0DD75E21
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 10:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8408E10EB47;
	Fri, 22 Nov 2024 10:31:40 +0000 (UTC)
X-Greylist: delayed 457 seconds by postgrey-1.36 at gabe;
 Fri, 22 Nov 2024 09:25:03 UTC
Received: from mailgw.gate-on.net (auth.Gate-On.Net [210.197.74.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B634510EB18
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 09:25:03 +0000 (UTC)
Received: from vega.pgw.jp (unknown [49.135.95.135])
 by mailgw.gate-on.net (Postfix) with ESMTP id 9957C800B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 18:17:24 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
 by vega.pgw.jp (Postfix) with SMTP
 id AD24CA53D; Fri, 22 Nov 2024 18:17:23 +0900 (JST)
From: <xkabe@vega.pgw.jp>
To: amd-gfx@lists.freedesktop.org
Cc: xkabe@vega.pgw.jp
Subject: [bugreport] Invoking Xorg -retro and using radeon.ko renders root
 window stipple in colored dots, not B/W standard stipple
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date: Fri, 22 Nov 2024 18:17:23 +0900
Message-ID: <241122181723.M0121717@vega.pgw.jp>
X-Mailman-Approved-At: Fri, 22 Nov 2024 10:31:40 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Subject: [bugreport] Invoking Xorg -retro and using radeon.ko renders root window stipple in colored dots, not B/W standard stipple

Graphic card: RV280 ATI Radeon 9200 Pro (PCI id 1002:5960,subid 148c:2094)
kernel: kernel-5.14.0-427.42.1.el9_4 (Rocky Linux 9.4)
Xorg: xorg-x11-server-Xorg-1.20.11-24.el9
radeon.ko: git master (xf86-video-ati-22.0.0, 888b33c67) to xf86-video-ati-7.10.0


Compiled and installed radeon.ko from https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati.git .

Full power-cycle the machine, and invoking the following for the first time
xinit -- /usr/bin/Xorg -retro 
renders root window stipple in colored dots, not Black/White standard stipple.

Exit the X session, and re-invoking
xinit -- /usr/bin/Xorg -retro 
renders the root stipple correctly.

It looks like something is not initialized when root stipple pattern is rendered.
Application is not affected, works perfectly. Only the root window stipple is the problem.

Uninstalling radeon.ko and using modesetting_drv.so has no problem.

I tried the following versions, and all had the same results.
Since not many people uses Xorg -retro, this seems to be a longstanding bug.
- master 888b33c67
- tag: xf86-video-ati-22.0.0
- tag: xf86-video-ati-19.1.0
- tag: xf86-video-ati-19.0.0
- tag: xf86-video-ati-18.1.0
- tag: xf86-video-ati-18.0.0 (Tue Mar 6 18:15:45 2018 +0100)
- tag: xf86-video-ati-7.10.0 (Fri Sep 8 17:02:59 2017 +0900)
I was not able to rewind further, since the Xorg buildsystem is too recent.

-- 
kabe
