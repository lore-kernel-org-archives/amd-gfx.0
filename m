Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06726C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 12:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A535510E792;
	Wed, 10 Jul 2024 12:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mhW8wXQ7";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E962310E792
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 12:45:44 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-42797289c8bso1430215e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720615543; x=1721220343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gXquec9p8XshpfjDNuZ5y6iycGENrPmzJEGsZ6qCM7c=;
 b=mhW8wXQ7r7V0Fa3JYGD+s8sg7X8vi/hglniIAOhLtBoN27vYhW/Q/5vxX1bdVKMieC
 nwM38u92HlvPNU/YoOBMqwvBrEQEGtAevc4FkXtC957REZDXnrsGFm2NIhkfqM4HhvsA
 qLmujbZUeKxjKwbJ2I94h56sfaL9ccnRaCVnwVdQOy5Eb+9n+NPkV9rEauqbxBn0FBND
 opgnC5ZJ7wQxfFwgiBf0Q4ttkXSp1mgedHGvdMFzJSmIJafS8fhpEDX3uRzflftSPM2A
 ULgKJ6Cc3cp5Bagr/jg+aZfuigVgpFymB37298F5rSd8S5udGuNR5NLrzyOUgdsT35w+
 cpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720615543; x=1721220343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXquec9p8XshpfjDNuZ5y6iycGENrPmzJEGsZ6qCM7c=;
 b=KgOh6MsUpfCGoi3xcqDqN866MZ8Tk9NPA2mIiUYuKXK7LjZPrR5yfvybk1NGRIp8cB
 YCI7eDf2So2h932Hhyfm7J0+4tCyqJbNnRp0B5JtEujMPPyPmOY1kDkEzw1A6Tdjj4eQ
 iNxAIIFHCmslL8rO2A5qj+/DdPv4IHabTJGBFH00DcBOWsHBk3jEARxmvntydZCA0K6l
 cVWBAzeFkk/x5/eoWCKXKHZXDIierTrDGU5tzCX0PER/6lFv87cTgE4rWjo0eLLtUzT9
 HzLAgb6sBdBPI6Z3R7u29yWGsRL1+lEfaoVk0qNUy2FCDtlSK/rgiAlHzRUWD/ADQI8b
 Ykxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY8qvtHFRGgligXck8sJ215S9jiXJPa3ur84+0AZJcr82QWK3LNd9uKke8ru6RFpsKZnXrz3/EfuhuLEnowrYbXgH4btkwjmC8cXDR9A==
X-Gm-Message-State: AOJu0Yz40607MZz+bRi8PDia6WsWEPo2pwEH6ueQ3mfgZ8EgcNIbNirb
 Cw3OaxL1nAiTGfiG1SlCdH+RQo/Fl2pGWPx5QhVKVibkeCY9YwoyNGVeOYnt
X-Google-Smtp-Source: AGHT+IE4DcgKA8BfKHRqDhV4E9dw7gKvprm4NV2jtocDO36XO9k6MbdyuxzgSC/Se/UoDD3oHwazWA==
X-Received: by 2002:a05:600c:2248:b0:426:61f6:2e38 with SMTP id
 5b1f17b1804b1-426708f1912mr35173125e9.35.1720615542806; 
 Wed, 10 Jul 2024 05:45:42 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f74462esm79037645e9.48.2024.07.10.05.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 05:45:42 -0700 (PDT)
Message-ID: <28dba774-ef8b-4f84-9ff3-6014b50e11b7@gmail.com>
Date: Wed, 10 Jul 2024 14:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
 <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
 <DS7PR12MB633361A48187FDC04193B93CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
 <3f6f779d-33ff-4cbb-9eaf-035888c200e5@gmail.com>
 <DS7PR12MB6333A502ED4D41239EEB86C8F4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB6333A502ED4D41239EEB86C8F4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
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

Am 10.07.24 um 12:15 schrieb Zhu, Jiadong:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Wednesday, July 10, 2024 5:27 PM
>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in the
>> right place
>>
>> Am 10.07.24 um 09:54 schrieb Zhu, Jiadong:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Wednesday, July 10, 2024 3:17 PM
>>>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in
>>>> the right place
>>>>
>>>> Am 10.07.24 um 02:31 schrieb jiadong.zhu@amd.com:
>>>>> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>>
>>>>> The job's embedded fence is dma_fence which shall not be conversed
>>>>> to amdgpu_fence.
>>>> Good catch.
>>>>
>>>>> The start timestamp shall be saved on job for hw_fence.
>>>> But NAK to that approach. Why do we need the start time here in the
>>>> first place?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> The start timestamp is used for ring mux to check if the fences are
>> unsignaled for a period of time under mcbp scenarios (by calling
>> amdgpu_fence_last_unsignaled_time_us).
>>
>> I can't find a reason for doing that in the first place. What is the background
>> of this?
>>
>> Regards,
>> Christian.
>>
> It is about os triggered mcbp on gfx9. When we are using software ring and ring mux on gfx9,  the ring mux checks the fence unsignaled time of the low priority context while high priority job comes. If the time duration exceeds a certain time, mux will trigger mcbp.
> we could add adev->gfx.mcbp check when set start_timestamp for those fences.

So you basically want to guarantee some forward progress?

While this is nice to have I don't think we need that in the first place.

I mean when I have two hardware queues the high priority one would 
starve the low priority one as well.

Regards,
Christian.

>
> Thanks,
> Jiadong
>
>>> Thanks,
>>> Jiadong
>>>>> v2: optimize get_fence_start_time.
>>>>> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31
>>>> ++++++++++++++++++++---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
>>>>>     2 files changed, 31 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index 2f24a6aa13bf..72bb007e48c8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -88,6 +88,31 @@ static inline struct amdgpu_fence
>>>> *to_amdgpu_fence(struct dma_fence *f)
>>>>>       return NULL;
>>>>>     }
>>>>>
>>>>> +static inline void set_fence_start_time(struct dma_fence *f,
>>>>> +ktime_t
>>>>> +start_timestamp) {
>>>>> +   if (f->ops == &amdgpu_fence_ops) {
>>>>> +           struct amdgpu_fence *__f = container_of(f, struct
>>>> amdgpu_fence,
>>>>> +base);
>>>>> +
>>>>> +           __f->start_timestamp = start_timestamp;
>>>>> +   } else if (f->ops == &amdgpu_job_fence_ops) {
>>>>> +           struct amdgpu_job *job = container_of(f, struct
>>>>> +amdgpu_job, hw_fence);
>>>>> +
>>>>> +           job->start_timestamp = start_timestamp;
>>>>> +   }
>>>>> +}
>>>>> +
>>>>> +static inline ktime_t get_fence_start_time(struct dma_fence *f) {
>>>>> +   if (unlikely(f->ops == &amdgpu_fence_ops)) {
>>>>> +           struct amdgpu_fence *__f = container_of(f, struct
>>>> amdgpu_fence,
>>>>> +base);
>>>>> +
>>>>> +           return __f->start_timestamp;
>>>>> +   }
>>>>> +   struct amdgpu_job *job = container_of(f, struct amdgpu_job,
>>>>> +hw_fence);
>>>>> +
>>>>> +   return job->start_timestamp;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * amdgpu_fence_write - write a fence value
>>>>>      *
>>>>> @@ -197,7 +222,7 @@ int amdgpu_fence_emit(struct amdgpu_ring
>> *ring,
>>>> struct dma_fence **f, struct amd
>>>>>               }
>>>>>       }
>>>>>
>>>>> -   to_amdgpu_fence(fence)->start_timestamp = ktime_get();
>>>>> +   set_fence_start_time(fence, ktime_get());
>>>>>
>>>>>       /* This function can't be called concurrently anyway, otherwise
>>>>>        * emitting the fence would mess up the hardware ring buffer.
>>>>> @@ -428,7 +453,7 @@ u64
>>>> amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>>>>               return 0;
>>>>>
>>>>>       return ktime_us_delta(ktime_get(),
>>>>> -           to_amdgpu_fence(fence)->start_timestamp);
>>>>> +           get_fence_start_time(fence));
>>>>>     }
>>>>>
>>>>>     /**
>>>>> @@ -451,7 +476,7 @@ void
>>>> amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring,
>>>> uint32_t seq,
>>>>>       if (!fence)
>>>>>               return;
>>>>>
>>>>> -   to_amdgpu_fence(fence)->start_timestamp = timestamp;
>>>>> +   set_fence_start_time(fence, timestamp);
>>>>>     }
>>>>>
>>>>>     /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> index a963a25ddd62..3a73fe11a1ce 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> @@ -73,6 +73,9 @@ struct amdgpu_job {
>>>>>       uint64_t                gds_va;
>>>>>       bool                    init_shadow;
>>>>>
>>>>> +   /* start timestamp for hw_fence*/
>>>>> +   ktime_t                 start_timestamp;
>>>>> +
>>>>>       /* job_run_counter >= 1 means a resubmit job */
>>>>>       uint32_t                job_run_counter;
>>>>>

