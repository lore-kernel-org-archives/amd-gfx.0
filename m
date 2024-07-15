Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E58C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA8810E399;
	Mon, 15 Jul 2024 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hevZFEzW";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176FD10E39A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:40:00 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so28422965e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721047198; x=1721651998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rV8CBz21NlvEp3orbP/l0+hZHUVgvwGgRpQc6amYZBI=;
 b=hevZFEzWqI7x9p6xpBkmRXCFcrU5/fhxwbWaQbHhI0e7iXLMjBi4alY/hZcrYqfZKi
 HSJq7u+ffN2tMlfZyF56SoISlbxQ2J+n0DAaeZBhrz3iPoKWR2qWhG/DNIu533oQoU1q
 JYzNaHelpzLrPmyoSxPcPslv66bZ9IV0WkYzXymvqfEOQY970uyo5lzITWIcRsi/07sU
 A/qSu+qsfWlSvwpsULfmpXRps+5wW03ft9qsR+d4MnoBqeTnHj42QWAL8dEBdSvaB/Du
 choSeA0iMny7InHTT2LIVz6Pc4KzIpoI3JexxgXaN7FcZIhwU4owreBwoTpf+qE0XqwS
 edNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721047198; x=1721651998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rV8CBz21NlvEp3orbP/l0+hZHUVgvwGgRpQc6amYZBI=;
 b=qqKew7qpew/R0qZP3T5ZXG2uIxdl3EztECVX0pg3QL8PRXwrOUMSy1rXQr8sLMupVK
 FbM5BuRnWaP30/6GdH7eIo0n+rr2JgqXFsQCEkxF1zc2f5/pf3Ncf+kJrcf/O4THbDqM
 vqAg7Zs0ZSoVjerUDyyEMB+MwutjkQ17QbXAzRgy227Qr2bbzBUxHQktBLDS0Hpmuqat
 vPYwVu2+hizZfOURAs5kMW5ia3/jP7xTo1WGbikRWTfSTNQNypNrxMyLeldJ3ahhmAmb
 Bq2JJKBQrbV8SvYIPvK2krZww44OB/sdzvRRxiC1X0mPG06LF2s9CFpzqTP9V+WhiFGB
 t1ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHleaj4EYPhekqo/H1qekDIgS+uvxFbEsHAKlLnfyUNfETEbaQojSVepC42DqPPe3rAKssGPqwxir7GH/yyqoyYHPxZNJk62DjSyz7MA==
X-Gm-Message-State: AOJu0Yz60IgcZBHaOUOhpLLcgAtWXIJSFTKu0TJil41UyYOIp7gvjeDZ
 qhFM24tkCpkELMNfzQ+L8jKV8ZoOzucSSJIUU3Z8+4jBS0tbEfQI1rkWbw==
X-Google-Smtp-Source: AGHT+IFm0DietgTRl9Y7vkbhMTpLQvS3tpSy4RdWJdZG6dycR1OrWK3vfMSEhd6oeZmw5KIdTXMBGQ==
X-Received: by 2002:a05:600c:55ce:b0:426:6ea7:3838 with SMTP id
 5b1f17b1804b1-426708f1dd5mr112461675e9.27.1721047197875; 
 Mon, 15 Jul 2024 05:39:57 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23984fsm121026095e9.7.2024.07.15.05.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 05:39:57 -0700 (PDT)
Message-ID: <d892bc3f-20ad-4074-baec-c9de456eabbf@gmail.com>
Date: Mon, 15 Jul 2024 14:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
To: Felix Kuehling <felix.kuehling@amd.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "cao, lin" <lin.cao@amd.com>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
 <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
 <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <PH0PR12MB5420453D1FF4C3834CDCFB4EE0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <ad162a88-7549-4fc0-9102-3f45b1e8ef73@gmail.com>
 <748a49bd-0726-46b1-a94e-6c4333fb219c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <748a49bd-0726-46b1-a94e-6c4333fb219c@amd.com>
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

Hi Felix,

yes that is a perfectly expected consequence.

The last time we talked about it the problem to solve this was that 
amdgpu_vm_sdma_prepare() couldn't read the fences from a resv object 
which wasn't locked.

That happens both during amdgpu_vm_handle_moved() as well as unlocked in 
validations of the page tables.

IIRC we postponed looking into the issue until it really becomes a 
problem which is probably now :)

Regards,
Christian.

Am 12.07.24 um 16:56 schrieb Felix Kuehling:
> KFD eviction fences are triggered by the enable_signaling callback on the eviction fence. Any move operations scheduled by amdgpu_bo_move are held up by the GPU scheduler until the eviction fence is signaled by the KFD eviction handler, which only happens after the user mode queues are stopped.
>
> As I understand it, VM BO invalidation does not unmap anything from the page table itself. So the KFD queues are OK continue running until the eviction handler stops them and signals the fence.
>
> However, if amdgpu_vm_handle_moved gets called before the eviction fence is signaled, then there could be a problem. In applications that do compute-graphics interop, the VM is shared between compute and graphics. So graphics and compute submissions at the same time are possible. @Christian, this is a concequence of using libdrm and insisting that each process uses only a single VM per GPU.
>
> Regards,
>    Felix
>
> On 2024-07-12 3:39, Christian König wrote:
>> Hi River,
>>
>> well that isn't an error at all, this is perfectly expected behavior.
>>
>> The VMs used by the KFD process are currently not meant to be used by classic CS at the same time.
>>
>> This is one of the reasons for that.
>>
>> Regards,
>> Christian.
>>
>> Am 12.07.24 um 09:35 schrieb YuanShang Mao (River):
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Add more info and CC @Kuehling, Felix @cao, lin
>>>
>>> In amdgpu_amdkfd_fence.c, there is a design description:
>>>
>>> /* Eviction Fence
>>>    * Fence helper functions to deal with KFD memory eviction.
>>>    * Big Idea - Since KFD submissions are done by user queues, a BO cannot be
>>>    *  evicted unless all the user queues for that process are evicted.
>>>    *
>>>    * All the BOs in a process share an eviction fence. When process X wants
>>>    * to map VRAM memory but TTM can't find enough space, TTM will attempt to
>>>    * evict BOs from its LRU list. TTM checks if the BO is valuable to evict
>>>    * by calling ttm_device_funcs->eviction_valuable().
>>>    *
>>>    * ttm_device_funcs->eviction_valuable() - will return false if the BO belongs
>>>    *  to process X. Otherwise, it will return true to indicate BO can be
>>>    *  evicted by TTM.
>>>    *
>>>    * If ttm_device_funcs->eviction_valuable returns true, then TTM will continue
>>>    * the evcition process for that BO by calling ttm_bo_evict --> amdgpu_bo_move
>>>    * --> amdgpu_copy_buffer(). This sets up job in GPU scheduler.
>>>    *
>>>    * GPU Scheduler (amd_sched_main) - sets up a cb (fence_add_callback) to
>>>    *  nofity when the BO is free to move. fence_add_callback --> enable_signaling
>>>    *  --> amdgpu_amdkfd_fence.enable_signaling
>>>    *
>>>    * amdgpu_amdkfd_fence.enable_signaling - Start a work item that will quiesce
>>>    * user queues and signal fence. The work item will also start another delayed
>>>    * work item to restore BOs
>>>    */
>>>
>>> If mark BOs as invalidated before submitting job to move the buffer, user queue is still active.
>>> During the time before user queue is evicted, if a drm job achieve, amdgpu_cs_vm_handling will call amdgpu_vm_handle_moved to clear the ptes of
>>> Invalidated BOs. Then page fault happens because compute shader is still accessing the "invalidated" BO.
>>>
>>> I am not familiar with amdgpu_vm_bo state machine, so I don’t know if it is an code error or an design error.
>>>
>>> Thanks
>>> River
>>>
>>>
>>> -----Original Message-----
>>> From: YuanShang Mao (River)
>>> Sent: Friday, July 12, 2024 10:55 AM
>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Cc: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>
>>> We need to make sure that all BOs of an active kfd process validated. Moving buffer will trigger process eviction.
>>> If mark it as invalided before process eviction, related kfd process is still active and may attempt to access this invalidated BO.
>>>
>>> Agree with Trigger. Seems kfd eviction should been synced to move notify, not the move action.
>>>
>>> Thanks
>>> River
>>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Thursday, July 11, 2024 8:39 PM
>>> To: Huang, Trigger <Trigger.Huang@amd.com>; YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>
>>> Yeah, completely agree. This patch doesn't really make sense.
>>>
>>> Please explain why you would want to do this?
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 11.07.24 um 13:56 schrieb Huang, Trigger:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> This patch seems to be wrong.
>>>> Quite a lot of preparations have been done in amdgpu_bo_move_notify
>>>> For example, amdgpu_bo_kunmap() will be called to prevent the BO from being accessed by CPU. If not called, the CPU may attempt to access the BO while it is being moved.
>>>>
>>>> Thanks,
>>>> Trigger
>>>>
>>>>> -----Original Message-----
>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>> YuanShang
>>>>> Sent: Thursday, July 11, 2024 5:10 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao
>>>>> (River) <YuanShang.Mao@amd.com>
>>>>> Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>>>
>>>>> Caution: This message originated from an External Source. Use proper
>>>>> caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>> It leads to race condition if amdgpu_bo is marked as invalid before
>>>>> it is really moved.
>>>>>
>>>>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>>>>>     1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 29e4b5875872..a29d5132ad3d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct
>>>>> ttm_buffer_object *bo, bool evict,
>>>>>
>>>>>            if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>>                             bo->ttm == NULL)) {
>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    ttm_bo_move_null(bo, new_mem);
>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    return 0;
>>>>>            }
>>>>>            if (old_mem->mem_type == AMDGPU_GEM_DOMAIN_DGMA || @@ -
>>>>> 530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>>>>> *bo, bool evict,
>>>>>            if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>>                (new_mem->mem_type == TTM_PL_TT ||
>>>>>                 new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    ttm_bo_move_null(bo, new_mem);
>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    return 0;
>>>>>            }
>>>>>            if ((old_mem->mem_type == TTM_PL_TT || @@ -542,9 +542,9 @@
>>>>> static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>>                            return r;
>>>>>
>>>>>                    amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    ttm_resource_free(bo, &bo->resource);
>>>>>                    ttm_bo_assign_mem(bo, new_mem);
>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    return 0;
>>>>>            }
>>>>>
>>>>> @@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct
>>>>> ttm_buffer_object *bo, bool evict,
>>>>>                new_mem->mem_type == AMDGPU_PL_OA ||
>>>>>                new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>                    /* Nothing to save here */
>>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    ttm_bo_move_null(bo, new_mem);
>>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>                    return 0;
>>>>>            }
>>>>>
>>>>> @@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct
>>>>> ttm_buffer_object *bo, bool evict,
>>>>>                    return -EMULTIHOP;
>>>>>            }
>>>>>
>>>>> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>            if (adev->mman.buffer_funcs_enabled)
>>>>>                    r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
>>>>>            else
>>>>>                    r = -ENODEV;
>>>>> +       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>>
>>>>>            if (r) {
>>>>>                    /* Check that all memory is CPU accessible */
>>>>> -- 
>>>>> 2.25.1

