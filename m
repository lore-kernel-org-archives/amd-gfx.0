Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07742C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 11:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C8310EA3B;
	Thu, 11 Jul 2024 11:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIsDO8cB";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388C110EA3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 11:56:10 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-36796bbf687so371086f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720698968; x=1721303768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pwDYMQwO2rpZT8vO6jOXx4pg9DA0t0y5rxzqSwAoeq8=;
 b=PIsDO8cBUUsQ4Yr/XbdPHg3VhMExunU0K+RR8gNmdfxLTzEoySugayexiPEKtW0i/C
 +jB/H9+H6clKGzs3leoBGABr/zYLZtCYYAcfbY4MIHGqmnJy57vIP/W5BxmAirJjfmJZ
 u44m+QFejrOUyUKtjEY+KzXBOfY0HcG5Zz3vl4+3tlO+CVyA5DhIH/YM23r+F/oVRnWE
 lMGSCnKpRuTRCL05uvVRyFovrgDJ2rmwPHqqEwIlvPvDWN5VyNjo56wUC7u3FMAjylyM
 YFsuarcETB6VXjgRJRAL/rnps9CGfaNtUgnOBhSpsMOacdrZku8OOUmMT72Jt32t9sCF
 S8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720698968; x=1721303768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pwDYMQwO2rpZT8vO6jOXx4pg9DA0t0y5rxzqSwAoeq8=;
 b=qXnIHcDCYG3oTwOBcv72DduDNEVe4eD9SxAKX34NJjnEmPuTdtwMoiM8CfFsVE/+DZ
 O8gFmu5mgPgeRqg17okZI260ZPgYPftR1sKivMI40yVDZXkiKl7w8jIxyw63qDio01ZG
 OoLntieAMZSLNSyz1IZo2EjpOB6gocSgbCg/UNnU8nIPgUq+IfG7+SGVP/tR/0vYU/eP
 bij6qpLiuSJxV/VBooxMWNT6cHn7cwE8+v0Qi+uZOdCz+O0BiNQsMdYDCV6MiFd0duPU
 CGoIwY2SDEqwVZLnyJAXCB81LYoHx9u3oDbdGT9uf++9hxz6KSlyTUIdD4zZE09TAZ/v
 5qlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrOS1ZIjqobNNZgWGYSxz+2QWbi/1a9y7dCnbTCAbYoba0Pv8xufmVDgvElmswtaUs3OGkhGOV8jxxwj94H0PXM6D4GnxeIR7BN6zxPg==
X-Gm-Message-State: AOJu0YyKUsKchCq+ufCRD5S8N9Lys8YHrH1Zjq/rCFRLqJtlbl6nN6BY
 dt+PCW+XDP2aeCjQs3A6kXoRHT7rcbuqNJGG2OxDfYhGNkUhp3/d
X-Google-Smtp-Source: AGHT+IGI/G0+mj0PaXttF0OXXFELz4BKHzp1BTpy6+y+VLIfuNbY4IRS2bqiU3FTcTPIAeTrrvwN6w==
X-Received: by 2002:adf:e692:0:b0:366:ec2f:dbc9 with SMTP id
 ffacd0b85a97d-367ceac4ba5mr5459827f8f.51.1720698968055; 
 Thu, 11 Jul 2024 04:56:08 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa0672sm7638732f8f.79.2024.07.11.04.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 04:56:07 -0700 (PDT)
Message-ID: <a3919111-1476-466a-a9b8-9779d2e5b072@gmail.com>
Date: Thu, 11 Jul 2024 13:56:05 +0200
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
 <28dba774-ef8b-4f84-9ff3-6014b50e11b7@gmail.com>
 <DS7PR12MB63330DE4D4D6664AC1BE31F7F4A52@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB63330DE4D4D6664AC1BE31F7F4A52@DS7PR12MB6333.namprd12.prod.outlook.com>
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

Am 11.07.24 um 03:31 schrieb Zhu, Jiadong:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Wednesday, July 10, 2024 8:46 PM
>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in the
>> right place
>>
>> Am 10.07.24 um 12:15 schrieb Zhu, Jiadong:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Wednesday, July 10, 2024 5:27 PM
>>>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>;
>>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in
>>>> the right place
>>>>
>>>> Am 10.07.24 um 09:54 schrieb Zhu, Jiadong:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>>> Sent: Wednesday, July 10, 2024 3:17 PM
>>>>>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>>>> Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in
>>>>>> the right place
>>>>>>
>>>>>> Am 10.07.24 um 02:31 schrieb jiadong.zhu@amd.com:
>>>>>>> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>>>>
>>>>>>> The job's embedded fence is dma_fence which shall not be
>> conversed
>>>>>>> to amdgpu_fence.
>>>>>> Good catch.
>>>>>>
>>>>>>> The start timestamp shall be saved on job for hw_fence.
>>>>>> But NAK to that approach. Why do we need the start time here in the
>>>>>> first place?
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>> The start timestamp is used for ring mux to check if the fences are
>>>> unsignaled for a period of time under mcbp scenarios (by calling
>>>> amdgpu_fence_last_unsignaled_time_us).
>>>>
>>>> I can't find a reason for doing that in the first place. What is the
>>>> background of this?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> It is about os triggered mcbp on gfx9. When we are using software ring and
>> ring mux on gfx9,  the ring mux checks the fence unsignaled time of the low
>> priority context while high priority job comes. If the time duration exceeds a
>> certain time, mux will trigger mcbp.
>>> we could add adev->gfx.mcbp check when set start_timestamp for those
>> fences.
>>
>> So you basically want to guarantee some forward progress?
> this patch is to fix the memory overlap on job->hw_fence.  For the other part we leave it as it was.
>
>> While this is nice to have I don't think we need that in the first place.
>>
>> I mean when I have two hardware queues the high priority one would starve
>> the low priority one as well.
> HWS has two levels to handle queue priority:  for priority mode, high priority queue will preempt low priority queue as long as it has some work. For quantum mode, all the queues are in the same priority, the queue would be preempted when it uses up its time slice.
> The hardware team suggested OS to use quantum mode as it will not starve low priority queue. Our implementation partially referred to that design.

Please drop that design. We don't have any use case for that quantum mode.

We only need high/low priority queues here.

Regards,
Christian.

>
> Thanks,
> Jiadong
>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Jiadong
>>>
>>>>> Thanks,
>>>>> Jiadong
>>>>>>> v2: optimize get_fence_start_time.
>>>>>>> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31
>>>>>> ++++++++++++++++++++---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
>>>>>>>      2 files changed, 31 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> index 2f24a6aa13bf..72bb007e48c8 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> @@ -88,6 +88,31 @@ static inline struct amdgpu_fence
>>>>>> *to_amdgpu_fence(struct dma_fence *f)
>>>>>>>        return NULL;
>>>>>>>      }
>>>>>>>
>>>>>>> +static inline void set_fence_start_time(struct dma_fence *f,
>>>>>>> +ktime_t
>>>>>>> +start_timestamp) {
>>>>>>> +   if (f->ops == &amdgpu_fence_ops) {
>>>>>>> +           struct amdgpu_fence *__f = container_of(f, struct
>>>>>> amdgpu_fence,
>>>>>>> +base);
>>>>>>> +
>>>>>>> +           __f->start_timestamp = start_timestamp;
>>>>>>> +   } else if (f->ops == &amdgpu_job_fence_ops) {
>>>>>>> +           struct amdgpu_job *job = container_of(f, struct
>>>>>>> +amdgpu_job, hw_fence);
>>>>>>> +
>>>>>>> +           job->start_timestamp = start_timestamp;
>>>>>>> +   }
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline ktime_t get_fence_start_time(struct dma_fence *f) {
>>>>>>> +   if (unlikely(f->ops == &amdgpu_fence_ops)) {
>>>>>>> +           struct amdgpu_fence *__f = container_of(f, struct
>>>>>> amdgpu_fence,
>>>>>>> +base);
>>>>>>> +
>>>>>>> +           return __f->start_timestamp;
>>>>>>> +   }
>>>>>>> +   struct amdgpu_job *job = container_of(f, struct amdgpu_job,
>>>>>>> +hw_fence);
>>>>>>> +
>>>>>>> +   return job->start_timestamp;
>>>>>>> +}
>>>>>>> +
>>>>>>>      /**
>>>>>>>       * amdgpu_fence_write - write a fence value
>>>>>>>       *
>>>>>>> @@ -197,7 +222,7 @@ int amdgpu_fence_emit(struct amdgpu_ring
>>>> *ring,
>>>>>> struct dma_fence **f, struct amd
>>>>>>>                }
>>>>>>>        }
>>>>>>>
>>>>>>> -   to_amdgpu_fence(fence)->start_timestamp = ktime_get();
>>>>>>> +   set_fence_start_time(fence, ktime_get());
>>>>>>>
>>>>>>>        /* This function can't be called concurrently anyway, otherwise
>>>>>>>         * emitting the fence would mess up the hardware ring buffer.
>>>>>>> @@ -428,7 +453,7 @@ u64
>>>>>> amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>>>>>>                return 0;
>>>>>>>
>>>>>>>        return ktime_us_delta(ktime_get(),
>>>>>>> -           to_amdgpu_fence(fence)->start_timestamp);
>>>>>>> +           get_fence_start_time(fence));
>>>>>>>      }
>>>>>>>
>>>>>>>      /**
>>>>>>> @@ -451,7 +476,7 @@ void
>>>>>> amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring,
>>>>>> uint32_t seq,
>>>>>>>        if (!fence)
>>>>>>>                return;
>>>>>>>
>>>>>>> -   to_amdgpu_fence(fence)->start_timestamp = timestamp;
>>>>>>> +   set_fence_start_time(fence, timestamp);
>>>>>>>      }
>>>>>>>
>>>>>>>      /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>> index a963a25ddd62..3a73fe11a1ce 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>>>> @@ -73,6 +73,9 @@ struct amdgpu_job {
>>>>>>>        uint64_t                gds_va;
>>>>>>>        bool                    init_shadow;
>>>>>>>
>>>>>>> +   /* start timestamp for hw_fence*/
>>>>>>> +   ktime_t                 start_timestamp;
>>>>>>> +
>>>>>>>        /* job_run_counter >= 1 means a resubmit job */
>>>>>>>        uint32_t                job_run_counter;
>>>>>>>

