Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1318CAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 07:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4111F10E9DA;
	Fri, 26 Sep 2025 07:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=panix.com header.i=@panix.com header.b="YQ7bWrZK";
	dkim-atps=neutral
X-Greylist: delayed 1183 seconds by postgrey-1.36 at gabe;
 Thu, 25 Sep 2025 14:16:38 UTC
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159C710E94E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 14:16:38 +0000 (UTC)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
 (No client certificate requested)
 by l2mail1.panix.com (Postfix) with ESMTPS id 4cXZyb6K0GzDTt
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 09:56:55 -0400 (EDT)
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net
 [45.31.46.51])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4cXZyZ0Wfnz4J6r;
 Thu, 25 Sep 2025 09:56:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1758808614; bh=zD/GEPGDzJUMByTyc0bl9Qr0XzWfns0yley3ONY2SGM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YQ7bWrZK8jG5TG+L8XsV2GsSTgoJdb2Nfcjrmuri+ycRc+88Efl+UY0THIXPZQIL0
 wDuiuk2Bh9ChTZ3m/kpM+g3tDqxJyu+7PM9H9fopOn+mTevexZLl39oFwadFfegW5f
 3IgeM9zqz0Pe3zboNkZUM+YC7qqLW/uDWpU+VbeE=
Message-ID: <3ee88489-278c-477a-9bfa-61e40070148f@panix.com>
Date: Thu, 25 Sep 2025 06:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fixes for hybrid sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>
References: <20250924205211.1059571-1-superm1@kernel.org>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250924205211.1059571-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 26 Sep 2025 07:25:25 +0000
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

(Thanks Mario for the hint re: replying via Lore!)

On 9/24/25 13:52, Mario Limonciello (AMD) wrote:
> Ionut Nechita reported recently a hibernate failure, but in debugging
> the issue it's actually not a hibernate failure; but a hybrid sleep
> failure.
> 
> Multiple changes related to the change of when swap is disabled in
> the suspend sequence contribute to the failure.  See the individual
> patches for details.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573

I just wanted to say that the non-AMD-display bits of this patch were 
tested by me and seem to have fixed a problem I'd had where if I had an 
NFS share mounted on suspend/hibernate, that ~50% of the time when 
resuming the machine would be up, but disk I/O would be deadlocked (so I 
really couldn't do anything except SysRq-S/U/B).

Still going to test a few more suspend/resume/hibernate cycles, but it 
does seem to have fixed that issue for me. There was a corresponding 
patch in linux-pm earlier along the same lines, but that one only had a 
limited success rate.

I have "hybrid sleep" enabled, where systemd will go into full 
hibernation after 4 hrs, BTW.

>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>   include/linux/suspend.h                 |  2 ++
>   kernel/power/hibernate.c                | 13 ++++++++++++-
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 

Tested-By: Kenneth Crudup <kenny@panix.com>

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

