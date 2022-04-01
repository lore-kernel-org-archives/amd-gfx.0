Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FD3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 08:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7ABF10FDD5;
	Fri,  1 Apr 2022 08:24:54 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219B710FDD5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 08:24:54 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id bh17so4247513ejb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Apr 2022 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=oCGRPh4BG9hyiN6NE626SYbjT5oc9qAnR5YwwJiKIc8=;
 b=BJ7pDED7C+XUgT2Xg6C2176Oj3nqb/Hzv2jRlttF6wqVNZERYoNxssh26y81H00gX5
 AKRuU21OVtYZy8LrSfNJH9wtFNjguMQZLxi9lqQN7iKRWckSaxOEdvXXvqOCvPfGg7a6
 jzwWUtjsesS0DAI41FaJyydf1UDKK03aIuj0ETxoXQaOPhNXR7qTU7T5EeF5Jzt3l7Ky
 ZxRPgsamqER4zoTfN4qDPEL7DrD/HE28H7ybZfaPI7IDf32KryI1CW1BSNfJWGOCmWuM
 H+mUfdbrQhhzpLb2VmYYrgfMPvfR9WyQrYnUjNhQy8XN3058TttJZtJs+Mjfz+6S8t7b
 bTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oCGRPh4BG9hyiN6NE626SYbjT5oc9qAnR5YwwJiKIc8=;
 b=UblZGv7J29Jh0WtpQV7NUtZuPub6rJayvf11rHROZSsj1ZlkgK5URQN+qNQCvv6sng
 PZRhB0T92evypdmB57uHQA40b0bvoyyhL8ZL+opodwrLCl+kXwJC3Zao7CFy/jzWApG/
 b/uZCXs54hTVoqWAW6prMwwsOCQuUngnlWxr1vu00jSLercAJ62MjadI6ILPfcyfNLIL
 7beulsaFq5Ehi/NXg8sbs06vddWc1dvnib0rFvZZuBDydYjSc605tDadl40q1/vcpDxz
 ws8Yc5hu5XjDzxA7DQ/tU8jqA/OhJsc9+06HvIVklOdwk40jYf91fIvaUKc7T/pNQAKz
 4PYQ==
X-Gm-Message-State: AOAM532JRSnOOBIoIZUDR7TjPCrxrOjyxI3X+fSSxQEKA7lk88Xx2UdQ
 kQr04ZKarXrf3G31Z1m8lY0=
X-Google-Smtp-Source: ABdhPJyiKnWCXdntJFU7Oe3qKkEDwwZsPhgtOzs5ztsLZ2DRKzFeMLKx71ObjRuCOwzn7mHBk65ATQ==
X-Received: by 2002:a17:907:1c9a:b0:6df:bfc3:c9f3 with SMTP id
 nb26-20020a1709071c9a00b006dfbfc3c9f3mr8643948ejc.679.1648801492489; 
 Fri, 01 Apr 2022 01:24:52 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 cr19-20020a170906d55300b006df6b316e29sm753248ejc.208.2022.04.01.01.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Apr 2022 01:24:51 -0700 (PDT)
Message-ID: <c561a97f-2d72-e50b-2e86-e52c605247a5@gmail.com>
Date: Fri, 1 Apr 2022 10:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, philip yang <yangp@amd.com>,
 amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
 <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
 <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
 <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 31.03.22 um 16:37 schrieb Felix Kuehling:
> Am 2022-03-31 um 02:27 schrieb Christian König:
>> Am 30.03.22 um 22:51 schrieb philip yang:
>>>
>>>
>>> On 2022-03-30 05:00, Christian König wrote:
>>>> Testing the valid bit is not enough to figure out if we
>>>> need to invalidate the TLB or not.
>>>>
>>>> During eviction it is quite likely that we move a BO from VRAM to 
>>>> GTT and
>>>> update the page tables immediately to the new GTT address.
>>>>
>>>> Rework the whole function to get all the necessary parameters 
>>>> directly as
>>>> value.
>>>>
>>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 
>>>> ++++++++++++++------------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 18 ++++----
>>>>   3 files changed, 48 insertions(+), 48 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 9992a7311387..1cac90ee3318 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -793,18 +793,19 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>>> dma_fence *fence,
>>>>   }
>>>>     /**
>>>> - * amdgpu_vm_bo_update_mapping - update a mapping in the vm page 
>>>> table
>>>> + * amdgpu_vm_update_range - update a range in the vm page table
>>>>    *
>>>> - * @adev: amdgpu_device pointer of the VM
>>>> - * @bo_adev: amdgpu_device pointer of the mapped BO
>>>> - * @vm: requested vm
>>>> + * @adev: amdgpu_device pointer to use for commands
>>>> + * @vm: the VM to update the range
>>>>    * @immediate: immediate submission in a page fault
>>>>    * @unlocked: unlocked invalidation during MM callback
>>>> + * @flush_tlb: trigger tlb invalidation after update completed
>>>>    * @resv: fences we need to sync to
>>>>    * @start: start of mapped range
>>>>    * @last: last mapped entry
>>>>    * @flags: flags for the entries
>>>>    * @offset: offset into nodes and pages_addr
>>>> + * @vram_base: base for vram mappings
>>>>    * @res: ttm_resource to map
>>>>    * @pages_addr: DMA addresses to use for mapping
>>>>    * @fence: optional resulting fence
>>>> @@ -812,17 +813,14 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>>> dma_fence *fence,
>>>>    * Fill in the page table entries between @start and @last.
>>>>    *
>>>>    * Returns:
>>>> - * 0 for success, -EINVAL for failure.
>>>> + * 0 for success, negative erro code for failure.
>>>>    */
>>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>> -                struct amdgpu_device *bo_adev,
>>>> -                struct amdgpu_vm *vm, bool immediate,
>>>> -                bool unlocked, struct dma_resv *resv,
>>>> -                uint64_t start, uint64_t last,
>>>> -                uint64_t flags, uint64_t offset,
>>>> -                struct ttm_resource *res,
>>>> -                dma_addr_t *pages_addr,
>>>> -                struct dma_fence **fence)
>>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>>> amdgpu_vm *vm,
>>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>>> +               struct dma_resv *resv, uint64_t start, uint64_t last,
>>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>>> +               struct dma_fence **fence)
>>>>   {
>>>>       struct amdgpu_vm_update_params params;
>>>>       struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>>> @@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>>> amdgpu_device *adev,
>>>>               }
>>>>             } else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
>>>> -            addr = bo_adev->vm_manager.vram_base_offset +
>>>> -                cursor.start;
>>>> +            addr = vram_base + cursor.start;
>>>>           } else {
>>>>               addr = 0;
>>>>           }
>>>> @@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>>> amdgpu_device *adev,
>>>>         r = vm->update_funcs->commit(&params, fence);
>>>>   -    if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
>>>> +    if (flush_tlb || params.table_freed) {
>>>
>>> All change look good to me, but when I look at previous changes 
>>> again, kfd_ioctl_map_memory_to_gpu is not correct now, as this 
>>> should flush TLB if (!kfd_flush_tlb_after_unmap(dev)).
>>>
>>
>> That was intentionally dropped as Felix said it wouldn't be necessary 
>> any more with the TLB flush rework.
>>
>> Is that really causing any trouble?
>
> I discussed it with Philip offline. The TLB flushing in 
> kfd_ioctl_map_memory_to_gpu is still there, but it is no longer 
> conditional on !kfd_flush_tlb_after_unmap. Instead kfd_flush_tlb 
> checks the sequence number to find out if the flush is needed 
> (presumably because we didn't flush after unmap).
>
> There is one case on Vega20+XGMI where PTEs get inadvertently cached 
> in L2 texture cache.

Ah, that one. Yeah I do remember that issue.

> In that case, we probably need to flush more frequently because a 
> cache line in L2 may contain stale invalid PTEs. So kfd_flush_tlb 
> would need to ignore the sequence number and heavy-weight flush TLB 
> unconditionally in this case.

Ok, but I think that is outside of the scope of the VM handling then. Or 
should we somehow handle that in the VM code as well?

I mean incrementing the sequence when the involved BO is mapped through 
XGMI is trivial. I just can't easily signal that we need a heavy-weight 
flush.

Thanks,
Christian.

>
> Regards,
>   Felix
>
>>
>> Christian.
>>
>>> To fix it, seems we need beow change, then pass flush_tlb flag via 
>>> kfd_ioctl_map_memory_to_gpu -> map_bo_to_gpuvm -> update_gpuvm_pte 
>>> -> amdgpu_vm_bo_update
>>>
>>> -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>>> amdgpu_bo_va *bo_va,
>>>             bool clear)
>>>
>>> -    bool flush_tlb = clear;
>>>
>>> +int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>>> amdgpu_bo_va *bo_va,
>>>             bool clear, bool flush_tlb)
>>>
>>> + flush_tlb |= clear;
>>>
>>> Regards,
>>>
>>> Philip
>>>
>>>>           tlb_cb->vm = vm;
>>>>           if (!fence || !*fence ||
>>>>               dma_fence_add_callback(*fence, &tlb_cb->cb,
>>>> @@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>       dma_addr_t *pages_addr = NULL;
>>>>       struct ttm_resource *mem;
>>>>       struct dma_fence **last_update;
>>>> +    bool flush_tlb = clear;
>>>>       struct dma_resv *resv;
>>>> +    uint64_t vram_base;
>>>>       uint64_t flags;
>>>> -    struct amdgpu_device *bo_adev = adev;
>>>>       int r;
>>>>         if (clear || !bo) {
>>>> @@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct 
>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>       }
>>>>         if (bo) {
>>>> +        struct amdgpu_device *bo_adev = adev;
>>>> +
>>>>           flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
>>>>             if (amdgpu_bo_encrypted(bo))
>>>>               flags |= AMDGPU_PTE_TMZ;
>>>>             bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>> +        vram_base = bo_adev->vm_manager.vram_base_offset;
>>>>       } else {
>>>>           flags = 0x0;
>>>> +        vram_base = 0;
>>>>       }
>>>>         if (clear || (bo && bo->tbo.base.resv ==
>>>> @@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>           last_update = &bo_va->last_pt_update;
>>>>         if (!clear && bo_va->base.moved) {
>>>> -        bo_va->base.moved = false;
>>>> +        flush_tlb = true;
>>>>           list_splice_init(&bo_va->valids, &bo_va->invalids);
>>>>         } else if (bo_va->cleared != clear) {
>>>> @@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct 
>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>             trace_amdgpu_vm_bo_update(mapping);
>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, 
>>>> false, false,
>>>> -                        resv, mapping->start,
>>>> -                        mapping->last, update_flags,
>>>> -                        mapping->offset, mem,
>>>> -                        pages_addr, last_update);
>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
>>>> +                       resv, mapping->start, mapping->last,
>>>> +                       update_flags, mapping->offset,
>>>> +                       vram_base, mem, pages_addr,
>>>> +                       last_update);
>>>>           if (r)
>>>>               return r;
>>>>       }
>>>> @@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>         list_splice_init(&bo_va->invalids, &bo_va->valids);
>>>>       bo_va->cleared = clear;
>>>> +    bo_va->base.moved = false;
>>>>         if (trace_amdgpu_vm_bo_mapping_enabled()) {
>>>>           list_for_each_entry(mapping, &bo_va->valids, list)
>>>> @@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct 
>>>> amdgpu_device *adev,
>>>>               mapping->start < AMDGPU_GMC_HOLE_START)
>>>>               init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>>> false,
>>>> -                        resv, mapping->start,
>>>> -                        mapping->last, init_pte_value,
>>>> -                        0, NULL, NULL, &f);
>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, true, 
>>>> resv,
>>>> +                       mapping->start, mapping->last,
>>>> +                       init_pte_value, 0, 0, NULL, NULL,
>>>> +                       &f);
>>>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>           if (r) {
>>>>               dma_fence_put(f);
>>>> @@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct 
>>>> amdgpu_device *adev, u32 pasid,
>>>>           goto error_unlock;
>>>>       }
>>>>   -    r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, 
>>>> NULL, addr,
>>>> -                    addr, flags, value, NULL, NULL, NULL);
>>>> +    r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, 
>>>> addr,
>>>> +                   addr, flags, value, 0, NULL, NULL, NULL);
>>>>       if (r)
>>>>           goto error_unlock;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 6b7682fe84f8..1a814fbffff8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct 
>>>> amdgpu_device *adev,
>>>>                  struct amdgpu_vm *vm);
>>>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>> -                struct amdgpu_device *bo_adev,
>>>> -                struct amdgpu_vm *vm, bool immediate,
>>>> -                bool unlocked, struct dma_resv *resv,
>>>> -                uint64_t start, uint64_t last,
>>>> -                uint64_t flags, uint64_t offset,
>>>> -                struct ttm_resource *res,
>>>> -                dma_addr_t *pages_addr,
>>>> -                struct dma_fence **fence);
>>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>>> amdgpu_vm *vm,
>>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>>> +               struct dma_resv *resv, uint64_t start, uint64_t last,
>>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>>> +               struct dma_fence **fence);
>>>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>>               struct amdgpu_bo_va *bo_va,
>>>>               bool clear);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 27533f6057e0..907b02045824 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>>         pr_debug("[0x%llx 0x%llx]\n", start, last);
>>>>   -    return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>>> true, NULL,
>>>> -                       start, last, init_pte_value, 0,
>>>> -                       NULL, NULL, fence);
>>>> +    return amdgpu_vm_update_range(adev, vm, false, true, true, 
>>>> NULL, start,
>>>> +                      last, init_pte_value, 0, 0, NULL, NULL,
>>>> +                      fence);
>>>>   }
>>>>     static int
>>>> @@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct 
>>>> kfd_process_device *pdd, struct svm_range *prange,
>>>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>>>                pte_flags);
>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, 
>>>> false, false,
>>>> -                        NULL, last_start,
>>>> -                        prange->start + i, pte_flags,
>>>> -                        last_start - prange->start,
>>>> -                        NULL, dma_addr,
>>>> -                        &vm->last_update);
>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, false, 
>>>> NULL,
>>>> +                       last_start, prange->start + i,
>>>> +                       pte_flags,
>>>> +                       last_start - prange->start,
>>>> + bo_adev->vm_manager.vram_base_offset,
>>>> +                       NULL, dma_addr, &vm->last_update);
>>>>             for (j = last_start - prange->start; j <= i; j++)
>>>>               dma_addr[j] |= last_domain;
>>

