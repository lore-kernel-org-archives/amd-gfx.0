Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45742C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 11:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAFF10E1D3;
	Tue, 13 Dec 2022 11:52:45 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839BA10E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 11:52:41 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id c66so17325744edf.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mh/b8OdrU1y48o0/0etK5ZpID9XN41QMRgvVgo1+Ppk=;
 b=qX9otn5Z4w/QejwVNMtwXf/8TnOr/SUSedfYcVfLLe9/7RszzJS0rGas+eSPC1rzS6
 HbKhA3tEKW1dQXi2JgPZuIRmqIc89TIQuHYkOMNn/tMMLLHR6tiNeECE/hUs9FKAgBrq
 xFzXwUZj1Ai1jeHpPrMCZ73z7FTlxFvEjXTiZSVwoRMNgW5o/hoR+LtvZhx7joV2OGHL
 23lEs9hg/AukKzrL5v7hTxnNITE5DOHM4G5Tod8PfMjmUNZL1tVFAe7A1PVbUwo9j1vn
 7NGZm9wPDPCTVMEu604AvoHOCRKRhizGagqsLw31xW5xg/yCa+Fm9/b6HwWzO4MbKXno
 YcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mh/b8OdrU1y48o0/0etK5ZpID9XN41QMRgvVgo1+Ppk=;
 b=Ba1caosGaJ3DD+CVtfV1uyYUMJ3r8ZyDpHHZqSefVVbQJZ/uezoU6/wbtHnK5y9LMv
 dinkJJbD0JixeePF1WaU3lIY5LdDiIoyoC0wEurY8iXc3lWJ1RjZw2B+xmePE3NyaNkg
 PjIYf5Jc2alxJMXbCMv3tfbPp5q7pcsYLX6k/HrYi1MJmVlN0uEGKH+bGFeE/hIB6hCM
 iRH4e0TZqgQrtKXzNJ0sZkyiiDvmGqCy0/ZFc2D0ESTKTX9I9urHmCt5lKVS/WP6sFe8
 m4xP7XY9WxJ6/0xSEgW4kn30HE6ZGN4RPT5r5Qt6MtbTkupqniMu3TLcgXjJqgCQ+Djx
 VhwQ==
X-Gm-Message-State: ANoB5plbwGGnwTgyBo8xKN0fswguWbDfp2XWr2yqeMmm/1KO4ur+oJ5s
 qkMrKpIs9SZzYWh47CFG5D0=
X-Google-Smtp-Source: AA0mqf4yLI3Me/OjKvL6/8LrnaRz7h8VOp1tpbV9XavzlwFS4wl5sbqdtTpobbslLqFcsuc14Jur0A==
X-Received: by 2002:a05:6402:3906:b0:461:79d8:f51a with SMTP id
 fe6-20020a056402390600b0046179d8f51amr16872221edb.10.1670932359899; 
 Tue, 13 Dec 2022 03:52:39 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea133.dip0.t-ipconnect.de. [91.14.161.51])
 by smtp.gmail.com with ESMTPSA id
 l4-20020aa7c304000000b0046b1d63cfc1sm4881406edq.88.2022.12.13.03.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Dec 2022 03:52:39 -0800 (PST)
Message-ID: <78758ba9-27db-4314-9e6d-101c11c669ca@gmail.com>
Date: Tue, 13 Dec 2022 12:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
 <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
 <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
 <e86f5bef-24a0-0eaf-7971-563285714399@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <e86f5bef-24a0-0eaf-7971-563285714399@amd.com>
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

Am 13.12.22 um 12:40 schrieb Lazar, Lijo:
> On 12/13/2022 12:30 PM, Christian König wrote:
>> Am 13.12.22 um 00:44 schrieb Luben Tuikov:
>>> On 2022-12-12 14:19, Christian König wrote:
>>>> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>>>>> Fix amdgpu_bo_validate_size() to check whether the TTM domain 
>>>>> manager for the
>>>>> requested memory exists, and to allow for non-exclusive domain 
>>>>> allocations, as
>>>>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>>>>> AMDGPU_GEM_DOMAIN_GTT.
>>>>>
>>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 
>>>>> +++++++------------
>>>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct 
>>>>> amdgpu_device *adev,
>>>>>        /*
>>>>>         * If GTT is part of requested domains the check must 
>>>>> succeed to
>>>>> -     * allow fall back to GTT
>>>>> +     * allow fall back to GTT.
>>>>> +     *
>>>>> +     * Note that allocations can request from either domain. For
>>>>> +     * this reason, check either in non-exclusive way, and if
>>>>> +     * neither satisfies, fail the validation.
>>>> That's not correct, the original logic was completely intentional.
>>>>
>>>> If both VRAM and GTT are specified it's valid if the size fits only 
>>>> into
>>>> GTT.
>>> Given that this patch fixes a kernel oops, should this patch then 
>>> fail the validation,
>>> i.e. return false?
>>
>> It should be sufficient if a BO fits into the GTT domain for size 
>> validation. If we haven't initialized the GTT domain and end up here 
>> we should probably just ignore it.
>>
>>>
>>> This would then fail, in amdgpu_ttm_reserve_tmr():
>>>
>>>     ret = amdgpu_bo_create_kernel_at(adev,
>>>                 adev->gmc.real_vram_size - 
>>> adev->mman.discovery_tmr_size,
>>>                 adev->mman.discovery_tmr_size,
>>>                 AMDGPU_GEM_DOMAIN_VRAM |
>>>                 AMDGPU_GEM_DOMAIN_GTT,
>>
>> As I said before using amdgpu_bo_create_kernel_at() with VRAM|GTT 
>> doesn't make any sense at all. We should probably drop the domain 
>> parameter altogether.
>>
>
> What is the alternative planned to prevent usage of VRAM at fixed 
> offsets?
>
> BTW, AMDGPU_GEM_DOMAIN_GTT for above doesn't make any sense. Discovery 
> region is always in VRAM domain.


Well that was my point, reserved regions are always in VRAM.

We probably don't need to ability to reserve in any other domain so we 
can drop the domain parameter here and just always assume that we need VRAM.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> &adev->mman.discovery_memory,
>>>                 NULL);
>>>
>>> Regards,
>>> Luben
>>>
>>

