Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B87C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 21:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB16510F0CD;
	Wed,  1 Jul 2026 21:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UGOSscHD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D60110F0CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 21:09:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9B20435AD;
 Wed,  1 Jul 2026 21:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12DA1F000E9;
 Wed,  1 Jul 2026 21:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782940177;
 bh=M7fN5VIJJJyCoxiQjOPES6bRIGwzJAc9UX6ylfBkdDw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UGOSscHD77Im5NVOIGtFJcXMm/v0nys/OD8Z2uO+dThW+2v/n9ZJvwC24yMHo1xDp
 mbP4ky5QkmL4JBRnwB5GU2tQMDZaXiaYB0z8eclylTe6enPQae4nfDugnh5xJscAaJ
 usWW7cjeO1dBDo5cgGswDsbcrfkUMXbGdQk6DdE8i1MPFqCHsSBjISqva9XO/749b9
 vTe4ccI8+tgpFaBoJuprw/JJP6wHMffTDvBWODOMUpUdj20jVw8yJfo585xahaZiOf
 CSV0+K9qwkMz9uO9O870aAO8ahQYvbWXJByRuvuWcQBaPJ1y627Xgtv4Q/kXNDfoAp
 CzdErjkKx0YeA==
Message-ID: <8c010f6b-c55c-4310-8c91-cc16dfeab283@kernel.org>
Date: Wed, 1 Jul 2026 16:09:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fixes for flip_done timed outs and PSR/Replay
 corruption
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud,
 timur.kristof@gmail.com, xaver.hugl@kde.org, mario.kleiner.de@gmail.com,
 michel.daenzer@mailbox.org, matthew.schwartz@linux.dev, chris@kode54.net
References: <20260630180301.362070-1-sunpeng.li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260630180301.362070-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/30/26 13:02, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> v1 here:
> https://lore.kernel.org/amd-gfx/20260616201828.389985-1-sunpeng.li@amd.com/
> v2 here:
> https://lore.kernel.org/amd-gfx/20260622171752.73374-1-sunpeng.li@amd.com/
> 
> Summary of changes since v2:
> 
> * Fixed a regression in kms_vrr@flip-basic, which exposed a scenario in
>    optimistic event delivery where wrong vblank timestamps were attached.
>    See new docstrings in patch 2/3 for details.
> * Readability cleanups in patch 2/3, thanks Michel!
> 
> v7.0.y based branch here (drops the revert and resolves merge conflicts
> due to recent refactor of IRQ handlers from amdgpu_dm.c into
> amdgpu_dm_irq.c):
> https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo/flip_done_timeout_corruption_fixes?ref_type=heads
> 
> A Note on LLM use:
> 
> Claude helped with code plumbing and IGT testing. The effort of
> reporting, debugging, spinning up fixes, and testing them, were from
> humans. Kudos to individuals who collaborated on the amd-gfx mailing
> list, gitlab, 2026 Display Hackfest, and AMD internal chats, to finally
> nail down a fix.
> 

Having been one of those being able to readily reproduce issues at the 
hackfest with PSR I'm happy to report that I tested a backport of this 
series on a clean 7.2-rc1 where I don't observe any issues.  Due to 
changes in the codebase it's not purely the same as your content headed 
to drm-next.

The branch of what I tested is here though if anyone else would like to 
test on 7.2 as well.

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=lileo/flip_done_timeout_corruption_fixes-7.2

So my tag isn't purely this series, but I guess at least close enough 
with the backport if you want to carry it forward.

Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

Also as I reviewed the series nothing stands out to me, you obviously 
know this part of the code base better than anyone though.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Since I had a hard time applying this even to 7.2, I suspect after we 
land this we'll need to do some custom/manual backports for each of the 
applicable stable series at the time it actually lands in mainline.

> 
> Leo Li (3):
>    drm/amd/display: consolidate DCN vblank/flip handling onto
>      vupdate_no_lock
>    drm/amd/display: check GRPH_FLIP status before sending event
>    Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 234 +++++++++++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  70 ++--
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 299 +++++++++---------
>   drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 +++
>   drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
>   5 files changed, 417 insertions(+), 232 deletions(-)
> 
> --
> 2.54.0
> 

