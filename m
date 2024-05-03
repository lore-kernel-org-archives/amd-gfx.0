Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92265C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 06:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69C0112825;
	Fri,  3 May 2024 06:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQmNGCXu";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF4B112825
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 06:27:01 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-41b5dd5af48so62945655e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714717619; x=1715322419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YojqVxA/6AyH+MnBiZBXg4cgTYpnSMOc0hqo/xN1p/o=;
 b=YQmNGCXu3Tnl4LYkuqjal97gcNiKiynGJTTjjJAOlfi1K7vPoWT+LgDBAgAXlowuTa
 +YNrCoF+qRDoHk1P9vwDcGA+JgXeKVaeLc21c8u2e3HxgwAFpL5aGZcePHwmUa2SAkfr
 oSXmSgQOKbXuug3BugvLgHgYcJ4T9g08hsiOA9HNWPrDRo+ShB1vZIe02HzQ/9dmYppR
 PkIF+vGWXgXYAQocCSeQzRAnHe1h08KqCiVyLoPZ1o/fbchr+mMUp3E/lN9W7L463Mj0
 bSlNM4wSolMi3ygelKkpceCDokm/RLBTcwc6UBvxyW3+WVxjyTTroXoentew0vlVD92/
 Xo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714717619; x=1715322419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YojqVxA/6AyH+MnBiZBXg4cgTYpnSMOc0hqo/xN1p/o=;
 b=Drpgr1DTMo7H5GRVsTywau/xuwkt9FEP1WqNu+O7hlF7QZtqTceleoWA8jRrS0a27H
 viFjk2JGAuqJRjPWazKmT47WqRbuiwGfmZyp7WpCQ8ODqMEf8IaUvbP06NckWVAXXIQj
 rTwmlNW6IgW1KkjL87xbtNq0qeuNzD9TmFQx/s8Z0Qh7lZ/O1Y5KfPQrcP7iLvYxe597
 C0G2HtPpRHozUJ4Ou25xUgMhD1eNQCfMK7yCurpL/dvzYiU9/pXfS3FwGFwapp5dJZSM
 zxAyn/KJXdT7G31vgQEerH3ElTCdLZODHT7NUliH29E4i0x+OEsd+GqHzWX0J1b1CdM5
 OD3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkvYBQC2n+G06GoGa2tsyoeHb1CVR/I5Xq/y4N7KhNrr/j7yppqnE4YZiHu4zPGe1FowA7jhGa1yla48ruxAV0pw8y1jDRhd98EdSy9A==
X-Gm-Message-State: AOJu0YyEhdWUfFTOwncc4SHEdCNThK2n+gwBtuEtuL2f7DNgQUeTSB5r
 nemvg9fS/U8v2ResS8D86t71ysZguR3huPXwqyWjiKflLtRGQNEi
X-Google-Smtp-Source: AGHT+IFakqhwk4CPjIovfrPymMfT3LlnhCA1j9PqMHw4X9+M3tWKH6vTPOeIiw/0LLu/NKnuki5zVQ==
X-Received: by 2002:a05:600c:3112:b0:419:f3f9:8ed6 with SMTP id
 g18-20020a05600c311200b00419f3f98ed6mr1343948wmo.4.1714717619294; 
 Thu, 02 May 2024 23:26:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ay35-20020a05600c1e2300b00419f419236fsm4457217wmb.41.2024.05.02.23.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 23:26:58 -0700 (PDT)
Message-ID: <bcbd2c3f-30c2-4e98-93d6-b752ae3a0a0f@gmail.com>
Date: Fri, 3 May 2024 08:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240429164707.49196-1-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240429164707.49196-1-tursulin@igalia.com>
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



Am 29.04.24 um 18:47 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Help code readability by replacing a bunch of:
>
> bo->tbo.base.resv == vm->root.bo->tbo.base.resv
>
> With:
>
> amdgpu_vm_is_bo_always_valid(vm, bo)
>
> No functional changes.
>
> v2:
>   * Rename helper and move to amdgpu_vm. (Christian)
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 +++++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>   3 files changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 67c234bcf89f..e698d65e9508 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		return -EPERM;
>   
>   	if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
> -	    abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> +	    !amdgpu_vm_is_bo_always_valid(vm, abo))
>   		return -EPERM;
>   
>   	r = amdgpu_bo_reserve(abo, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..01ca4b35b369 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> -	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		return;
>   
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> @@ -1101,13 +1101,13 @@ static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
>   	 * For now ignore BOs which are currently locked and potentially
>   	 * changing their location.
>   	 */
> -	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>   	    !dma_resv_trylock(bo->tbo.base.resv))
>   		return;
>   
>   	amdgpu_bo_get_memory(bo, stats);
> -	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> -	    dma_resv_unlock(bo->tbo.base.resv);
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo))
> +		dma_resv_unlock(bo->tbo.base.resv);
>   }
>   
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
> @@ -1203,8 +1203,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		uncached = false;
>   	}
>   
> -	if (clear || (bo && bo->tbo.base.resv ==
> -		      vm->root.bo->tbo.base.resv))
> +	if (clear || amdgpu_vm_is_bo_always_valid(vm, bo))
>   		last_update = &vm->last_update;
>   	else
>   		last_update = &bo_va->last_pt_update;
> @@ -1246,7 +1245,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	 * the evicted list so that it gets validated again on the
>   	 * next command submission.
>   	 */
> -	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
>   		uint32_t mem_type = bo->tbo.resource->mem_type;
>   
>   		if (!(bo->preferred_domains &
> @@ -1640,10 +1639,9 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	if (mapping->flags & AMDGPU_PTE_PRT)
>   		amdgpu_vm_prt_get(adev);
>   
> -	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> -	    !bo_va->base.moved) {
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>   		amdgpu_vm_bo_moved(&bo_va->base);
> -	}
> +
>   	trace_amdgpu_vm_bo_map(bo_va, mapping);
>   }
>   
> @@ -1922,7 +1920,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   		if (before->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
>   
> -		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> +		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>   		    !before->bo_va->base.moved)
>   			amdgpu_vm_bo_moved(&before->bo_va->base);
>   	} else {
> @@ -1937,7 +1935,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   		if (after->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
>   
> -		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> +		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>   		    !after->bo_va->base.moved)
>   			amdgpu_vm_bo_moved(&after->bo_va->base);
>   	} else {
> @@ -2017,7 +2015,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   
>   	if (bo) {
>   		dma_resv_assert_held(bo->tbo.base.resv);
> -		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
> +		if (amdgpu_vm_is_bo_always_valid(vm, bo))
>   			ttm_bo_set_bulk_move(&bo->tbo, NULL);
>   
>   		for (base = &bo_va->base.bo->vm_bo; *base;
> @@ -2111,7 +2109,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		if (evicted && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
> +		if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
>   			amdgpu_vm_bo_evicted(bo_base);
>   			continue;
>   		}
> @@ -2122,7 +2120,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   
>   		if (bo->tbo.type == ttm_bo_type_kernel)
>   			amdgpu_vm_bo_relocated(bo_base);
> -		else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
> +		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
>   			amdgpu_vm_bo_moved(bo_base);
>   		else
>   			amdgpu_vm_bo_invalidated(bo_base);
> @@ -2986,3 +2984,15 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>   	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
>   
> +/**
> + * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
> + *
> + * @vm: VM to test against.
> + * @abo: BO to be tested.
> + *
> + * Returns true if the BO is VM always valid.

Maybe improve that a bit, e.g. something like this:

"Returns true if the BO shares the dma_resv object with the root PD and 
is always guaranteed to be valid inside the VM."

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

> + */
> +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
> +{
> +	return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 54d7da396de0..ec688a47dec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -561,6 +561,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>   
>   int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   
> +bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> +
>   /**
>    * amdgpu_vm_tlb_seq - return tlb flush sequence number
>    * @vm: the amdgpu_vm structure to query

