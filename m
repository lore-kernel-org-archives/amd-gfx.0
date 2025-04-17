Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C2AC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 07:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A738C10EA44;
	Thu, 17 Apr 2025 07:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXVMBtLC";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997C810EA44
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 07:35:07 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so1943075e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744875306; x=1745480106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HPnOH4ZeRGWvoe0udhFTGqvK/k/rkLQcxzPY56aaWjo=;
 b=QXVMBtLCql3lSSsVWlFBMxA+zKIcHZ7wg0xVCWh81fdUwPJXOaz/YyqDSmDNYGkhrW
 emg/vJnSnST6rtlQWdR84GNPWmnTssWzPUu4UxoAlA047SehXPVcGvegVf9qIoUCaWEJ
 oHrmLz6/yUhWLi9/SX+5X01qKmUTpLna/x5czJ11k3+SGZXdIFOWGCEuCUgoMDJxwe2r
 pVWWjkmqBgI4T2isZhPa5Z1ntqLZkWsuPOP/R9WOqzRQ/ffoOCHwKtKbOvEAHsKqQseV
 7Ua4t2hajnSdcQ0OOrgJJBWYe6Kd8xNn2ZQzpe4Frd+8JGmTXZIgQxTaC0Ma8noPvXp5
 3UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744875306; x=1745480106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HPnOH4ZeRGWvoe0udhFTGqvK/k/rkLQcxzPY56aaWjo=;
 b=d+sJ7NE0/uMoiy43uYjoy1iqu+n9DE1MA6Y2P5t3Gb0eiXWHibfnSUJjBNny4ITI5I
 x2pED/WEZDGRlHN4nxEGgwbsnbhQb1Xvg2c08ZhZTn8aG7jadKGW1yJf39bpAepZRH4Z
 CjJjVWN3xGN364g2Py83ITnql+tzF0TXJpTU6f6e97Ti0jOtLyMhkQN1uMS5u/oQWV7f
 uK9D3P6hzkRUKVduhMK2ppY7ZNhZGNxnC1WBNLcyAQCAsaSt8/rHlapM0hmCf6nph4bP
 a1DyjY1MRyHNFFv2w0xN+FNDsVDEktfhkVnHi73wIyJ0G/V8HzajF47RM7CuGRjZ4rRK
 jnmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKkKopPppa+FumKtZVEUtYLkvATSMhjCk3yR+q6hpcn/cekge/N+vT0rEEZl1EpC9Kg92ElMjk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgjDkDz0LBKEgJJOq2mJa/HwHm5uS1inKTyXMlpA73rEv010Le
 nu44xr72nwu3QAxKK1hu+OFDNKD9bsOBcKhoouomB8TMnzjaaj6x
X-Gm-Gg: ASbGncvnJIwjScSofSFWdguABtAobFUX9oRs/ln0yOcq7+th9AJNi6fJ0yX1geeViDq
 H6F/51g3jQ2uiTLDjJwcM24LvZrNLPOOUqBzgXiduBy9sqqqteBsH4Rl7ptaogFOfmkmR2O6oNy
 /WNinYqGHN+Iuj6gjuKZdWz1SD+9uR/Ql5Svs5NQyuAlvMRm5cf7Lh8IzsuG1AMEV05eZLGIOBL
 hzeH8J+psZeeUzauoBTtxrhcoez+2l+Uvx5h8i2/EcGq+xSlqofVcsWAmy31BpwbkDDzAmq71rw
 elcYoNb8k5vvjKeAz0XSwwtDvkB0hsdnmyDYMaYtMcm1lttg/bF/jM4KJ1+0LHKY1YkQHas1vmb
 ubS5g
X-Google-Smtp-Source: AGHT+IGKEGjL/adP8LhwLl05l+3nQXywGygKORZTH1BNkf+/MPZP1Cym73BAPLjMJhXAYMvbQtOY9w==
X-Received: by 2002:a05:600c:1c07:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-4405d61c9f6mr49097965e9.12.1744875305882; 
 Thu, 17 Apr 2025 00:35:05 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445454sm19095396f8f.83.2025.04.17.00.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 00:35:05 -0700 (PDT)
Message-ID: <da07f6a6-5270-4cbf-a319-e20c82d3a1ea@gmail.com>
Date: Thu, 17 Apr 2025 09:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: trace the scheduler dependent job fence
 name
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-3-Prike.Liang@amd.com>
 <b11d325b-77e1-4350-8caf-406fac4d13d8@amd.com>
 <DS7PR12MB60053AACAD58864072A3F513FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB60053AACAD58864072A3F513FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
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

Am 16.04.25 um 16:16 schrieb Liang, Prike:
> [Public]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 16, 2025 7:04 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amdgpu: trace the scheduler dependent job fence
>> name
>>
>> Am 16.04.25 um 10:50 schrieb Prike Liang:
>>> This trace will help in tracking the scheduler dependent job fence.
>> Changes for general DRM code need to got o the appropriate mailing list.
> Yes, it should be sent to dri-dev group.
>
>> Apart from that IIRC we intentionally didn't do that. Why should the driver name be
>> relevant here?
> By adding the scheduler-dependent fence name dump, this can help identify which exact fence is depended on by the scheduler job. With this dump, successfully catch the case about the SDMA and GFX kernel queue scheduled jobs that are dependent on the eviction fence when enabling the kq and uq at the same time.

Mhm, I see why you want to make that shortcut but we kind of agreed to identify fences in the scheduler always as context:seqno.

If you then want the driver/timeline names for that you should probably enable the fence trace points as well.

We are trying to reduce the accesses to those names to eventually allow dma_fence destruction independent of the driver module.

Regards,
Christian.

>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
>>> b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
>>> index c75302ca3427..473a2cbbd7bd 100644
>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
>>> @@ -91,6 +91,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
>>>                          __field(struct dma_fence *, fence)
>>>                          __field(uint64_t, ctx)
>>>                          __field(unsigned, seqno)
>>> +                        __string(dep_fence_name, fence->ops-
>>> get_driver_name(fence))
>>>                          ),
>>>
>>>         TP_fast_assign(
>>> @@ -99,9 +100,11 @@ TRACE_EVENT(drm_sched_job_wait_dep,
>>>                        __entry->fence = fence;
>>>                        __entry->ctx = fence->context;
>>>                        __entry->seqno = fence->seqno;
>>> +                      __assign_str(dep_fence_name);
>>>                        ),
>>> -       TP_printk("job ring=%s, id=%llu, depends fence=%p, context=%llu,
>> seq=%u",
>>> +       TP_printk("job ring=%s, id=%llu, depends fence(name: %s) addr
>>> +=%p, context=%llu, seq=%u",
>>>                   __get_str(name), __entry->id,
>>> +                 __get_str(dep_fence_name),
>>>                   __entry->fence, __entry->ctx,
>>>                   __entry->seqno)
>>>  );

