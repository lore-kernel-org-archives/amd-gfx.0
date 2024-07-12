Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C0C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 07:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F2C10EC3A;
	Fri, 12 Jul 2024 07:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mkf2vxT6";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A93C10EC3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 07:33:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso10462215e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720769592; x=1721374392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rf4/B6K4/Rk9pOEQXu0mKGxBVKSlajcdOWWV9C4G3oQ=;
 b=Mkf2vxT6QcR10AyN6eLYSzivdn/aZBo+NVDcRY2RuAUvd3q1rxz39m7qNXB4acWxeA
 tD6Xuw2/6vVxi2AiRcfbjCSsti00mhRWRhwwn3bDXzgSiwdwcJed4G/l7niZd4XntbN2
 2mnc5MUqQ19XLkY/W01J25fuxeokEZ4Nd8sXvOI2+PTW4Sik4pcWf6xM95NqVX8k5UAL
 7gXurnuS0s57QFvfPmMUduMVCwhHBIsm5UzCPz9EpYl7V4IgQw1rmg6L21Vl/c+P/8bv
 1UxB9Kv+Pz7+5IH2GkerFzAIzbxp3K7kFoY3+Nd+3Os+dwmF/Q4gCD6n/CPG+BOeN5LP
 QByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720769592; x=1721374392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rf4/B6K4/Rk9pOEQXu0mKGxBVKSlajcdOWWV9C4G3oQ=;
 b=JbjfROuZQHOARKCvvekkZvuORpIAB4mrSOb9BGfaHn/7dERok3qSUXLLvqZb3gh9NN
 SBS1JadXWyoCRvbaIr0lVBYpKPRfpfxZ4Jy+2umEaDrIYI99b+KOLU1Ox68faxlD5h4K
 5bW3TG+VBsASDYXTewT74gelZKN6vfYWwzrl820g74FXm6/pYzXn9oC1oLSFDtJmGi9a
 rhoxTOYptfmiiD83jusAu1wHGntZ7eXyP8qF4aqg7irnWpKWOA2TFYf9tDnFENiOQXFM
 U5m20MC1HnXnbZ6jH1ERZ1aoVyXTnETidFn0tdUl8tiQOjV25tkZmfobgbfptJwnrV90
 PUYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkZdQn4Aj/WzvXb4GaD8HJEgUjF125/eMR1UqtMsQFQ6x6F4OQDDh0WMVtIcu8tVUZJCQSJv6esCsYxm7xaHuF588NiLcUfU7IKLfCsg==
X-Gm-Message-State: AOJu0Yw+czQr9yHEqC445V83CHaqVYWAHJP7YBdvtcYiyCwV0ZCBGHWZ
 pgU/Jw/eD81l7HwcYrCTlWVW4gKtTLxEAiN3Nowxxn4AOkgCjLEp
X-Google-Smtp-Source: AGHT+IGFK17I8Ylv1MHf2jQfENADqqh4xo7LltBOSIVipA5OeRlJ05VeL+Kit1Cg15F77C6tQKdlhg==
X-Received: by 2002:a05:600c:5748:b0:426:6696:9e50 with SMTP id
 5b1f17b1804b1-426707d8b42mr63681435e9.14.1720769591120; 
 Fri, 12 Jul 2024 00:33:11 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25942csm13131255e9.15.2024.07.12.00.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 00:33:10 -0700 (PDT)
Message-ID: <219f3419-148e-4516-8c57-ee708dc65ef2@gmail.com>
Date: Fri, 12 Jul 2024 09:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu: More efficient ring padding
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240711181746.86311-1-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240711181746.86311-1-tursulin@igalia.com>
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

Am 11.07.24 um 20:17 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
>  From the department of questionable optimisations today we have a minor
> improvement to how padding / filling the rings with nops is done.
>
> Having noticed that typically 200+ nops per submission are filled into the
> ring, using a rather verbose one-nop-at-a-time-plus-ring-buffer-arithmetic
> as done in amdgpu_ring_write(), while right next to it there is
> amdgpu_ring_write_multiple(), I thought why not pre-cache a block of nops
> and write them out more efficiently.
>
> The patch is rather quick and dirty, does not deal with all insert_nops
> vfuncs, and the cache should probably go one level up so it is not
> replicated per amdgpu_ring instance.

Why should that be more effective? We essentially use more cache lines 
than before.

> And performance gains are not that amazing for normal workloads. For
> instance a game which results in two submissions per frame, each pads
> with 222 nops, submission worker thread profile changes from:

Mhm, why the heck are we using so many nops in the first place?

Regards,
Christian.

>
> +   90.78%     0.67%  kworker/u32:3-e  [kernel.kallsyms]  [k] process_one_work
> +   48.92%     0.12%  kworker/u32:3-e  [kernel.kallsyms]  [k] commit_tail
> +   41.18%     1.73%  kworker/u32:3-e  [kernel.kallsyms]  [k] amdgpu_dm_atomic_commit_tail
> -   30.31%     0.67%  kworker/u32:3-e  [kernel.kallsyms]  [k] drm_sched_run_job_work
>     - 29.63% drm_sched_run_job_work
>        + 8.55% dma_fence_add_callback
>        - 7.50% amdgpu_job_run
>           - 7.43% amdgpu_ib_schedule
>              - 2.46% amdgpu_ring_commit
>                   1.44% amdgpu_ring_insert_nop
>
> To:
>
> +   89.83%     0.51%  kworker/u32:6-g  [kernel.kallsyms]  [k] process_one_work
> +   47.65%     0.30%  kworker/u32:6-g  [kernel.kallsyms]  [k] commit_tail
> +   39.42%     1.97%  kworker/u32:6-g  [kernel.kallsyms]  [k] amdgpu_dm_atomic_commit_tail
> -   29.57%     1.10%  kworker/u32:6-g  [kernel.kallsyms]  [k] drm_sched_run_job_work
>     - 28.47% drm_sched_run_job_work
>        + 8.52% dma_fence_add_callback
>        - 6.33% amdgpu_job_run
>           - 6.19% amdgpu_ib_schedule
>              - 1.85% amdgpu_ring_commit
>                   0.53% amdgpu_ring_insert_nop
>
> Or if we run a more "spammy" workload, which does several orders of
> magnitude more submissions second we go from:
>
> +   79.38%     1.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] process_one_work
> -   63.13%     6.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] drm_sched_run_job_work
>     - 56.47% drm_sched_run_job_work
>        - 25.67% amdgpu_job_run
>           - 24.40% amdgpu_ib_schedule
>              - 15.29% amdgpu_ring_commit
>                   12.06% amdgpu_ring_insert_nop
>
> To:
>
> +   77.76%     1.97%  kworker/u32:6-f  [kernel.kallsyms]  [k] process_one_work
> -   60.15%     7.04%  kworker/u32:6-f  [kernel.kallsyms]  [k] drm_sched_run_job_work
>     - 53.11% drm_sched_run_job_work
>        - 19.35% amdgpu_job_run
>           - 17.85% amdgpu_ib_schedule
>              - 7.75% amdgpu_ring_commit
>                   3.27% amdgpu_ring_insert_nop
>
> Not bad and "every little helps", or flame-throwers at ready?
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 20 +++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ad49cecb20b8..22ec9de62b06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -108,10 +108,14 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>    */
>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   {
> -	int i;
> +	if (count > 1 && count <= ARRAY_SIZE(ring->nop_cache)) {
> +		amdgpu_ring_write_multiple(ring, ring->nop_cache, count);
> +	} else {
> +		int i;
>   
> -	for (i = 0; i < count; i++)
> -		amdgpu_ring_write(ring, ring->funcs->nop);
> +		for (i = 0; i < count; i++)
> +			amdgpu_ring_write(ring, ring->funcs->nop);
> +	}
>   }
>   
>   /**
> @@ -124,8 +128,11 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>    */
>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
>   {
> -	while (ib->length_dw & ring->funcs->align_mask)
> -		ib->ptr[ib->length_dw++] = ring->funcs->nop;
> +	u32 count = ib->length_dw & ring->funcs->align_mask;
> +
> +	memcpy(&ib->ptr[ib->length_dw], ring->nop_cache, count * sizeof(u32));
> +
> +	ib->length_dw += count;
>   }
>   
>   /**
> @@ -359,6 +366,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   			&ring->sched;
>   	}
>   
> +	for (r = 0; r < ARRAY_SIZE(ring->nop_cache); r++)
> +		ring->nop_cache[r] = ring->funcs->nop;
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 582053f1cd56..74ce95b4666a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -246,6 +246,7 @@ struct amdgpu_ring {
>   	struct amdgpu_bo	*ring_obj;
>   	volatile uint32_t	*ring;
>   	unsigned		rptr_offs;
> +	u32			nop_cache[256];
>   	u64			rptr_gpu_addr;
>   	volatile u32		*rptr_cpu_addr;
>   	u64			wptr;

