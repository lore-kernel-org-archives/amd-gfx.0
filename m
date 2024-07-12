Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39837C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 07:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E178810EC3F;
	Fri, 12 Jul 2024 07:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WzRPnS8k";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8726110EC3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 07:39:09 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-42679f33fefso11287935e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 00:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720769948; x=1721374748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ASoL2n44cIGdLcKkIeaBgYofTWWcQ/Km4ZFF+6f+LtQ=;
 b=WzRPnS8kyGqSqpEHRunDRmFNqEqPSt4wdh/actnYkE7/EjrK26PYWqN7d66E0Uw03u
 9F2MKf7ZmR3fDizfeCvr10dNsXeZUVtc+UTLiEEyLYd0LLrwPr+ddREyqJGnSAoW1z5f
 zU4CTlXzZtSb9mcOSbjzIfr+fCTjlIoNURP9YsEfQrlD+y4U0oKsfzxMw9Q9Q/0RntgJ
 mYQmzUsAkbiLWQE74C/tx2JQ91Eh5mwxF1VUnXwgIUDLA9UTqoLDe/tbEDURvbVFJRDa
 jJ4sw5AQuAxFFzb5PhUyDcBNQw1ZR4j+eXpnzs2yXACVYPLFiBl+q8CHO25Fpw2FG4VM
 QjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720769948; x=1721374748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ASoL2n44cIGdLcKkIeaBgYofTWWcQ/Km4ZFF+6f+LtQ=;
 b=s6UyiGUctjuT/Z9CkayCIL1ymlAT5fy1gXSkQ90mThqq3lykTKD40MLKLAXzxOzpSq
 xA8ZfW+gsf7eteE+XT3lkzZg5frZpn8G7cwGbeWI/NPQnKwAolRTKWLVkpj4b2Z5n7fG
 OE921jyiXiviLnUDspYRinWZeWHYsldXXICEs8wizyt4Bt9TByV2PR4CY3bRWhpaX/iz
 uequFHaAe+Oc2vVyU8jLuvqS2y1GqEiYoNwf/fcu48a3zHdeVSoUmtm3nToiLuUvswN6
 rpm9tf90MUwn+BvvfZHTDA2ypKSXwuaMlt1Wpde4uh9Vbzx4oDF4zj41b1c4C/8VeKDr
 l/sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB2eajPZQOwR1O/f1OXTRNeSZUt8AhRAXr9DpiNjc7wCqNfraQwBJb+QmPXqF99jEuAIFfKHTDM10jGjIwGUR1zEzDNG5q0kOQHXogSw==
X-Gm-Message-State: AOJu0YxIIBiqJPgzkQCpeWcTpWa2/kDemQ3w8LbtzQn89bOYdr63gW5w
 iInapGSTu5T97ahPpeakWHQ6C79jcrV31jHqesK6RBWTcC71QdZQ
X-Google-Smtp-Source: AGHT+IG+4Jwe71P/WjAKOZgKaSJv4V/ocgS6VuUDT0OcYMh18oFQdywoMCskHYHobLNmvb5opSmxzw==
X-Received: by 2002:a05:600c:4d0d:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-426708f1fb7mr71566805e9.32.1720769947235; 
 Fri, 12 Jul 2024 00:39:07 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2be68bsm13263965e9.40.2024.07.12.00.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 00:39:06 -0700 (PDT)
Message-ID: <ad162a88-7549-4fc0-9102-3f45b1e8ef73@gmail.com>
Date: Fri, 12 Jul 2024 09:39:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "cao, lin" <lin.cao@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
 <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
 <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <PH0PR12MB5420453D1FF4C3834CDCFB4EE0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH0PR12MB5420453D1FF4C3834CDCFB4EE0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
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

Hi River,

well that isn't an error at all, this is perfectly expected behavior.

The VMs used by the KFD process are currently not meant to be used by 
classic CS at the same time.

This is one of the reasons for that.

Regards,
Christian.

Am 12.07.24 um 09:35 schrieb YuanShang Mao (River):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Add more info and CC @Kuehling, Felix @cao, lin
>
> In amdgpu_amdkfd_fence.c, there is a design description:
>
> /* Eviction Fence
>   * Fence helper functions to deal with KFD memory eviction.
>   * Big Idea - Since KFD submissions are done by user queues, a BO cannot be
>   *  evicted unless all the user queues for that process are evicted.
>   *
>   * All the BOs in a process share an eviction fence. When process X wants
>   * to map VRAM memory but TTM can't find enough space, TTM will attempt to
>   * evict BOs from its LRU list. TTM checks if the BO is valuable to evict
>   * by calling ttm_device_funcs->eviction_valuable().
>   *
>   * ttm_device_funcs->eviction_valuable() - will return false if the BO belongs
>   *  to process X. Otherwise, it will return true to indicate BO can be
>   *  evicted by TTM.
>   *
>   * If ttm_device_funcs->eviction_valuable returns true, then TTM will continue
>   * the evcition process for that BO by calling ttm_bo_evict --> amdgpu_bo_move
>   * --> amdgpu_copy_buffer(). This sets up job in GPU scheduler.
>   *
>   * GPU Scheduler (amd_sched_main) - sets up a cb (fence_add_callback) to
>   *  nofity when the BO is free to move. fence_add_callback --> enable_signaling
>   *  --> amdgpu_amdkfd_fence.enable_signaling
>   *
>   * amdgpu_amdkfd_fence.enable_signaling - Start a work item that will quiesce
>   * user queues and signal fence. The work item will also start another delayed
>   * work item to restore BOs
>   */
>
> If mark BOs as invalidated before submitting job to move the buffer, user queue is still active.
> During the time before user queue is evicted, if a drm job achieve, amdgpu_cs_vm_handling will call amdgpu_vm_handle_moved to clear the ptes of
> Invalidated BOs. Then page fault happens because compute shader is still accessing the "invalidated" BO.
>
> I am not familiar with amdgpu_vm_bo state machine, so I don’t know if it is an code error or an design error.
>
> Thanks
> River
>
>
> -----Original Message-----
> From: YuanShang Mao (River)
> Sent: Friday, July 12, 2024 10:55 AM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>
> Cc: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>
> We need to make sure that all BOs of an active kfd process validated. Moving buffer will trigger process eviction.
> If mark it as invalided before process eviction, related kfd process is still active and may attempt to access this invalidated BO.
>
> Agree with Trigger. Seems kfd eviction should been synced to move notify, not the move action.
>
> Thanks
> River
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Thursday, July 11, 2024 8:39 PM
> To: Huang, Trigger <Trigger.Huang@amd.com>; YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>
> Yeah, completely agree. This patch doesn't really make sense.
>
> Please explain why you would want to do this?
>
> Regards,
> Christian.
>
> Am 11.07.24 um 13:56 schrieb Huang, Trigger:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> This patch seems to be wrong.
>> Quite a lot of preparations have been done in amdgpu_bo_move_notify
>> For example, amdgpu_bo_kunmap() will be called to prevent the BO from being accessed by CPU. If not called, the CPU may attempt to access the BO while it is being moved.
>>
>> Thanks,
>> Trigger
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> YuanShang
>>> Sent: Thursday, July 11, 2024 5:10 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao
>>> (River) <YuanShang.Mao@amd.com>
>>> Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> It leads to race condition if amdgpu_bo is marked as invalid before
>>> it is really moved.
>>>
>>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 29e4b5875872..a29d5132ad3d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct
>>> ttm_buffer_object *bo, bool evict,
>>>
>>>           if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>                            bo->ttm == NULL)) {
>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   ttm_bo_move_null(bo, new_mem);
>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   return 0;
>>>           }
>>>           if (old_mem->mem_type == AMDGPU_GEM_DOMAIN_DGMA || @@ -
>>> 530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>>> *bo, bool evict,
>>>           if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>               (new_mem->mem_type == TTM_PL_TT ||
>>>                new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   ttm_bo_move_null(bo, new_mem);
>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   return 0;
>>>           }
>>>           if ((old_mem->mem_type == TTM_PL_TT || @@ -542,9 +542,9 @@
>>> static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>                           return r;
>>>
>>>                   amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   ttm_resource_free(bo, &bo->resource);
>>>                   ttm_bo_assign_mem(bo, new_mem);
>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   return 0;
>>>           }
>>>
>>> @@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct
>>> ttm_buffer_object *bo, bool evict,
>>>               new_mem->mem_type == AMDGPU_PL_OA ||
>>>               new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>                   /* Nothing to save here */
>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   ttm_bo_move_null(bo, new_mem);
>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>                   return 0;
>>>           }
>>>
>>> @@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct
>>> ttm_buffer_object *bo, bool evict,
>>>                   return -EMULTIHOP;
>>>           }
>>>
>>> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>           if (adev->mman.buffer_funcs_enabled)
>>>                   r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
>>>           else
>>>                   r = -ENODEV;
>>> +       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>
>>>           if (r) {
>>>                   /* Check that all memory is CPU accessible */
>>> --
>>> 2.25.1

