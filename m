Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE50DC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 11:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCC010E19B;
	Wed, 15 Jul 2026 11:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="U7FP5t/Q";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D49110E19B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 11:07:52 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so308044166b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784113670; x=1784718470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BqvNWS7ynothILQGOIFzn3zEwNSgdylTQT+Ovugrxi0=;
 b=U7FP5t/QkJ2Kf+kiZzw/AYqn/Kfed5RbABtCAQkwkVtRxrF6Hnu6uwqSDG5CXLDRbn
 3/N+/5RXeN8QPQC6SWcQgBMapGB2wceZnaVeZpMJxkhdkdEU1r7eVAK2G8bIzlfBhkWY
 RlEfsyfdhxV1ApC90DbGnDMWQ8d8tP90PXH7BGblQ3QHvko14fmp0Rfa9qNIOhusJq1A
 ooqWb8dhKTAYhNW2XhJwrwy9dnps22ig6tvbDCuq0ljkBj+anp/uBr9h/ZKWg3PgM3KD
 oypetxotp28AUs7RdaoDqNEAyG6Iyp1BYQIj81Sy1v/ulGakKH6vwgEB/woi0/V1+1Ns
 nICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113670; x=1784718470;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BqvNWS7ynothILQGOIFzn3zEwNSgdylTQT+Ovugrxi0=;
 b=G+CeRsjTm7YdIbkfdXcluXH84kvlJ98X/Vo9nP3QwXnnJ1tVY8ZPluNySsrcswUp1Y
 G68C15pRHYYIYOHkFPQmjzOiRHvL3bqKCXO39+saz+mpak5B9s2ayZYx9i5iWBuo888r
 R8xpT69NIDqzHMdGwSi11HNRhFca5tA6PSIT9kT7FXtTd2JbwCRQ/iFMmAhXZR76nsWC
 JMiyrrvjaJXfqRjT2vgLTffFi6hkP7O4mJTYEhJiwtg9P8hlXDn9ebBhNpxuwqMvLq8q
 HDOVEFgZt8Bbw8fp1cdmCHX4R0kq5aY+pjl01VfD1E8qbHqZhGzZ9U1kFVRCxeosu3FO
 76kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ+mFCWGsnMOO7QNxSZ2iZQWY02C8W0KluHZfHqgFfprFTiP6l4j9mX0qWXJDytTp6lZY6vueu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi5o7VwzuAMfM9kBV2KXFx4IlFNfY5ZciqrrhtqgZoYT0/Vxkn
 TwS28RYCyDMd/sz8m1IHIEPCPNvJ1A16nWOAxKck1TNaMBqnspfkPu9Rx4W3KGqsTkE=
X-Gm-Gg: AfdE7cmz8cc1ASYSQty1+HGBlait2j+eJrX5k28dFxSIy2Gl8v6iZ/sL7tD73KmcE3/
 fDwVs4HMAEmzdAjQAIfpSpcCS3j5SVf97suZJnVhamEnQqgdjVEZfJa4qNppicVlwUH73yq+TMK
 GJbJoFxUIvQSHMG5bZjvr+qgjMqoFztyYdgNLFbneRf2T3qPsIkgB5QbfwkCM2LNk+ELnEw75h2
 bA98cYl1CddDGzpMbnCa+IMziE3wiTXLJGjeuHJpWFEarI/IHy4DTPE8VQEaTBgQXGcUOU/DH2c
 b0TebpmF0kNwD6Meviz2BLoAcGbxqI4L2jcdYnE1iHSPjg2si+i9VKm5g77DfnZgRIhQ5vwTtZY
 Xt6l6gFzemLc5Ind4l7/s2KLS09xGw5IBbZZmWrbcAjr49VLQ9De978qtBRYILhvOw/5vjhPmO+
 jkZM1cyWT1BJxNso4WotO3IwYoChSvIQMEtA==
X-Received: by 2002:a17:907:7247:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c161e844fc3mr1071625566b.6.1784113670174; 
 Wed, 15 Jul 2026 04:07:50 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16873187absm4086666b.38.2026.07.15.04.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 04:07:49 -0700 (PDT)
Message-ID: <c4989cf2-9826-4c8f-9a7f-d3155fde8738@ursulin.net>
Date: Wed, 15 Jul 2026 12:07:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdgpu/gfx7: Clean up gfx ring during reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-7-timur.kristof@gmail.com>
 <d6e5a13d-bb65-4633-8c0e-8b89f292bc3f@ursulin.net>
 <20288812.fSG56mABFh@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20288812.fSG56mABFh@timur-max>
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


On 15/07/2026 11:16, Timur Kristóf wrote:
> On 2026. július 15., szerda 11:18:19 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 13/07/2026 13:58, Timur Kristóf wrote:
>>> Clear the WPTR and RPTR at ring initialization.
>>> Additionally clear the ring contents during reset.
>>
>> Please add the why part to your commit messages. ;)
> 
> After a reset, the ring contents could be "dirty" and thus need to be cleared
> to prevent the command processor from executing packets left over in the ring
> from before the reset. I think this is obvious, but I'm happy to add some text
> to the commit message to explain it more.

Yes please, it's easier to review if commit messages always explain the 
what, how and why. It does not have to be long when it is simple like in 
this patch.

>> Cover letter mentions the series is reworking to match gfx7 to gfx8 but
>> I looked in drm-tip and amd-staging-drm-next and
>> gfx_v8_0_cp_gfx_resume() does not yet have these changes.
> 
> The GFX8 code does have this:
> 
> For graphics queues:
> In gfx_v8_0_cp_gfx_resume() it also sets wptr = 0; and calls
> amdgpu_ring_clear_ring() unconditionally. This is actually not needed during
> first initialization because the amdgpu_ring_init() called from
> gfx_v8_0_sw_init() already clears the ring, which is why I call the clear
> conditionally on GFX6-7. I could of course change the GFX6-7 code to also call
> it unconditionally though for the sake of simplicity and consistency.
> (It is missing the atomic things though. I think it should have that too.)

Ack. Then just improve the commit message please - instead "Additionally 
clear the ring contents during reset", have something like "Move the 
existing clearing of ring content to happen only during reset because it 
is otherwise already done during ring init".

Presumably this is also true during resume?

> For compute queues:
> In gfx_v8_0_kcq_init_queue() it clears the wptr, also the wptr_cpu_addr and
> also calls amdgpu_ring_clear_ring().

Specifically about wptr_cpu_addr and rptr_cpu_addr.

1)
Does gfx7 have 64-bit support or normal write would do? Ie. I don't see 
gfx7 code using the atomic64. 64-bit support seems to start in gfx9.

2)
Does rptr_cpu_addr need touching at all? Out of all other files only MES 
does it. At least if my quick grep is to be trusted.

>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index a93cc02c3400..915612628f9a
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -2546,8 +2546,14 @@ static int gfx_v7_0_cp_gfx_resume(struct
>>> amdgpu_device *adev)>
>>>    	WREG32(mmSCRATCH_ADDR, 0);
>>>    	
>>>    	/* ring 0 - compute and gfx */
>>>
>>> -	/* Set ring buffer size */
>>>
>>>    	ring = &adev->gfx.gfx_ring[0];
>>>
>>> +	atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
>>> +	atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
>>
>> One day we need to fix this whole atomic64 situation.
> 
> What is the situation that needs to be fixed?

It is defined as normal u32 * and then, AFAIU, different ip version use 
32- or 64-bit access depending on whether the respective ip version has 
support for 64-bit ring pointers. The ugly casting should be hidden in 
wrappers as minimum. Another task for a rainy day.

Regards,

Tvrtko

>>
>>> +
>>> +	if (amdgpu_in_reset(adev))
>>> +		amdgpu_ring_clear_ring(ring);
>>> +
>>> +	/* Set ring buffer size */
>>>
>>>    	rb_bufsz = order_base_2(ring->ring_size / 8);
>>>    	tmp = (order_base_2(AMDGPU_GPU_PAGE_SIZE/8) << 8) | rb_bufsz;
>>>    
>>>    #ifdef __BIG_ENDIAN
>>>
>>> @@ -2559,6 +2565,7 @@ static int gfx_v7_0_cp_gfx_resume(struct
>>> amdgpu_device *adev)>
>>>    	WREG32(mmCP_RB0_CNTL, tmp | CP_RB0_CNTL__RB_RPTR_WR_ENA_MASK);
>>>    	ring->wptr = 0;
>>>    	WREG32(mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
>>>
>>> +	WREG32(mmCP_RB0_RPTR, lower_32_bits(ring->wptr));
>>>
>>>    	/* set the wb address whether it's enabled or not */
>>>    	rptr_addr = ring->rptr_gpu_addr;
> 
> 
> 
> 

