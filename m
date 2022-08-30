Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F76ECAAD1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 06:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5EB10E2F7;
	Tue, 30 Aug 2022 06:00:46 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1644510E63E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 06:00:42 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id z8so3971010edb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 23:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=0ATL6lwNPyzvw2sj3AM0Iezo54B1U88cO8UNYdgNKR4=;
 b=qSe5ybqNwdUcpWXmW1mD9ObkPJMiRyJZgYyEuN1L/Gxuc4mEo42h8GTQbmp3mVohGP
 WGL16t+Za9J8he0BrLqktshmD2gKPWH9FGoBNw3aDyGFmZaGsiyJCuCE3BilUh6Yhjpi
 7osr9fLuLfshFvuF/mB5GtcBT9WttvvX/p8dTaGVGSaerA22As/oq+nIc/U6oYTgkAk3
 3MktnlB1P4xaks1NNyZXx0a1mKwmKe5iPnuTa8zIfFQBned/WS3MlrXvyIByZ1k7nNYK
 +7/JJYS91Jr+fy+yLswieteIT8m9gg7x/SVWe3hVftlhtwSYZK6qtwW5BCUQcjPqGmKO
 fxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=0ATL6lwNPyzvw2sj3AM0Iezo54B1U88cO8UNYdgNKR4=;
 b=XorPqR28xT/viULB8FVUTQY8PnGA+O1rySWTZ20FP6lpmdHOq2Y7IvH34DyQ1EZzhc
 9WFEh+YoYZ6NFdWzkqiwt0XlMl3HVuTa/urc+WuE05hHDku+VseNqrUARyUBnLrmgZtu
 ZNKxpZ4Cu2580i1zhNEc7ZzlXJbJVB0KLLmfOSfsesAf6UHCNe3NFFRtm0iw+QUbZ0w/
 /49WWXCqGDRDp8CSTd0atQx3oJ59P/TrkfsNZqOOs21m5i0e/E4ohFO0RlZPrcf/VJDv
 +w1Kvakb5N+26PGAoc4FoeJOInxsOjbO8IzMP4xyfQlBKZJiTHAlJF4TwizYSvUzxz1P
 +ceQ==
X-Gm-Message-State: ACgBeo1SDo1ZEiIP6bRwlnr0YOg3T4L0McgzNRA81EPzVPPbrhpPJcPV
 aYBfo3HjCB6kaG9D2d+pP7g=
X-Google-Smtp-Source: AA6agR4voOb35olsrjuFSZ0yw6p4CH/SPoQIqmZqEamOJ8rEsoJsiUysE77BV4z140EP6EwtrS/8QA==
X-Received: by 2002:a50:baea:0:b0:448:182d:9bc2 with SMTP id
 x97-20020a50baea000000b00448182d9bc2mr11879097ede.341.1661839240518; 
 Mon, 29 Aug 2022 23:00:40 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ad4.dip0.t-ipconnect.de.
 [79.194.10.212]) by smtp.gmail.com with ESMTPSA id
 o20-20020a170906769400b0073306218484sm1858990ejm.26.2022.08.29.23.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Aug 2022 23:00:39 -0700 (PDT)
Message-ID: <c5e6912f-215e-8c6d-8946-b2a9bebd8668@gmail.com>
Date: Tue, 30 Aug 2022 08:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220826231654.335169-1-Felix.Kuehling@amd.com>
 <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
 <09f808fb-908c-477e-5470-cdd75b539273@amd.com>
 <b349a15b-7ac7-4358-bbc2-d5952a891448@gmail.com>
 <5d877fee-ec7a-0c17-c72f-ca3569a3ef8b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5d877fee-ec7a-0c17-c72f-ca3569a3ef8b@amd.com>
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

Am 29.08.22 um 21:30 schrieb Felix Kuehling:
>
> Am 2022-08-29 um 14:59 schrieb Christian König:
>> Am 29.08.22 um 18:07 schrieb Felix Kuehling:
>>> Am 2022-08-29 um 11:38 schrieb Christian König:
>>>> Am 27.08.22 um 01:16 schrieb Felix Kuehling:
>>>>> BOs can be in a different location than was intended at allocation 
>>>>> time,
>>>>> for example when restoring fails after an eviction or BOs get 
>>>>> pinned in
>>>>> system memory. On some GPUs the MTYPE for coherent mappings 
>>>>> depends on
>>>>> the actual memory location.
>>>>>
>>>>> Use the actual location to determine the pte_flags every time the 
>>>>> page
>>>>> tables are updated.
>>>>
>>>> For a workaround ok, but looks a bit awkward. Basically we need 
>>>> different MTYPE based on the location, right?
>>>
>>> Yes. On Aldebaran and Arcturus we need different MTYPEs for 
>>> fine-grained coherence depending on the location.
>>
>> It would be much cleaner to have a better description how all this 
>> came to be in the mapping.
>>
>> E.g. that we generate the flags in the VM code based on the 
>> requirements described in the mapping.
>>
>> Do we have time to clean this up thoughtfully?
>
> Currently we have two places in the KFD code that generates the 
> mapping flags. I was planning to eliminate the duplication. I think 
> you're suggesting moving it into the amdgpu_vm code instead. 
> Unfortunately it's somewhat GPU-specific. So you probably won't like 
> this code in the general amdgpu_vm code. Maybe the HW-specific part 
> should be in gmc_v*.c.

We have the gmc_v*_get_vm_pte() and gmc_v*_get_vm_pde() functions 
exactly for that.

>
> The requirements would include:
>
>  * Memory type and mapping (local, system, PCIe P2P, XGMI P2P)
>  * Memory model (coarse-grained or fine-grained coherence)

Question is if any of this is a per BO or per mapping information?

For the gfx side we unfortunately have put the MTYPE into the mapping 
(which turned out to be a bad idea).

So as far as I understand it the MTYPE should rather be obtained from 
per buffer flags and the current placement, correct?

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> ---
>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 
>>>>> +++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
>>>>>   3 files changed, 28 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index cbd593f7d553..5dd89f5a032f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, 
>>>>> struct amdgpu_sync *sync)
>>>>>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct 
>>>>> kgd_mem *mem)
>>>>>   {
>>>>>       struct amdgpu_device *bo_adev = 
>>>>> amdgpu_ttm_adev(mem->bo->tbo.bdev);
>>>>> +    bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
>>>>>       bool coherent = mem->alloc_flags & 
>>>>> KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>>>>>       bool uncached = mem->alloc_flags & 
>>>>> KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
>>>>>       uint32_t mapping_flags;
>>>>> @@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct 
>>>>> amdgpu_device *adev, struct kgd_mem *mem)
>>>>>       switch (adev->asic_type) {
>>>>>       case CHIP_ARCTURUS:
>>>>>       case CHIP_ALDEBARAN:
>>>>> -        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>>> +        if (is_vram) {
>>>>>               if (bo_adev == adev) {
>>>>>                   if (uncached)
>>>>>                       mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>>> @@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct kgd_mem 
>>>>> *mem,
>>>>>   {
>>>>>       struct amdgpu_bo_va *bo_va = entry->bo_va;
>>>>>       struct amdgpu_device *adev = entry->adev;
>>>>> +    uint64_t pte_flags = get_pte_flags(adev, mem);
>>>>>       int ret;
>>>>>         ret = kfd_mem_dmamap_attachment(mem, entry);
>>>>>       if (ret)
>>>>>           return ret;
>>>>>   +    if (unlikely(entry->pte_flags != pte_flags)) {
>>>>> +        amdgpu_vm_bo_update_flags(bo_va, pte_flags);
>>>>> +        entry->pte_flags = pte_flags;
>>>>> +    }
>>>>> +
>>>>>       /* Update the page tables  */
>>>>>       ret = amdgpu_vm_bo_update(adev, bo_va, false);
>>>>>       if (ret) {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 59cac347baa3..954a40d5d828 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct 
>>>>> amdgpu_device *adev,
>>>>>       }
>>>>>   }
>>>>>   +/**
>>>>> + * amdgpu_vm_bo_update_flags - Update mapping flags of invalid 
>>>>> mappings
>>>>> + *
>>>>> + * @bo_va: identifies the BO and VM
>>>>> + * @flags: new mapping flags
>>>>> + *
>>>>> + * The update is only applied to invalid mappings. This allows 
>>>>> updating the
>>>>> + * mapping flags after a migration to maintain the desired 
>>>>> coherence. The next
>>>>> + * call to amdgpu_vm_bo_update() will apply the new @flags to the 
>>>>> page table.
>>>>> + */
>>>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
>>>>> +                   uint64_t flags)
>>>>> +{
>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>> +
>>>>> +    list_for_each_entry(mapping, &bo_va->invalids, list)
>>>>> +        mapping->flags = flags;
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * amdgpu_vm_get_block_size - calculate VM page table size as 
>>>>> power of two
>>>>>    *
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 9ecb7f663e19..11793716cd8b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>>> *adev,
>>>>>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>>>>   void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>>>>>                    struct amdgpu_bo *bo, bool evicted);
>>>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, 
>>>>> uint64_t flags);
>>>>>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, 
>>>>> uint64_t addr);
>>>>>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>>>>                          struct amdgpu_bo *bo);
>>>>
>>

