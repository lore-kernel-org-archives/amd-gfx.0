Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D1CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 20:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50B510E211;
	Tue, 26 May 2026 20:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y5UvNknY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17F210E211
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 20:18:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC620600CB;
 Tue, 26 May 2026 20:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8E81F000E9;
 Tue, 26 May 2026 20:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779826726;
 bh=47iIZXKRidiLTOF6lAPeXDmDm898asPSwXJLd/b4t54=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y5UvNknYb5IR9ajgDgPL4kSenD/+YbGZpfOGnVjZQVKa2gfrACcyoag3B0ld3czET
 UzQxeXfqsyCs+WZ8tygiHhrIgSa7g3rbwu1ctPQR6f/wbl/mL9FG28Q42stvj/aPb0
 /uSLt5LUwTNJ1eNqvVJvRgbrVfjOB98qxw3VOU6sJZnTDhQv6qLQvnRaI4OcgauELt
 tDWDHXYNLcNcN7zheCa9CMXgajRrZBS5fNAT3mfPSZIsD/i7MnA9BaXBbecLg8Druv
 L1Au9NZZ7odHNCa/I3v+Sj0UeBkqpC2ExoiALlFxfw5zPeLZrapbTM125MXH6X1szJ
 XGHLi98frXCEQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 6641CF4007B;
 Tue, 26 May 2026 16:18:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 26 May 2026 16:18:45 -0400
X-ME-Sender: <xms:JQAWalEB-0IsRTLSwkiSmJdfQufyFeEE6OQ9n3nqqxeNcqwrY2QyDA>
 <xme:JQAWapZQIwsIJqdJcwcYxzplXv_c_joFk6GBEGH-Gy9PUhU0VcVWZrO7kSVR044fM
 zApixKaemdVTgrmX5p__IOvz8k9y03cWotNyt2JbtsYyruz5MHdaw>
X-ME-Received: <xmr:JQAWatXRRGqJz6dUc5bk6NOdqQktXj30cpW16V_d2-5f5APKXSm-d0UoNSmKGPdFQBPoljZiI1fK_Ax02sVEoDRyQiALjokI>
X-ME-Proxy-Cause: dmFkZTG3thSBC5a1jgixtCNlMIow7u8H/RHRECRviaMLOn1B3gbhrRmoOyivz8ntfIP46e
 QE07pbgXupVZQE9Yzxh0pJB6S6lv76AzWWwv/RpGQ7XTuVXkF1mqaQye6WUzv2i4PCIlR+
 MKDCQ8nGDW8bvvbiiXYTuUBLiYV8UQdhwB6ZWqkcmFFS3Htto1YXTteH5Vt+wI9AKmBUsj
 RkUr6SdE4j1Ow3p94OnJYoBwP//+VOOoci8uBtkgb7fm9IngHx6a2V0d0X8zOucV6Wu44a
 5bsJzXasv5X01Im0bjy2dBhKboYXd+WFveZ9VuvWPf4FcNBeYho+oA8cFIthEpooGsBMWt
 1gqYKgCczJ6Nbx4YsNMKSJG3VOiyUwIPtKfErm+ONlPgZqJ6gFlXENJL2liPN7V37yweMD
 PE5m4HUIzoj1BinPKrt8JXlgZu3XGcR1nfoqi8eaN2MwT0wJlee4ngb/BwHUa1eHVuoD8Y
 pL5fp3ZnGHBn5C1EPZeXd8tyiiNxVzXPtm7ebGar9cCdsquobO/EGYn3ryDC0I+XeYOanu
 Oii6kWzRhIYL54ll9pQZKMeHFZoyNd6MPLSjNwGJ9dJCQXln3Q9kFYX/AtvpWjnYKgCeJ+
 B+QkR6AlntanKm1BME0CMMuPTkvBMX6puDRXYdbDhHMTosYmbAHvIi3drpeg
X-ME-Proxy: <xmx:JQAWannTF6-gy72NICkqjoglWvzB37AE2_XWzxcnHFfF1zTKjylyOA>
 <xmx:JQAWagBP7v51_zgDdeMjpr3ShObs1XclOiA8HSitzVOySwYRa-tLdw>
 <xmx:JQAWauigKVvspCgvNLq4VhuuaTyQPGBncKpHHqPsDID7gKutaeQm2w>
 <xmx:JQAWalxD7T9G-s2g6N5-SBdne1c8tQDDcHRobn3wJVuInP6kIuDQ4g>
 <xmx:JQAWan02Dnb8TSbANdu37eOHAHadjoX77WUw-A0n2JIwnN1mUeNYYklX>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 16:18:44 -0400 (EDT)
Date: Tue, 26 May 2026 13:18:43 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 sunil.khatri@amd.com, Amber.Lin@amd.com, Jesse.Zhang@amd.com,
 Shaoyun.Liu@amd.com
Subject: Re: [PATCH 00/42] Enable pipe reset for compute
Message-ID: <ahYAIzazFpb0YsDP@tardis.local>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
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

Hi Alex,

On Thu, May 21, 2026 at 08:20:06PM -0400, Alex Deucher wrote:
> There are certain corner cases where a queue reset is not
> able to recover a hung queue.  A pipe reset can recover
> some of those cases, however, when the pipe is reset
> all queues on that pipe are reset.  This requires
> coordination across all components using compute queues.
> There is quite a bit of prep work in this series, some
> of which I sent out previously. Another prerequisite
> for this was reworking the userq reset path.  It should
> be more straight-forward now.  The final patch also
> needs to be updated once the new MES firmware is relased so
> we can check the proper firmware versions. Using older
> MES firmware may fail and end up in an adapter reset in some
> cases where the pipe reset would have worked so it should
> be comparable to the current behavior.
> 

Do you have a branch somewhere I can test with? Or what's the base
commit of this patchset? Thanks!

Regards,
Boqun

> Alex Deucher (34):
>   drm/amdkfd: always resume_all after suspend_all
>   drm/amdgpu: don't reemit if there is nothing to reemit
>   drm/amdgpu: track guilty fence for queue reset
>   drm/amdgpu/fence: add helper to extract the guilty fence
>   drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL
>     fence
>   drm/amdgpu/vcn: handle pipe reset more gracefully
>   drm/amdgpu/sdma: handle pipe reset more gracefully
>   drm/amdgpu/mes12: use proper grbm_select function
>   drm/amdgpu/gfx11: only need to remap KCQs when reset via MMIO
>   drm/amdgpu/gfx12: only need to remap KCQs when reset via MMIO
>   drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
>   drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
>   drm/amdgpu/mes: add userq reset helper
>   drm/amdgpu/mes: add a MMIO queue reset helper
>   drm/amdgpu/userq: split the queue reset from adapter reset
>   drm/amdgpu/userq: add per queue reset callback
>   drm/amdgpu/userq: add mes userq reset callback
>   drm/amdgpu/userq: switch to per queue reset
>   drm/amdgpu/userq: drop detect_and_reset callback
>   drm/amdkfd: rework MES queue reset sequence
>   drm/amdgpu/gfx: add a helper for MQD restore
>   drm/amdgpu/gfx11: use the new MQD helper for queue reset
>   drm/amdgpu/gfx12: use the new MQD helper for queue reset
>   drm/amdgpu/gfx11: unmap the queue via MES on reset for MMIO path
>   drm/amdgpu/gfx12: unmap the queue via MES on reset for MMIO path
>   drm/amdgpu: store whether to use MMIO or MES for reset
>   drm/amdgpu: Use a common KGQ and KCQ reset helper for gfx11/12
>   drm/amdkfd: split out mes queue reset sequence into standalone
>     function
>   drm/amdkfd: plumb a helper to reset a KFD user queue
>   drm/amdgpu/userq: add MES userq reset helper
>   drm/amdgpu/gfx: add a common helper to handle MES compute resets
>   drm/amdgpu: use a single entry point for mes compute reset
>   drm/amdgpu/mes11: enable compute MMIO pipe reset
>   drm/amdgpu/mes12: enable compute MMIO pipe reset
> 
> Amber Lin (3):
>   drm/amdgpu: Allocate enough space for hpd info on gfx11
>   drm/amdkfd: Update queue reset support on KFD topology
>   drm/amdgpu: Expand MES queue/pipe reset support
> 
> Jesse Zhang (4):
>   drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy queues on
>     unified MES
>   drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy queues on
>     unified MES
>   drm/amdgpu/gfx11: Refactor compute pipe reset and add HQD cleanup
>   drm/amdgpu/gfx12: Refactor compute pipe reset and add HQD cleanup
> 
> Shaoyun Liu (1):
>   drm/amd/amdgpu/include : update mes api header v11/v12
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  16 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  54 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 193 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  16 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  67 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  14 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  19 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  84 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  64 +++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 264 +-----------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 216 +-------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 111 ++++----
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.h    |   9 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 250 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 263 +++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  22 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  24 ++
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 ++++-----
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   3 +-
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h |   5 +-
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h |   5 +-
>  26 files changed, 1150 insertions(+), 708 deletions(-)
> 
> -- 
> 2.54.0
> 
