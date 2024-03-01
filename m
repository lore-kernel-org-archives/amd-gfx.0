Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2D1C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 12:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E428C10E2F7;
	Fri,  1 Mar 2024 12:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LhMvdHEb";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD0410E2F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 12:59:12 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-412c23551e2so8670055e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Mar 2024 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709297950; x=1709902750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gECsXJicyzRrU3m5dJNwDaOoreYWs2mTwDR+PhQMf1w=;
 b=LhMvdHEb5AuifGnh7F3l1MUK0wTmtYXDAaWMR6Vz3PWAcVsxDPnS2409Q9VJQhvxZc
 a2zTchbbprt3bK6W7mAkEKUVWM6yARZFZGejBwenl9dntcgjY+XYxTSrdoY2OvC4XceH
 7KqTZX1yWPr4mf5vxLTHGNbr1X7gb6yWj+nsI60EvbpCFV9Ig2trnliJRHjBj7LREPWZ
 Sc8V+vgomdTxPOEDng3ZKuVqF/hctG+rlPKRy1MfwCGEMMkRdFTs8B8bEYTXDEgha2I+
 +rEqD1CdjgCf5A0mH09rOh3Sgq+T0o9K5InuKdfVQNytnnx2mQEHHzEjc9JDGSY1bklL
 U4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709297950; x=1709902750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gECsXJicyzRrU3m5dJNwDaOoreYWs2mTwDR+PhQMf1w=;
 b=hW9xWUb23lfiiMMS6t/+S2Nad7C3G6wQtitiCdNpaqUNxqP4Hbbq3xnGmBEUL24naI
 N1cdHpfhE9jUea2kWsq8avVTSnQq6OieBi1+q77d9lXntG2n2yrU9NQTIUEA69I1AVjE
 TTKOqOQgLFnmCU3Y0ptxaZlwzj8C5z/NPzGbk8WVRB47n59gE4cAdXy8oPBbRa06WlBL
 3Wadu5x11yxUL9CwqbbIwNRzGjqPldXtjRqodnslxKqhO45gGZRh1b7vWU9EOE6iMWz7
 PL4CUoMspAXiB1KaEwQ1LzeUJD2vx/T1BL47T3iiE6mY7ij6yfrpPC8NChzLNBROqGSY
 7eXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViVDN9FrpETmfZEJbNi8dK0uAYuIZK25uCwQxG76k2fq6DD5ip7nNQWXwb3D0J9KJDnjDZ/nb9mBGE3m9L8dKHyLMDgKM30CNPnTSH0Q==
X-Gm-Message-State: AOJu0YyHjvFmElkBl2bNbrEQoaVfLw3VfF/l6c08kUSdr0TUdn0hqn2g
 RJ2VRQPUqmj7sNJ5llbPqJG5sFXQZBFZ0Zz3xRd+PAVYqpBGoCnl
X-Google-Smtp-Source: AGHT+IGsWMOVNO6cy1Wfw1rkuygCAatxqYPu2L691JQqOAXtE50p2RilRvqTKk209z6CgNdIEZZmmA==
X-Received: by 2002:a05:600c:3513:b0:412:a397:c8f2 with SMTP id
 h19-20020a05600c351300b00412a397c8f2mr2117959wmq.17.1709297950161; 
 Fri, 01 Mar 2024 04:59:10 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 hg14-20020a05600c538e00b0041228b2e179sm5353063wmb.39.2024.03.01.04.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 04:59:09 -0800 (PST)
Message-ID: <33c50082-c9d2-425f-9f6d-74ed43ba565d@gmail.com>
Date: Fri, 1 Mar 2024 13:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240301110724.947-1-shashank.sharma@amd.com>
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

Am 01.03.24 um 12:07 schrieb Shashank Sharma:
> From: Christian König <christian.koenig@amd.com>
>
> The problem is that when (for example) 4k pages are replaced
> with a single 2M page we need to wait for change to be flushed
> out by invalidating the TLB before the PT can be freed.
>
> Solve this by moving the TLB flush into a DMA-fence object which
> can be used to delay the freeing of the PT BOs until it is signaled.
>
> V2: (Shashank)
>      - rebase
>      - set dma_fence_error only in case of error
>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>      - use vm->pasid when f is NULL (Mukul)
>
> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>      - move the misplaced fence_create call to the end (Philip)
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 111 ++++++++++++++++++
>   4 files changed, 127 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index fa26a4e3a99d..91ab4cf29b5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> -	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
> +	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
> +	amdgpu_ib.o amdgpu_pll.o \
>   	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0960e0a665d3..310aae6fb49b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->commit(&params, fence);
>   
> +	/* Prepare a TLB flush fence to be attached to PTs */
> +	if (!unlocked && params.needs_flush && vm->is_compute_context) {
> +		amdgpu_vm_tlb_fence_create(adev, vm, fence);
> +
> +		/* Makes sure no PD/PT is freed before the flush */
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);
> +	}
> +
>   error_unlock:
>   	amdgpu_vm_eviction_unlock(vm);
>   	drm_dev_exit(idx);
> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;
> +	vm->tlb_fence_context = dma_fence_context_alloc(1);
>   
>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>   				false, &root, xcp_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 64b3f69efa57..298f604b8e5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>   	atomic64_t		tlb_seq;
>   	uint64_t		tlb_seq_va;
>   	uint64_t		*tlb_seq_cpu_addr;
> +	uint64_t		tlb_fence_context;
>   
>   	atomic64_t		kfd_last_flushed_seq;
>   
> @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>   				  uint64_t addr,
>   				  uint32_t status,
>   				  unsigned int vmhub);
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 struct dma_fence **fence);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> new file mode 100644
> index 000000000000..54c33c24fa46
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
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
> + */
> +
> +#include <linux/dma-fence.h>
> +#include <linux/workqueue.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_gmc.h"
> +
> +struct amdgpu_tlb_fence {
> +	struct dma_fence	base;
> +	struct amdgpu_device	*adev;
> +	struct dma_fence	*dependency;
> +	struct work_struct	work;
> +	spinlock_t		lock;
> +	uint16_t		pasid;
> +
> +};
> +
> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
> +{
> +	return "amdgpu tlb fence";
> +}
> +
> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	return "amdgpu tlb timeline";
> +}
> +
> +static void amdgpu_tlb_fence_work(struct work_struct *work)
> +{
> +	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
> +	int r;
> +
> +	if (f->dependency) {
> +		dma_fence_wait(f->dependency, false);
> +		f->dependency = dma_fence_get_stub();

That doesn't correctly drops the f->depency reference.

You need something like "dma_fence_put(f->depency); f->dependency = 
NULL;" here instead.

Apart from that looks good to me,
Christian.

> +	}
> +
> +	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
> +	if (r) {
> +		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
> +			f->pasid);
> +		dma_fence_set_error(&f->base, r);
> +	}
> +
> +	dma_fence_signal(&f->base);
> +	dma_fence_put(&f->base);
> +}
> +
> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
> +	.use_64bit_seqno = true,
> +	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
> +};
> +
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +				struct dma_fence **fence)
> +{
> +	struct amdgpu_tlb_fence *f;
> +
> +	f = kmalloc(sizeof(*f), GFP_KERNEL);
> +	if (!f) {
> +		/*
> +		 * We can't fail since the PDEs and PTEs are already updated, so
> +		 * just block for the dependency and execute the TLB flush
> +		 */
> +		if (*fence)
> +			dma_fence_wait(*fence, false);
> +
> +		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> +		*fence = dma_fence_get_stub();
> +		return;
> +	}
> +
> +	f->adev = adev;
> +	f->dependency = *fence;
> +	f->pasid = vm->pasid;
> +	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
> +	spin_lock_init(&f->lock);
> +
> +	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> +		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
> +
> +	/* TODO: We probably need a separate wq here */
> +	dma_fence_get(&f->base);
> +	schedule_work(&f->work);
> +
> +	*fence = &f->base;
> +}

