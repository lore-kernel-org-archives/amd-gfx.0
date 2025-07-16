Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1841FC83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 14:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC9910E753;
	Wed, 16 Jul 2025 14:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NbjE3Ni5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583FF10E753
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wP3H6VNBYfO6INO4GnSM+dMGL/8NJq1UWj1yhENc52k=; b=NbjE3Ni5Iu6PMxbn2e3jnjmBa2
 T8ArcDu8L7NHB8boAv9v9zIDLGxjS5FbnWet/mHUN0PF8cvdOFSx8eXF+9Uv6D2YfD4DP4Gk/ftag
 QTT+jd8wV/EaQbAfM6KR/xqBBzvUb/oSxFc1VXSDkpxhds/e+nhQq2zsW9H3fsLwhLPqF7sD943J1
 m6Z+5IgfXDCHupzR0IeA39abVGr7aXv3Q0TSWmSX/0QVFNXRn7HmPk8n/1m089vWrD95nfH1w55sE
 OvuCXFRjOC01+PtRvHxCR4rKY2CebAGjWhSwgNKU0e4LeDhK4bGzkNWBvuqzUf9Y53hmJswIW9wad
 iBWEe/Dg==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1uc2mE-00HLGj-HU; Wed, 16 Jul 2025 16:06:30 +0200
Message-ID: <3ba4e401-149a-4bb2-8725-1e4fd58f3288@igalia.com>
Date: Wed, 16 Jul 2025 15:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
 <CADnq5_NYhPa+6gUqeJsvXkqtkwwkWmv=F70Wv96L+CEA-AGE1w@mail.gmail.com>
 <6d19ad87-6091-477c-a1ee-ddb224a63fe1@igalia.com>
 <CADnq5_PFKKdDOnX7np+31jDfmf17=PNSFoFtmHk+XSPqRjnf4Q@mail.gmail.com>
 <a07c4db8-a775-4036-a30e-8266c02283df@igalia.com>
 <83463d64-b0dc-43e7-b098-b978c44756da@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <83463d64-b0dc-43e7-b098-b978c44756da@amd.com>
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


On 16/07/2025 14:00, Christian König wrote:
> On 16.07.25 14:51, Tvrtko Ursulin wrote:
>>>>>>> be disabled once GFX/SDMA is no longer active.  In this particular
>>>>>>> case there was a race condition somewhere in the internal handshaking
>>>>>>> with SDMA which led to SDMA missing doorbells sometimes and not
>>>>>>> executing the job even if there was work in the ring.
>>>>>>
>>>>>> Thank you, more or less than what I assumed.
>>>>>>
>>>>>> But in this case there should be no harm in holding GFXOFF disabled
>>>>>> until the job completes (like this patch)? Only a win to avoid the SMU
>>>>>> communication latencies while unit is powered on anyway.
>>>>>
>>>>> The extra latency is only on the CPU side, once the
>>>>> amdgpu_ring_commit() is called the SDMA engine is already working.
>>>>
>>>> It is on the CPU side but can create bubbles in the pipeline, no? Is
>>>> there no scope with AMD to have GFX and SDMA jobs depend on each other?
>>>> Because, as said, I've seen some high latencies from the GFXOFF disable
>>>> calls.
>>>
>>> The SDMA job is already executing at that point.  The allow gfxoff
>>> message to the firmware shouldn't come until later because it's
>>> handled by a delayed work thread from end_use().  If you have multiple
>>> submissions to SDMA within the delay window, the begin_use() and
>>> end_use() will just be ref count handling and won't actually talk to
>>> the firmware.
>>
>> I followed up with testing a bunch more games, and is it turns out, Cyberpunk 2077 is the only one which has this submission patterns where default GFX_OFF_DELAY_ENABLE is regularly defeated.
>>
>> There, around 1.2 times per second the SDMA submissions miss that 100ms hysteresis and cause a CPU latency over 100us (I only measured when >100us and ignored the rest). Average latency is ~400us and max is ~2ms. So IMHO quite bad.
> 
> What exactly does Cyberpunk do to hit that? Are those SDMA page table updates, clears or userspace submissions?

I will have to look into that to provide an answer.

>> And the vast majority of those latencies come from the SMU request. Only very rarely someone hits the mutex contention path.
>>
>> So that was the motivation for the RFC. I suppose I could have also proposed to increase the hysteresis, but holding the GFXOFF disabled for the duration of the job sounded preferable for power consmuption.
>>
>> Anyway, given I only found Cyberpunk 2077 suffers from this I guess it maybe isn't to interesting to upstream for you guys. Then again it is limited to specific old SKU so maybe it should not be that controversial either? Only that Christian NAKed tying it to job lifetime. So I don't know, AMDs call.
> 
> Well what you could do is to take a look if we couldn't simplify the SMU and/or adjust the GFX_OFF_DELAY_ENABLED.

SMU stuff, as far as I can follow it, ends up with simply sending some 
messages to the firmware. So I am not sure what and how could be 
optimised there.

Increasing GFX_OFF_DELAY_ENABLED would work, if large enough, but I 
think it could be bad for power usage, depending on the workload.

> On the other hand why does it help to keep GFXOFF disabled while running the SDMA job?

Only because I tied it to both GFX and SDMA.

RFC does this:

1) Marks SDMA as "needs GFXOFF workaround".
2) Propagates "needs GFXOFF workaround" to adev if any active ring has 
it set.
3) If adev has it set, it grabs and extra GFXOFF disable for GFX, 
COMPUTE and SDMA submissions, and marks those jobs as "hold GFXOFF".
4) Releases the GFXOFF when marked jobs are "completed" (well freed, 
since completion is IRQ context so hard).

AFAIU from what Alex said I understood the parts of the chip handling 
GFX and SDMA (not sure about compute) are under the same "power gating 
domain" (right name?).

What would you suggest to log power use during the game? Something like 
once per second or so?

Regards,

Tvrtko

