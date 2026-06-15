Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8BCD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0331010E526;
	Mon, 15 Jun 2026 15:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="vV5/srHL";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B02A10E526
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:48:32 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso32036995e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781538511; x=1782143311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IitncnWmL4jmyadiRBuM5hwogrltjhCKyVH/ZMoybAQ=;
 b=vV5/srHLhX+v2S4WAysmQIPaiLWNW+e6LR4GC6IWDYnCE+Wq5wK0RBUZQdHohgRUxQ
 1PBTTQMxyobFrMCKrOg9cazbdO2PILF8exUPaZE11REBxn7g+NV1yckohnVDLZOeLN4c
 OHPlVmFNhAUApn5HCDEWBwLZhSzhUpkbKEtYM7AyrJyXxiCAh/W3aCXzdf+kvo6c21Rc
 IZ1KPqs9NW4rO2zg3BNXXGbHrE6UrZjJGvzBJQAyarw6bOBlzMUe6NjBxyQsNl8g9unJ
 Pmn3UO2KgZZu4eEQGjaJ2oZP/UArhijxwCau0pY9SqrqHtw7GVGF9DH3VG253e3zgVZK
 q2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781538511; x=1782143311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IitncnWmL4jmyadiRBuM5hwogrltjhCKyVH/ZMoybAQ=;
 b=lyxEtWF3jVIsGsWjGmOmwzem4LHgkovctMdBk+ZkfifoHnvWAr2gPMEvhVfRnOE2Q7
 feYHVMiuayRUsN6xt4VvD+SrQb/LavrgsgPBf9WAc1RV0JaUpDWQrnDIS+PlszBhQ4R+
 QCxNuh4ashKgr6EE1QZLoeZAXmKW9ILiYDPcs5Nb4afhfjd0KOQSA1DLaGPhkauC2b+c
 OwRZRSXMoU7xHw5w2eXgNiQTkZtBrUgpjS+0qjg4Rc2XLHprh03CfsKjfwfzkKLwFmXu
 Jy70iCQcXmaJHb4iH0LXcHh9koyIbhK9hLB8Y+ZwIkyyNLMrnNTaguBaEIXS0igPgfWa
 KQcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+c9T+EfHhijtn7OFU8ndms+E6XrT2YEsx1FWerw5oY4hsVx2kV7b3OrSpTn743HhjJhunQxlQs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYQPFxCKTTrIphmjGcCTHbInttc8NfQ+gec4MwgOOlH52F0vql
 KYRQXgFTYrwm7iznRijF7uxLL9uruk6GJ5+nf3cvt9pUwU2UT1bwWWRY8LsYJMjYU8s=
X-Gm-Gg: Acq92OHCunnT5xYgstkdVOkrfVGUgVHTfweGuJaoR0xq6ORbJgRMd/tZQ6bH7/Zqdeb
 InlGvM7ImW5WuyeKpwrPDYWW+d25H0QMltn5f8P975KdB9fdyzhLiPYZYHKn+i7a4h/Hoig1gSd
 x7nDZtPdQF+72UjmBkualP/0/JE5+hDI5mtf4gjGJy4sZgRuK+AL1463Wvc+/Oje/FYoGmZviXv
 7gh36SCN8d+C4ENvm7Wr1FBvAyHo0pFnqD1z2HOYGvD2/J1R6Fs3zr8C/vo73W+tk+A9Ux4nMxu
 OkhTaQheJ6zJe50PPc2ADCnpnL+e75/tfeSQ/goTMkG+QePmOozMT2keXiVtFXZlgC0mkZjC3ti
 pg+z5s6CA/+1uZRRV6YtzZlI0IQhh1huPUX+E5zC/e3oIovDsCrqIKmW8aFGUvVkvIbnPeVO9bF
 ugMa4QFs02RJC5PB+IAfN+iB84LohPXUlMGU/ajrCXLzCM
X-Received: by 2002:a05:600c:c0d1:10b0:490:b9c3:6c69 with SMTP id
 5b1f17b1804b1-490ec50f80cmr150202305e9.30.1781538510875; 
 Mon, 15 Jun 2026 08:48:30 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa5b079sm1860125e9.12.2026.06.15.08.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 08:48:29 -0700 (PDT)
Message-ID: <c3f7ba5b-ce84-4626-b772-1e7d656aac93@ursulin.net>
Date: Mon, 15 Jun 2026 16:48:27 +0100
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
 <2805750.vuYhMxLoTh@timur-hyperion>
 <0b18193b-9f2d-4ea9-8db3-08579325ab0c@ursulin.net>
 <10078559.eNJFYEL58v@timur-hyperion>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <10078559.eNJFYEL58v@timur-hyperion>
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


On 15/06/2026 16:32, Timur Kristóf wrote:
> On Monday, June 15, 2026 5:23:52 PM Central European Summer Time Tvrtko
> Ursulin wrote:
>> On 15/06/2026 15:52, Timur Kristóf wrote:
>>> On Monday, June 15, 2026 4:32:23 PM Central European Summer Time Tvrtko
>>>
>>> Ursulin wrote:
>>>> On 25/05/2026 12:45, Timur Kristóf wrote:
>>>>> Different interrupts may have different timestamp sources,
>>>>> which shouldn't be compared.
>>>>>
>>>>> If we compare the timestamps of retry faults to timestamps
>>>>> of other interrupts, it may result in all retry fault
>>>>> interrupts being filtered out, because of the different
>>>>> time stamp source.
>>>>>
>>>>> This issue was observed on Strix Halo.
>>>>> Solved by storing the timestamp of the last page fault interrupt.
>>>
>>> Hi,
>>>
>>>> This one may require access to AMD docs to review. For example I am
>>>> immediately curious as to how many different clock sources on a single
>>>> IH there are
>>>
>>> As far as I know there are various timestamp sources in the GPU and some
>>> interrupts use different ones. I am not aware of any documentation on this
>>> topic, unfortunately.
>>>
>>>> how does that relate to the timestamp_src field
>>>
>>> The timestamp_src field is set differently when the timestamp source is
>>> different. So, it could happen that we accidentally filter out all page
>>> faults when we shouldn't.
>>>
>>>> and if there are indeed multiple clock domains should the patch perhaps
>>>> be
>>>> generalized to something like
>>>> ih->processed_timestamp[entry->timestamp_src] or something?
>>>
>>> For the context of this patch, I think it doesn't matter how many
>>> different
>>> kinds of time stamps there are. What's important is that we just shouldn't
>>> compare timestamps of page faults with time stamps of other interrupts.
>>
>> True, thank you!
>>
>> Another question is why the backward timestamp check is needed only for
>> fault interrupts? I do not see it elsewhere.
> 
> Correct, this is only used for retry fault interrupts and only when they are
> dispatched to the soft IH ring.
> 
> The reason this was added is because when retry faults are enabled and the GPU
> hits a VM fault, it keeps spamming the CPU with many interrupts for the same
> fault until the fault is resolved. The CPU needs to filter out the faults which
> it is already handling, otherwise we would end up handling the same fault
> multiple times.

Got it, thank you!

> (As a side note, I should also probably look into how to reduce the frequency
> of how often these interrupts are repeated.)
> 
>>
>> Let me also ask two more things below.
>>
>>> As far as I see the timestamp doesn't really matter for other interrupts
>>> as we only use it to filter out page faults and nothing else.
>>>
>>> Hope this helps,
>>> Timur
>>>
>>>>> ---
>>>>>
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>>>>>     2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>>>> 13bec8461cde..52258f1341c2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device
>>>>> *adev,>
>>>>>
>>>>>     	uint32_t hash;
>>>>>     	
>>>>>     	/* Stale retry fault if timestamp goes backward */
>>>>>
>>>>> -	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
>>>>> +	if (timestamp == adev->gmc.processed_fault_timestamp ||
>>>>> +		amdgpu_ih_ts_after(timestamp, adev-
>>>>
>>>> gmc.processed_fault_timestamp))
>>
>> First thing is whether you are confident the equality check is either
>> safe or required?
> 
> I don't see why it wouldn't be safe. But maybe it isn't required.
> What do you suggest instead?

Safe as is whether it has potential to swallow a legitimate unseen faults.

Looking at amdgpu_gmc_filter_faults() a bit lower down, it does appear 
to filter out repeated faults on the same address. Would it be safe to 
rely on that instead of the timestamp equality check?

I appreciate that may cause a transient interrupt handling storm if the 
clock granularity is poor, but maybe that is better than losing a fault.

>> For example can two blocks fault with the same timestamp on different
>> addresses?
> 
> They might. But keep in mind that the GFX block just keeps spamming the
> interrupts until the fault is handled. So, if we filter one out by mistake, we
> know we will just receive the same fault again very soon.
> 
>> Or from a different angle, is the clock granularity good enough to not
>> coalesce two separate faults to a single timestamp?
> 
> I am not sure about that.

I guess if the equality filter can be removed then this concern also 
goes away.

Regards,

Tvrtko

>>
>>>>>     		return true;
>>>>>
>>>>> +	adev->gmc.processed_fault_timestamp = MAX(timestamp,
>>>>> adev->gmc.processed_fault_timestamp); +
>>
>> Doesn't a plain assign work here? The if above has already verified new
>> timestamp is larger than the old.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>>>     	/* If we don't have space left in the ring buffer return
>>>
>>> immediately */
>>>
>>>>>     	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>>>>>     	
>>>>>     		AMDGPU_GMC_FAULT_TIMEOUT;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
>>>>> 676e3aaa1f27..77eb15380284 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>> @@ -361,6 +361,7 @@ struct amdgpu_gmc {
>>>>>
>>>>>     	u64 noretry_flags;
>>>>>     	u64 init_pte_flags;
>>>>>
>>>>> +	u64 processed_fault_timestamp;
>>>>>
>>>>>     	bool flush_tlb_needs_extra_type_0;
>>>>>     	bool flush_tlb_needs_extra_type_2;
> 
> 
> 
> 

