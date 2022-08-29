Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2B2ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 18:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF4610E4B5;
	Mon, 29 Aug 2022 18:59:28 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778E110E4B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 18:59:24 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id lx1so17522966ejb.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=aPeKcE8fzM/Iq/OzwS/5Ym0zVURyFn2uUuTt30ZGs1U=;
 b=ctQ2YP1ahy7XLSBcBY35cju/Som4DX6vlkntKKaITGzsYJCeRj2Qus8KEbtRnL5buB
 WmmOI7McjM/ROpF8S+LEiX3bFps53F9X0+5KzfU/c23A82DTp9wwKCAQiB0OWV03KNUb
 ajbXhoYQ9/BIQd1EGqLIq+GYk1BnFQxL+AX5QJ9gakVj07/bh5zg4wjr6qo32Tdpy3LQ
 zwxHy0OKVp2fgCdivAq0f1awbEP2t8axUN2l593VfEu4REdL+eNVpxezpuqaEnTCyABh
 tX9tJApVTXaplSPPffX9l0fLj5a5QtI1DZzfS0oXJB5XfFCjx3CNgsWdCR4eGSx0SBRT
 Ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=aPeKcE8fzM/Iq/OzwS/5Ym0zVURyFn2uUuTt30ZGs1U=;
 b=peDuzfJaVrp3L5gd57wbekD85jdZnbNbPahwFtq/hXA2LFh/iS4pXM1qlnxsbrosSC
 fBqLKzamqwYbUcru2ih/Dpomm5R/5nC0vb0yAjLJaPv+bHQdEiSdVeCe0N01acOrX+fK
 IcrgoIvgNOOYxtmUPEETwitGdF6ja8LL+HtOGkuE4GqAduRo/2k/RHRSBHc50RCVuB5s
 NukYNfDQEZHvwxDDjrTkVoKaj3/2dnMNB5yms7hSaqxHrPbA7Ya7dQB55UDOMcl1UbIx
 wzIwAwms6W1Z2uPZVFyYCIOxsFsM8KBVSt9bsswJLl7V7zmHcTetYz8+WceRUMQ9iItC
 CAZQ==
X-Gm-Message-State: ACgBeo0I5c9n/Zr2xk7EYdNOI0VdRXP8f04hHVCE3OORCP2ROny42Zhk
 dZ16aJg0wqdDtwWmRxzXAQyhxf5i/Qs=
X-Google-Smtp-Source: AA6agR6HIm9VMFVJfx9z4pcQROjT/10G5CyS/xdhrJc3PhUhlsU8IDVHdBu3N2TQnnpcjT10lH3fOg==
X-Received: by 2002:a17:906:dc89:b0:731:67eb:b60b with SMTP id
 cs9-20020a170906dc8900b0073167ebb60bmr13995630ejc.614.1661799562955; 
 Mon, 29 Aug 2022 11:59:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:835b:9e1b:adab:38e8?
 ([2a02:908:1256:79a0:835b:9e1b:adab:38e8])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a170906198600b0073dc6def190sm4747617ejd.158.2022.08.29.11.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Aug 2022 11:59:22 -0700 (PDT)
Message-ID: <b349a15b-7ac7-4358-bbc2-d5952a891448@gmail.com>
Date: Mon, 29 Aug 2022 20:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220826231654.335169-1-Felix.Kuehling@amd.com>
 <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
 <09f808fb-908c-477e-5470-cdd75b539273@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <09f808fb-908c-477e-5470-cdd75b539273@amd.com>
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

Am 29.08.22 um 18:07 schrieb Felix Kuehling:
> Am 2022-08-29 um 11:38 schrieb Christian König:
>> Am 27.08.22 um 01:16 schrieb Felix Kuehling:
>>> BOs can be in a different location than was intended at allocation 
>>> time,
>>> for example when restoring fails after an eviction or BOs get pinned in
>>> system memory. On some GPUs the MTYPE for coherent mappings depends on
>>> the actual memory location.
>>>
>>> Use the actual location to determine the pte_flags every time the page
>>> tables are updated.
>>
>> For a workaround ok, but looks a bit awkward. Basically we need 
>> different MTYPE based on the location, right?
>
> Yes. On Aldebaran and Arcturus we need different MTYPEs for 
> fine-grained coherence depending on the location.

It would be much cleaner to have a better description how all this came 
to be in the mapping.

E.g. that we generate the flags in the VM code based on the requirements 
described in the mapping.

Do we have time to clean this up thoughtfully?

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Christian.
>>
>>>
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 
>>> +++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
>>>   3 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index cbd593f7d553..5dd89f5a032f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, 
>>> struct amdgpu_sync *sync)
>>>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct 
>>> kgd_mem *mem)
>>>   {
>>>       struct amdgpu_device *bo_adev = 
>>> amdgpu_ttm_adev(mem->bo->tbo.bdev);
>>> +    bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
>>>       bool coherent = mem->alloc_flags & 
>>> KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>>>       bool uncached = mem->alloc_flags & 
>>> KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
>>>       uint32_t mapping_flags;
>>> @@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct 
>>> amdgpu_device *adev, struct kgd_mem *mem)
>>>       switch (adev->asic_type) {
>>>       case CHIP_ARCTURUS:
>>>       case CHIP_ALDEBARAN:
>>> -        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>> +        if (is_vram) {
>>>               if (bo_adev == adev) {
>>>                   if (uncached)
>>>                       mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>> @@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct kgd_mem 
>>> *mem,
>>>   {
>>>       struct amdgpu_bo_va *bo_va = entry->bo_va;
>>>       struct amdgpu_device *adev = entry->adev;
>>> +    uint64_t pte_flags = get_pte_flags(adev, mem);
>>>       int ret;
>>>         ret = kfd_mem_dmamap_attachment(mem, entry);
>>>       if (ret)
>>>           return ret;
>>>   +    if (unlikely(entry->pte_flags != pte_flags)) {
>>> +        amdgpu_vm_bo_update_flags(bo_va, pte_flags);
>>> +        entry->pte_flags = pte_flags;
>>> +    }
>>> +
>>>       /* Update the page tables  */
>>>       ret = amdgpu_vm_bo_update(adev, bo_va, false);
>>>       if (ret) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 59cac347baa3..954a40d5d828 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct 
>>> amdgpu_device *adev,
>>>       }
>>>   }
>>>   +/**
>>> + * amdgpu_vm_bo_update_flags - Update mapping flags of invalid 
>>> mappings
>>> + *
>>> + * @bo_va: identifies the BO and VM
>>> + * @flags: new mapping flags
>>> + *
>>> + * The update is only applied to invalid mappings. This allows 
>>> updating the
>>> + * mapping flags after a migration to maintain the desired 
>>> coherence. The next
>>> + * call to amdgpu_vm_bo_update() will apply the new @flags to the 
>>> page table.
>>> + */
>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
>>> +                   uint64_t flags)
>>> +{
>>> +    struct amdgpu_bo_va_mapping *mapping;
>>> +
>>> +    list_for_each_entry(mapping, &bo_va->invalids, list)
>>> +        mapping->flags = flags;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vm_get_block_size - calculate VM page table size as 
>>> power of two
>>>    *
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 9ecb7f663e19..11793716cd8b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>>   void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>>>                    struct amdgpu_bo *bo, bool evicted);
>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, uint64_t 
>>> flags);
>>>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t 
>>> addr);
>>>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>>                          struct amdgpu_bo *bo);
>>

