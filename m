Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8390C3ABA2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 14:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EC410E06B;
	Mon, 16 Sep 2024 14:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eVPLZj1H";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E25410E06B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 14:14:21 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so26809445e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726496060; x=1727100860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UgFiRD30MPgROYN052JVxH/sGd6o1wLmBXsh+vDkJOo=;
 b=eVPLZj1HqNv9gZCHyOipIVAHuqquCP1IfDDS1hxefWWP1FfgUQweCkgpGLL2Mnrchr
 jXKp40nx6zaQfSjU4EA26OaO98itvmtsZV7Z2JWsTZ/u6she5gpR7aqlzgq5xbw/wHqU
 z/a0prF32ABmK6ByW/q9Y7dIJk2aZfa5sj0X6Ec5rmd4t14UDDrSo8xgZisHO0fcVHQv
 YJzTAX9qpoFMa8ULAmXJi8Hm7VQ/yBrmlk5OOATrUdSnsXaqvycQK295nACDvCLo2/2k
 2X/4hETCE7cESYCGOKDMR4lIJwlGteIv0lP213mKR2F/Nwi6OANYSd/VJ1oYYP5L1UvK
 TGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726496060; x=1727100860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UgFiRD30MPgROYN052JVxH/sGd6o1wLmBXsh+vDkJOo=;
 b=v+Okb828qmCN5WhVyPv2QycjuIqY+ILted1Wg5okf2aNjoqzJf1SQPFbVRhde/Mbjx
 7slaQFzFe0efK6JgrrJ8r+tBj35V6IVP5Vt/5A/nBDm1hFn2yQzYcTQpMjk7vgbVTomi
 eGhhrCyQA1i1iU1DpR7SSD15fHHG1xYaqxzKi7ti+vSFvvMinyB7m1MTjDaaZMdKR/pu
 MV7Snr1nsdehptkfGyqZEU/wr/m7XQl6qMaFLw02gIOYmK+z3iNhEP9ZzbvqL7nQd8Z7
 rjcXGCKKInLQ5KtlF4t491jjodJajFcLMOeY5RNgrduHNqPmlUMcLuNer1SLTdrHTt3d
 OgBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWthKhKdtgWR0i/abN2wfG3tayC2dwS64ZOeD6ZSwxoak7ed5JOhUqIOko2krdKQM49jjSOSdig@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ/hOVOEog8ZxFz8kN4WoRw/0R3IsFZuGKpNTZ0OIdexxPzk52
 boxwPBnDpm7znWW1bdCas9URz6BG+SkAHDL7JZ0E6xA3t9u3R4C/o/BQPz3e
X-Google-Smtp-Source: AGHT+IHj8De+fAM42YUvrF3ObKcNYcVTpB2qzA5SSHgb35ajJ7uJpf/23mEHygwWvpXSBL1Yhc0g0A==
X-Received: by 2002:a05:600c:4e94:b0:42c:b34d:720c with SMTP id
 5b1f17b1804b1-42d9070a587mr67588105e9.4.1726496058772; 
 Mon, 16 Sep 2024 07:14:18 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b055075sm113916355e9.8.2024.09.16.07.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2024 07:14:18 -0700 (PDT)
Message-ID: <7ee872e3-7dea-43c2-84fa-4170b127ff06@gmail.com>
Date: Mon, 16 Sep 2024 16:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/28] drm/amdgpu: add gfx eviction fence helpers
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-17-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909200614.481-17-shashank.sharma@amd.com>
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

Am 09.09.24 um 22:06 schrieb Shashank Sharma:
> This patch adds basic eviction fence framework for the gfx buffers.
> The idea is to:
> - One eviction fence is created per gfx process, at kms_open.
> - This fence is attached to all the gem buffers created
>    by this process.
> - This fence is detached to all the gem buffers at postclose_kms.
>
> This framework will be further used for usermode queues.
>
> V2: Addressed review comments from Christian
>      - keep fence_ctx and fence_seq directly in fpriv
>      - evcition_fence should be dynamically allocated
>      - do not save eviction fence instance in BO, there could be many
>        such fences attached to one BO
>      - use dma_resv_replace_fence() in detach
>
> V3: Addressed review comments from Christian
>      - eviction fence create and destroy functions should be called only once
>        from fpriv create/destroy
>      - use dma_fence_put() in eviction_fence_destroy
>
> V4: Addressed review comments from Christian:
>      - create a separate ev_fence_mgr structure
>      - cleanup fence init part
>      - do not add a domain for fence owner KGD
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Change-Id: I7a8d27d7172bafbfe34aa9decf2cd36655948275
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +-
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 148 ++++++++++++++++++
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  65 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   9 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   3 +
>   6 files changed, 231 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ff5621697c68..0643078d1225 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -66,7 +66,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>   	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> -	amdgpu_userq_fence.o
> +	amdgpu_userq_fence.o amdgpu_eviction_fence.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 76ada47b1875..0013bfc74024 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -113,6 +113,7 @@
>   #include "amdgpu_seq64.h"
>   #include "amdgpu_reg_state.h"
>   #include "amdgpu_userqueue.h"
> +#include "amdgpu_eviction_fence.h"
>   #if defined(CONFIG_DRM_AMD_ISP)
>   #include "amdgpu_isp.h"
>   #endif
> @@ -481,7 +482,6 @@ struct amdgpu_flip_work {
>   	bool				async;
>   };
>   
> -
>   /*
>    * file private structure
>    */
> @@ -495,6 +495,10 @@ struct amdgpu_fpriv {
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
>   	struct amdgpu_userq_mgr	userq_mgr;
> +
> +	/* Eviction fence infra */
> +	struct amdgpu_eviction_fence_mgr evf_mgr;
> +
>   	/** GPU partition selection */
>   	uint32_t		xcp_id;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> new file mode 100644
> index 000000000000..2d474cb11cf9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/sched.h>
> +#include "amdgpu.h"
> +
> +static const char *
> +amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
> +{
> +	return "amdgpu";
> +}
> +
> +static const char *
> +amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	struct amdgpu_eviction_fence *ef;
> +
> +	ef = container_of(f, struct amdgpu_eviction_fence, base);
> +	return ef->timeline_name;
> +}
> +
> +static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_eviction_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
> +};
> +
> +int amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +	int ret;
> +
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	ret = dma_fence_signal(&evf_mgr->ev_fence->base);
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +	return ret;
> +}
> +
> +struct amdgpu_eviction_fence *
> +amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +	struct amdgpu_eviction_fence *ev_fence;
> +
> +	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
> +	if (!ev_fence)
> +		return NULL;
> +
> +	get_task_comm(ev_fence->timeline_name, current);
> +	spin_lock_init(&ev_fence->lock);
> +	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
> +		       &ev_fence->lock, evf_mgr->ev_fence_ctx,
> +		       atomic_inc_return(&evf_mgr->ev_fence_seq));
> +	return ev_fence;
> +}
> +
> +void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +	if (!evf_mgr->ev_fence)
> +		return;
> +
> +	if (!dma_fence_is_signaled(&evf_mgr->ev_fence->base))

You can drop that if, dma_fence_wait() will check that anyway.

> +		dma_fence_wait(&evf_mgr->ev_fence->base, false);
> +
> +	/* Last unref of ev_fence */
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	dma_fence_put(&evf_mgr->ev_fence->base);
> +	evf_mgr->ev_fence = NULL;
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +}
> +
> +int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				 struct amdgpu_bo *bo)
> +{
> +	struct dma_fence *ef;
> +	struct amdgpu_eviction_fence *ev_fence = evf_mgr->ev_fence;
> +	struct dma_resv *resv = bo->tbo.base.resv;
> +	int ret;
> +
> +	if (!ev_fence || !resv)
> +		return 0;
> +
> +	ef = &ev_fence->base;
> +	ret = dma_resv_reserve_fences(resv, 1);
> +	if (ret) {
> +		dma_fence_wait(ef, false);
> +		return ret;
> +	}
> +
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	dma_resv_add_fence(resv, ef, DMA_RESV_USAGE_BOOKKEEP);
> +	spin_unlock(&evf_mgr->ev_fence_lock);

That spinlock is protecting evf_mgr->ev_fence, isn't it?

In that case you probably shouldn't dereference it outside of the spinlock.

> +	return 0;
> +}
> +
> +void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				  struct amdgpu_bo *bo)
> +{
> +	struct dma_fence *stub;
> +	struct amdgpu_eviction_fence *ev_fence = evf_mgr->ev_fence;
> +
> +	if (!ev_fence)
> +		return;
> +
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	stub = dma_fence_get_stub();
> +	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
> +				stub, DMA_RESV_USAGE_BOOKKEEP);
> +	dma_fence_put(stub);
> +	spin_unlock(&evf_mgr->ev_fence_lock);

This operation doesn't need the spinlock since we are not accessing 
evf_mgr->ev_fence.

> +}
> +
> +void amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +
> +	/* This needs to be done one time per open */
> +	atomic_set(&evf_mgr->ev_fence_seq, 0);
> +	evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
> +	spin_lock_init(&evf_mgr->ev_fence_lock);
> +
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	evf_mgr->ev_fence = amdgpu_eviction_fence_create(evf_mgr);

amdgpu_eviction_fence_create() will call kmalloc, doing that while 
holding the spinlock is a bad idea.

You need to do something like:

tmp = amdgpu_eviction_fence_create(....);
spin_lock(...);
evf_mgr->ev_fence = tmp;
...

> +	if (!evf_mgr->ev_fence) {
> +		DRM_ERROR("Failed to craete eviction fence\n");
> +		goto unlock;
> +	}
> +
> +unlock:
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> new file mode 100644
> index 000000000000..b47ab1307ec5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_EV_FENCE_H_
> +#define AMDGPU_EV_FENCE_H_
> +
> +struct amdgpu_eviction_fence {
> +	struct dma_fence base;
> +	spinlock_t	 lock;
> +	char		 timeline_name[TASK_COMM_LEN];
> +	struct amdgpu_userq_mgr *uq_mgr;
> +};
> +
> +struct amdgpu_eviction_fence_mgr {
> +	u64			ev_fence_ctx;
> +	atomic_t		ev_fence_seq;
> +	spinlock_t 		ev_fence_lock;
> +	struct amdgpu_eviction_fence *ev_fence;
> +};
> +
> +/* Eviction fence helper functions */
> +struct amdgpu_eviction_fence *
> +amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +
> +void
> +amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +
> +int
> +amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +			     struct amdgpu_bo *bo);
> +
> +void
> +amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +			     struct amdgpu_bo *bo);
> +
> +void
> +amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +
> +int
> +amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +
> +int
> +amdgpu_eviction_fence_replace_fence(struct amdgpu_fpriv *fpriv);
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f4529f2fad97..c9b4a6ce3f14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -186,6 +186,13 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
>   	else
>   		++bo_va->ref_count;
> +
> +	if (!vm->is_compute_context || !vm->process_info) {

I said it before, we should really drop this line since the user queues 
are completely independent of that.

> +		/* attach gfx eviction fence */
> +		if (amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo))
> +			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> +	}
> +
>   	amdgpu_bo_unreserve(abo);
>   
>   	/* Validate and add eviction fence to DMABuf imports with dynamic
> @@ -236,6 +243,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>   	struct drm_exec exec;
>   	long r;
>   
> +	amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
> +

We should probably skip that call for per VM BOs, or otherwise we will 
also detach the page tables accidentally.

BTW: Were do we attach the eviction fence to the page tables?

Regards,
Christian.

>   	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>   	drm_exec_until_all_locked(&exec) {
>   		r = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 019a377620ce..e7fb13e20197 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1391,6 +1391,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	mutex_init(&fpriv->bo_list_lock);
>   	idr_init_base(&fpriv->bo_list_handles, 1);
>   
> +	amdgpu_eviction_fence_init(&fpriv->evf_mgr);
> +
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>   
>   	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> @@ -1464,6 +1466,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   		amdgpu_bo_unreserve(pd);
>   	}
>   
> +	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
>   	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);

