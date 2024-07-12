Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F176C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 07:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC9F10EC3E;
	Fri, 12 Jul 2024 07:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iZaC1s6b";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE61010EC3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 07:36:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-42662d80138so10526295e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720769782; x=1721374582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDtViol4g2LzhSS5XlhcbWFCymKU1QkxpglqbLets0M=;
 b=iZaC1s6bh4KVz9t73zjBqanXgT3mmEJ9IalITuD4UL62jD1hfUFPbUn7CWv7aLT2ob
 kyzEeg8XGjrNYtO8rC82CfZVomgzTdsKz2Dwgf1cd27tBpj8ZAk1bP2qDK/w4cg92Zb+
 q3kP2Ceb7axilQZf5TtrHnh5nlm/ernlmMwZ93Zr/yJUgzY4ocHVh6fmGfbE4I1XLJY0
 ysfjlXyjzK8YOu+ij7buDZlJBg2LuM9jgHV61mT+m6oVXmTmz6kDgdFRLCh/mb2OiVK2
 V6YkxXy3yRmyLApZaqFLtA7V1mI9ZQJ4g8yXLZfZnJbvDd3D1rNMVK+ifUCldCXjCb6m
 4kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720769782; x=1721374582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDtViol4g2LzhSS5XlhcbWFCymKU1QkxpglqbLets0M=;
 b=XtvViDdJPopDMXlVs5winucxn66Vwc5ItdrdGOa7x4zI8PzsQ8XCUWQUOiaGCxHsIW
 OU0sEHY5k3rWWJppso+XjJb/CP/zJry3f9Arb7H4L3mQi8RlCYyrQVfSmfh0oEimJmgy
 oeoaKq9FbKo5PopZaaTjYQ9t5Dp+c+/zkogFuh2ZxAM879PcigX1tLVqI2w/uwl+49tO
 q7Enf9aHGzlbVSp3JbQGhfMHDLhpVu035lz0Kh1OoPFMqz187qvQ98Pv+f0vHAxzpSy4
 tu97sUrhlLyHmJKm1AUipq5wJLo3qtkSzejaMNRgYmUqucBY6mFSVfxslbv4Cr4tNEla
 HHag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYT5WqIj6l707dr5YNiQ818O4UVZ3T5heAFteqD6cgfYExQiNuL9i0l8p+LtqL3cH7XIqXjT3OJ+ZAhsIoyMUR5VJKQF2CoOS9XMDqWA==
X-Gm-Message-State: AOJu0YxHsoRz6DEmwIyJ2SvwWM8SveZiA3vQODd3wy4WYY7uTvOjqRp6
 iD3jlky/rPA0VNxlEecGQBslDS6GFC98ybRX37SfrnOau3RYQRszjnH50GZ/
X-Google-Smtp-Source: AGHT+IFTPmR7P2NZ/Q7VDBFRP4PKkaNyvRUkGUdtSDMv4ClSjlKTcjb4udNjAcEl5dLijkdstSLtiw==
X-Received: by 2002:a05:600c:2109:b0:426:549b:dd7a with SMTP id
 5b1f17b1804b1-426708fa767mr68789365e9.36.1720769781642; 
 Fri, 12 Jul 2024 00:36:21 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa06ffsm9525275f8f.77.2024.07.12.00.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 00:36:21 -0700 (PDT)
Message-ID: <a2786797-738a-4263-b29f-654fc3fd4945@gmail.com>
Date: Fri, 12 Jul 2024 09:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
Cc: "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
 <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
 <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
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

well that is complete nonsense.

The BOs are not meant to be used with on demand faulting, so their VM 
state absolutely shouldn't matter to the KFD.

Regards,
Christian.

Am 12.07.24 um 04:54 schrieb YuanShang Mao (River):
> [AMD Official Use Only - AMD Internal Distribution Only]
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

