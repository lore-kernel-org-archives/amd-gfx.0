Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458A3C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 09:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CC210E118;
	Wed, 10 Jul 2024 09:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHDcMN3h";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0210A10E118
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 09:27:27 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-367a081d1cdso3393141f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720603646; x=1721208446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qIrFg1mcPMXEcp4AwvL9KtHSad2s3JE4VORsXTNtdt0=;
 b=jHDcMN3hrguNvZH1mDCwDvlanDD+synhV/gff05hd9P1aO26UMOe5S0tpe49N/iVen
 euVC59SF1g0xGNVH+gF+CGZnPxHXMyjeFMqX6hm+Lom8AcNkNx/NQif9osYW76wmsa/i
 qF4rV1EpGiALzk9MQMlxCF/9a0Qq3ZUUHfq73fXm9LzvL0CQYo50egudw1G7SSb9Dqq7
 +T3sgDECJ5wa1hURwECz17KpVPyiraDApB9arrThGO64+oppSbXFmNa+u9D/9AYK4mt1
 j0DQRFOMNvz56MDzQrrOLNtGVNlMDS5lgknH7byryubqLt0tE6kBqqZpjIs/DmEhnS2d
 YI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720603646; x=1721208446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qIrFg1mcPMXEcp4AwvL9KtHSad2s3JE4VORsXTNtdt0=;
 b=kOJWriYyJzZIg7VzJzalo6Kp9VddtXIy5Kq37IumIMk2LVRkCg5jsi9sx3FkHZ7E7w
 v1jaUOhWJnxPZOfGTJlMzsyVC3ZBaIzcVe7qnDaiRrs6y3NDmpWNaQAri8IKY5yyGe6Z
 HVENyhcr04kt25LbObKpwNtMsOzF1aKBmSymqbQRDdJHQ2UkTR9QTE5AGjp05EOx8J2c
 qsK729W/WwkRVss0mwoGxegpVSQOYWhG9/zRkz1fg+VvAW2/YQ8HCdOlNmhvzkgV0HQx
 r1onzmeI3gFLofCPKOTIV+9Duf3RB7wLu/fvhaF59+SWgtMDH1ReDmTQvgsU21V1z4nB
 MAWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3O+P8+WgURyTEoH0vqM9x97Usmih0dmlab+fFdYpfQRSB4PonX5XW2h6MBK7rd5bXB2Rb9sPoJuuwxlXSfHjQgDr/eLRIU8WZP9J/rA==
X-Gm-Message-State: AOJu0Ywhmhw5CKiS66/iwLpCO0tY3okwsMzyw+ZtPrfujZ1bbYJeDZTy
 nNLoRGq768BdX67H1V5DhhgILTqKHVui/rY7UJRVc3WdDWQot7iT
X-Google-Smtp-Source: AGHT+IFElVyv2FfGSupO1kzDM6YRaysFqjabdmyQgwoNDK5QaXCDFX1ymi19ZKwyRUau/6KzEm8qZA==
X-Received: by 2002:adf:f20b:0:b0:367:4dfe:3e8d with SMTP id
 ffacd0b85a97d-367cea45a27mr3091517f8f.13.1720603645805; 
 Wed, 10 Jul 2024 02:27:25 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde846b9sm4799895f8f.29.2024.07.10.02.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 02:27:25 -0700 (PDT)
Message-ID: <3f6f779d-33ff-4cbb-9eaf-035888c200e5@gmail.com>
Date: Wed, 10 Jul 2024 11:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
 <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
 <DS7PR12MB633361A48187FDC04193B93CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB633361A48187FDC04193B93CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
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

Am 10.07.24 um 09:54 schrieb Zhu, Jiadong:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Wednesday, July 10, 2024 3:17 PM
>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in the
>> right place
>>
>> Am 10.07.24 um 02:31 schrieb jiadong.zhu@amd.com:
>>> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>
>>> The job's embedded fence is dma_fence which shall not be conversed to
>>> amdgpu_fence.
>> Good catch.
>>
>>> The start timestamp shall be saved on job for hw_fence.
>> But NAK to that approach. Why do we need the start time here in the first
>> place?
>>
>> Regards,
>> Christian.
>>
> The start timestamp is used for ring mux to check if the fences are  unsignaled for a period of time under mcbp scenarios (by calling amdgpu_fence_last_unsignaled_time_us).

I can't find a reason for doing that in the first place. What is the 
background of this?

Regards,
Christian.


>
> Thanks,
> Jiadong
>>> v2: optimize get_fence_start_time.
>>> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31
>> ++++++++++++++++++++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
>>>    2 files changed, 31 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 2f24a6aa13bf..72bb007e48c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -88,6 +88,31 @@ static inline struct amdgpu_fence
>> *to_amdgpu_fence(struct dma_fence *f)
>>>      return NULL;
>>>    }
>>>
>>> +static inline void set_fence_start_time(struct dma_fence *f, ktime_t
>>> +start_timestamp) {
>>> +   if (f->ops == &amdgpu_fence_ops) {
>>> +           struct amdgpu_fence *__f = container_of(f, struct
>> amdgpu_fence,
>>> +base);
>>> +
>>> +           __f->start_timestamp = start_timestamp;
>>> +   } else if (f->ops == &amdgpu_job_fence_ops) {
>>> +           struct amdgpu_job *job = container_of(f, struct amdgpu_job,
>>> +hw_fence);
>>> +
>>> +           job->start_timestamp = start_timestamp;
>>> +   }
>>> +}
>>> +
>>> +static inline ktime_t get_fence_start_time(struct dma_fence *f) {
>>> +   if (unlikely(f->ops == &amdgpu_fence_ops)) {
>>> +           struct amdgpu_fence *__f = container_of(f, struct
>> amdgpu_fence,
>>> +base);
>>> +
>>> +           return __f->start_timestamp;
>>> +   }
>>> +   struct amdgpu_job *job = container_of(f, struct amdgpu_job,
>>> +hw_fence);
>>> +
>>> +   return job->start_timestamp;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_fence_write - write a fence value
>>>     *
>>> @@ -197,7 +222,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,
>> struct dma_fence **f, struct amd
>>>              }
>>>      }
>>>
>>> -   to_amdgpu_fence(fence)->start_timestamp = ktime_get();
>>> +   set_fence_start_time(fence, ktime_get());
>>>
>>>      /* This function can't be called concurrently anyway, otherwise
>>>       * emitting the fence would mess up the hardware ring buffer.
>>> @@ -428,7 +453,7 @@ u64
>> amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>>              return 0;
>>>
>>>      return ktime_us_delta(ktime_get(),
>>> -           to_amdgpu_fence(fence)->start_timestamp);
>>> +           get_fence_start_time(fence));
>>>    }
>>>
>>>    /**
>>> @@ -451,7 +476,7 @@ void
>> amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring,
>> uint32_t seq,
>>>      if (!fence)
>>>              return;
>>>
>>> -   to_amdgpu_fence(fence)->start_timestamp = timestamp;
>>> +   set_fence_start_time(fence, timestamp);
>>>    }
>>>
>>>    /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index a963a25ddd62..3a73fe11a1ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -73,6 +73,9 @@ struct amdgpu_job {
>>>      uint64_t                gds_va;
>>>      bool                    init_shadow;
>>>
>>> +   /* start timestamp for hw_fence*/
>>> +   ktime_t                 start_timestamp;
>>> +
>>>      /* job_run_counter >= 1 means a resubmit job */
>>>      uint32_t                job_run_counter;
>>>

