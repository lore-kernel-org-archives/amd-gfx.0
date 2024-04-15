Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39FAC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 14:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD791125D1;
	Mon, 15 Apr 2024 14:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWireX4x";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBE41125D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 14:03:42 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso1488354f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713189820; x=1713794620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ec6Dk38E8G6ibwSt/iPdhuxtBkYBJoG5+Zh5T2ub6IQ=;
 b=iWireX4xaYNCjZE23Hr62s3/gvy2NoX7BPpzv4FDm7O8Q7pkEHJC7hhEI+USSH4iVi
 tLcX3WDDDs1JStCH+y/jBy3C8KfkovL8KjP902sc8YvMH7hohfssq+wubynO5Qia5Ue2
 4hfeaQQY0FCPnWcjx7W+Ggy/JrVbs9iSk4MClVaNorEl6ig1C6bImK01VujNqblbYaxg
 HuGmkGigyvpyhA+ojInmwGrZY/9/df/YbrkZtTtmkoa2U+nKuQ8imQinkK6AgXMRSNKs
 LPPHQOwl5eRQ8NbwKoIdZEoMSaB0VLUhslK8nN2JStGC+2AYSvjxZLly0lrLU38IQP+Q
 wy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713189820; x=1713794620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ec6Dk38E8G6ibwSt/iPdhuxtBkYBJoG5+Zh5T2ub6IQ=;
 b=WhYURY1g7hFhkhbfyqp/t1kbwStuwPyPREpdKBah2uj+Ow2sq8KpGQ+xJ331hCHOir
 jmO4UtbBX9dSmkukxaMbsjLTkb3ifbEYQhtnXSi6nqdOhDEJ+WcUJ1okqTPs+Bq2IigY
 kbj/1d2VfzjgkZfPjn2t3p/j+dEzUsOz4t1fydDbq3HbNjkUkmHEQFyJU9php8l69ZwW
 tuB0e8Xh8M/PRVAY7JvTDtOUPelbL/39UC6/Z2jHvV9ZQM/AkA+wngTSo8CCxIR+U/dG
 XRYVnPOQnZjoow+Mea0LZ4eHOzZCrx+6tQbtYyTILVcBjwCrhbRhus90orP5BpeJ0rMn
 ChqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAjridwe0AVp1URxQcwu14epruOZVDvlfzWec+4W2Setk/qFkkP3W3mavsUsuZVmhZNaYCxbdiEHe0EQq151KXHOmOfGavgQdxElFRkQ==
X-Gm-Message-State: AOJu0Yz83MejNVEAGoVpOckqz42pHFF7QdMlYE9NfVqq9JDjfdgKiSJT
 HXY65tIbMtUTTMcWZRy4ZYCKd+to4WsB487SVbU4dDO73fCANrQN
X-Google-Smtp-Source: AGHT+IGUCIVt4OYVwfCcC9b8v9gBsfAT8VSk31NEBFW0Q7U6WmNBR4Vl/+RaCIg7shhwYEjQJ7/Ecg==
X-Received: by 2002:a5d:6744:0:b0:343:a8cb:7990 with SMTP id
 l4-20020a5d6744000000b00343a8cb7990mr7543053wrw.29.1713189820241; 
 Mon, 15 Apr 2024 07:03:40 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm8647088wrq.19.2024.04.15.07.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:03:39 -0700 (PDT)
Message-ID: <4f929e29-599a-431e-ab21-768aee8d765a@gmail.com>
Date: Mon, 15 Apr 2024 16:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
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

Am 14.04.24 um 16:57 schrieb Arunpravin Paneer Selvam:
> Now we have two flags for contiguous VRAM buffer allocation.
> If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
> it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
> buffer's placement function.
>
> This patch will change the default behaviour of the two flags.
>
> When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
> - This means contiguous is not mandatory.
> - we will try to allocate the contiguous buffer. Say if the
>    allocation fails, we fallback to allocate the individual pages.
>
> When we setTTM_PL_FLAG_CONTIGUOUS
> - This means contiguous allocation is mandatory.
> - we are setting this in amdgpu_bo_pin_restricted() before bo validation
>    and check this flag in the vram manager file.
> - if this is set, we should allocate the buffer pages contiguously.
>    the allocation fails, we return -ENOSPC.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 14 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
>   2 files changed, 49 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8bc79924d171..41926d631563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -153,8 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   		else
>   			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>   
> -		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
> -			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
>   		c++;
>   	}
>   
> @@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct ttm_operation_ctx ctx = { false, false };
> +	struct ttm_place *places = bo->placements;
> +	u32 c = 0;
>   	int r, i;
>   
>   	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
> @@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   
>   	if (bo->tbo.pin_count) {
>   		uint32_t mem_type = bo->tbo.resource->mem_type;
> -		uint32_t mem_flags = bo->tbo.resource->placement;
>   
>   		if (!(domain & amdgpu_mem_type_to_domain(mem_type)))
>   			return -EINVAL;
>   
> -		if ((mem_type == TTM_PL_VRAM) &&
> -		    (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &&
> -		    !(mem_flags & TTM_PL_FLAG_CONTIGUOUS))
> -			return -EINVAL;
> -

I think that check here needs to stay.

>   		ttm_bo_pin(&bo->tbo);
>   
>   		if (max_offset != 0) {
> @@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   			bo->placements[i].lpfn = lpfn;
>   	}
>   
> +	if (domain & AMDGPU_GEM_DOMAIN_VRAM &&
> +	    !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
> +		places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +

This needs to go into the loop directly above as something like this here:

If (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
     bo->placements[i].mem_type == TTM_PL_VRAM)
         o->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;

This essentially replaces the removed code in 
amdgpu_bo_placement_from_domain() and only applies it during pinning.

>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (unlikely(r)) {
>   		dev_err(adev->dev, "%p pin failed\n", bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 8db880244324..ddbf302878f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -88,6 +88,30 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
>   	return size;
>   }
>   
> +static inline unsigned long
> +amdgpu_vram_find_pages_per_block(struct ttm_buffer_object *tbo,
> +				 const struct ttm_place *place,
> +				 unsigned long bo_flags)

Well I think we need a better name here. "find" usually means we look up 
something in a data structure. Maybe 
amdgpu_vram_mgr_calculate_pages_per_block.

> +{
> +	unsigned long pages_per_block;
> +
> +	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
> +	    place->flags & TTM_PL_FLAG_CONTIGUOUS) {
> +		pages_per_block = ~0ul;
> +	} else {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		pages_per_block = HPAGE_PMD_NR;
> +#else
> +		/* default to 2MB */
> +		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
> +#endif
> +		pages_per_block = max_t(uint32_t, pages_per_block,
> +					tbo->page_alignment);
> +	}
> +
> +	return pages_per_block;
> +}
> +
>   /**
>    * DOC: mem_info_vram_total
>    *
> @@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>   	struct amdgpu_device *adev = to_amdgpu_device(mgr);
>   	u64 vis_usage = 0, max_bytes, min_block_size;
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   	struct amdgpu_vram_mgr_resource *vres;
>   	u64 size, remaining_size, lpfn, fpfn;
> +	unsigned long bo_flags = bo->flags;
>   	struct drm_buddy *mm = &mgr->mm;
>   	struct drm_buddy_block *block;
>   	unsigned long pages_per_block;
> @@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (tbo->type != ttm_bo_type_kernel)
>   		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS) {
> -		pages_per_block = ~0ul;
> -	} else {
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -		pages_per_block = HPAGE_PMD_NR;
> -#else
> -		/* default to 2MB */
> -		pages_per_block = 2UL << (20UL - PAGE_SHIFT);
> -#endif
> -		pages_per_block = max_t(uint32_t, pages_per_block,
> -					tbo->page_alignment);
> -	}
> +	pages_per_block =
> +		amdgpu_vram_find_pages_per_block(tbo, place, bo_flags);
>   
>   	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
>   	if (!vres)
> @@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	if (place->flags & TTM_PL_FLAG_TOPDOWN)
>   		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
>   
> -	if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +	if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
> +	    place->flags & TTM_PL_FLAG_CONTIGUOUS)
>   		vres->flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>   
>   	if (fpfn || lpfn != mgr->mm.size)
> @@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   					   min_block_size,
>   					   &vres->blocks,
>   					   vres->flags);
> -		if (unlikely(r))
> +		if (unlikely(r)) {
> +			if (bo_flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
> +				/* Fallback to non contiguous allocation */
> +				vres->flags &= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
> +				bo_flags &= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +
> +				pages_per_block =
> +					amdgpu_vram_find_pages_per_block(tbo,
> +									 place,
> +									 bo_flags);
> +				continue;
> +			}

Let's talk about that on our weekly call. Might be a bit overkill, but 
I'm not so deep inside the code any more.

But looks quite good actually.

Regards,
Christian.

>   			goto error_free_blocks;
> +		}
>   
>   		if (size > remaining_size)
>   			remaining_size = 0;

