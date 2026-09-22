Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42ABC98310
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 07:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB0510EF6B;
	Wed, 23 Sep 2026 07:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="aKY42+Q4";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9E510E77D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 18:04:31 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=gTvdQTe1qhvC1Ir7p+EF17rnVLs9NmAqY+ufn3cXwLo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790100270; v=1; x=1790705070;
 b=aKY42+Q4ZpkobfwROkO3wbDMUgEwxJZUzJXoh+6jXsfn+SfOhQueltVfv/HAdvlcWAkB8Mjf
 BsipTCEldb6LtBe27OqmqPS+UnJd39l2l1S1/3Qvw5vwyO5xWu+LhnnD1MYX0gdF4L5I8p3mViV
 gAmhw/xO/2Yh3QIBbMDfFv3s=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id e830e1a7bb5815cd;
 Tue, 22 Sep 2026 18:04:29 +0000
X-Mizu-Trace-ID: e830e1a7bb5815cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <a2a345da-a199-48f8-8461-ebd298aa252a@linux.dev>
Date: Tue, 22 Sep 2026 11:04:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: only allow freesync on a VRR_ENABLED crtc
To: Leo Li <sunpeng.li@amd.com>, George Zhang <george.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Fangzhi Zuo <jerry.zuo@amd.com>
References: <20260909195906.3584191-1-matthew.schwartz@linux.dev>
 <2dff79db-bfa9-48ce-94c6-c467a85c8b8e@amd.com>
 <6e07ec9f-9423-475c-8751-289ff11a40cb@linux.dev>
 <c50780fe-70dc-4ecd-81df-90a6f7fa37d9@amd.com>
Content-Language: en-US
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <c50780fe-70dc-4ecd-81df-90a6f7fa37d9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:55:58 +0000
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

On 9/22/26 10:50 AM, Leo Li wrote:
> 
> 
> On 2026-09-21 15:47, Matthew Schwartz wrote:
>> Hi George,
>>
>> After updating to Linux 7.2.x, I noticed gamescope's frame limiter falling
>> below the requested rate. The reproducer was a Navi 33 driving 4K120
>> through a DP-HDMI PCON, with VRR disabled. A 40fps limit was producing
>> roughly 37fps.
>>
>> Gamescope was pacing against the fixed 120Hz refresh interval, but we
>> observed frame intervals stretching to around 9.34ms instead of 8.33ms.
>> The OTG vtotal also increased from 2249 to 2521. This was enough to
>> disrupt the limiter's pacing despite userspace leaving VRR_ENABLED=0.
> 
> Hi Matt,
> 
> I wonder if this has to do with re-introducing 2-frame vblank off for NV3+
> DGPUs, which made it into 7.2:
> 
> fba211b078d6 ("Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"")
> 
> Since gamescope is only updating every 3rd frame, it's possible vblanks were
> turned off during those two frames, signaling driver to enable idle optimizations.
> 
> To test this idea, does bumping this line to something like 5 frames ((u64)50 *) help?
> https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L3377

Tested this by reverting my own patch in the kernel and replacing it with this, and unfortunately the issue
still reproduces here. In Hades 2, a 40FPS limit is locking to 37FPS erroneously.

Matt

> 
> Thanks,
> Leo 
>>
>> Tracing this led to allow_freesync remaining true for a VRR-capable
>> sink even when the FreeSync state was inactive. That allowed FPO to
>> stretch vblank around UCLK switches. The PCON whitelist change exposed
>> this on our setup by making the sink eligible for that path.
>>
>> The intent is to keep the frame period fixed when userspace has
>> disabled VRR, while retaining FPO eligibility when variable refresh is
>> actually requested. With the patch, the original setup holds the
>> requested 40fps again. I also tested VRR toggling on a Legion Go 2's
>> internal eDP OLED panel and did not observe a regression.
>>
>> Thanks,
>> Matt
> 

