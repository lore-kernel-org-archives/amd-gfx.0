Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A58CD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F260910E4F5;
	Mon, 15 Jun 2026 15:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Yf1fNJk2";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79F510E4F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:23:55 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so5587657a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781537034; x=1782141834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zt/UuJFb8pVpUtNblYiydB7//duhwa9/qQazr47fsR4=;
 b=Yf1fNJk2urLSestJdh1gL/K31X4aXJcus662YBhe1alYweg5PBnzTx3JtFJ8n8rjDe
 azE3HkYLeMH0Cu0p2B2mCWiIytgN5IB+KgMgU2xkgs7VCQphINcoZ0+SSUMfnDuefTYK
 6o+HmaczfdwGITQCleAIJ17PO/Kq3orIhQoffoQOV9TwUQWmMF2VwCaWv1fsr2dYk1Vn
 t+HufF8dLC6PbRqD1GOWOWldJwA22dPfe7om7HyVokFRWfBUipak+pcxB2B5vl3WsoBr
 bmEHZd/ek1OP+cAIkpUutfnH6fC7EUd7WiJyIfw5eB07M0fumNj4MPDkmB03oqms/qd6
 Jvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781537034; x=1782141834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zt/UuJFb8pVpUtNblYiydB7//duhwa9/qQazr47fsR4=;
 b=e4Q5NazpN+/s7faRrkpRBGEqlMjn3Vfnq9CP9PsycmUMo8LB/78PL3nz5/oJZ5OTjv
 jSPqHICa58CoDo9a/cpGVJMMEUTFtniVe1CpW7h/zf25rzO0XvyufbNJM+8LqHUH0b2M
 84mscyMexatd/rRNbYM0eWHAB4Sf5eYHglmoUu0QVpx4cf5RtFI7vCbP76v3IZD1HSMF
 PDGTKUajr2Tr5mMPf/JkfVf62zhdrqdzUZMFwOO5JIlG4QFsulVc8fJQcxHtcvU4n6q9
 WFA4WVlAZdSgHEYrx2MOsEEj4JXuNIJ1C4OZ8tqLtY/78BDNZ+3sJdOmqrLsnIyf13OV
 LwPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98dJF5PKRA/POPphbjiM30KspyUjVNVYM3nWqZ4NO4kCO1W99TwRno19oLv+3gWI3gJGqXW/uv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlE/OfgI395HLySFG6DB0VMbvSTro/q3NDCfCKhW9HqX/NxmlO
 D0UMiw4UDyAgFrO9iILq5MDGXy8+AQgviD/mvIejS9BVSBMFAuqLd2w6pOYCBe7IdYA=
X-Gm-Gg: Acq92OEbCFemboQZSYD/D0lSs3eZculyq3HTLIx2Hq+f9DSCer+Zj52MIo0ChVmC9I6
 lSwBlVGEkv/rPH0RmMiz9obuWPd4Yv83yjAz9vl63uSRhQdTLdv9v8tVkHCtD+UssjaJl+BEe6M
 zd08FS98xvTqOxyR9m6ZhC48iQClSuPFCzIMg9mqPrVl/SZSejkwDMwlM21iVjZ+6zBtnUbzlys
 m2F+HXruwxO5tII7w+4+HzJQV8qUJeNYOF/fRtulEBaYz3F+3U3Z3o5I6rJg+tlU7fzJzcdsinQ
 7nIcMQ9OIFtPlAwBleEpgfbswkq4icWPFG3Z30jF7cwIBGPPAOnQJQP4CXtRhTcIU540KFTrieJ
 qymvEoe2E2WkX+y85gwJdpKrKPz60H78FZMwf0NHuGv4ooFDKrICAPx8U0vwx5IKH+zC+2rnA0j
 xAjvNy0HouXBZ+q8MnnsQN6dst3hPtswmHj5Wv/DXSMonS
X-Received: by 2002:a17:907:3f27:b0:bfb:bca0:5a04 with SMTP id
 a640c23a62f3a-bff4bdfbd06mr492132866b.29.1781537033725; 
 Mon, 15 Jun 2026 08:23:53 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4420854sm499669966b.7.2026.06.15.08.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 08:23:53 -0700 (PDT)
Message-ID: <0b18193b-9f2d-4ea9-8db3-08579325ab0c@ursulin.net>
Date: Mon, 15 Jun 2026 16:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-4-timur.kristof@gmail.com>
 <fc23a624-650b-40b3-8de2-07d4a44ff603@ursulin.net>
 <2805750.vuYhMxLoTh@timur-hyperion>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <2805750.vuYhMxLoTh@timur-hyperion>
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


On 15/06/2026 15:52, Timur Kristóf wrote:
> On Monday, June 15, 2026 4:32:23 PM Central European Summer Time Tvrtko
> Ursulin wrote:
>> On 25/05/2026 12:45, Timur Kristóf wrote:
>>> Different interrupts may have different timestamp sources,
>>> which shouldn't be compared.
>>>
>>> If we compare the timestamps of retry faults to timestamps
>>> of other interrupts, it may result in all retry fault
>>> interrupts being filtered out, because of the different
>>> time stamp source.
>>>
>>> This issue was observed on Strix Halo.
>>> Solved by storing the timestamp of the last page fault interrupt.
>>
> 
> Hi,
> 
>> This one may require access to AMD docs to review. For example I am
>> immediately curious as to how many different clock sources on a single
>> IH there are
> 
> As far as I know there are various timestamp sources in the GPU and some
> interrupts use different ones. I am not aware of any documentation on this
> topic, unfortunately.
> 
>> how does that relate to the timestamp_src field
> 
> The timestamp_src field is set differently when the timestamp source is
> different. So, it could happen that we accidentally filter out all page faults
> when we shouldn't.
> 
>> and if there are indeed multiple clock domains should the patch perhaps be
>> generalized to something like
>> ih->processed_timestamp[entry->timestamp_src] or something?
> 
> For the context of this patch, I think it doesn't matter how many different
> kinds of time stamps there are. What's important is that we just shouldn't
> compare timestamps of page faults with time stamps of other interrupts.

True, thank you!

Another question is why the backward timestamp check is needed only for 
fault interrupts? I do not see it elsewhere.

Let me also ask two more things below.

> As far as I see the timestamp doesn't really matter for other interrupts as we
> only use it to filter out page faults and nothing else.
> 
> Hope this helps,
> Timur
> 
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>> 13bec8461cde..52258f1341c2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device
>>> *adev,>
>>>    	uint32_t hash;
>>>    	
>>>    	/* Stale retry fault if timestamp goes backward */
>>>
>>> -	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
>>> +	if (timestamp == adev->gmc.processed_fault_timestamp ||
>>> +		amdgpu_ih_ts_after(timestamp, adev-
>> gmc.processed_fault_timestamp))

First thing is whether you are confident the equality check is either 
safe or required?

For example can two blocks fault with the same timestamp on different 
addresses?

Or from a different angle, is the clock granularity good enough to not 
coalesce two separate faults to a single timestamp?

>>>
>>>    		return true;
>>>
>>> +	adev->gmc.processed_fault_timestamp = MAX(timestamp,
>>> adev->gmc.processed_fault_timestamp); +

Doesn't a plain assign work here? The if above has already verified new 
timestamp is larger than the old.

Regards,

Tvrtko

>>>
>>>    	/* If we don't have space left in the ring buffer return
> immediately */
>>>    	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>>>    	
>>>    		AMDGPU_GMC_FAULT_TIMEOUT;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
>>> 676e3aaa1f27..77eb15380284 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -361,6 +361,7 @@ struct amdgpu_gmc {
>>>
>>>    	u64 noretry_flags;
>>>    	u64 init_pte_flags;
>>>
>>> +	u64 processed_fault_timestamp;
>>>
>>>    	bool flush_tlb_needs_extra_type_0;
>>>    	bool flush_tlb_needs_extra_type_2;
> 
> 
> 
> 

