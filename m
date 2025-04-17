Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A586EC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 07:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDF410E16B;
	Thu, 17 Apr 2025 07:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HUxdb1lt";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85A810E16B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 07:39:46 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so9036525e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744875585; x=1745480385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UMbddTsOAJfYZzdedQ7ccwYPXjfIK8mQE1jDQD2a3D0=;
 b=HUxdb1ltMawIg305nQ7nKa1jiIlPIvpfBCi/J47lzRmJp6AMsGi1ob+CbYwUovU3My
 FtGP58tfKex2GoimPb9HmAexfPP82rE5FIjwGBiyVOxqQNf+aYFjkOAuyg/RBaDHS1ub
 H4q53TEpu8D1C9tYg5oDZw9Go5AIjr7JeBVSXZMT8AZv8ixgKC2QUuLFARE9usZgisyC
 bInyE0IHJT5C3IUnbUlESbicemiKO3TputhTb4MAxH2DwCCd4c9/ofNZpt/j6W6dlQWp
 oCxtyDtrcRvxBgTzezkS/9gQ4iJOefvRItPn4Wo3c61daRvrp8HvBAQ6Ao5+jnuitmps
 W4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744875585; x=1745480385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMbddTsOAJfYZzdedQ7ccwYPXjfIK8mQE1jDQD2a3D0=;
 b=JpY38bTabgyTPPYgxyKlBqjOWyMGyVfEz68U9NKvYWGb0llfYPU+cG4elbXEtFlUWt
 FX0dHBJ8aLrDKlAJd3JsBFh8bL6vIJme5/+b2zSLwF60fGCx4B4qEMZnGb8Jg8OF1VtN
 GPAtu4oy9jjY1HE64yBJj4YccvmH3UdpGGSHi+jf23+0F2S5aBTmlM4qYEonZ+Rx2pmd
 26+QT1KNXqnv8nkMVGxe2ocg0OjoyejekaPhNs7cxec8vCDWH5OWQi9CPGouydBX0/P2
 kteBdFBnqtmmAlEz9NOo4HZuJeefyRgLzGVaMIFD5uU7tLcsQe7RqFs7PeVKoy6TycCU
 YPhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFBMguG9t/UVxbaYu6ciqsbHSXzqzepIonhZyBUxQ5vFak2NQUeWCX8hEamc1GIfDbkEIfAA/X@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkUWgYMNTh6aagUKySmWZKp6Av5ibtwS6afTVIsmWa9iWzpIXd
 v7xPCdBMfVD5C5suIeNP75NuhSKH3w4zlswtS31d+RBzabi0CWSj
X-Gm-Gg: ASbGnct4Apl7AmfJtNbdZ+vPRFAEjZxcY4l9kit33XxkBhLGQdlYVUVqv1wBrOxc0OW
 LghqvD8uUSXh79/UI+2hbA2m2OrMT8+oNDt7NuuioW2N7s0N66PBquMgIaZ4lUdSkRFKiqpTbil
 oAD+8Wg9jF3gL5BAwzs+ubpsdLZDeHjU73/ec86KiWanbESiA8XAeTmTEUNcvPyvO2GBORqG0DG
 6mXsm6jxYb0sNhNVkuugcrB6dx3j53JF1icLCcbIG4VbOreo5k7eQT/pLJIY1vkyguxF8PU7Fr2
 BfXh3eD9e1+wYDsAsh7E1qLngHBK9QfIO8HyOh1aK6ZM9hnNUnoRaAnOAQ8v782cjMHueA==
X-Google-Smtp-Source: AGHT+IG3aMlHw0Hx1h+ZMHkUFFozJcuG+wj3jnhfpBMAdJCQxdzRKyxZ6wDUljlpqwOAurGSyWRilg==
X-Received: by 2002:a5d:5f52:0:b0:39c:30f7:a599 with SMTP id
 ffacd0b85a97d-39eea304084mr1302018f8f.18.1744875585302; 
 Thu, 17 Apr 2025 00:39:45 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b58d0d9sm42933765e9.31.2025.04.17.00.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 00:39:44 -0700 (PDT)
Message-ID: <1a4990eb-a0cd-43fb-95aa-19dcae93e03c@gmail.com>
Date: Thu, 17 Apr 2025 09:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
 <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
 <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 16.04.25 um 16:47 schrieb Liang, Prike:
> [Public]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 16, 2025 7:07 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
>>
>> Am 16.04.25 um 10:50 schrieb Prike Liang:
>>> Free the evf when the attached bo released. The evf still be dependent
>>> on and referred to by the attached bo that is scheduled by the kernel
>>> queue SDMA or gfx after the evf signalled.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 31 ++++++++++++++++---
>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  1 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  1 +
>>>  3 files changed, 28 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index b34225bbd85d..60be1ac5047d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -27,6 +27,7 @@
>>>
>>>  #define work_to_evf_mgr(w, name) container_of(w, struct
>>> amdgpu_eviction_fence_mgr, name)  #define evf_mgr_to_fpriv(e)
>>> container_of(e, struct amdgpu_fpriv, evf_mgr)
>>> +#define fence_to_evf(f)  container_of(f, struct
>>> +amdgpu_eviction_fence, base)
>>>
>>>  static const char *
>>>  amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence) @@
>>> -47,7 +48,7 @@ int  amdgpu_eviction_fence_replace_fence(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>                                 struct drm_exec *exec)
>>>  {
>>> -   struct amdgpu_eviction_fence *old_ef, *new_ef;
>>> +   struct amdgpu_eviction_fence *new_ef;
>>>     struct drm_gem_object *obj;
>>>     unsigned long index;
>>>     int ret;
>>> @@ -72,7 +73,6 @@ amdgpu_eviction_fence_replace_fence(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>
>>>     /* Update the eviction fence now */
>>>     spin_lock(&evf_mgr->ev_fence_lock);
>>> -   old_ef = evf_mgr->ev_fence;
>>>     evf_mgr->ev_fence = new_ef;
>>>     spin_unlock(&evf_mgr->ev_fence_lock);
>>>
>>> @@ -102,9 +102,6 @@ amdgpu_eviction_fence_replace_fence(struct
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>             }
>>>     }
>>>
>>> -   /* Free old fence */
>>> -   if (old_ef)
>>> -           dma_fence_put(&old_ef->base);
>> That change looks completely incorrect to me, you will now leak the old fence.
> The eviction fence is attached and shared by all the restored validated VM BOs during UQ restore, and at this placement the eviction fence is only detached from one of the BOs. Using amdgpu_userq_remove_all_eviction_fences() will walk over the resv objects and detach the fence from the resv objs when freeing the BO.

Yeah, but that doesn't justify this change here. See you're completely messing up the fence reference count with that.

>
> But there's a problem: even though dropping all the evf attached to VM BOs with this patch, the evf still referred to by the SDMA and GFX kernel queue jobs at the case when enabling the kq and uq at the same time. Thoughts?

Mhm, the eviction fence is always added as bookmark isn't it? As long as the GFX and SDMA jobs are not for evicting something then they should only depend on fences with usage < bookmark.

Can you dig up when they are added to the dependencies of the job?

Thanks,
Christian.

PS: Please stop calling the eviction fence evf.

>
>>>     return 0;
>>>
>>>  free_err:
>>> @@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>     dma_fence_put(stub);
>>>  }
>>>
>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo)
>> Please name that amdgpu_eviction_fence_remove_all().
> Noted.
>
>> Regards,
>> Christian.
>>
>>> +{
>>> +   struct dma_resv *resv = &bo->tbo.base._resv;
>>> +   struct dma_fence *fence, *stub;
>>> +   struct dma_resv_iter cursor;
>>> +
>>> +   dma_resv_assert_held(resv);
>>> +
>>> +   stub = dma_fence_get_stub();
>>> +   dma_resv_for_each_fence(&cursor, resv,
>> DMA_RESV_USAGE_BOOKKEEP, fence) {
>>> +           struct amdgpu_eviction_fence *ev_fence;
>>> +
>>> +           ev_fence = fence_to_evf(fence);
>>> +           if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
>>> +                   continue;
>>> +
>>> +           dma_resv_replace_fences(resv, fence->context, stub,
>>> +                           DMA_RESV_USAGE_BOOKKEEP);
>>> +
>>> +   }
>>> +
>>> +   dma_fence_put(stub);
>>> +}
>>> +
>>>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
>>> *evf_mgr)  {
>>>     /* This needs to be done one time per open */ diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> index fcd867b7147d..da99ac322a2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>> @@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct
>>> amdgpu_eviction_fence_mgr *evf_mgr,  int
>>> amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr
>> *evf_mgr,
>>>                                 struct drm_exec *exec);
>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo *bo);
>>>  #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 1e73ce30d4d7..f001018a01eb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct
>> ttm_buffer_object *bo)
>>>     amdgpu_vram_mgr_set_cleared(bo->resource);
>>>     dma_resv_add_fence(&bo->base._resv, fence,
>> DMA_RESV_USAGE_KERNEL);
>>>     dma_fence_put(fence);
>>> +   amdgpu_userq_remove_all_eviction_fences(abo);
>>>
>>>  out:
>>>     dma_resv_unlock(&bo->base._resv);

