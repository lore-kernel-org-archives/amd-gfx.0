Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E45CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 13:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9340810E05F;
	Fri, 20 Oct 2023 13:10:28 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE0EA10E05F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 13:10:24 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so12150621fa.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697807423; x=1698412223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Km4gmlUHmEwDJfvc6XatZAQt1uguGOV9c98P/6IKeE=;
 b=mNMrlES16szmHajY6YzUAHYrTtl0jfRJBw+VKBtfYGr+SA5gB9b5J5ZcqP7+CJFjoC
 kPI7UWArqLQ16BQ6B5XW2Gds4zVQ2vSq+X9gOFjQpPWxx4Z7/D8KePDI9X4rA+FP6WIl
 cFG7ha2dVwvi9SgJLtVxpEwpjfJhDee80DGUnWzBD3Gi8GqOowJauX6XCNV10ghNF+OE
 xOyMsJZl8Hc6ZsUkTQUBNn8p7pl2nkMtfnaiwotnLEDGFQe6IPb45GAUxS9ugRBR84Oh
 4BMAg68jHRxwrnTjBO6ggJikGV6VwTCiEYErcqPZYBrSeL0qPcFS4rulx02U6dpzMiCN
 Y2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807423; x=1698412223;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Km4gmlUHmEwDJfvc6XatZAQt1uguGOV9c98P/6IKeE=;
 b=pUaXoSt9tRgh0mxuudGdFIQSJuYCYIJetcNERe2aXXhKgd8I+uJ3GXxukwmRwSyRXd
 2VtgKY8MLjc63w5XUPeiy4JGSmai2CAFF88xt7L2AX44OVCIWLIpdKUtTsqvE8KmRmIG
 hwd8kiaFAOS+ntAuZ4JqWM2NGdti8qCv2pxOfJFrSoVb0YJd9aQZ4z2Rdo7bxO30B38i
 z2BrXJtZs+8SPCuiw41y8GAf5AMhl/9ij/+jBr3ggxEMo+oXUB3smpG9NZC6+6fbFXMW
 sKDLJo/lRYO6DiIDmyonI4hwZddp3Jh8YKJ8TEnL7Ozt75l+BlhvkM5zQGWRz0U3NW5d
 fhFg==
X-Gm-Message-State: AOJu0YxYSQk60zQ/cBJQbfxiRznOJAy4DyauHVre/yF+eMu7NcN8MDa0
 0dAbSr5TLVIna+FzgwfMiU6dV6vDoTo88Q==
X-Google-Smtp-Source: AGHT+IE19FRIWp3aj/e+BwHFSaf91pJwIVC45H04/GQ0dWNnUGA5yXN0mgkJAYpK0SIZ9lMIDwLCMA==
X-Received: by 2002:a2e:be2b:0:b0:2bb:78ad:56cb with SMTP id
 z43-20020a2ebe2b000000b002bb78ad56cbmr1513563ljq.37.1697807422795; 
 Fri, 20 Oct 2023 06:10:22 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adfdd85000000b0032dba85ea1bsm1667195wrl.75.2023.10.20.06.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 06:10:22 -0700 (PDT)
Message-ID: <f833c27f-eb11-4191-a3c0-dd81c34fcecf@gmail.com>
Date: Fri, 20 Oct 2023 15:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231020061307.588900-1-Emily.Deng@amd.com>
 <fbf6e76a-547d-423d-987b-9d1260437322@gmail.com>
 <PH0PR12MB5417863B213789488F00ADC98FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH0PR12MB5417863B213789488F00ADC98FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
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

No, the wait forever is what is expected and perfectly valid user 
experience.

Waiting with a timeout on the other hand sounds like a really bad idea 
to me.

Every wait with a timeout needs a justification, e.g. for example that 
userspace explicitly specified it. And I absolutely don't see that here.

Regards,
Christian.

Am 20.10.23 um 10:52 schrieb Deng, Emily:
> [AMD Official Use Only - General]
>
> Hi Christian,
>       The issue is running a compute hang with a quark and trigger a compute job timeout. For compute, the timeout setting is 60s, but for gfx and sdma, it is 10s.
> So, get the timeout from the sched is reasonable for different sched.
>      And if wait timeout, it will print error, so won't hint real issues. And even it has real issue, the wait forever is bad user experience, and driver couldn't work anymore.
>
> Emily Deng
> Best Wishes
>
>
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Friday, October 20, 2023 3:29 PM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
>>
>> Am 20.10.23 um 08:13 schrieb Emily Deng:
>>> Issue: Dead heappen during gpu recover, the call sequence as below:
>>>
>>> amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset-
>>> flush_delayed_work
>>> -> amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait
>>>
>>> It is because the amdgpu_sync_wait is waiting for the bad job's fence,
>>> and never return, so the recover couldn't continue.
>>>
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> index dcd8c066bc1f..6253d6aab7f8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>> @@ -406,8 +406,15 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync,
>> bool intr)
>>>       int i, r;
>>>
>>>       hash_for_each_safe(sync->fences, i, tmp, e, node) {
>>> -            r = dma_fence_wait(e->fence, intr);
>>> -            if (r)
>>> +            struct drm_sched_fence *s_fence = to_drm_sched_fence(e-
>>> fence);
>>> +            long timeout = msecs_to_jiffies(10000);
>> That handling doesn't make much sense. If you need a timeout then you need
>> a timeout for the whole function.
>>
>> Additional to that timeouts often just hide real problems which needs fixing.
>>
>> So this here needs a much better justification otherwise it's a pretty clear NAK.
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +            if (s_fence)
>>> +                    timeout = s_fence->sched->timeout;
>>> +
>>> +            if (r == 0)
>>> +                    r = -ETIMEDOUT;
>>> +            if (r < 0)
>>>                       return r;
>>>
>>>               amdgpu_sync_entry_free(e);

