Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A66C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 14:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEB110E0AC;
	Thu, 21 Mar 2024 14:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="tXcPRv2g";
	dkim-atps=neutral
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7D010E0AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 14:12:59 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-4146a1ac117so6408945e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1711030378; x=1711635178;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CsoKO4/zoKcFb/Zvo/52kZwroa1JRk+kB8SlJIUTJjY=;
 b=tXcPRv2g169P3Rvts4lln1E3WR8p+OYBqokXMF+3jHsPMuXQAYplcvMDCINKd5CHYI
 36JMsq7D89BaOqhqKq2KxP7ggzFex+nayBgPKFWSKyUZMKXD1pw05Fikz6ZtDeKtmeyz
 uRwRX01xR4MuLSmRrT/MdeliJ+pyxsMxps75ATKnmDBgSXnd3miZXGwcxKc1V5ogGx4X
 /GCWEUyaLqkghb6/zix9hBKkPIBdbe0FJa0Ce9wKUFHZj3TAkZzfNXYsRVq83IbUNFh7
 10vipVG5B7FxplgebM6+z5AYqlsussNglVIQx64EsSu530t2vrzpV7qngjsdpFT71Hn8
 7yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711030378; x=1711635178;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CsoKO4/zoKcFb/Zvo/52kZwroa1JRk+kB8SlJIUTJjY=;
 b=lemL2rirKKN4ovpmzj1JICdM75VLfzXfVqrE/beXUbxv43IrAZdGhkLtSBmqpzwHtw
 7gDRa6KtGqxrnfKVNuiXl4Y6BNiMFl8Tv8DXW4P7DP0xx2B6Yrd4I68JATHcyNxZKFpM
 kJ3YlODwMX0rvv6sL5ywElkgu7l2arXczsFNLfJkJIDZbgbIglgfEvRbCuBNrSje0u4f
 REYTK52/3hldg/OkxliN9HQlM6pQkdT1Q6P6a7Ml7nAAMAfb6/IZKjp5ksqe5IYCmS1o
 9dhkQgTuFlVaXdrecN0qw7z7zrJS+4d7W+eQ8KvWE05rSSHJpF15AjEVjMZO90Atlob8
 qx5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/Z9PXtSmVLqLwDOF2DkwOpu2O/Cn9ZJ0Xz9Qg/wMr0uR4QW/qFFxXTgRXi+ynDIKadOcUdzloGzosoJGQzHrn1WNlLBGV6XtmazSRzA==
X-Gm-Message-State: AOJu0YwkyqQoQtSDHta5ERNpoTdJ3PnvXumudZDpk5ERi7VB9pUBcJjR
 XA+jVKeImlTFG8rrljlf31x5A1HVI7N0Im6K7KVM95FFPVgDSjCoX7Rjts6un9U=
X-Google-Smtp-Source: AGHT+IE9LFAQK0fyjSi6kfJxE83+C1FDg62LLrxRdF4unSPSbtrf/4/0l9bZpwmnASorfZkv9rpqmA==
X-Received: by 2002:a05:600c:4f10:b0:412:c285:1091 with SMTP id
 l16-20020a05600c4f1000b00412c2851091mr2596552wmq.7.1711030377864; 
 Thu, 21 Mar 2024 07:12:57 -0700 (PDT)
Received: from [192.168.0.101] ([84.65.0.132])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a05600c1e1200b004146d785508sm5136810wmb.0.2024.03.21.07.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 07:12:57 -0700 (PDT)
Message-ID: <fbe52af7-4ebb-490d-9771-d0ee177307e5@ursulin.net>
Date: Thu, 21 Mar 2024 14:12:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: once more fix the call oder in
 amdgpu_ttm_move()
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20240321124311.2279-1-christian.koenig@amd.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240321124311.2279-1-christian.koenig@amd.com>
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


On 21/03/2024 12:43, Christian König wrote:
> This reverts drm/amdgpu: fix ftrace event amdgpu_bo_move always move
> on same heap. The basic problem here is that after the move the old
> location is simply not available any more.
> 
> Some fixes where suggested, but essentially we should call the move
> notification before actually moving things because only this way we have
> the correct order for DMA-buf and VM move notifications as well.
> 
> Also rework the statistic handling so that we don't update the eviction
> counter before the move.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Don't forget:

Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move always 
move on same heap")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171

;)

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 15 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 48 ++++++++++++----------
>   3 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 425cebcc5cbf..eb7d824763b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1245,19 +1245,20 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>    * amdgpu_bo_move_notify - notification about a memory move
>    * @bo: pointer to a buffer object
>    * @evict: if this move is evicting the buffer from the graphics address space
> + * @new_mem: new resource for backing the BO
>    *
>    * Marks the corresponding &amdgpu_bo buffer object as invalid, also performs
>    * bookkeeping.
>    * TTM driver callback which is called when ttm moves a buffer.
>    */
> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
> +			   bool evict,
> +			   struct ttm_resource *new_mem)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	struct ttm_resource *old_mem = bo->resource;
>   	struct amdgpu_bo *abo;
>   
> -	if (!amdgpu_bo_is_amdgpu_bo(bo))
> -		return;
> -
>   	abo = ttm_to_amdgpu_bo(bo);
>   	amdgpu_vm_bo_invalidate(adev, abo, evict);
>   
> @@ -1267,9 +1268,9 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
>   	    bo->resource->mem_type != TTM_PL_SYSTEM)
>   		dma_buf_move_notify(abo->tbo.base.dma_buf);
>   
> -	/* remember the eviction */
> -	if (evict)
> -		atomic64_inc(&adev->num_evictions);
> +	/* move_notify is called before move happens */
> +	trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
> +			     old_mem ? old_mem->mem_type : -1);
>   }
>   
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index a3ea8a82db23..d28e21baef16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -344,7 +344,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>   int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>   			   size_t buffer_size, uint32_t *metadata_size,
>   			   uint64_t *flags);
> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
> +			   bool evict,
> +			   struct ttm_resource *new_mem);
>   void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
>   vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
>   void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a5ceec7820cf..460b23918bfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -471,14 +471,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   
>   	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>   			 bo->ttm == NULL)) {
> +		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_bo_move_null(bo, new_mem);
> -		goto out;
> +		return 0;
>   	}
>   	if (old_mem->mem_type == TTM_PL_SYSTEM &&
>   	    (new_mem->mem_type == TTM_PL_TT ||
>   	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
> +		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_bo_move_null(bo, new_mem);
> -		goto out;
> +		return 0;
>   	}
>   	if ((old_mem->mem_type == TTM_PL_TT ||
>   	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
> @@ -488,9 +490,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   			return r;
>   
>   		amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
> +		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_resource_free(bo, &bo->resource);
>   		ttm_bo_assign_mem(bo, new_mem);
> -		goto out;
> +		return 0;
>   	}
>   
>   	if (old_mem->mem_type == AMDGPU_PL_GDS ||
> @@ -502,8 +505,9 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	    new_mem->mem_type == AMDGPU_PL_OA ||
>   	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>   		/* Nothing to save here */
> +		amdgpu_bo_move_notify(bo, evict, new_mem);
>   		ttm_bo_move_null(bo, new_mem);
> -		goto out;
> +		return 0;
>   	}
>   
>   	if (bo->type == ttm_bo_type_device &&
> @@ -515,22 +519,23 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>   	}
>   
> -	if (adev->mman.buffer_funcs_enabled) {
> -		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
> -		      new_mem->mem_type == TTM_PL_VRAM) ||
> -		     (old_mem->mem_type == TTM_PL_VRAM &&
> -		      new_mem->mem_type == TTM_PL_SYSTEM))) {
> -			hop->fpfn = 0;
> -			hop->lpfn = 0;
> -			hop->mem_type = TTM_PL_TT;
> -			hop->flags = TTM_PL_FLAG_TEMPORARY;
> -			return -EMULTIHOP;
> -		}
> +	if (adev->mman.buffer_funcs_enabled &&
> +	    ((old_mem->mem_type == TTM_PL_SYSTEM &&
> +	      new_mem->mem_type == TTM_PL_VRAM) ||
> +	     (old_mem->mem_type == TTM_PL_VRAM &&
> +	      new_mem->mem_type == TTM_PL_SYSTEM))) {
> +		hop->fpfn = 0;
> +		hop->lpfn = 0;
> +		hop->mem_type = TTM_PL_TT;
> +		hop->flags = TTM_PL_FLAG_TEMPORARY;
> +		return -EMULTIHOP;
> +	}
>   
> +	amdgpu_bo_move_notify(bo, evict, new_mem);
> +	if (adev->mman.buffer_funcs_enabled)
>   		r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
> -	} else {
> +	else
>   		r = -ENODEV;
> -	}
>   
>   	if (r) {
>   		/* Check that all memory is CPU accessible */
> @@ -545,11 +550,10 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   			return r;
>   	}
>   
> -	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
> -out:
> -	/* update statistics */
> +	/* update statistics after the move */
> +	if (evict)
> +		atomic64_inc(&adev->num_evictions);
>   	atomic64_add(bo->base.size, &adev->num_bytes_moved);
> -	amdgpu_bo_move_notify(bo, evict);
>   	return 0;
>   }
>   
> @@ -1551,7 +1555,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   static void
>   amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
>   {
> -	amdgpu_bo_move_notify(bo, false);
> +	amdgpu_bo_move_notify(bo, false, NULL);
>   }
>   
>   static struct ttm_device_funcs amdgpu_bo_driver = {
