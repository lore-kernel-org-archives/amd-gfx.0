Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11FFEC1EB9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B94610E8CE;
	Thu,  5 Feb 2026 14:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="kOcbBeSw";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="LogiJorH";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A4A10E8CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770300999;
 bh=6iBfV5IYZlI68zgHpvzAB3+
 k2tn3Ts0K/+YomooK720=; b=kOcbBeSwrHIWP0md83JimJ9DoVlBg355Tx6gxfPhaY+EhfQFLB
 0IpuHmdrSEtt03OM9wO6W7q1Vd7iRsdMmguzW6kDMGPaQWV9OHN5dtR6mifhfxxHCe870Vnm8cc
 aXHcH6d21Kcecg+dq/cewboGu364uOmvR/TY0c+DijNa0SfHkhO3O9Qe4puoTmbA7LJVWAep7AF
 tG/MJs5uoVkUxlt5q8eGtofa9K7S7iJcEgqWUamMvVYb7OPviC5V6bXvGbhOgp+f1x3rzHISTIQ
 zBUlA8pSBKMQEEWe8ZBAs3vsBB/nfmJWMFxJSph77T75YycLIPj0WlWlaDSPzSrQU2g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1770300999; bh=6iBfV5IYZlI68zgHpvzAB3+
 k2tn3Ts0K/+YomooK720=; b=LogiJorHJsm6icWaP129e341BlhsUTkJDRh0OD6tpjUGIf4GQ9
 2sFEnnylVwEx6/jFqwnsATLjljn2yBEAgYBA==;
Message-ID: <806c201c-11f2-49a1-8b06-2fa908a3283d@damsy.net>
Date: Thu, 5 Feb 2026 15:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] drm/amdgpu: reorder IB schedule sequence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-11-alexander.deucher@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260130173042.15008-11-alexander.deucher@amd.com>
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



Le 30/01/2026 à 18:30, Alex Deucher a écrit :
> This reorders the IB schedule sequence to cleanly
> separate the vm operation from the IB submission.
> This makes the two independent so we can cleanly
> associate each one with its respective fence.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 22 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  7 +++++++
>   2 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 1f60ccb8782ee..0932a093dee3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -192,16 +192,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		dma_fence_put(tmp);
>   	}
>   
> -	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
> -		ring->funcs->emit_mem_sync(ring);
> -
> -	if (ring->funcs->emit_wave_limit &&
> -	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
> -		ring->funcs->emit_wave_limit(ring, true);
> -
> -	if (ring->funcs->insert_start)
> -		ring->funcs->insert_start(ring);
> -
>   	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
>   	if (r) {
>   		amdgpu_ring_undo(ring);
> @@ -210,6 +200,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   
>   	amdgpu_ring_ib_begin(ring);
>   
> +	if (ring->funcs->insert_start)
> +		ring->funcs->insert_start(ring);
> +
> +	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
> +		ring->funcs->emit_mem_sync(ring);
> +
> +	if (ring->funcs->emit_wave_limit &&
> +	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
> +		ring->funcs->emit_wave_limit(ring, true);
> +
>   	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
>   		amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_va, job->gds_va,
>   					    job->init_shadow, vmid);
> @@ -297,6 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>   		ring->funcs->emit_wave_limit(ring, false);
>   
> +	amdgpu_ring_ib_end(ring);
>   	/* Save the wptr associated with this fence.
>   	 * This must be last for resets to work properly
>   	 * as we need to save the wptr associated with this
> @@ -305,7 +306,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	 */
>   	amdgpu_fence_save_wptr(af);
>   
> -	amdgpu_ring_ib_end(ring);
>   	amdgpu_ring_commit(ring);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c8..ed0d450b08362 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -815,6 +815,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		return 0;
>   
>   	amdgpu_ring_ib_begin(ring);
> +
> +	if (ring->funcs->insert_start)
> +		ring->funcs->insert_start(ring);
> +
>   	if (ring->funcs->init_cond_exec)
>   		patch = amdgpu_ring_init_cond_exec(ring,
>   						   ring->cond_exe_gpu_addr);
> @@ -891,6 +895,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_ring_emit_switch_buffer(ring);
>   	}
>   
> +	if (ring->funcs->insert_end)
> +		ring->funcs->insert_end(ring);
> +
>   	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
