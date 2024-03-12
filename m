Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C2DC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 08:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0F31123AA;
	Tue, 12 Mar 2024 08:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXw5tqRn";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F099112444
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 08:31:58 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-413328344acso3680335e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710232317; x=1710837117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=80Be8dF2UCxPaJ1w2MwWXCWYBlvJuvL7IjlBjfpljkE=;
 b=cXw5tqRngq9DuGhu6jshrBE+lHqatBFsgIzplSe1xzfrMmQ3+zibFgpdSBofp/aXTE
 6c2ZWrAXkllcalFXCtpxAouDQeFjZbzTch1E+xUQ3Dimd+VVXtLBEa89veD0QOOfGvH4
 hFHDGrMG7osTolCP+h7fDqqSWujh1EoAsOS5LvHuAHwKw76lMyrqVQl1qIvEc/48u1s+
 +m7+/sLg5rdBx3sc1oCEPUog7Sg6+vVH36sxhpI3oREpsCODWlyKRZb+GugeQopfouIs
 v1rEkhysEVaPuKcDnBs8wBK82A7MYDNOQ+Oo+lKm/AvITq1yMKDQdxrI/cAQPG7a5jon
 ZSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710232317; x=1710837117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80Be8dF2UCxPaJ1w2MwWXCWYBlvJuvL7IjlBjfpljkE=;
 b=vtJgodwl/5QfV7eageczm+vA3DG/e28HkT/3GbMoxouuvxszegcQpqDMZZjpuYdknb
 S+m9n8h3CdyqGcOem4BjLODxfS4GuCL2QzEq4F1/RO6IaKjwq5t1FhVITOi1s13JbUS2
 iJK0eUrkqnTUOiw0Xc5zbpVkJpykwXb665Pm04sVdcvbkySCTP3ieF4A1a2UvJaHGiCm
 /RD05kgD1MvfdI9pzDThGJa5IR6FSPYkx7gIcRUSE0kTxzEXvTmBzBUJ80BTnL2EgaU3
 xYv90/Q+n28gS54rRSrGx7zSTk8XcNkHFuoWDOXLXtkpOGukgFeu77NxugIBcAMPhNXu
 go6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL+f3HAXVBjZIpzjXhxMPhmvN1G6X3m1+B0BT7DKpuCdhitLVXimsXU3+i3B/Fg67fUDjrRfc+OpN+aFuFKTCd1t79/7WGz0bQkzV9qg==
X-Gm-Message-State: AOJu0Yx4+ovq+x4udkzEcDLrEGvoA25rMcDDGHSjyGumEPa+/FNJhIuQ
 PZvQYwvCiOFBRUIfrKCZZvfp9WRtq3s1Lc1ijHjjz3LMNxGMiWp/
X-Google-Smtp-Source: AGHT+IG5DUWoqHYKjgzU/qVpzc36W/zZ/AoI4i8JaNHh3fRCddekEKoyMto7HUg57qGGrr1+xdksww==
X-Received: by 2002:a05:600c:4f0e:b0:413:1212:3eed with SMTP id
 l14-20020a05600c4f0e00b0041312123eedmr6441928wmq.3.1710232316519; 
 Tue, 12 Mar 2024 01:31:56 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c358b00b00412ebd587ebsm18323225wmq.3.2024.03.12.01.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:31:55 -0700 (PDT)
Message-ID: <dac63b64-7b25-439f-a883-393e37826fb3@gmail.com>
Date: Tue, 12 Mar 2024 09:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, Philip Yang
 <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
 <939a8f23-952f-8993-9c1c-178bb0fd42b5@amd.com>
 <98f72106-e62e-ef02-ff9b-d92edeb6950d@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <98f72106-e62e-ef02-ff9b-d92edeb6950d@amd.com>
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

Am 11.03.24 um 15:37 schrieb Sharma, Shashank:
>
> On 07/03/2024 20:22, Philip Yang wrote:
>>
>>
>> On 2024-03-06 09:41, Shashank Sharma wrote:
>>> From: Christian König<christian.koenig@amd.com>
>>>
>>> The problem is that when (for example) 4k pages are replaced
>>> with a single 2M page we need to wait for change to be flushed
>>> out by invalidating the TLB before the PT can be freed.
>>>
>>> Solve this by moving the TLB flush into a DMA-fence object which
>>> can be used to delay the freeing of the PT BOs until it is signaled.
>>>
>>> V2: (Shashank)
>>>      - rebase
>>>      - set dma_fence_error only in case of error
>>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>>      - use vm->pasid when f is NULL (Mukul)
>>>
>>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>>      - move the misplaced fence_create call to the end (Philip)
>>>
>>> V5: - free the f->dependency properly (Christian)
>>>
>>> Cc: Christian Koenig<christian.koenig@amd.com>
>>> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
>>> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
>>> Cc: Alex Deucher<alexander.deucher@amd.com>
>>> Reviewed-by: Shashank Sharma<shashank.sharma@amd.com>
>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 
>>> ++++++++++++++++++
>>>   4 files changed, 128 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index fa26a4e3a99d..91ab4cf29b5b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>>> amdgpu_kms.o \
>>>       amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>> -    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>> amdgpu_pll.o \
>>> +    amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o 
>>> amdgpu_vm_tlb_fence.o \
>>> +    amdgpu_ib.o amdgpu_pll.o \
>>>       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>> amdgpu_virt.o \
>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 0960e0a665d3..310aae6fb49b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>         r = vm->update_funcs->commit(&params, fence);
>>>   +    /* Prepare a TLB flush fence to be attached to PTs */
>>> +    if (!unlocked && params.needs_flush && vm->is_compute_context) {
>>> +        amdgpu_vm_tlb_fence_create(adev, vm, fence);
>>> +
>>> +        /* Makes sure no PD/PT is freed before the flush */
>>> +        dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>> +                   DMA_RESV_USAGE_BOOKKEEP);
>>> +    }
>>> +
>>>   error_unlock:
>>>       amdgpu_vm_eviction_unlock(vm);
>>>       drm_dev_exit(idx);
>>> @@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm,
>>>         mutex_init(&vm->eviction_lock);
>>>       vm->evicting = false;
>>> +    vm->tlb_fence_context = dma_fence_context_alloc(1);
>>>         r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>>                   false, &root, xcp_id);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 64b3f69efa57..298f604b8e5f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -341,6 +341,7 @@ struct amdgpu_vm {
>>>       atomic64_t        tlb_seq;
>>>       uint64_t        tlb_seq_va;
>>>       uint64_t        *tlb_seq_cpu_addr;
>>> +    uint64_t        tlb_fence_context;
>>>         atomic64_t        kfd_last_flushed_seq;
>>>   @@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct 
>>> amdgpu_device *adev,
>>>                     uint64_t addr,
>>>                     uint32_t status,
>>>                     unsigned int vmhub);
>>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>>> +                 struct amdgpu_vm *vm,
>>> +                 struct dma_fence **fence);
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>> new file mode 100644
>>> index 000000000000..51cddfa3f1e8
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>> @@ -0,0 +1,112 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>> +/*
>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to 
>>> whom the
>>> + * Software is furnished to do so, subject to the following 
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +#include <linux/dma-fence.h>
>>> +#include <linux/workqueue.h>
>>> +
>>> +#include "amdgpu.h"
>>> +#include "amdgpu_vm.h"
>>> +#include "amdgpu_gmc.h"
>>> +
>>> +struct amdgpu_tlb_fence {
>>> +    struct dma_fence    base;
>>> +    struct amdgpu_device    *adev;
>>> +    struct dma_fence    *dependency;
>>> +    struct work_struct    work;
>>> +    spinlock_t        lock;
>>> +    uint16_t        pasid;
>>> +
>>> +};
>>> +
>>> +static const char *amdgpu_tlb_fence_get_driver_name(struct 
>>> dma_fence *fence)
>>> +{
>>> +    return "amdgpu tlb fence";
>>> +}
>>> +
>>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct 
>>> dma_fence *f)
>>> +{
>>> +    return "amdgpu tlb timeline";
>>> +}
>>> +
>>> +static void amdgpu_tlb_fence_work(struct work_struct *work)
>>> +{
>>> +    struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>>> +    int r;
>>> +
>>> +    if (f->dependency) {
>>> +        dma_fence_wait(f->dependency, false);
>>> +        dma_fence_put(f->dependency);
>>> +        f->dependency = NULL;
>>> +    }
>>> +
>>> +    r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>>
>> To flush all XCCs, as this is a corner case, we could start with this 
>> to make it correct for SPX mode for now, with extra flush for other 
>> modes.
>>
>>     int num_xcc = f->adev->gfx.xcc_mask ? 
>> NUM_XCC(f->adev->gfx.xcc_mask) : 1;
>>     uint32_t xcc_mask = GENMASK(num_xcc - 1, 0);
>>     int i;
>>
>>     for_each_inst(i, xcc_mask)
>>          r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 
>> TLB_FLUSH_LEGACY, true, i);
>
> Thanks for this input, Philip.
>
> @Christian, your feedback for this ?

IIRC Felix and I talked about that before. In theory each VM should only 
clear one XCC, but in practice that won't work.

I suggest to just make it another parameter and maybe separate fence 
allocation from actually arming it.

Christian.

>
> - Shashank
>
>>
>> Regards,
>> Philip
>>> +    if (r) {
>>> +        dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>>> +            f->pasid);
>>> +        dma_fence_set_error(&f->base, r);
>>> +    }
>>> +
>>> +    dma_fence_signal(&f->base);
>>> +    dma_fence_put(&f->base);
>>> +}
>>> +
>>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>>> +    .use_64bit_seqno = true,
>>> +    .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>>> +    .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>>> +};
>>> +
>>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> +                struct dma_fence **fence)
>>> +{
>>> +    struct amdgpu_tlb_fence *f;
>>> +
>>> +    f = kmalloc(sizeof(*f), GFP_KERNEL);
>>> +    if (!f) {
>>> +        /*
>>> +         * We can't fail since the PDEs and PTEs are already 
>>> updated, so
>>> +         * just block for the dependency and execute the TLB flush
>>> +         */
>>> +        if (*fence)
>>> +            dma_fence_wait(*fence, false);
>>> +
>>> +        amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>>> +        *fence = dma_fence_get_stub();
>>> +        return;
>>> +    }
>>> +
>>> +    f->adev = adev;
>>> +    f->dependency = *fence;
>>> +    f->pasid = vm->pasid;
>>> +    INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>>> +    spin_lock_init(&f->lock);
>>> +
>>> +    dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>>> +               vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>>> +
>>> +    /* TODO: We probably need a separate wq here */
>>> +    dma_fence_get(&f->base);
>>> +    schedule_work(&f->work);
>>> +
>>> +    *fence = &f->base;
>>> +}

