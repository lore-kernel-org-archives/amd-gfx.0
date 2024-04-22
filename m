Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3D7C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E48112BC3;
	Mon, 22 Apr 2024 15:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a/meJ/86";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B293112BC3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:05:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-418e4cd2196so33578625e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713798338; x=1714403138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fnyUvg9f9geLcuXWAEpJbL7aTf8D3TBhioLf6tjVj6Y=;
 b=a/meJ/864Xq2w7vkqstUniVb6VHAKq1fqje+3v4qHRI0KzU7v4VZX6cezsplQ+m+vp
 BsH/LkzyQsjgCE2DieofNoQXyLqxbpEi+eVIPHE9/nezrpf4CRqKbqeHmiGfxr/RibVI
 kdTuv9eoo7DaorY13JCMsaKpkvi4MDFyx5Cm3RsKYh3+yvXhobx0RAMGCq2nbk5PY+oI
 d/lOui0/tLZiRaFVUntDDk0mSlnADaPEGFZTzLpN1KdV7qD9ECplSmy7lrdjc1TUsfgX
 Y3NiX5Yg3FCB/3G8fklI/eixriDHu1JRq7rSOVqw3b8dZfj2xzPGqd5tX8bQWd98lsgn
 rBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713798338; x=1714403138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnyUvg9f9geLcuXWAEpJbL7aTf8D3TBhioLf6tjVj6Y=;
 b=MldlRxI74KVcBSJdKVnsnvciG+tdrbVVdmmqMfdh2V8UmpjAlbJQF5k/ntpRZTzAsv
 OE0k6LCri5sKhQMA5/gjK6Sfj0XNqTsgJPAwJIh3SbP9g+GlNBkdSUAxqaYfN8mbv07s
 wzv2LOCPXwgmmwcCj0xe4+C701Rm4wnmYA202Mwrx66+o9nB5gb14Qc1rzwW6J9+UkPB
 dpUK1Li0+P+FhqmgpCYLRWlhdQ2oCh+GdL4fsWflR8yYN8ej0Fa+1U/6pBMbBWDA0aO7
 LRxMx0PC1HY3O8UKd0DJw6sf9C0HQB0LYLZT7d+LDfkM3yriaPhrK1j33/7+OcnFClNn
 8NaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL2FtCE0TAYRu5NagmWzLb1yWV7OuaTht4wVbLZt6KJSL55JmXxtw8mb6ebaroPJxeSs570XeM4DNd5hoNBgwU0kbVsva5ey80FukyGQ==
X-Gm-Message-State: AOJu0Yzgn95zwFOg4edXGYi8zy1JQDB3ZQOv4/yfmLaP6neM1nlMuTly
 kHUanEN8rIsOpPs4cOF03tnRPpFt1uypj6PuOQ36s4WCKqojMg0Q
X-Google-Smtp-Source: AGHT+IG0sDvFpuaNvEnwEOkW4+9cwE541mZeBsGf2IDywtFXX/UF2inQZ3evmYr7Dnez4HskZe7jRQ==
X-Received: by 2002:a05:600c:c86:b0:41a:a422:1255 with SMTP id
 fj6-20020a05600c0c8600b0041aa4221255mr14700wmb.9.1713798337816; 
 Mon, 22 Apr 2024 08:05:37 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004185be4baefsm14267973wmm.0.2024.04.22.08.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 08:05:37 -0700 (PDT)
Message-ID: <62056c2e-4ca4-4ce3-bbe1-1c2f07078254@gmail.com>
Date: Mon, 22 Apr 2024 17:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: once more fix the call oder in
 amdgpu_ttm_move()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20240321124311.2279-1-christian.koenig@amd.com>
 <fbe52af7-4ebb-490d-9771-d0ee177307e5@ursulin.net>
 <5d237fd2-4af4-4a4a-8c52-224b41f505f9@gmail.com>
 <CADnq5_Pk_1H07acZ83bPHVhjaTEgkR5Yr7=6TbH-Oy=NmFYgYw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_Pk_1H07acZ83bPHVhjaTEgkR5Yr7=6TbH-Oy=NmFYgYw@mail.gmail.com>
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

Am 18.04.24 um 18:10 schrieb Alex Deucher:
> On Thu, Mar 21, 2024 at 10:37 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 21.03.24 um 15:12 schrieb Tvrtko Ursulin:
>>> On 21/03/2024 12:43, Christian König wrote:
>>>> This reverts drm/amdgpu: fix ftrace event amdgpu_bo_move always move
>>>> on same heap. The basic problem here is that after the move the old
>>>> location is simply not available any more.
>>>>
>>>> Some fixes where suggested, but essentially we should call the move
>>>> notification before actually moving things because only this way we have
>>>> the correct order for DMA-buf and VM move notifications as well.
>>>>
>>>> Also rework the statistic handling so that we don't update the eviction
>>>> counter before the move.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Don't forget:
>>>
>>> Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move
>>> always move on same heap")
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
>> Ah, thanks. I already wanted to ask if there is any bug report about
>> that as well.
> Did this ever land?  I don't see it anywhere.

No, I never found time to actually rebase and push it.

Just did so 10 minutes ago, should probably show up in 
amd-staging-drm-next unless there isn't any CI hickup again.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>> ;)
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 15 +++----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 48 ++++++++++++----------
>>>>    3 files changed, 37 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 425cebcc5cbf..eb7d824763b9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -1245,19 +1245,20 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo
>>>> *bo, void *buffer,
>>>>     * amdgpu_bo_move_notify - notification about a memory move
>>>>     * @bo: pointer to a buffer object
>>>>     * @evict: if this move is evicting the buffer from the graphics
>>>> address space
>>>> + * @new_mem: new resource for backing the BO
>>>>     *
>>>>     * Marks the corresponding &amdgpu_bo buffer object as invalid,
>>>> also performs
>>>>     * bookkeeping.
>>>>     * TTM driver callback which is called when ttm moves a buffer.
>>>>     */
>>>> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
>>>> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>>>> +               bool evict,
>>>> +               struct ttm_resource *new_mem)
>>>>    {
>>>>        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>>> +    struct ttm_resource *old_mem = bo->resource;
>>>>        struct amdgpu_bo *abo;
>>>>    -    if (!amdgpu_bo_is_amdgpu_bo(bo))
>>>> -        return;
>>>> -
>>>>        abo = ttm_to_amdgpu_bo(bo);
>>>>        amdgpu_vm_bo_invalidate(adev, abo, evict);
>>>>    @@ -1267,9 +1268,9 @@ void amdgpu_bo_move_notify(struct
>>>> ttm_buffer_object *bo, bool evict)
>>>>            bo->resource->mem_type != TTM_PL_SYSTEM)
>>>>            dma_buf_move_notify(abo->tbo.base.dma_buf);
>>>>    -    /* remember the eviction */
>>>> -    if (evict)
>>>> -        atomic64_inc(&adev->num_evictions);
>>>> +    /* move_notify is called before move happens */
>>>> +    trace_amdgpu_bo_move(abo, new_mem ? new_mem->mem_type : -1,
>>>> +                 old_mem ? old_mem->mem_type : -1);
>>>>    }
>>>>      void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> index a3ea8a82db23..d28e21baef16 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> @@ -344,7 +344,9 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo,
>>>> void *metadata,
>>>>    int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>>>>                   size_t buffer_size, uint32_t *metadata_size,
>>>>                   uint64_t *flags);
>>>> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
>>>> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>>>> +               bool evict,
>>>> +               struct ttm_resource *new_mem);
>>>>    void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
>>>>    vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object
>>>> *bo);
>>>>    void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index a5ceec7820cf..460b23918bfc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -471,14 +471,16 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>          if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>                 bo->ttm == NULL)) {
>>>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>            ttm_bo_move_null(bo, new_mem);
>>>> -        goto out;
>>>> +        return 0;
>>>>        }
>>>>        if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>            (new_mem->mem_type == TTM_PL_TT ||
>>>>             new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>            ttm_bo_move_null(bo, new_mem);
>>>> -        goto out;
>>>> +        return 0;
>>>>        }
>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>> @@ -488,9 +490,10 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>                return r;
>>>>              amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>            ttm_resource_free(bo, &bo->resource);
>>>>            ttm_bo_assign_mem(bo, new_mem);
>>>> -        goto out;
>>>> +        return 0;
>>>>        }
>>>>          if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>> @@ -502,8 +505,9 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>            new_mem->mem_type == AMDGPU_PL_OA ||
>>>>            new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>            /* Nothing to save here */
>>>> +        amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>            ttm_bo_move_null(bo, new_mem);
>>>> -        goto out;
>>>> +        return 0;
>>>>        }
>>>>          if (bo->type == ttm_bo_type_device &&
>>>> @@ -515,22 +519,23 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>            abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>>>        }
>>>>    -    if (adev->mman.buffer_funcs_enabled) {
>>>> -        if (((old_mem->mem_type == TTM_PL_SYSTEM &&
>>>> -              new_mem->mem_type == TTM_PL_VRAM) ||
>>>> -             (old_mem->mem_type == TTM_PL_VRAM &&
>>>> -              new_mem->mem_type == TTM_PL_SYSTEM))) {
>>>> -            hop->fpfn = 0;
>>>> -            hop->lpfn = 0;
>>>> -            hop->mem_type = TTM_PL_TT;
>>>> -            hop->flags = TTM_PL_FLAG_TEMPORARY;
>>>> -            return -EMULTIHOP;
>>>> -        }
>>>> +    if (adev->mman.buffer_funcs_enabled &&
>>>> +        ((old_mem->mem_type == TTM_PL_SYSTEM &&
>>>> +          new_mem->mem_type == TTM_PL_VRAM) ||
>>>> +         (old_mem->mem_type == TTM_PL_VRAM &&
>>>> +          new_mem->mem_type == TTM_PL_SYSTEM))) {
>>>> +        hop->fpfn = 0;
>>>> +        hop->lpfn = 0;
>>>> +        hop->mem_type = TTM_PL_TT;
>>>> +        hop->flags = TTM_PL_FLAG_TEMPORARY;
>>>> +        return -EMULTIHOP;
>>>> +    }
>>>>    +    amdgpu_bo_move_notify(bo, evict, new_mem);
>>>> +    if (adev->mman.buffer_funcs_enabled)
>>>>            r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
>>>> -    } else {
>>>> +    else
>>>>            r = -ENODEV;
>>>> -    }
>>>>          if (r) {
>>>>            /* Check that all memory is CPU accessible */
>>>> @@ -545,11 +550,10 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>                return r;
>>>>        }
>>>>    -    trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>>>> -out:
>>>> -    /* update statistics */
>>>> +    /* update statistics after the move */
>>>> +    if (evict)
>>>> +        atomic64_inc(&adev->num_evictions);
>>>>        atomic64_add(bo->base.size, &adev->num_bytes_moved);
>>>> -    amdgpu_bo_move_notify(bo, evict);
>>>>        return 0;
>>>>    }
>>>>    @@ -1551,7 +1555,7 @@ static int amdgpu_ttm_access_memory(struct
>>>> ttm_buffer_object *bo,
>>>>    static void
>>>>    amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
>>>>    {
>>>> -    amdgpu_bo_move_notify(bo, false);
>>>> +    amdgpu_bo_move_notify(bo, false, NULL);
>>>>    }
>>>>      static struct ttm_device_funcs amdgpu_bo_driver = {

