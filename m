Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97BAC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AC010E956;
	Tue, 23 Apr 2024 13:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rsu3GtJ4";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79AD210E956
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:58:28 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-41a523e27e0so16885725e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713880707; x=1714485507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nPjynfS6dyziS2u+FMnS7EyrSflENvAXeAU49aYq4AA=;
 b=Rsu3GtJ4TQilA66jS7PTzTy0xVJU02vQMovTZJv257HVzIVUe/xyBXvyV0Gqagb1iM
 YFYWbBfuV++bB3lQ77K88k6Zw9RvfEhAcGBfL5IFCD5QZmi3S0aew+Nu0e3E8/NP/kdK
 uUTmbdWw849Q8p0Z3yZacS9q+osYRJT4nk/l4WfmgCvtXWnX+AKo5qKlNtw64BL16LVj
 yVlOAJW8h/LQ0MsAT12Tj2ygtZjcVQdjfSYJ1uyEVtzLObudYxi1Yzzr8E8C/ucqVj7P
 OVAmlSf7WYwFxHCZ8CTklwE8kTzgjLbOqpIOlxD5tWsOyx9up98HcyXHkjN+oShApXXn
 T6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713880707; x=1714485507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nPjynfS6dyziS2u+FMnS7EyrSflENvAXeAU49aYq4AA=;
 b=EOpY6TDUQlmHlSvN1O28B6BAfZgKpDTGeXv5ZgG40HjPC+HCDwxdaXT0UFHjYn257g
 IAWIRtAbO1HFqVEwQ8qSA5/bu4fkv+pDZ6KCNofIoaQS8I3oDTvwC9TBMHA5tE8Pew4t
 vxG5cP0aCsngYMW19unTjrDUixsrY4UM1HgVHiamYGmZnazbLRbLBKK8CZQNf9+6mGEU
 vh6zOpR82KR/7xzN3VKXAmotIowUmHNAWRXaO3psN09MfumcJxc+ZJGdjQ4DYzgyRHr2
 t/J6wuFU7x6ZSgVYUie+jCUqG/MxKJzEe2QVIfcxpylXDVchuG6/fYiKhc1/dQDoVzZ0
 tQ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhaGg2oUcOg5laLjF90fKYAVO8XgLCkBBg+YrwTmF7mxnRQD/Bg67N17ST2cTCfspJhTpxs400idHqgil0HjAeA5OGJGwYGnIZI5SM4Q==
X-Gm-Message-State: AOJu0Ywq+ZgvIA7o7tl1kUghJF1kjfuLBCjtL0M9LAyBoIzUghj0Kcl8
 m4qfA/L+1nXByhl5JSADvkqN8OZ9Exaxhh5bdQ21851XtAfqnrCY
X-Google-Smtp-Source: AGHT+IGZ8dd3pUSfNgajLMZmHSUUbJt3lD7dIAhUsyU9+R6ssEjKDES+ULJ5B3i6ssqgysVRPDVRPQ==
X-Received: by 2002:a05:600c:46c8:b0:414:d95:cc47 with SMTP id
 q8-20020a05600c46c800b004140d95cc47mr13338583wmo.30.1713880706490; 
 Tue, 23 Apr 2024 06:58:26 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a05600c1d9200b0041a3c0ee713sm8603673wms.39.2024.04.23.06.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:58:26 -0700 (PDT)
Message-ID: <2e0941f9-a5b0-40a7-b1ad-329d4ae53cd6@gmail.com>
Date: Tue, 23 Apr 2024 15:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240422143738.322710-1-alexander.deucher@amd.com>
 <959d6fe8-b5e4-4ffe-918c-cbd29a2342e1@gmail.com>
 <CADnq5_PzNC8qWq=XP5KCuvR15-UEJ0QDMtaK821wFVu-p_=Jsw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PzNC8qWq=XP5KCuvR15-UEJ0QDMtaK821wFVu-p_=Jsw@mail.gmail.com>
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

Am 23.04.24 um 15:18 schrieb Alex Deucher:
> On Tue, Apr 23, 2024 at 2:57 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 22.04.24 um 16:37 schrieb Alex Deucher:
>>> As we use wb slots more dynamically, we need to lock
>>> access to avoid racing on allocation or free.
>> Wait a second. Why are we using the wb slots dynamically?
>>
> See patch 2.  I needed a way to allocate small GPU accessible memory
> locations on the fly.  Using WB seems like a good solution.

That's probably better done with the seq64 allocator. At least the 
original idea was that it is self containing and can be used by many 
threads at the same time.

Apart from that I really think we need to talk with the MES guys about 
changing that behavior ASAP. This is really a bug we need to fix and not 
work around like that.

Christian.

>
> Alex
>
>> The number of slots made available is statically calculated, when this
>> is suddenly used dynamically we have quite a bug here.
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
>>>    2 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index cac0ca64367b..f87d53e183c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -502,6 +502,7 @@ struct amdgpu_wb {
>>>        uint64_t                gpu_addr;
>>>        u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
>>>        unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
>>> +     spinlock_t              lock;
>>>    };
>>>
>>>    int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index f8a34db5d9e3..869256394136 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1482,13 +1482,17 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
>>>     */
>>>    int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
>>>    {
>>> -     unsigned long offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
>>> +     unsigned long flags, offset;
>>>
>>> +     spin_lock_irqsave(&adev->wb.lock, flags);
>>> +     offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
>>>        if (offset < adev->wb.num_wb) {
>>>                __set_bit(offset, adev->wb.used);
>>> +             spin_unlock_irqrestore(&adev->wb.lock, flags);
>>>                *wb = offset << 3; /* convert to dw offset */
>>>                return 0;
>>>        } else {
>>> +             spin_unlock_irqrestore(&adev->wb.lock, flags);
>>>                return -EINVAL;
>>>        }
>>>    }
>>> @@ -1503,9 +1507,13 @@ int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
>>>     */
>>>    void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>    {
>>> +     unsigned long flags;
>>> +
>>>        wb >>= 3;
>>> +     spin_lock_irqsave(&adev->wb.lock, flags);
>>>        if (wb < adev->wb.num_wb)
>>>                __clear_bit(wb, adev->wb.used);
>>> +     spin_unlock_irqrestore(&adev->wb.lock, flags);
>>>    }
>>>
>>>    /**
>>> @@ -4061,6 +4069,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>        spin_lock_init(&adev->se_cac_idx_lock);
>>>        spin_lock_init(&adev->audio_endpt_idx_lock);
>>>        spin_lock_init(&adev->mm_stats.lock);
>>> +     spin_lock_init(&adev->wb.lock);
>>>
>>>        INIT_LIST_HEAD(&adev->shadow_list);
>>>        mutex_init(&adev->shadow_list_lock);

