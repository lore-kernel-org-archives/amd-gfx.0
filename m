Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22313C4707B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 14:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E4110E044;
	Mon, 15 Jan 2024 14:00:49 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDED610E044
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 14:00:48 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so7316128f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705327247; x=1705932047; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SFgMWqZZzeVfJ0BqRYToYGxFbh3mG9YLb2S6nyGM1xo=;
 b=eSaWRtjxJ/ZWxZrhlmE0OX39FK11JxNemZNc/QomHCVPeKsJARUha8okz2U/hGMiJo
 a7w993tnRHgRc6YlYE+HyOI3/OdiOjVV8Bok8pjemQqo1t5G4Zl9LqQSVWuRIS8hz8HO
 5Y+l2NlqUXZN4bihzCg3GgEuM3c17xy9Oi3hnbkmBFBUHgLcVHf0V0X93g85gbKxaWXV
 fEKM5dJenEnZfpT2nl9akoYfK2F/y+VTibQcaLTDLCKmiLyWFFpV4pSY4vfVxgJwj/gD
 oXilmEQGpWo8mVmk6/D9JDxFsVTwIxJZ7yQvYpH2qFupOHOZiDL3pEzedjESVmq5JEUb
 Uwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705327247; x=1705932047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SFgMWqZZzeVfJ0BqRYToYGxFbh3mG9YLb2S6nyGM1xo=;
 b=kkF3KdsoUN0sTqMCVFqJ68h/VB5VapHqArBCjyr+1ZZRaKqzxfasL/btNZznQQuKZJ
 ECy4vzm1MjoTbxlB+76yHSRx6wR0ZGeJ5DPTipE3F2yy/an+Qj9a4r17s/GN6j3b3Wlk
 aa4UycR4qBI3wEjguJGigIGltVxlUZN6LPLTKoAd1ZAg1+98qzTJPPcoZ4a0d8GKOYBt
 kDK58GdgVIx7Ws8A19EoNJGxBUz+7GK2GRsitCAmPMURF7Ci6b6ZH/OHTqSOy/Cb9IWb
 pWV4iwkgpLFnMsqP7wZTDgzaUGvkVOHR3YUYD0SthgIsL3Qn5p6AfTLJzk59N+yumh3/
 w8FA==
X-Gm-Message-State: AOJu0YwrxLItufSbOjymhAYEBJlO5/wuDN0KTF34o0me8KskKY//tBew
 2eqIoG/PNPku872QH9XY74rKxqsu8FdiSA==
X-Google-Smtp-Source: AGHT+IF+MoSyWSLAxyW59bSmFQq1rcoH06DfOJ6Dzssc/D8jgh/2zUTQeal28MoWVbCZP+8OxsLdPw==
X-Received: by 2002:adf:a306:0:b0:337:6f4e:3833 with SMTP id
 c6-20020adfa306000000b003376f4e3833mr3329645wrb.12.1705327247030; 
 Mon, 15 Jan 2024 06:00:47 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 d15-20020adf9c8f000000b00336c43b366fsm12011870wre.12.2024.01.15.06.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 06:00:46 -0800 (PST)
Message-ID: <4dc0c6c6-6f6e-4b04-b611-78b181e4d7a6@froggi.es>
Date: Mon, 15 Jan 2024 14:00:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
 <a88f1d5f-c13c-4b46-9bba-f96d43bd4e1a@froggi.es>
 <c71cc2ba-72f3-4869-b804-51d5d6704f49@amd.com>
 <68936df5-3f5b-47a9-b861-eeaa4030c893@froggi.es>
 <d8039165-0d54-4a42-a46a-922c1f691c24@amd.com>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <d8039165-0d54-4a42-a46a-922c1f691c24@amd.com>
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 13:19, Christian König wrote:
> Am 15.01.24 um 12:54 schrieb Joshua Ashton:
>> [SNIP]
>>>
>>> The question here is really if we should handled soft recovered 
>>> errors as fatal or not. Marek is in pro of that Michel is against it.
>>>
>>> Figure out what you want in userspace and I'm happy to implement it :)
>>>
>>>>
>>>> (That being said, without my patches, RADV treats *any* reset from 
>>>> the query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost 
>>>> and it was not guilty, so any faulting/hanging application causes 
>>>> every Vulkan app to die e_e. This is fixed in 
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )
>>>
>>> That is actually intended behavior. When something disrupted the GPU 
>>> execution and the application is affected it is mandatory to forward 
>>> this error to the application.
>>
>> No. If said context was entirely unaffected, then it should be 
>> completely transparent to the application.
>>
>> Consider the following:
>>
>>  - I have Counter-Strike 2 running
>>  - I have Gamescope running
>>
>> I then go ahead and start HangApp that hangs the GPU.
>>
>> Soft recovery happens and that clears out all the work for the 
>> specific VMID for HangApp's submissions and signals the submission fence.
>>
>> In this instance, the Gamescope and Counter-Strike 2 ctxs are 
>> completely unaffected and don't need to report VK_ERROR_DEVICE_LOST as 
>> there was no impact to their work.
> 
> Ok, that is something I totally agree on. But why would the Gamescope 
> and Counter-Strike 2 app report VK_ERROR_DEVICE_LOST for a soft recovery 
> in the first place?
> 
> IIRC a soft recovery doesn't increment the reset counter in any way. So 
> they should never be affected.

It does, and without assigning any guilt, amdgpu_ring_soft_recovery 
calls atomic_inc(&ring->adev->gpu_reset_counter).


> 
> Regards,
> Christian.
> 
>>
>> Even if Gamescope or Counter-Strike 2 were occupying CUs in tandem 
>> with HangApp, FWIU the way that the clear-out works being vmid 
>> specific means that they would be unaffected, right?
>>
>> - Joshie 🐸✨
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> - Joshie 🐸✨
>>>>
>>>>>
>>>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>>>>
>>>>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>>>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: André Almeida <andrealmeid@igalia.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>>>>   1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> index 25209ce54552..e87cafb5b1c3 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>>>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>>>>           dma_fence_set_error(fence, -ENODATA);
>>>>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>>>> +    if (job->vm)
>>>>>> +        drm_sched_increase_karma(&job->base);
>>>>>> atomic_inc(&ring->adev->gpu_reset_counter);
>>>>>>       while (!dma_fence_is_signaled(fence) &&
>>>>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>>
>>>
>>
> 

- Joshie 🐸✨
