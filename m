Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C47DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC09710E5C3;
	Fri, 25 Nov 2022 09:57:50 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1C010E5C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 09:57:46 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id n20so9272699ejh.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KP+pdLfey8myM74LUSEWqRilU7o29NDYyjn315Ums6o=;
 b=cV5ihGfwibCxopGQmoPcj7JA0D2DaJKCcWKNxulJTMTR6PE04PfOuzI1WIAsdsW/Ww
 eoSzbKoN3cgBOxAUQOU8kYd0KwjkexwqqSYyBmUE389ZchiJQr4EI+oCT0JnUBJAwBDH
 i6jip+PQuZV9q1pWIF5kzrhkqLU0yKcBNowrTE7y8p6Qot82gnQ80b0ADUPS7traLjwt
 KrVULafrvL52Zqem0ME3YGYmMrvv7rOcQFaByYKn0cT9LC+xfzJgOOxPB2amxN6hGyve
 hmqUyode8/zI75R/KUhZg8q2lqB9Rz0qaIJOdDI8SirQWXI/J6/3YiRV8KwFKODrb+wL
 UWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KP+pdLfey8myM74LUSEWqRilU7o29NDYyjn315Ums6o=;
 b=wi33WKmR2bZXCL4fRW53AzuEBbu0VB2JWYLSzmBUO5tjUy6wg+DBsnBljjh0TPkQqn
 PjJ1FhSbZge1yBJCX59MQ+H5W7Be1ftIuEtJKXuYdP2LnzakERSAKI/L3KXqqqY5ZuIM
 3/xalDGt42xQb8xvMxL4togl9A1QnXyqSOmr433gFONzXjybcDa3vZDvhRQOBNR+osPk
 FIKctFMk/zmldQdhdYNINezuSleLA1P3jb7Jc5R/+a/p+iz7GhaliTc9yNBmgKSl5P2l
 c74o4tH0izsy5A10GUIaCYEpD+1UI7cJxV71AGyGc1iy81XesKD6p3LHFTWIFiFpIMbo
 U8bA==
X-Gm-Message-State: ANoB5plkat8nA7uYJY1+dxV5saJr40jyyOAmeQto4huMttiQ73eapFkU
 IP/kC2pE3yz1OPFSpZqH7tE=
X-Google-Smtp-Source: AA0mqf6oVVPNdUHqowhoFUqpa84+LWEO/v4AgGaz+KQNCbMEiMgDic8+inqemx+mQlV3Rfmk4t21Bg==
X-Received: by 2002:a17:907:8d03:b0:7ae:1d34:4da5 with SMTP id
 tc3-20020a1709078d0300b007ae1d344da5mr27431361ejc.340.1669370264533; 
 Fri, 25 Nov 2022 01:57:44 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:24a6:d989:49bb:611a?
 ([2a02:908:1256:79a0:24a6:d989:49bb:611a])
 by smtp.gmail.com with ESMTPSA id
 p27-20020a17090628db00b007ae4717bef1sm1405438ejd.15.2022.11.25.01.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 01:57:43 -0800 (PST)
Message-ID: <22425c61-9a95-a650-d113-396aa35e52cc@gmail.com>
Date: Fri, 25 Nov 2022 10:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
 <5319277f-5841-4051-2684-93b3a985197a@amd.com>
 <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
 <52eed51e-e234-aa36-3d74-3a4f39bb1dad@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <52eed51e-e234-aa36-3d74-3a4f39bb1dad@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 25.11.22 um 09:33 schrieb Luben Tuikov:
> On 2022-11-25 02:59, Christian König wrote:
>> Am 25.11.22 um 08:56 schrieb Luben Tuikov:
>>> On 2022-11-25 02:45, Christian König wrote:
>>>> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>>>>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>>>>
>>>>> Cc: James Zhu <James.Zhu@amd.com>
>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>>>>     1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>>     	hmm_range->dev_private_owner = owner;
>>>>>     
>>>>>     	do {
>>>>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>>>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>>>>> +				       hmm_range->start + MAX_WALK_BYTE,
>>>>> +				       end);
>>>> Since end is a local variable I would strongly prefer to just have it
>>>> use the correct type for it.
>>>>
>>>> Otherwise we might end up using something which doesn't work on all
>>>> architectures.
>>> They all appear to be "unsigned long". I thought, since we assign to
>>> hmm_range->end, we use that type.
>> Mhm, then why does the compiler complain here?
> Right... so MAX_WALK_BYTE is 2^36 ULL (diabolically defined as 64ULL<<30 :-) ),
> and this is why the minmax check complains.
>
> So, since the left-hand expression is unsigned long,
> i.e.,
> 	hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
> is,
> 	unsigned long = min(unsigned long long, unsigned long);
> The compiler complains.
>
> I'd really prefer MAX_WALK_BYTE be less than or equal to ULONG_MAX,

That's not only a preference, but a must have. Otherwise the code maybe 
won't work as expected on 32bit architectures.

> and be defined as <literal>UL. I mean, why is everything in struct hmm_range
> "unsigned long", but we set a high limit of 10_0000_0000h for an end, and
> compare it to "end" to find the smaller? If our "end" could potentially
> be 10_0000_0000h then shouldn't the members in struct hmm_range be
> unsigned long long as well?

No, that the hmm range depends on the address space bits of the CPU is 
perfectly correct. Essentially this is just an userspace address range.

Our problem here is that this code needs to work on both 32bit and 64bit 
systems. And on a 32bit system limiting the types wouldn't work 
correctly as far as I can see.

So the compiler is complaining for rather good reasons and by using 
"min_t(UL" we just hide that instead of fixing the problem.

I suggest to use "min_t(u64" instead. An intelligent compiler should 
even be capable of optimizing this away by looking at the input types on 
32bit archs.

>
> And for the timeout, we have the (now) obvious,
>
> 	timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL);
>
> and I don't know why we necessarily need a "1ULL", when 1UL would do just fine,
> and then compilation passes for that statement. I can set this to 1UL, instead
> of using max_t().

I think just changing this to 1UL should be sufficient.

Regards,
Christian.

>
> Regards,
> Luben
>
>
>> As far as I can see "unsigned long" is correct here, but if we somehow
>> have a typecast then something is not working as expected.
>>
>> Is MAX_WALK_BYTE maybe of signed type?
>>
>>> Would you prefer at the top of the function to define "timeout" and "end" as,
>>> 	typeof(hmm_range->end) end, timeout;
>> Well for end that might make sense, but timeout is independent of the
>> hmm range.
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Luben
>>>

