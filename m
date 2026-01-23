Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B538D6CFAD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 05:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E090410E11D;
	Fri, 23 Jan 2026 05:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=king.net.nz header.i=@king.net.nz header.b="gOatuKHE";
	dkim-atps=neutral
X-Greylist: delayed 2456 seconds by postgrey-1.36 at gabe;
 Fri, 23 Jan 2026 05:44:06 UTC
Received: from bob.king.net.nz (juliet.king.net.nz [202.49.187.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5750810E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=king.net.nz
 ; s=s1;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version
 :Date:Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D6wBr+10N6to9ARjnjSuop1M5AfSsaVU8z0vaSewEKQ=; b=gOatuKHEfDpttKCf/QQfGsaAy3
 x+mJZYd2r98p2oG/C/ObFfKMV4MMgJd8kfcnrX+1xiRVzraJ7z8ZJTzOZ3cDfnzHLm7UUBtRSFgIr
 GHE1y8IE7E4BW/cl05yOkk9oI6NkGQCz/4EXqG/2pbAqC+81woIQmoqAXVPTdOhRgbJY=;
Received: from 122-63-133-99.mobile.spark.co.nz ([122.63.133.99]:15502
 helo=[192.168.240.207])
 by juliet.king.net.nz with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <alex@king.net.nz>) id 1vj9K8-002Dkf-3D
 for amd-gfx@lists.freedesktop.org; Fri, 23 Jan 2026 18:03:09 +1300
Message-ID: <04b9c31c-1f60-465d-9316-44997555af00@king.net.nz>
Date: Fri, 23 Jan 2026 18:03:07 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
From: Alex King <alex@king.net.nz>
Subject: Problem with Hardware cursor on AMD RV730
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

I have a problem that the mouse cursor disappears after being logged in 
for some time (e.g. 15 - 30 minutes,) and while the mouse can still has 
en effect (e.g. I can see different elements on the screen getting focus 
as I move the mouse, the cursor no longer displays making it practically 
unusable.

A reboot is required to get the cursor back.


I see a few other reports of the same problem on the internet, e.g.

https://forums.linuxmint.com/viewtopic.php?t=439325
https://www.reddit.com/r/linuxmint/comments/1cqnome/mouse_cursor_disappears/
https://forums.linuxmint.com/viewtopic.php?t=357803

The common workaround is to set a software cursor in Xorg.conf. I'm 
using wayland and I don't see a way to do that with wayland. I'd switch 
back to Xorg with a software cursor if that would work and its the only 
workaround.

I didn't have this problem on the previous Debian version, so I'm 
considering reverting the kernel to an earlier one to see if that helps.

Does anyone have further tips on troubleshooting this?  E.g. should I 
diff the changes between driver versions and try to work out what's 
changed relating to the cursor?  I'm not familiar with display driver 
code but I'd kind of be interested to have a look if it was likely to be 
of use.

Some system details below.



I've got an older Mac (iMac11,2) and I'm running Debian Trixie on it.

It has RV730 inbuilt video:

$lspci

...

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] RV730/M96-XT [Mobility Radeon HD 4670]
     Subsystem: Apple Inc. Device 00b6
     Kernel driver in use: radeon
     Kernel modules: radeon, amdgpu


I have this file:

/usr/lib/modules/6.12.63+deb13-amd64/kernel/drivers/gpu/drm/radeon/radeon.ko.xz

which I assume is the driver:

alex@amac:~$ lsmod|grep radeon
radeon               1929216  28
i2c_algo_bit           16384  2 amdgpu,radeon
drm_suballoc_helper    12288  2 amdgpu,radeon
drm_display_helper    274432  2 amdgpu,radeon
drm_ttm_helper         16384  2 amdgpu,radeon
ttm                   106496  3 amdgpu,radeon,drm_ttm_helper
drm_kms_helper        253952  4 
drm_display_helper,amdgpu,radeon,drm_ttm_helper
drm                   774144  22 
gpu_sched,drm_kms_helper,drm_exec,drm_suballoc_helper,drm_display_helper,drm_buddy,amdgpu,radeon,drm_ttm_helper,ttm,amdxcp
video                  81920  2 amdgpu,radeon



Thanks,
Alex

