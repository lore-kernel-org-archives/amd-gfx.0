Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D76C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 15:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EA310E784;
	Mon, 26 Feb 2024 15:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bfc10K5W";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B2A10E784
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 15:13:09 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso2183167f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 07:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708960388; x=1709565188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J1q3Q0LLNm8ILrf8Bccpaj2IyTWLnAbxPe1Y8Fqv/R4=;
 b=Bfc10K5W3oHSd30X7aWLehQTF+NZkGa3FJOQTLOMXKYPuR3K+r/LYB/pMGH6wrl4q6
 Fbz/k6n1+W3Xad6OMMEsWJS6I/wFmDVNg23P1ukC4klwmIe4hcRkkQhDZAvwyTihe7qG
 NmWRTPVR9tr877yzeqYKcBdZdRtb5BNf9BxUliL5v3WTqf8xDrYO4bc/CUa8fOI6SYNE
 jEhhf04BjLZECLc4WsQ7bvQfhZ5LEAyITLbI++Kfg3QbBB+dRSMwIkOmZoVLKmEiVwjd
 lgP2CBHGR5hL8tGuwAvaVMikIFIVBmLv0IuI6I4rEUWzF+TEYjevEaICaVEQknBY8UcW
 YZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708960388; x=1709565188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J1q3Q0LLNm8ILrf8Bccpaj2IyTWLnAbxPe1Y8Fqv/R4=;
 b=p9xCSCQ8Pa9iKI3dV9AViGpH9cr409K3efxQyJQP32INqVz7Lu9g59ZXw9GhnUU8rU
 qHkE8dDfAJ6FKrUvMm0zKDqYBvpWO82ll9Sr5qqK+XxbHtyGkq2yuu569hyWaSdsakHj
 t8kUSxKkyujxoX8IYR9aWGrdP0ju+3kDaNlSYUPDGD24wTmCNVDSEhdJqY/j5a+IKV2N
 wE3DewqnaqcnShPOs6GUTBiI5fv0lWLYjLbJzhtyrnm/YbIgLcIj+Z80G6jjnUhy4tW4
 3gD4MeT7V8bREoqArkdPhLM3g6lf5LCx3+ce6d+UIl48ex5M9DdHj4tP2j91qdIKkNRB
 AD/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyj8oySLXJRmIpWuPNDlXqVmn6Gm95OGbaZZrMxG5TK0L6116w7Rvb8QBhJrtkmFFUdZSEHlq/A6oI1O3WdyBU2I8N/q0ZK7jfBgmeUw==
X-Gm-Message-State: AOJu0YwrUjuc06u5vZsanZ2yrOJ+x8fwWQvlcwco3FRY5oE9ixnQ+rlY
 cx4XlG+pcWHyxpYWJyuLcm0stIPwPtE36/76f8MM0HWJHCmzZ+YU
X-Google-Smtp-Source: AGHT+IEJPSBTbRS1WkUjmB9g+qiO/St3DeIr4X6MkdM17KR0U97wiUfIyemvoXZCMUGj8+cD/zi/Vg==
X-Received: by 2002:a5d:528f:0:b0:33d:dec1:55b6 with SMTP id
 c15-20020a5d528f000000b0033ddec155b6mr1952577wrv.30.1708960387431; 
 Mon, 26 Feb 2024 07:13:07 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05600c0a0e00b00412a37130ccsm4798775wmp.48.2024.02.26.07.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 07:13:07 -0800 (PST)
Message-ID: <4d2019a3-bd39-4738-8c63-c6a8db823e07@gmail.com>
Date: Mon, 26 Feb 2024 16:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <20240223134206.899-2-shashank.sharma@amd.com>
 <be0a4509-497f-2264-987d-2941ce21d97f@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <be0a4509-497f-2264-987d-2941ce21d97f@amd.com>
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



Am 23.02.24 um 17:58 schrieb Philip Yang:
>
>
> On 2024-02-23 08:42, Shashank Sharma wrote:
>> From: Christian König<christian.koenig@amd.com>
>>
>> The problem is that when (for example) 4k pages are replaced
>> with a single 2M page we need to wait for change to be flushed
>> out by invalidating the TLB before the PT can be freed.
>>
>> Solve this by moving the TLB flush into a DMA-fence object which
>> can be used to delay the freeing of the PT BOs until it is signaled.
>>
>> V2: (Shashank)
>>      - rebase
>>      - set dma_fence_error only in case of error
>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>      - use vm->pasid when f is NULL (Mukul)
>>
>> Cc: Christian Koenig<christian.koenig@amd.com>
>> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Signed-off-by: Christian König<christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 106 ++++++++++++++++++
>>   4 files changed, 122 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 4c989da4d2f3..fdbb3d770c7b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>   	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>> -	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
>> +	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
>> +	amdgpu_ib.o amdgpu_pll.o \
>>   	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
>>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 0960e0a665d3..67c690044b97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -932,6 +932,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	if (r)
>>   		goto error_unlock;
>>   
>> +	/* Prepare a TLB flush fence to be attached to PTs */
>> +	if (!unlocked && params.needs_flush && vm->is_compute_context) {
>> +		amdgpu_vm_tlb_fence_create(adev, vm, fence);
>> +
>> +		/* Makes sure no PD/PT is freed before the flush */
>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +				   DMA_RESV_USAGE_BOOKKEEP);
>> +	}
>> +
>>   	amdgpu_res_first(pages_addr ? NULL : res, offset,
>>   			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
>>   	while (cursor.remaining) {
>> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   	mutex_init(&vm->eviction_lock);
>>   	vm->evicting = false;
>> +	vm->tlb_fence_context = dma_fence_context_alloc(1);
>>   
>>   	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>   				false, &root, xcp_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index ac9380afcb69..8e6fd25d07b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -332,6 +332,7 @@ struct amdgpu_vm {
>>   	atomic64_t		tlb_seq;
>>   	uint64_t		tlb_seq_va;
>>   	uint64_t		*tlb_seq_cpu_addr;
>> +	uint64_t		tlb_fence_context;
>>   
>>   	atomic64_t		kfd_last_flushed_seq;
>>   
>> @@ -585,5 +586,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>>   				  uint64_t addr,
>>   				  uint32_t status,
>>   				  unsigned int vmhub);
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +				 struct amdgpu_vm *vm,
>> +				 struct dma_fence **fence);
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> new file mode 100644
>> index 000000000000..569681badd7c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/dma-fence.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +
>> +struct amdgpu_tlb_fence {
>> +	struct dma_fence	base;
>> +	struct amdgpu_device	*adev;
>> +	struct dma_fence	*dependency;
>> +	struct work_struct	work;
>> +	spinlock_t		lock;
>> +	uint16_t		pasid;
>> +
>> +};
>> +
>> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
>> +{
>> +	return "amdgpu tlb fence";
>> +}
>> +
>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
>> +{
>> +	return "amdgpu tlb timeline";
>> +}
>> +
>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>> +{
>> +	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +	int r;
>> +
>> +	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>> +	if (r) {
>> +		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>> +			f->pasid);
>> +		dma_fence_set_error(&f->base, r);
>> +	}
>> +
>> +	dma_fence_signal(&f->base);
>> +	dma_fence_put(&f->base);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> +	.use_64bit_seqno = true,
>> +	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
>> +	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>> +};
>> +
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +				struct dma_fence **fence)
>> +{
>> +	struct amdgpu_tlb_fence *f;
>> +
>> +	f = kmalloc(sizeof(*f), GFP_KERNEL);
>> +	if (!f) {
>> +		/*
>> +		 * We can't fail since the PDEs and PTEs are already updated, so
>> +		 * just block for the dependency and execute the TLB flush
>> +		 */
>> +		if (*fence)
>> +			dma_fence_wait(*fence, false);
>> +
>> +		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +		*fence = dma_fence_get_stub();
>> +		return;
>> +	}

We should probably avoid that fallback path somehow.

Easiest would be to separate allocation and initialization, e.g. so that 
we kalloc the memory before doing anything.

>> +
>> +	f->adev = adev;
>> +	f->dependency = *fence;
>> +	f->pasid = vm->pasid;
>> +	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>> +	spin_lock_init(&f->lock);
>> +
>> +	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>> +		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>> +
>> +	/* TODO: We probably need a separate wq here */
>
> tlb_fence_work flush tlb, then signal fence to free pt bo, but how to 
> guarantee the tlb_fence_work is executed after updating page table 
> done? This looks racy to schedule tlb_fence_work right after creating 
> fence to attach to pt bo.
>

At least in my original implementation the worker was waiting for the 
dependency before executing the TLB flush and signaling completion.

It looks like that got missing somehow in this version here.

Regards,
Christian.

> Regards,
>
> Philip
>
>> +	dma_fence_get(&f->base);
>> +	schedule_work(&f->work);
>> +
>> +	*fence = &f->base;
>> +}

