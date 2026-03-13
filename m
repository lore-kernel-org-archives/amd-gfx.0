Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C60106FD9F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091BE10EB37;
	Fri, 13 Mar 2026 08:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="YpNu4bgY";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583D010EB37
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:53:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so15338795e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773392000; x=1773996800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uHDj+bTy8U+lBFqZB1slJzuP7ex4OXLMrgHWZDZSptg=;
 b=YpNu4bgYYs+FdXHLp7NJOzyPPQOz7Yc4LYCu5rqh8L39jT+udC/WXoVHHHXAUBV6Tg
 kb1+vWgrZbkLoTHmI+1WZwQyQaAa3igA7TU5NEAUBpbOcE1W8J4dpY9q2d+TEI/7+W2n
 FINYHdAOFvac+kmiMYgJwzb+fUIOpweZaoTYBJuIwt2FW6n4rlddGiXO7npgpYUdqIjJ
 mysXRDB3UZe4D7MoCvGmJXzDlWk9Ff/UFlstRcI0u0x+tr6twS+DW+qRZ3Wc4lbu9eWl
 S2OLbu4/Lxj5s/xpN4fatV7FW0onUp9UD/6QVlz0ukBExXkg6FOutRVQ952iSJYqByja
 Ya4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773392000; x=1773996800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHDj+bTy8U+lBFqZB1slJzuP7ex4OXLMrgHWZDZSptg=;
 b=n4FwueF8/vu7F7UJF1dEOkUWkpB0tXg2rVWyyaBKU6EOb1DYo6hUDYWnVoJ8gmmYsx
 5c5ZbYPkRoWofUbDiI8M1aZmu+JgwwNtuDf138s2YC5FQxeEBMchk8USZyLIhShd4GFk
 mIcykSUdngDFkAK5boJ3WlTpnA93Qno7cposP2KnUJaL2XjdnRHydk2hnbgC5G85BOSb
 zG4FaXova0gz0sGz7rEz6opZNxo8oZAqGY76NpdWSRJR3RRV0QYFI4mtWPxtbMgV4ugm
 U7+03Ues8ONcs+N1Ae1b7KNi+imtbou2BgbLavrNDaDf66pDd35tQw9ZjZmE26lsKyPq
 Ax4g==
X-Gm-Message-State: AOJu0Yxcn3rlhpunJsj6VwDrF/Fa0MumLndvSlPmkrKv6PvIXsGDj4k7
 JwHRYm9n/M1R1SNUMmy5P8fuus8DKsvypNWwBTc11s8x2bUzMwXSOZA/Mk7CK784BPU=
X-Gm-Gg: ATEYQzyCcgHy94P4WfayaESCHbG0iqS7DeO3eHsXHOsc19RYCF0XsMGItFPj5guavtk
 In/ZO9cDn/I1Xc/c3C3fhWewkvZc2B1UjZIw3inx2A5gXvfa5yvzLasrMotg2gD2JbuaT8U5lEE
 k/qejQEDTmssVvMyAC+2e3Y/SSndYiSSgRa46+KVYpF5ptsFrfQu5aVboD3t5E/wSilR1S0y7t3
 T/jEgseCM/HACBljFczigyfNYvQoi7CUmHWTTgbKEG4mjpCay2s4zKlw3MkW2ZztbhpRPrWJ08m
 5Jn37seux6BO1PeyAIiBkXCKy18aTQsu/AwiTqyJCEPs4GBfQwnUP6ZsIuCxZxTs0IIRK1GJoyk
 /bE4QPBnZ1aF8Fj+Adog/Ihua1vk+xbJMAq92iho7WQi2e6ddlGOY0qHf3orh+FhDbN1QL2vftv
 wumYnErXw6Gp6c/U8HWheqzPtJVww8II6fs/VBn5h7qSVK
X-Received: by 2002:a05:600c:3550:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-4855670b6a9mr38844585e9.25.1773391999637; 
 Fri, 13 Mar 2026 01:53:19 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm520083545e9.10.2026.03.13.01.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:53:19 -0700 (PDT)
Message-ID: <3e393a12-be1f-4fa9-9024-35661cabb29a@ursulin.net>
Date: Fri, 13 Mar 2026 08:53:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects
 when count is non zero
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260310135531.3954691-1-sunil.khatri@amd.com>
 <3d80b2b5-4d1d-4435-8418-f59e2b905ed7@ursulin.net>
 <563d4978-6e84-4059-80bf-5b5d6d5699e5@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <563d4978-6e84-4059-80bf-5b5d6d5699e5@amd.com>
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


On 13/03/2026 08:45, Khatri, Sunil wrote:
> 
> On 13-03-2026 02:09 pm, Tvrtko Ursulin wrote:
>>
>> On 10/03/2026 13:55, Sunil Khatri wrote:
>>> In function amdgpu_userq_wait_ioctl, call function 
>>> drm_gem_objects_lookup
>>> only if the count is valid i.e non zero.
>>>
>>> In case of object count is 0 set the pointer to NULL for proper clean
>>> up.
>>
>> Hasn't this been discussed already with the conclusion that nothing is 
>> broken? Or I am missing something?
>> Regards,
>>
>> Tvrtko
> Issue was seen again since Alex pulled 6.19 fixes from DRM and the 
> drm_gem_objects_lookup again got reverted to old and we started to see 
> the issue. With that in mind Alex too suggested that nothing wrong if we 
> explicitly check in driver too. Also i thought its only when handles are 
> Zero case when the problem is actually seen and why not that have a 
> check targeting that and not to invoke the function 
> drm_gem_objects_lookup itself for that specific case.

Yes nothing wrong with checking, thanks for clarifying. I was just 
worried I again missed something in the code.

Regards,

Tvrtko

>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++-------
>>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 76f32fd768fb..a4fff90b190a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           goto free_timeline_handles;
>>>       }
>>>   -    r = drm_gem_objects_lookup(filp,
>>> - u64_to_user_ptr(wait_info->bo_read_handles),
>>> -                   num_read_bo_handles,
>>> -                   &gobj_read);
>>> -    if (r)
>>> -        goto free_timeline_points;
>>> +    if (num_read_bo_handles) {
>>> +        r = drm_gem_objects_lookup(filp,
>>> + u64_to_user_ptr(wait_info->bo_read_handles),
>>> +                       num_read_bo_handles,
>>> +                       &gobj_read);
>>> +        if (r)
>>> +            goto free_timeline_points;
>>> +    } else {
>>> +        gobj_read = NULL;
>>> +    }
>>>   -    r = drm_gem_objects_lookup(filp,
>>> - u64_to_user_ptr(wait_info->bo_write_handles),
>>> -                   num_write_bo_handles,
>>> -                   &gobj_write);
>>> -    if (r)
>>> -        goto put_gobj_read;
>>> +    if (num_write_bo_handles) {
>>> +        r = drm_gem_objects_lookup(filp,
>>> + u64_to_user_ptr(wait_info->bo_write_handles),
>>> +                       num_write_bo_handles,
>>> +                       &gobj_write);
>>> +        if (r)
>>> +            goto put_gobj_read;
>>> +    } else {
>>> +        gobj_write = NULL;
>>> +    }
>>>         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>>                 (num_read_bo_handles + num_write_bo_handles));
>>

