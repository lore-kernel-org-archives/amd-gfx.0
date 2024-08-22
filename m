Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396D9C5320E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 09:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD5410E809;
	Thu, 22 Aug 2024 09:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m0/0pa9p";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5F610E823
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 09:07:10 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-429da8b5feaso4866685e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724317628; x=1724922428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjNUxqznhvmKNyiOk/SUcNSfwRpqNNVUsBEaTGO9oZ0=;
 b=m0/0pa9pDen09zqUDkndUnAPIOvQ4ti74Btgm037Tf4a/sYpdTYU7Z+j2nNh3v3Q9T
 w2C+5JMPu87SOiHrBlNXqMsaukfv2LZcKmSUnKVR5u3wrF//dx8ZarWlfAaQeIBiJyC/
 2HeOpoZuQa3+xKyuqcAfcxAC+suawJSrlJzlBVZwcylrdkE8mqX3VZMW3RY5Bi+8M2yT
 VOcw7MfTB9M6DVn3p/rTacehCJKaJrcEVHDXeZQ9YVgmpxr7ievv0pMJ6e5Q82EHBpOr
 RP2dHfMtg+lbvOrm2Pt0/f5c+wosDbwx+8RF6XnA6SoUY3NmdWHBbg3G2dnM8iTBKTrc
 AQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724317628; x=1724922428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sjNUxqznhvmKNyiOk/SUcNSfwRpqNNVUsBEaTGO9oZ0=;
 b=VRAem9OdFpC5gtQ1UVNgMB38Wp0g5b07SJjS+ZP/0gr/0i/Imo9wVEnq9O4LcqU290
 7mac5fPhGdxOyzOfKF98LO/RobQI9Yw5WczPPfg+wAl9UxDYccdaCjssnewJx34EMMxe
 iiagNj6C1sPzQq0P8r74KeNmLdpk0PNzwY1Rn1ek34c8n4tBtRMmNuozfMzMY3ZuANfi
 4AcD4+cXfxEehNcF7+dhAOqsspgW5+Pu3TyxKk8YWaXX33LNeESgBLyAi62c4D6apmIL
 Stt1SteplZl9FQL9jt3iSiuKveCsUE+zrgat1X7PevzJFZaYf9PcCJ/QetPVMB4QIVis
 ScdQ==
X-Gm-Message-State: AOJu0YyFWbAJcLCIQl4S/bsPzGax7g8s8//PbhQ5fver4GjhcdlPP7dR
 f9SEzOE6HduHV6RCYbrMgGH4224h1/cD3LycGjW3FfWPieEMo5k4
X-Google-Smtp-Source: AGHT+IEQwJnnYj54g7d1Hfk6JvVHCLl4wQKWYObajyeoKoM/P8VFLyi1/YuIXPRRPHQ0ooK/izZG+A==
X-Received: by 2002:a05:600c:b9a:b0:429:a3e:c786 with SMTP id
 5b1f17b1804b1-42ac5628e05mr11597135e9.24.1724317627952; 
 Thu, 22 Aug 2024 02:07:07 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac514e1d0sm17341905e9.1.2024.08.22.02.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 02:07:07 -0700 (PDT)
Message-ID: <4968a387-d82a-404c-8ff9-7e4406ef33d2@gmail.com>
Date: Thu, 22 Aug 2024 11:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: sync to KFD fences before clearing PTEs
To: Felix Kuehling <felix.kuehling@amd.com>, friedrich.vock@gmx.de,
 bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
 <20240821120324.4583-2-christian.koenig@amd.com>
 <a511a28c-13d7-452f-96bd-911148c4d175@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a511a28c-13d7-452f-96bd-911148c4d175@amd.com>
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

Am 21.08.24 um 22:01 schrieb Felix Kuehling:
> On 2024-08-21 08:03, Christian König wrote:
>> This patch tries to solve the basic problem we also need to sync to
>> the KFD fences of the BO because otherwise it can be that we clear
>> PTEs while the KFD queues are still running.
>
> This is going to trigger a lot of phantom KFD evictions and will tank 
> performance. It's probably not what you intended.

I tried to avoid that by only waiting for the KFD fence only in the 
particular situation that we can't lock the cleared BO because of 
contention.

The only short term alternative I can see is to lock all BOs during CS 
and that is a) a really large rework and b) will most likely hurt 
performance.

Then there is the alternative to lock the VM during BO eviction, but 
that means we need to wait on using the drm_exec object inside TTM as 
well. So that won't get this fixed in the next halve year or so.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 30 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  6 +++++
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> index bdf1ef825d89..c586ab4c911b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> @@ -260,6 +260,36 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, 
>> struct amdgpu_sync *sync,
>>       return 0;
>>   }
>>   +/**
>> + * amdgpu_sync_kfd - sync to KFD fences
>> + *
>> + * @sync: sync object to add KFD fences to
>> + * @resv: reservation object with KFD fences
>> + *
>> + * Extract all KFD fences and add them to the sync object.
>> + */
>> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
>> +{
>> +    struct dma_resv_iter cursor;
>> +    struct dma_fence *f;
>> +    int r = 0;
>> +
>> +    dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
>> +    dma_resv_for_each_fence_unlocked(&cursor, f) {
>> +        void *fence_owner = amdgpu_sync_get_owner(f);
>> +
>> +        if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
>> +            continue;
>> +
>> +        r = amdgpu_sync_fence(sync, f);
>> +        if (r)
>> +            break;
>> +    }
>> +    dma_resv_iter_end(&cursor);
>> +
>> +    return r;
>> +}
>> +
>>   /* Free the entry back to the slab */
>>   static void amdgpu_sync_entry_free(struct amdgpu_sync_entry *e)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> index cf1e9e858efd..e3272dce798d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> @@ -51,6 +51,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, 
>> struct dma_fence *f);
>>   int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync 
>> *sync,
>>                struct dma_resv *resv, enum amdgpu_sync_mode mode,
>>                void *owner);
>> +int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
>>   struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>>                        struct amdgpu_ring *ring);
>>   struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index ba99d428610a..13d429b91327 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1168,6 +1168,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>> *adev, struct amdgpu_bo_va *bo_va,
>>                        AMDGPU_SYNC_EQ_OWNER, vm);
>>           if (r)
>>               goto error_free;
>> +        if (bo) {
>> +            r = amdgpu_sync_kfd(&sync, bo->tbo.base.resv);
>> +            if (r)
>> +                goto error_free;
>> +        }
>> +
>>       } else {
>>           struct drm_gem_object *obj = &bo->tbo.base;

