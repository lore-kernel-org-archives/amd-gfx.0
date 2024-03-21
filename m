Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B79C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 14:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9158D10EB47;
	Thu, 21 Mar 2024 14:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDgD8ziY";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F2510EB49
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 14:37:31 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-41466e01965so7307865e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711031850; x=1711636650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LEIQ+H8jRSTnmAYsUWgE1VDJQTUleDHcfiCid/+YBGA=;
 b=TDgD8ziYDYOS+jU3XjsFH7aUP3NB6vCA3kbOdf83lCuS+U+tycj16m9D1RlRSc0fk5
 f73QoayBcdGW15uMGAiehWmqozlwi/GvtWOluYLSvqKugnXwN4nMKLXlOR6mdr3W4zid
 tbpFGvQRIUo0lMP9Y5gFf8JWk45aSYcHkrMeqf+mHKFcLToEG0s6yZPTv2i64llBqoMd
 LA38JTUyVuTxF0TrsxwRIeBzL0NGAotFASS9/+okcYtNFf9YaGwzKSSzAuE+uooyTp4Y
 MIxVG/NjfIe7fI5VM5j6g789Ys+/d/2QrW5GgyCTNxR4MG25Se2s0o3pCM2tRqZDndZW
 N7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711031850; x=1711636650;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LEIQ+H8jRSTnmAYsUWgE1VDJQTUleDHcfiCid/+YBGA=;
 b=MOEIyLmj5pnAaVC+XypFwhDWpzAsH0y4fncgmnGB+yeE68CVI3zOUIZqHJ6M1PgQrQ
 wDZ7JHz8wW7mIR4XVAinDsh85PzWtg2nvn2Pq5aFeVIk52hjyzcRi+HX99AkdjC8U9+4
 TSR/etQTqT/9+ZK0yhDCAdkn2ULXG31eoNfs9S6m52JNSrRIiQKwikZOIybGfLnuvhoI
 9Tg92Fwlwj86BgiDnx33BqHbpHTTO+HBBIaGza9AFDGgClCRtoqd5A63WJyVh0tR+7De
 8zdLWYDIAJHthmoI+39Twsc8BIAU1S7pssAOpMmreuhnS0f2NUVMdANJYJYFwhHI0AZ+
 FpRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV79fRVjmmlj6FsY9WpZ/PQjBfdTAKy0F/4sIBv9i9RJ1YWKXlccSch1qvZYlr365ZIw6zD6aMZcMEk0OatsSABbkSl6DYs0uN0qs0GTQ==
X-Gm-Message-State: AOJu0YwzMamomUb1F6ZzYo4lYjJWj5mFx3ifmHG3RM1uokdzq3GCOZ6h
 3+brKN1arYy7oCH38Cz7lltAtWE/7jJqZSaTAzjJrV7m94yqHwd4QaXEbmvxQ3U=
X-Google-Smtp-Source: AGHT+IEs7Vv1SwRI8QvAlYILxhW3e7ffx7zCMsfWer3ywyZnlJO5L4Q64Oy4/PymLW2h5Cx599LyOQ==
X-Received: by 2002:a05:600c:35c9:b0:414:6a02:ebfa with SMTP id
 r9-20020a05600c35c900b004146a02ebfamr3949628wmq.20.1711031849985; 
 Thu, 21 Mar 2024 07:37:29 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b0041461a922c2sm5790872wmq.5.2024.03.21.07.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 07:37:29 -0700 (PDT)
Message-ID: <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
Date: Thu, 21 Mar 2024 15:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: once more fix the call oder in
 amdgpu_ttm_move()
Content-Language: en-US
To: Tvrtko Ursulin <tursulin@ursulin.net>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20240321124311.2279-1-christian.koenig@amd.com>
 <fbe52af7-4ebb-490d-9771-d0ee177307e5@ursulin.net>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <fbe52af7-4ebb-490d-9771-d0ee177307e5@ursulin.net>
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

Am 21.03.24 um 15:12 schrieb Tvrtko Ursulin:
>
> On 21/03/2024 12:43, Christian König wrote:
>> This reverts drm/amdgpu: fix ftrace event amdgpu_bo_move always move
>> on same heap. The basic problem here is that after the move the old
>> location is simply not available any more.
>>
>> Some fixes where suggested, but essentially we should call the move
>> notification before actually moving things because only this way we have
>> the correct order for DMA-buf and VM move notifications as well.
>>
>> Also rework the statistic handling so that we don't update the eviction
>> counter before the move.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>
> Don't forget:
>
> Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move 
> always move on same heap")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171

Ah, thanks. I already wanted to ask if there is any bug report about 
that as well.

Regards,
Christian.

>
> ;)
>
> Regards,
>
> Tvrtko
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 15 +++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 48 ++++++++++++----------
>>   3 files changed, 37 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 425cebcc5cbf..eb7d824763b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1245,19 +1245,20 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo 
>> *bo, void *buffer,
>>    * amdgpu_bo_move_notify - notification about a memory move
>>    * @bo: pointer to a buffer object
>>    * @evict: if this move is evicting the buffer from the graphics 
>> address space
>> + * @new_mem: new resource for backing the BO
>>    *
>>    * Marks the corresponding &amdgpu_bo buffer object as invalid, 
>> also performs
>>    * bookkeeping.
>>    * TTM driver callback which is called when ttm moves a buffer.
>>    */
>> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
>> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>> +               bool evict,
>> +               struct ttm_resource *new_mem)
>>   {
>>       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +    struct ttm_resource *old_mem = bo->resource;
>>       struct amdgpu_bo *abo;
>>   -    if (!amdgpu_bo_is_amdgpu_bo(bo))
>> -        return;
>> -
>>       abo = ttm_to_amdgpu_bo(bo);
>>       amdgpu_vm_bo_invalidate(adev, abo, evict);
>>   @@ -1267,9 +1268,9 @@ void amdgpu_bo_move_notify(struct 
>> ttm_buffer_object *bo, bool evict)
>>           bo->resource->mem_type != TTM_PL_SYSTEM)
>>           dma_buf_move_notify(abo->tbo.base.dma_buf);
>>   -    /* remember the eviction */
>> -    if (evict)
>> -        atomic64_inc(&adev->num_evictions);
>> +    /* move_notify is called before move happens */
>> +    trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
>> +                 old_mem ? old_mem->mem_type : -1);
>>   }
>>     void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index a3ea8a82db23..d28e21baef16 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -344,7 +344,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, 
>> void *metadata,
>>   int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>>                  size_t buffer_size, uint32_t *metadata_size,
>>                  uint64_t *flags);
>> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
>> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>> +               bool evict,
>> +               struct ttm_resource *new_mem);
>>   void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
>>   vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object 
>> *bo);
>>   void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index a5ceec7820cf..460b23918bfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -471,14 +471,16 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>         if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>                bo->ttm == NULL)) {
>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>           ttm_bo_move_null(bo, new_mem);
>> -        goto out;
>> +        return 0;
>>       }
>>       if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>           (new_mem->mem_type == TTM_PL_TT ||
>>            new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>           ttm_bo_move_null(bo, new_mem);
>> -        goto out;
>> +        return 0;
>>       }
>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>> @@ -488,9 +490,10 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>               return r;
>>             amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>           ttm_resource_free(bo, &bo->resource);
>>           ttm_bo_assign_mem(bo, new_mem);
>> -        goto out;
>> +        return 0;
>>       }
>>         if (old_mem->mem_type == AMDGPU_PL_GDS ||
>> @@ -502,8 +505,9 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>           new_mem->mem_type == AMDGPU_PL_OA ||
>>           new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>           /* Nothing to save here */
>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>           ttm_bo_move_null(bo, new_mem);
>> -        goto out;
>> +        return 0;
>>       }
>>         if (bo->type == ttm_bo_type_device &&
>> @@ -515,22 +519,23 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>           abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>       }
>>   -    if (adev->mman.buffer_funcs_enabled) {
>> -        if (((old_mem->mem_type == TTM_PL_SYSTEM &&
>> -              new_mem->mem_type == TTM_PL_VRAM) ||
>> -             (old_mem->mem_type == TTM_PL_VRAM &&
>> -              new_mem->mem_type == TTM_PL_SYSTEM))) {
>> -            hop->fpfn = 0;
>> -            hop->lpfn = 0;
>> -            hop->mem_type = TTM_PL_TT;
>> -            hop->flags = TTM_PL_FLAG_TEMPORARY;
>> -            return -EMULTIHOP;
>> -        }
>> +    if (adev->mman.buffer_funcs_enabled &&
>> +        ((old_mem->mem_type == TTM_PL_SYSTEM &&
>> +          new_mem->mem_type == TTM_PL_VRAM) ||
>> +         (old_mem->mem_type == TTM_PL_VRAM &&
>> +          new_mem->mem_type == TTM_PL_SYSTEM))) {
>> +        hop->fpfn = 0;
>> +        hop->lpfn = 0;
>> +        hop->mem_type = TTM_PL_TT;
>> +        hop->flags = TTM_PL_FLAG_TEMPORARY;
>> +        return -EMULTIHOP;
>> +    }
>>   +    amdgpu_bo_move_notify(bo, evict, new_mem);
>> +    if (adev->mman.buffer_funcs_enabled)
>>           r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
>> -    } else {
>> +    else
>>           r = -ENODEV;
>> -    }
>>         if (r) {
>>           /* Check that all memory is CPU accessible */
>> @@ -545,11 +550,10 @@ static int amdgpu_bo_move(struct 
>> ttm_buffer_object *bo, bool evict,
>>               return r;
>>       }
>>   -    trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>> -out:
>> -    /* update statistics */
>> +    /* update statistics after the move */
>> +    if (evict)
>> +        atomic64_inc(&adev->num_evictions);
>>       atomic64_add(bo->base.size, &adev->num_bytes_moved);
>> -    amdgpu_bo_move_notify(bo, evict);
>>       return 0;
>>   }
>>   @@ -1551,7 +1555,7 @@ static int amdgpu_ttm_access_memory(struct 
>> ttm_buffer_object *bo,
>>   static void
>>   amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
>>   {
>> -    amdgpu_bo_move_notify(bo, false);
>> +    amdgpu_bo_move_notify(bo, false, NULL);
>>   }
>>     static struct ttm_device_funcs amdgpu_bo_driver = {

