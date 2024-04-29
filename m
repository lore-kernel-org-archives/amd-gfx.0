Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80007C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 11:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF12310E650;
	Mon, 29 Apr 2024 11:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OlFVRulz";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4457010E650
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 11:02:17 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-41bab13ca81so24971825e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714388535; x=1714993335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oz+2NKm5T9d8uJwVUGq6v8bTNi8yhrzIupOLSa/498w=;
 b=OlFVRulzUmdm2A4JBvNF5QuD1/tU4UOeVDv2vVz4oTGF8ETvNbzEpk8/BehGx/aJ91
 mhUp+jSA0Ff5dx4Qne6T+EHJqWIkSrsicI+WOWPbd8Z/7P1McFguGXuxzwhbRwRs1BRf
 6Ox8ryoM6jfUj4/85pEFMYR8WfEgo8f8/T52m49nSzzlcsvSYSlNWomtU60JeJvsYarb
 DcjIqg5ay7CmObb6cv7Ip34Rrfh2AdvjBWjZNbI7Wfj4jwCrMzAxgny9a4GLvMJzGS58
 hGiZ5p51BDX5KLh3tELrIJYlPpM2oJjVV87bAoSY8HxXS3KthTF3oKeaCqaFJW8PA/RM
 oK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388535; x=1714993335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oz+2NKm5T9d8uJwVUGq6v8bTNi8yhrzIupOLSa/498w=;
 b=YSS9SLrU2KVFUI+80KZbukaqZPhqs6pCdp8CeOWfsT4Wzk3aWy2os6FOanGcfBXrUQ
 vrOU14k/d2HPVHu6/fT4dE6+1wEeNxtHDyQQXWB/i/A2wa0pds+t73S8/WeawjxmwsYM
 w28UBE234zhndqIJZkyc1fpXS/L8kErHWdpgbmpVvKwwKAS58FSNMvaCQQ0D/QYoe+MG
 Jr+cpzi25taSwOyow7RhbAThB/nAxKgvauhD4ZTCjv/85L6mnR/TOY2tT56NzWiZrUNp
 SCDOBrJt47RX8SrBh6lqt7n/tZ19aZ7DbrejR7/YZckgq3MZejKx6vjr1c8Ad0rJYGwt
 gDZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv5K5zJBiCwcyqyPKSkk2GhW3NFiv0JX+P03Q4uS3WLxxNZpeZ94pPzFa2zF0X7PcDWgTMfZ46CBOycG0m7aHi5ivuBd/o++7cCUWzFg==
X-Gm-Message-State: AOJu0Yxtr6OUc6kCCgt4UHjMhWKVvR9BYWb1TbV10k1IspZb3nrsfQjz
 xmqrgdkPgbQHbYyz+gF/7qr7wB0VC/SkZ5nTCc6MgIh4X+TxfvjU
X-Google-Smtp-Source: AGHT+IHIDW0Udu99pz75ZT284hl+X4EuhsFRMkjtVWRh8eWfEVVUK3a7eOKg1Qyh5CzUR8mv1LllqA==
X-Received: by 2002:a05:600c:19c8:b0:41c:2313:da8d with SMTP id
 u8-20020a05600c19c800b0041c2313da8dmr3353293wmq.0.1714388535072; 
 Mon, 29 Apr 2024 04:02:15 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 iv20-20020a05600c549400b00418e4cc9de7sm40825337wmb.7.2024.04.29.04.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:02:14 -0700 (PDT)
Message-ID: <e7ee1c2d-9c1c-456f-bee6-8971b9e4fb2f@gmail.com>
Date: Mon, 29 Apr 2024 13:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-2-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426164355.1563-2-tursulin@igalia.com>
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

Am 26.04.24 um 18:43 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Help code readability by replacing a bunch of:
>
> bo->tbo.base.resv == vm->root.bo->tbo.base.resv
>
> With:
>
> amdgpu_bo_is_vm_bo(bo, vm)
>
> No functional changes.

Ah,yes that was on my TODO list as well.

But I would have rather added this to the VM instead. In other words 
move it to amdgpu_vm.h and call it amdgpu_vm_is_bo_always_valid() or 
something like that.

Regards,
Christian.

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 +++++++++-------------
>   3 files changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 67c234bcf89f..32e4a9c6e805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		return -EPERM;
>   
>   	if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
> -	    abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> +	    !amdgpu_bo_is_vm_bo(abo, vm))
>   		return -EPERM;
>   
>   	r = amdgpu_bo_reserve(abo, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index be679c42b0b8..f2bb6965cc77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -307,6 +307,20 @@ static inline struct amdgpu_bo *amdgpu_bo_shadowed(struct amdgpu_bo *bo)
>   	return NULL;
>   }
>   
> +/**
> + * amdgpu_bo_is_vm_bo - check if the BO is VM always valid
> + *
> + * @abo: BO to be tested.
> + * @vm: VM to test against.
> + *
> + * Returns true if the BO is VM always valid.
> + */
> +static inline bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo,
> +				      struct amdgpu_vm *vm)
> +{
> +	return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
> +}
> +
>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
>   void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..6d6f0e325172 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> -	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> +	if (!amdgpu_bo_is_vm_bo(bo, vm))
>   		return;
>   
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> @@ -1101,13 +1101,12 @@ static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
>   	 * For now ignore BOs which are currently locked and potentially
>   	 * changing their location.
>   	 */
> -	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
> -	    !dma_resv_trylock(bo->tbo.base.resv))
> +	if (!amdgpu_bo_is_vm_bo(bo, vm) && !dma_resv_trylock(bo->tbo.base.resv))
>   		return;
>   
>   	amdgpu_bo_get_memory(bo, stats);
> -	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
> -	    dma_resv_unlock(bo->tbo.base.resv);
> +	if (amdgpu_bo_is_vm_bo(bo, vm))
> +		dma_resv_unlock(bo->tbo.base.resv);
>   }
>   
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
> @@ -1203,8 +1202,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		uncached = false;
>   	}
>   
> -	if (clear || (bo && bo->tbo.base.resv ==
> -		      vm->root.bo->tbo.base.resv))
> +	if (clear || amdgpu_bo_is_vm_bo(bo, vm))
>   		last_update = &vm->last_update;
>   	else
>   		last_update = &bo_va->last_pt_update;
> @@ -1246,7 +1244,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	 * the evicted list so that it gets validated again on the
>   	 * next command submission.
>   	 */
> -	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
> +	if (amdgpu_bo_is_vm_bo(bo, vm)) {
>   		uint32_t mem_type = bo->tbo.resource->mem_type;
>   
>   		if (!(bo->preferred_domains &
> @@ -1640,10 +1638,9 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	if (mapping->flags & AMDGPU_PTE_PRT)
>   		amdgpu_vm_prt_get(adev);
>   
> -	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> -	    !bo_va->base.moved) {
> +	if (amdgpu_bo_is_vm_bo(bo, vm) && !bo_va->base.moved)
>   		amdgpu_vm_bo_moved(&bo_va->base);
> -	}
> +
>   	trace_amdgpu_vm_bo_map(bo_va, mapping);
>   }
>   
> @@ -1922,8 +1919,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   		if (before->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
>   
> -		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> -		    !before->bo_va->base.moved)
> +		if (amdgpu_bo_is_vm_bo(bo, vm) && !before->bo_va->base.moved)
>   			amdgpu_vm_bo_moved(&before->bo_va->base);
>   	} else {
>   		kfree(before);
> @@ -1937,8 +1933,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   		if (after->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
>   
> -		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> -		    !after->bo_va->base.moved)
> +		if (amdgpu_bo_is_vm_bo(bo, vm) && !after->bo_va->base.moved)
>   			amdgpu_vm_bo_moved(&after->bo_va->base);
>   	} else {
>   		kfree(after);
> @@ -2017,7 +2012,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   
>   	if (bo) {
>   		dma_resv_assert_held(bo->tbo.base.resv);
> -		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
> +		if (amdgpu_bo_is_vm_bo(bo, vm))
>   			ttm_bo_set_bulk_move(&bo->tbo, NULL);
>   
>   		for (base = &bo_va->base.bo->vm_bo; *base;
> @@ -2111,7 +2106,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>   		struct amdgpu_vm *vm = bo_base->vm;
>   
> -		if (evicted && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
> +		if (evicted && amdgpu_bo_is_vm_bo(bo, vm)) {
>   			amdgpu_vm_bo_evicted(bo_base);
>   			continue;
>   		}
> @@ -2122,7 +2117,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   
>   		if (bo->tbo.type == ttm_bo_type_kernel)
>   			amdgpu_vm_bo_relocated(bo_base);
> -		else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
> +		else if (amdgpu_bo_is_vm_bo(bo, vm))
>   			amdgpu_vm_bo_moved(bo_base);
>   		else
>   			amdgpu_vm_bo_invalidated(bo_base);

