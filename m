Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5406ECD4F49
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 10:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA05B10E303;
	Mon, 18 May 2026 10:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="ojg498Rc";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Dg4egxee";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5800910E78D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1779098607; bh=2LBHdMyzNAs+5dmFiOSG0aP
 blZ+/6ZGoy9+hxx9RhjI=; b=ojg498RcOeGDrvPz2EeK/UpoN4ZB0NLk8KBj4XXyv2LfOOJ4v+
 VN0TPPI63w0+BuudU9wDoa8Cm3lQGKGuiNDg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1779098607; bh=2LBHdMyzNAs+5dmFiOSG0aP
 blZ+/6ZGoy9+hxx9RhjI=; b=Dg4egxeeyQXfoEEI2e1Q8SW+FnI9aHmUVKA7MTkmDh2zl8OVxk
 wJ3UT0cSSf3i+HewmIW3rfmp9dxTt2232QCQHLwGHs0sgt3MkPcmeweDMGofnWKAD88Nu5jl7Wy
 lk5hrh0P1tHLYLafs72uFaKFg4Yb9l9utC0B/XHi4E6RTUJ6JvD0vWch+JIFHzujJVIA7P5z+bY
 8m/VVdxml1jG1m7fVUeJLZ2A0Bly0oZAvgAV8EyyIxCGXjuOgselRTwAjZTm3pC46twieszVmqQ
 6ErH1MRlcNOVExo5a93WgSnTxNWIfEvdAGO7R6kSTiTE2wlTQFBNsExMF0DI/f7CuhA==;
Message-ID: <ea43efe7-f49c-4e24-8c42-673eb207deba@damsy.net>
Date: Mon, 18 May 2026 12:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix KASAN slab-out-of-bounds in
 amdgpu_coredump ring dump
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260514232307.123284-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260514232307.123284-1-vitaly.prosyak@amd.com>
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



Le 15/05/2026 à 01:22, vitaly.prosyak@amd.com a écrit :
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> The ring content dump in amdgpu_coredump() uses two separate loops over
> adev->rings[]: the first counts rings with unsignalled fences to size
> the allocation, and the second copies ring data into the allocated
> buffers.
> 
> Both loops use the same condition to skip rings:
> 
>      atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq
> 
> Because last_seq is an atomic that is updated concurrently by the fence
> signalling path, additional rings may appear unsignalled in the second
> loop that were signalled during the first. When this happens, idx
> exceeds the allocated ring_count and the store to coredump->rings[idx]
> writes past the end of the kcalloc-ed buffer.
> 
> This was found during IGT stressful test amd_queue_reset which
> triggers random GPU resets. The OVERSIZE subtest
> (CMD_STREAM_EXEC_INVALID_PACKET_LENGTH_OVERSIZE on GFX ring) provokes
> a ring timeout and subsequent coredump, which hits the race between
> the counting and copying loops. The failure is non-deterministic and
> depends on fence signalling timing during the reset.
> 
> KASAN log:
> 
>    BUG: KASAN: slab-out-of-bounds in amdgpu_coredump+0x1274/0x12f0 [amdgpu]
>    Write of size 4 at addr ffff888106154258 by task kworker/u128:5/23625
>    CPU: 16 UID: 0 PID: 23625 Comm: kworker/u128:5 Not tainted 6.19.0+ #35
>    Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0xa5/0x110
>     print_report+0xd1/0x660
>     kasan_report+0xf3/0x130
>     __asan_report_store4_noabort+0x17/0x30
>     amdgpu_coredump+0x1274/0x12f0 [amdgpu]
>     amdgpu_job_timedout+0xef0/0x16c0 [amdgpu]
>     drm_sched_job_timedout+0x194/0x5c0 [gpu_sched]
>     process_one_work+0x84b/0x1990
>     worker_thread+0x6b8/0x11b0
>     </TASK>
> 
>    Allocated by task 23625:
>     kasan_save_stack+0x39/0x70
>     __kasan_kmalloc+0xc3/0xd0
>     __kmalloc_noprof+0x2ec/0x910
>     amdgpu_coredump+0x5c5/0x12f0 [amdgpu]
>     amdgpu_job_timedout+0xef0/0x16c0 [amdgpu]
> 
>    The buggy address belongs to the object at ffff888106154200
>     which belongs to the cache kmalloc-rnd-09-96 of size 96
>    The buggy address is located 16 bytes to the right of
>     allocated 72-byte region [ffff888106154200, ffff888106154248)
> 
> 72 bytes = 3 * sizeof(struct amdgpu_coredump_ring), so ring_count was 3
> but idx reached 3+, writing ring_index (at struct offset 16) 16 bytes
> past the allocation.
> 
> Fix by adding an idx < ring_count guard to the copy loop so it cannot
> exceed the allocated count even when the fence state changes between
> the two passes.
> 
> Fixes: 678236b37eee (drm/amdgpu: save ring content before resetting the device)
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>


Reviewed-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index d386bc775d03..3d5a2abf27c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -553,7 +553,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>   	coredump->rings_dw = kzalloc(total_ring_size, GFP_NOWAIT);
>   	coredump->rings = kcalloc(ring_count, sizeof(struct amdgpu_coredump_ring), GFP_NOWAIT);
>   	if (coredump->rings && coredump->rings_dw) {
> -		for (i = 0, off = 0, idx = 0; i < adev->num_rings; i++) {
> +		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
>   			ring = adev->rings[i];
>   
>   			if (atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq &&
