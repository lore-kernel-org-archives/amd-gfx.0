Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22FEC624CE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B6C10E6B9;
	Mon, 31 Aug 2026 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=tsoft.com header.i=@tsoft.com header.b="cCy9yl/E";
	dkim-atps=neutral
X-Greylist: delayed 1577 seconds by postgrey-1.36 at gabe;
 Mon, 31 Aug 2026 03:29:01 UTC
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
 by gabe.freedesktop.org (Postfix) with ESMTP id 85B4A10E042
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 03:29:01 +0000 (UTC)
Received: from [192.168.5.3] ([24.6.215.85]) (authenticated bits=0)
 by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 67V32hR9091286
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 20:02:43 -0700 (PDT)
 (envelope-from yuri@tsoft.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tsoft.com; s=aug2026;
 t=1788145363; bh=0VS7BLym0qQe03FdUulWGEaenLYacwHlYg3Pf/1vk7U=;
 h=Date:To:From:Subject;
 b=cCy9yl/EGtKeu5tv9s0j7MKtabKfVbKJVCiPmiVsn+phPSav3oNF6MNjcpfZKHAob
 JcrFzSf6Fl1khUwiKyn+60WTxXdG+MDkWcEHF9wUrs59uFi6bZk2FQ3Xpwy4IPATya
 KXmVCYPPsO2qAQiBuiMgUOh9ccsC19fLSJkDbpEA=
X-Authentication-Warning: shell1.rawbw.com: Host [24.6.215.85] claimed to be
 [192.168.5.3]
Message-ID: <b8178f55-0b2a-4563-894c-94a045695462@tsoft.com>
Date: Sun, 30 Aug 2026 20:02:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
From: Yuri <yuri@tsoft.com>
Subject: error messages "[drm] Fence fallback timer expired on ring gfx_0.0.0"
 are printed after which Xorg becomes unusable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:04:50 +0000
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

On FreeBSD 15 the amdgpu kernel module built from sources from 
https://github.com/ROCm/amdgpu prints fence fallback messages after 
which Xorg becomes extremely slow.

More details are in this GitHub issue: 
https://github.com/ROCm/amdgpu/issues/229

Googling reveals that a lot of linux users also have the same problem.

amdgpu.ko installed by drm-612-kmod-6.12.85.1501501_1 is used.


Is there a fix for this bug?



Thank you,

Yuri


