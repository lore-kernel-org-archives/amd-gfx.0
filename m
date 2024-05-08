Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D07C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 05:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433F511333D;
	Wed,  8 May 2024 05:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lrn8k3OA";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814B210F43B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 05:43:03 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-41b794510cdso30965255e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 May 2024 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715146982; x=1715751782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Xkff9jv55gsrFkYh/8OlntFt6Z6Awn/xSOkFq5qsi4=;
 b=Lrn8k3OAuj2WmRg8tXyyLZ262IDW8aYxjLqECOSEADMRYgsbZWNW3DQ0j9udODbPQg
 i5UrvjUr67oW3z+ImuyuCRlHMR8Zwv43pq5LZ/pdhsEbV2ONVqaccU0hUAupJ2/E3ezk
 SKpdBibSJHkCVBaQvmf17ObmGK5Th2zH1mLxWklt9iQREg6PyLwiMS7YJFkQozbYNEqK
 rK7tylHy9CU3uRDYICygnc46Tn51JG4IKBghIlHQPHBvAfPGwgzl1652+cJF6v4VpFFS
 76XFT43NQGn+94N1BMSghTyf05l9TSSl64XvTYBPoFXIs3h6w0D/7jrGR2kkod88EBsU
 RUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715146982; x=1715751782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Xkff9jv55gsrFkYh/8OlntFt6Z6Awn/xSOkFq5qsi4=;
 b=COHkympUM/nK18S7KkiomAmpXAXR9ia8RvHQRyBXGMlTL7XJ46uqpV2n4exIMUOisV
 O4ddHv8q/qZ/JzBfCI1hOrfl3hxKqsuaY7WEsE+UTmA9794tiLCBIpN5E3rMkuse949d
 n+I8nSASpRBVcA78pAh8ia5cd9TAXPs0fDVvU2IIkrcbaCKyfx1RPZQIfiEzPFQ3NQEe
 fGX7GmEKKEd4/2xzv7H795b45Rm3Bn11P/CKOSwDQXndOGvoWaLBGeQTm8RXX9HoTdPI
 MBoB9rDv7drDdsT3IPTVDg7LBuZvlS+TY4D1hzW6avDJEHDt4JONTBbs9cxSXcGffk7i
 ztcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEbZ8FicwGish97KyOjEOyDkurMRg8fbcODK8d0DVKcHSWz7ZLqRsYh1DnhZqGzQlqtO6WI8/SRo1TfnfzK4JvWUasY1orsInwxiJycw==
X-Gm-Message-State: AOJu0YyxRtIC2sTsJN+jtjCQLmArp7rU2iKYYY1ZkOdUgEXMGylKQ6Br
 ANFaSLQc4bm9DR3Ae4ulJiakfz2jSsN7rqFVqGndbrG65KxC+hTG
X-Google-Smtp-Source: AGHT+IFAiWlfcETHov+8lyTuDKijrxiNTQ0aSgzfJKCXOT6k89vvjeTzF0/+UacBH10a9FoeElxbow==
X-Received: by 2002:a05:600c:1c0f:b0:41b:e6f8:bf31 with SMTP id
 5b1f17b1804b1-41f71309ed6mr14412055e9.15.1715146981416; 
 Tue, 07 May 2024 22:43:01 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 iv19-20020a05600c549300b0041bbec72670sm938551wmb.39.2024.05.07.22.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 22:43:00 -0700 (PDT)
Message-ID: <7361a70b-656b-4de3-bf63-5a913bdfc5fe@gmail.com>
Date: Wed, 8 May 2024 07:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20240503091500.7768-1-tursulin@igalia.com>
 <48fd5f77-9a5f-43a3-8009-e1655cb447bc@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <48fd5f77-9a5f-43a3-8009-e1655cb447bc@igalia.com>
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

Am 06.05.24 um 18:26 schrieb Tvrtko Ursulin:
>
> On 03/05/2024 10:14, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Help code readability by replacing a bunch of:
>>
>> bo->tbo.base.resv == vm->root.bo->tbo.base.resv
>>
>> With:
>>
>> amdgpu_vm_is_bo_always_valid(vm, bo)
>>
>> No functional changes.
>>
>> v2:
>>   * Rename helper and move to amdgpu_vm. (Christian)
>>
>> v3:
>>   * Use Christian's kerneldoc.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 41 ++++++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>>   3 files changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 67c234bcf89f..e698d65e9508 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>           return -EPERM;
>>         if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
>> -        abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>> +        !amdgpu_vm_is_bo_always_valid(vm, abo))
>>           return -EPERM;
>>         r = amdgpu_bo_reserve(abo, false);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 4e2391c83d7c..d451ff9d5af4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct 
>> amdgpu_vm_bo_base *base,
>>       base->next = bo->vm_bo;
>>       bo->vm_bo = base;
>>   -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>           return;
>>         dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> @@ -1101,13 +1101,13 @@ static void amdgpu_vm_bo_get_memory(struct 
>> amdgpu_bo_va *bo_va,
>>        * For now ignore BOs which are currently locked and potentially
>>        * changing their location.
>>        */
>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
>> +    if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>           !dma_resv_trylock(bo->tbo.base.resv))
>>           return;
>>         amdgpu_bo_get_memory(bo, stats);
>> -    if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>> -        dma_resv_unlock(bo->tbo.base.resv);
>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo))
>
> Beware the logic inversion here - luckily no one merged it yet! I will 
> send a respin..

Let me know when that is done, I was about to merge it.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>> + dma_resv_unlock(bo->tbo.base.resv);
>>   }
>>     void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>> @@ -1203,8 +1203,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>> *adev, struct amdgpu_bo_va *bo_va,
>>           uncached = false;
>>       }
>>   -    if (clear || (bo && bo->tbo.base.resv ==
>> -              vm->root.bo->tbo.base.resv))
>> +    if (clear || amdgpu_vm_is_bo_always_valid(vm, bo))
>>           last_update = &vm->last_update;
>>       else
>>           last_update = &bo_va->last_pt_update;
>> @@ -1246,7 +1245,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>> *adev, struct amdgpu_bo_va *bo_va,
>>        * the evicted list so that it gets validated again on the
>>        * next command submission.
>>        */
>> -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
>>           uint32_t mem_type = bo->tbo.resource->mem_type;
>>             if (!(bo->preferred_domains &
>> @@ -1640,10 +1639,9 @@ static void amdgpu_vm_bo_insert_map(struct 
>> amdgpu_device *adev,
>>       if (mapping->flags & AMDGPU_PTE_PRT)
>>           amdgpu_vm_prt_get(adev);
>>   -    if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>> -        !bo_va->base.moved) {
>> +    if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>           amdgpu_vm_bo_moved(&bo_va->base);
>> -    }
>> +
>>       trace_amdgpu_vm_bo_map(bo_va, mapping);
>>   }
>>   @@ -1942,7 +1940,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>> amdgpu_device *adev,
>>           if (before->flags & AMDGPU_PTE_PRT)
>>               amdgpu_vm_prt_get(adev);
>>   -        if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>               !before->bo_va->base.moved)
>> amdgpu_vm_bo_moved(&before->bo_va->base);
>>       } else {
>> @@ -1957,7 +1955,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>> amdgpu_device *adev,
>>           if (after->flags & AMDGPU_PTE_PRT)
>>               amdgpu_vm_prt_get(adev);
>>   -        if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>               !after->bo_va->base.moved)
>>               amdgpu_vm_bo_moved(&after->bo_va->base);
>>       } else {
>> @@ -2037,7 +2035,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>         if (bo) {
>>           dma_resv_assert_held(bo->tbo.base.resv);
>> -        if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>> +        if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>               ttm_bo_set_bulk_move(&bo->tbo, NULL);
>>             for (base = &bo_va->base.bo->vm_bo; *base;
>> @@ -2131,7 +2129,7 @@ void amdgpu_vm_bo_invalidate(struct 
>> amdgpu_device *adev,
>>       for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>           struct amdgpu_vm *vm = bo_base->vm;
>>   -        if (evicted && bo->tbo.base.resv == 
>> vm->root.bo->tbo.base.resv) {
>> +        if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
>>               amdgpu_vm_bo_evicted(bo_base);
>>               continue;
>>           }
>> @@ -2142,7 +2140,7 @@ void amdgpu_vm_bo_invalidate(struct 
>> amdgpu_device *adev,
>>             if (bo->tbo.type == ttm_bo_type_kernel)
>>               amdgpu_vm_bo_relocated(bo_base);
>> -        else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>> +        else if (amdgpu_vm_is_bo_always_valid(vm, bo))
>>               amdgpu_vm_bo_moved(bo_base);
>>           else
>>               amdgpu_vm_bo_invalidated(bo_base);
>> @@ -3006,3 +3004,16 @@ void amdgpu_vm_update_fault_cache(struct 
>> amdgpu_device *adev,
>>       xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>   }
>>   +/**
>> + * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>> + *
>> + * @vm: VM to test against.
>> + * @abo: BO to be tested.
>> + *
>> + * Returns true if the BO shares the dma_resv object with the root 
>> PD and is
>> + * always guaranteed to be valid inside the VM.
>> + */
>> +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct 
>> amdgpu_bo *bo)
>> +{
>> +    return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 54d7da396de0..ec688a47dec1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -561,6 +561,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm 
>> *vm, struct seq_file *m);
>>     int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm);
>>   +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct 
>> amdgpu_bo *bo);
>> +
>>   /**
>>    * amdgpu_vm_tlb_seq - return tlb flush sequence number
>>    * @vm: the amdgpu_vm structure to query

