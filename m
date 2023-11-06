Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A66C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 12:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F3310E06E;
	Mon,  6 Nov 2023 12:31:56 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A988010E06E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 12:31:53 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40839807e82so26750585e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Nov 2023 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699273912; x=1699878712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mT8DshFByZi1cB9vHhL3aykt3S8oLYv9ECCteWxYwzY=;
 b=LUkHDWoZnmFPR3P/eOIk+MNMAFSBU1kscR+CAKRJQG05/8GLIc7EzPRFVUf2liAPA1
 /hfyfw6X9flwUWkr/WqjZGcU334ulDdzHmybP/XqrRuzNtW9tGZ2uuMLod+j7i7fZgOo
 zDoyPfkk0nxXBAoQ0nxAyVkKcOom4g2+Xm9uWMZSgaRRmBRo8tUrFRTSkv4K0cJbS6Eo
 GvJrdHPggBbe1yrzXo7a92H2YPn2WFmVVZBLtQ70LNuZw8QZuqaJOV5NBVTjql9AeZuY
 musqUF32ByU79PAdhXu4AeENRg9f/Qi0mSQaaEgi4x5kvfvCXZh/5O6/XILuTaaiIXfY
 +9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699273912; x=1699878712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mT8DshFByZi1cB9vHhL3aykt3S8oLYv9ECCteWxYwzY=;
 b=eoULLwbieDBwH8KwdEmvsdxUrLbmtk2l9ivxVU7v77FKC9LPTtBG3TNBDgQD7ZBkVH
 /yo3ff0x1rAHgvn2I8uAch/Frm6jwbsjzK5SgQ7NWAoqwA+cF5R0hSOl4TKwe8tx//Mw
 ERq+keSYwLJlOoC+K9QqvWXP4nDlmWMERli2xTS3w0pJn8ffc1E+TDb9JJUswOUMasL3
 FVDCuGAVkK/031adk1N3A19RXtFjtKertL80eLfhQMkbNV1IeT3dRwTOtBlCcUwtrpEO
 aiAbGs6rdrkObRHZbJRHNmBFMeaGbIk0qmRGd8/CXEZTe+ZN0hiyPJGEa4ZafOBrYv0l
 KNig==
X-Gm-Message-State: AOJu0YyLv6NYv6Z7T6WOdLpnRsfXa4FC2UZvcGCWk/OX3ZiEGvZcR+7A
 BNKOP5UjAPwmYJSefEYsSi7WTBJpnWWwog==
X-Google-Smtp-Source: AGHT+IFinoWz6D4AiHc682nzMWsj0+zhKJdyejWGC1HBHjZaTUkYl1pe209cIFc2wifu0AhN2zBVeg==
X-Received: by 2002:a05:600c:3c91:b0:405:3924:3cad with SMTP id
 bg17-20020a05600c3c9100b0040539243cadmr12006844wmb.15.1699273911406; 
 Mon, 06 Nov 2023 04:31:51 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 fb14-20020a05600c520e00b0040841e79715sm11803511wmb.27.2023.11.06.04.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 04:31:50 -0800 (PST)
Message-ID: <d71eacf2-6a2c-4993-9fd5-0280aa2d9ee1@gmail.com>
Date: Mon, 6 Nov 2023 13:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix error handling in amdgpu_vm_init
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20231031145534.2501-1-christian.koenig@amd.com>
 <CADnq5_N1St5NDG-uAtVnEcj1P+f0jt-Rp-3kND_XjTTbqmbbGw@mail.gmail.com>
 <9622bd17-a526-48d2-b3c3-f5e7bbd82ecf@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <9622bd17-a526-48d2-b3c3-f5e7bbd82ecf@amd.com>
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
Cc: Alexander.Deucher@amd.com, Kenny.Ho@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.11.23 um 23:00 schrieb Felix Kuehling:
> On 2023-10-31 11:18, Alex Deucher wrote:
>> On Tue, Oct 31, 2023 at 11:12 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> When clearing the root PD fails we need to properly release it again.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Has this been submitted? I see some intermittent failures in the PSDB 
> that may be related to this.

Not yet. But going to push that now

This is just a fix for the error code path. Fixing the underlying 
problem had more importance.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 
>>> +++++++++++++-------------
>>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index d72daf15662f..5877f6e9b893 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2042,7 +2042,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, 
>>> long timeout)
>>>    * Returns:
>>>    * 0 for success, error for failure.
>>>    */
>>> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm 
>>> *vm, int32_t xcp_id)
>>> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +                  int32_t xcp_id)
>>>   {
>>>          struct amdgpu_bo *root_bo;
>>>          struct amdgpu_bo_vm *root;
>>> @@ -2061,6 +2062,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm, int32_t xcp
>>>          INIT_LIST_HEAD(&vm->done);
>>>          INIT_LIST_HEAD(&vm->pt_freed);
>>>          INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>> +       INIT_KFIFO(vm->faults);
>>>
>>>          /* create scheduler entities for page table updates */
>>>          r = drm_sched_entity_init(&vm->immediate, 
>>> DRM_SCHED_PRIORITY_NORMAL,
>>> @@ -2103,34 +2105,33 @@ int amdgpu_vm_init(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm, int32_t xcp
>>>                                  false, &root, xcp_id);
>>>          if (r)
>>>                  goto error_free_delayed;
>>> -       root_bo = &root->bo;
>>> +
>>> +       root_bo = amdgpu_bo_ref(&root->bo);
>>>          r = amdgpu_bo_reserve(root_bo, true);
>>> -       if (r)
>>> -               goto error_free_root;
>>> +       if (r) {
>>> +               amdgpu_bo_unref(&root->shadow);
>>> +               amdgpu_bo_unref(&root_bo);
>>> +               goto error_free_delayed;
>>> +       }
>>>
>>> +       amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
>>>          r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
>>>          if (r)
>>> -               goto error_unreserve;
>>> -
>>> -       amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
>>> +               goto error_free_root;
>>>
>>>          r = amdgpu_vm_pt_clear(adev, vm, root, false);
>>>          if (r)
>>> -               goto error_unreserve;
>>> +               goto error_free_root;
>>>
>>>          amdgpu_bo_unreserve(vm->root.bo);
>>> -
>>> -       INIT_KFIFO(vm->faults);
>>> +       amdgpu_bo_unref(&root_bo);
>>>
>>>          return 0;
>>>
>>> -error_unreserve:
>>> -       amdgpu_bo_unreserve(vm->root.bo);
>>> -
>>>   error_free_root:
>>> -       amdgpu_bo_unref(&root->shadow);
>>> +       amdgpu_vm_pt_free_root(adev, vm);
>>> +       amdgpu_bo_unreserve(vm->root.bo);
>>>          amdgpu_bo_unref(&root_bo);
>>> -       vm->root.bo = NULL;
>>>
>>>   error_free_delayed:
>>>          dma_fence_put(vm->last_tlb_flush);
>>> -- 
>>> 2.34.1
>>>

