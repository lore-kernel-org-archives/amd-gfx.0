Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEB7C004C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 11:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6933E10E09B;
	Mon, 23 Oct 2023 11:39:37 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE96D10E09B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 11:39:35 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso3026735e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698061174; x=1698665974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WgqwX7p0N8gKo2l4vN7FOUt77XkFDiVn7CjEKkEg40Y=;
 b=KVfixqB4n2buS9G5ZVyAH793alKADLwdjPDELHPJ/ZNnxfSrkp7twBT1ALbfvHD60J
 p1VXP3aOhElHnuMRToOtCTv/ntLxis4tjLdNujgL+CgfNR+A6C+9vvEt9Rnl4GEeZRxu
 9nKZMnSjXplDtZQ7CnxvHyRxJGYYIwQdxnLqvet2EQH6iBsIjiV/p5cQg4cQ+BxG5Z6D
 GMcrFWLm7duyrZRUtMWcULu8xYTuBQdcLIkMW8kHtlXWv+dRUMpq7iDF6U/dGDpD+n1E
 n3Yt/6dv/NHp7b30uFJD1aTkddxAj7RoXQHwEIovaPn7AjaIztAAanWIUsx4/elgmSzi
 LtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698061174; x=1698665974;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WgqwX7p0N8gKo2l4vN7FOUt77XkFDiVn7CjEKkEg40Y=;
 b=rbvc5Xu7POBY1nMh8tzvK1M3Fi8RY/9/t4+Z3E1OYfe36+d2ply/HNvnUmfD7eQ332
 W8Aup+rmWHqpmezAkXG+UXAvY06+6lUBVbnM3Y/Mzq94HU+q+NK31U3UDs1pOVLSSOWI
 vkrR5vGV80pd/oQ+ju+WR0J913Sx9hB+dvB5krkCFlwjyi3g9S6JNtN0MRGs/eHMp/C/
 /Qtpdh5XXOF1A+3hFQ2Y9Y5V9zlDqLhdHD3hlr5y/L/Hj9DzJNzKRpE+NWKp6Gu3IavE
 UTUNPyt9nfBB5VaU0Es5P5vIspOFyu8/AKNxgXRotUu+FfNoGs41UvwxrzeGsTSi4reA
 VSlA==
X-Gm-Message-State: AOJu0YxtW4cd+79wdQOnlr2grD5afCLlpvTrlCW8WkS4GksMdXZOmjuj
 iZH6EC5YSkoAvp5+C+7dxaw=
X-Google-Smtp-Source: AGHT+IFQJIoJ3QvtgP1RUzfY5OdcB6t4h/ujqW99SjqWpC1SLtH5sirMrxx6kP7eH7nEHTNxwUAwYg==
X-Received: by 2002:a05:600c:548f:b0:401:c338:ab96 with SMTP id
 iv15-20020a05600c548f00b00401c338ab96mr6400532wmb.34.1698061173702; 
 Mon, 23 Oct 2023 04:39:33 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b00402d34ea099sm14032355wms.29.2023.10.23.04.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 04:39:32 -0700 (PDT)
Message-ID: <036ba08e-a579-4028-ab55-bdfedfc2ec19@gmail.com>
Date: Mon, 23 Oct 2023 13:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231020061307.588900-1-Emily.Deng@amd.com>
 <fbf6e76a-547d-423d-987b-9d1260437322@gmail.com>
 <PH0PR12MB5417863B213789488F00ADC98FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
 <f833c27f-eb11-4191-a3c0-dd81c34fcecf@gmail.com>
 <21f7ca52-2060-48ce-8b1c-119fb0717d00@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <21f7ca52-2060-48ce-8b1c-119fb0717d00@amd.com>
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

Am 20.10.23 um 21:47 schrieb Felix Kuehling:
>
> On 2023-10-20 09:10, Christian König wrote:
>> No, the wait forever is what is expected and perfectly valid user 
>> experience.
>>
>> Waiting with a timeout on the other hand sounds like a really bad 
>> idea to me.
>>
>> Every wait with a timeout needs a justification, e.g. for example 
>> that userspace explicitly specified it. And I absolutely don't see 
>> that here.
> In this case the wait is in a kernel worker thread, and the wait is 
> not interruptible. Not having a timeout means, you can have a kernel 
> worker stuck forever. The restore worker also has retry logic already, 
> so it can handle a timeout perfectly well. But maybe this shouldn't be 
> done automatically for all callers of amdgpu_sync_wait, but only for 
> this particular caller in the restore_process_worker. So we'd need to 
> add a timeout parameter to amdgpu_sync_wait.

Adding a parameter sounds like a good idea to me, but it's mandatory 
that dma_fence operations finish in a reasonable amount of time in the 
first place.

This is even documented by now and basically means we need timeouts in 
the area of 100ms for each operation and not between 10 and 60 seconds.

If upstream starts to taint the kernel for longer timeouts we will need 
to reduce the current values massively.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>> Am 20.10.23 um 10:52 schrieb Deng, Emily:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Christian,
>>>       The issue is running a compute hang with a quark and trigger a 
>>> compute job timeout. For compute, the timeout setting is 60s, but 
>>> for gfx and sdma, it is 10s.
>>> So, get the timeout from the sched is reasonable for different sched.
>>>      And if wait timeout, it will print error, so won't hint real 
>>> issues. And even it has real issue, the wait forever is bad user 
>>> experience, and driver couldn't work anymore.
>>>
>>> Emily Deng
>>> Best Wishes
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Friday, October 20, 2023 3:29 PM
>>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
>>>>
>>>> Am 20.10.23 um 08:13 schrieb Emily Deng:
>>>>> Issue: Dead heappen during gpu recover, the call sequence as below:
>>>>>
>>>>> amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset-
>>>>> flush_delayed_work
>>>>> -> amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait
>>>>>
>>>>> It is because the amdgpu_sync_wait is waiting for the bad job's 
>>>>> fence,
>>>>> and never return, so the recover couldn't continue.
>>>>>
>>>>>
>>>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
>>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>> index dcd8c066bc1f..6253d6aab7f8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>> @@ -406,8 +406,15 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync,
>>>> bool intr)
>>>>>       int i, r;
>>>>>
>>>>>       hash_for_each_safe(sync->fences, i, tmp, e, node) {
>>>>> -            r = dma_fence_wait(e->fence, intr);
>>>>> -            if (r)
>>>>> +            struct drm_sched_fence *s_fence = to_drm_sched_fence(e-
>>>>> fence);
>>>>> +            long timeout = msecs_to_jiffies(10000);
>>>> That handling doesn't make much sense. If you need a timeout then 
>>>> you need
>>>> a timeout for the whole function.
>>>>
>>>> Additional to that timeouts often just hide real problems which 
>>>> needs fixing.
>>>>
>>>> So this here needs a much better justification otherwise it's a 
>>>> pretty clear NAK.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +
>>>>> +            if (s_fence)
>>>>> +                    timeout = s_fence->sched->timeout;
>>>>> +
>>>>> +            if (r == 0)
>>>>> +                    r = -ETIMEDOUT;
>>>>> +            if (r < 0)
>>>>>                       return r;
>>>>>
>>>>>               amdgpu_sync_entry_free(e);
>>

