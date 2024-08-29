Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E9C71135
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 09:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5ED110E1AF;
	Thu, 29 Aug 2024 09:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XwV+90pp";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A016A10E12E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 09:48:46 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8abeso668005e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724924925; x=1725529725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6yElEG6O7YJSw8FYvMON2Z4I0Wkc90cuseeVABniHRo=;
 b=XwV+90pp9nG2bY/MoBtkyte5QGsMet7zMTbgnZyMjj/e6GVDmw+w0eczcF8LOS3xeM
 GuarTxhV2J3LVB+1KX+CaS8+RsG5XERAzAyD/WA+dBqrO7L0Fy1yJ0DxLh4tV3Mx4Pop
 /29+HCfYKQQaSiz9d8lr7dQzy8px3WrinRgJY84H3xtdwZg5aRslDAdPCiWxwjPKnHXL
 9j/ggwfl/XEZTmUFn+LkqJMsIXcgIBIDuo0csq4CWOTh+5MWMiFyBBLlQ5d1pX9LkWjT
 hkkAbrS1AWfqCgq4GYDQ9PyrISSkF849lMmbC9UpliEJ3rGpp7PSymBCw15i3pcmPuBC
 /kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724924925; x=1725529725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6yElEG6O7YJSw8FYvMON2Z4I0Wkc90cuseeVABniHRo=;
 b=mPXZmzeVYtkDI6RFGRwsuS9E/9g3mbdJbS/dBJx6hMelCsbDvee00aBnajk6gWq99e
 XJAsZ0jQM2+Fa8Ki3YacChdBTX2onoSDmNZ8EVVSfULikaJMpLBJX3lPst+m8f/43lzN
 wFFAfjOj8GL4hwKENjD0yxHAzbb4AwRFxjORjwUf9nUL16it/EEoAJkNKkST3eZeZgoE
 2rFZeipDUrE3axtdt15FzeQnQQAk+ZwuLQnnPnu9PTLXm4Pj7UCYK/FzrjybPklrJ9AR
 TJL4Hsn87m+4+a8d/vJDiu3pH4ooEVFE7POEm3CDRc0Bvvx4r5nuVCbpcNsa4ZFIQd/O
 8CaA==
X-Gm-Message-State: AOJu0YyoN5R3BFkhydHrW92bpIvDr1N9hBPMgWekbIXAhNdFq3oNG7Rs
 VQZzbe6GAwfeW3PfiNjPGVqHQa7YEI6hIVyb36LLAPkgDcnvKMo0
X-Google-Smtp-Source: AGHT+IEoIOBjbQ2A5XI1TOed8R/NXQJesxS+4aveRHAd4PL6mdmcZ9NBtzfEsbEMR0tiugPcRvUlZA==
X-Received: by 2002:a05:600c:4693:b0:426:6ed5:fd5 with SMTP id
 5b1f17b1804b1-42bb01ae664mr17159145e9.6.1724924924116; 
 Thu, 29 Aug 2024 02:48:44 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42b9d9561b1sm56285505e9.0.2024.08.29.02.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 02:48:43 -0700 (PDT)
Message-ID: <c9bb85b6-5386-415f-b169-b89d2e7d8cb0@gmail.com>
Date: Thu, 29 Aug 2024 11:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: sync to KFD fences before clearing PTEs
To: Felix Kuehling <felix.kuehling@amd.com>, friedrich.vock@gmx.de,
 bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
 <20240821120324.4583-2-christian.koenig@amd.com>
 <a511a28c-13d7-452f-96bd-911148c4d175@amd.com>
 <4968a387-d82a-404c-8ff9-7e4406ef33d2@gmail.com>
 <dea2c696-9944-47d3-9348-b12a52f42892@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <dea2c696-9944-47d3-9348-b12a52f42892@amd.com>
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

Am 29.08.24 um 00:40 schrieb Felix Kuehling:
>
> On 2024-08-22 05:07, Christian König wrote:
>> Am 21.08.24 um 22:01 schrieb Felix Kuehling:
>>> On 2024-08-21 08:03, Christian König wrote:
>>>> This patch tries to solve the basic problem we also need to sync to
>>>> the KFD fences of the BO because otherwise it can be that we clear
>>>> PTEs while the KFD queues are still running.
>>>
>>> This is going to trigger a lot of phantom KFD evictions and will 
>>> tank performance. It's probably not what you intended.
>>
>> I tried to avoid that by only waiting for the KFD fence only in the 
>> particular situation that we can't lock the cleared BO because of 
>> contention.
>
> OK. It's hard to make out where you're adding that call with the small 
> context in the patch. As far as I can tell it's in the "if (clear || 
> !bo)" branch. The "clear" case is as you mention, only used when the 
> BO cannot be locked. The !bo case is PRT?

Yes, exactly that.

>
> Contention would happen, if this runs concurrently with a 
> restore-from-eviction, in which case we're already on a slow path and 
> another eviction doesn't matter (as long as we're not getting into a 
> live-lock situation). Or if a KFD BO is in the middle of being mapped 
> or unmapped by another thread, which should be unlikely. So maybe this 
> won't have a huge impact in practice. It's worth a try.
>
> The patch is
>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>

Let's see if this works or not in practice.

Thanks,
Christian.

>
>
>>
>> The only short term alternative I can see is to lock all BOs during 
>> CS and that is a) a really large rework and b) will most likely hurt 
>> performance.
>>
>> Then there is the alternative to lock the VM during BO eviction, but 
>> that means we need to wait on using the drm_exec object inside TTM as 
>> well. So that won't get this fixed in the next halve year or so.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 30 
>>>> ++++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  6 +++++
>>>>   3 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> index bdf1ef825d89..c586ab4c911b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> @@ -260,6 +260,36 @@ int amdgpu_sync_resv(struct amdgpu_device 
>>>> *adev, struct amdgpu_sync *sync,
>>>>       return 0;
>>>>   }
>>>>   +/**
>>>> + * amdgpu_sync_kfd - sync to KFD fences
>>>> + *
>>>> + * @sync: sync object to add KFD fences to
>>>> + * @resv: reservation object with KFD fences
>>>> + *
>>>> + * Extract all KFD fences and add them to the sync object.
>>>> + */
>>>> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
>>>> +{
>>>> +    struct dma_resv_iter cursor;
>>>> +    struct dma_fence *f;
>>>> +    int r = 0;
>>>> +
>>>> +    dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
>>>> +    dma_resv_for_each_fence_unlocked(&cursor, f) {
>>>> +        void *fence_owner = amdgpu_sync_get_owner(f);
>>>> +
>>>> +        if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
>>>> +            continue;
>>>> +
>>>> +        r = amdgpu_sync_fence(sync, f);
>>>> +        if (r)
>>>> +            break;
>>>> +    }
>>>> +    dma_resv_iter_end(&cursor);
>>>> +
>>>> +    return r;
>>>> +}
>>>> +
>>>>   /* Free the entry back to the slab */
>>>>   static void amdgpu_sync_entry_free(struct amdgpu_sync_entry *e)
>>>>   {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>> index cf1e9e858efd..e3272dce798d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>>>> @@ -51,6 +51,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, 
>>>> struct dma_fence *f);
>>>>   int amdgpu_sync_resv(struct amdgpu_device *adev, struct 
>>>> amdgpu_sync *sync,
>>>>                struct dma_resv *resv, enum amdgpu_sync_mode mode,
>>>>                void *owner);
>>>> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
>>>>   struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>>>>                        struct amdgpu_ring *ring);
>>>>   struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index ba99d428610a..13d429b91327 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1168,6 +1168,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>> *adev, struct amdgpu_bo_va *bo_va,
>>>>                        AMDGPU_SYNC_EQ_OWNER, vm);
>>>>           if (r)
>>>>               goto error_free;
>>>> +        if (bo) {
>>>> +            r = amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
>>>> +            if (r)
>>>> +                goto error_free;
>>>> +        }
>>>> +
>>>>       } else {
>>>>           struct drm_gem_object *obj = &bo->tbo.base;
>>

