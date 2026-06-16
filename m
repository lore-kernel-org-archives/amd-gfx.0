Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909C9CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 13:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BCA10EAB6;
	Tue, 16 Jun 2026 13:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="JHI7N1C8";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E7210EAB6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 13:32:58 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6914a658115so5890474a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781616777; x=1782221577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cJ8uzDfkyPC114TCwls4I0KN7WwlmLTXw+oDgsP0ZvQ=;
 b=JHI7N1C8VQ/jbedvCoFB4xnf3lqsYgqTasPfCNqHSOFkfFNbnO+XUTe/Pzwrz8C3/V
 BFSY47g7H2j8ASvGJsRBnUltXrW/U8rcnpgMYF9M3Fw6srBUCZLNmbLjouj/W4p7uQeR
 IS+DU+bdDe8DyyaNjFHOwVDEiY1fFNL0fXNe8QcxT1UwSn5E7cF25YvJ+VdgycJwTDbS
 4PYCkpmpGEZG/5jb/4NsUiOG/quPQP/m0yNnG+onQ0QmKMB6W3bwRZY3NZc4hF8EtQby
 lOaYe/gXLpNAFRQ0rSPTDv2KxNUxnaBcQhnpGndMHjd7VUBJVJKs35EBV4gZ6nMaD18x
 dflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781616777; x=1782221577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ8uzDfkyPC114TCwls4I0KN7WwlmLTXw+oDgsP0ZvQ=;
 b=feKr8iGM/0fkm4VudxyS7TDTk8kB2IeBNf028/e6NTPt3fcp59g9g3Xagc7Driubc7
 93CkNjZMokwcgEpXfuOL7G5tiMP4DpBwkuKiy+Wp7pnVm35f4nVTLdbK7BVrxWRHX2zs
 kWefRtHg4zklyYUOct/NoL8cBm7JKj1oS6bg4KvK0taBceWA9OrSwxrJMIHpbCDIyX7+
 vPyXKeksUMvn8YEuDbh3cyAdG1xdNKgulR6wA6c5w2X5VFIGb0U9aA1tIwXH7VKAe9RR
 MITkkCKWa8RFiP1cN7/BTFerBL6o15llhgdVKJkxqY6EEuOKZ0Q0b8eEbZ5m/Dponpsy
 tFBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pCmCurEh0LeK/vJ9+Qf4ahk46eBeSQYhiJgUQhdUkIxXMQAnWZDnuaadbYg79T/TTESMWDx2M@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWdYHMz6NxNGY1FiUsvRAzGTaVS0IaAYYxNbbiu7nWcJ1pSrXh
 XL3OhNHbsKcjyPpssUgYlk/vTUp9rA1o+Yas+6DO7AFOPj2hgza74KOemyMoh4ltAlX4o4bd8lp
 gXD11hjo=
X-Gm-Gg: Acq92OFzUgiTrM1j9Dt5aXNyByLhVUaCWIzLat5MQmtWBVnHsS6mgvlShTdu+fiClX7
 BS9JWUHr2fI+3Sh2eIJ9FmicSG4lmIMjgiyoEAr4tUZw3CHve7mw47TxkdDpKxT4J4iUmZbRlMi
 i7Ut4QseqXrvKeYrDwp/fFMvQhvaAvLQJzZcQNlBQGonB+T/fLHsZDx3dwpBunh/vDyTOk0VA/o
 koXqobozNtv9mymuciwNHlNxqpGsgJJwe/lMS4V23cstSL0oSJeIwyNKUdoPHR/4xXFCIhy7BLh
 CTllflsT7IdAvM2ZiOmJGuxpJ4M4cYEquX2VSu8aLZhQ5pS3X12xjsEbfOUsVeeWqFyJZbzdOCe
 Ulkk4wLlhrLAo2qk7rlZC0fYmepTkfKVL2jbHIV1cYtEQuwhvpKArck0mUTRZUl8ml3BO73sJ1T
 /eKiH5novhGK8q3hCgcoeU9xxIeOuIAMd87faZkwBCxKKb
X-Received: by 2002:a17:907:a28a:b0:bee:1e36:8772 with SMTP id
 a640c23a62f3a-c043cdd53a7mr182783466b.20.1781616776329; 
 Tue, 16 Jun 2026 06:32:56 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb7b6de98sm653628766b.30.2026.06.16.06.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 06:32:55 -0700 (PDT)
Message-ID: <e0b6b177-74b2-4040-abce-e51d4d39a9fe@ursulin.net>
Date: Tue, 16 Jun 2026 14:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amdgpu/ih: Don't perturb HW registers when accessing
 soft IH ring
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, amir.shetaia@amd.com
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-3-timur.kristof@gmail.com>
 <6f5c367e-b234-491b-81e2-d928cd54050d@ursulin.net>
 <5402227.Qq0lBPeGtt@timur-hyperion>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <5402227.Qq0lBPeGtt@timur-hyperion>
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


On 16/06/2026 13:04, Timur Kristóf wrote:
> On Tuesday, June 16, 2026 1:39:56 PM Central European Summer Time Tvrtko
> Ursulin wrote:
>> On 13/05/2026 18:08, Timur Kristóf wrote:
>>> The soft IH ring is implemented entirely in software.
>>> We shouldn't read (or write) and HW registers when accessing it.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
>>>    4 files changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c index 333e9c30c091..65e5d21753f9
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> @@ -439,6 +439,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device
>>> *adev,>
>>>    	struct amdgpu_ih_regs *ih_regs;
>>>    	
>>>    	wptr = le32_to_cpu(*ih->wptr_cpu);
>>>
>>> +
>>> +	if (ih == &adev->irq.ih_soft)
>>> +		goto out;
>>> +
>>
>> Would it be feasible to move amdgpu_ih_funcs from device global into the
>> IH rings themselves? Then we could have soft IH ops and it would be very
>> clean.
>>
>> Possibly also cleanup all the protoptyes to operate only on ih and not
>> the adev + ih pair.
> 
> Sure, we can do that in the future. The reason I chose not to do that is
> because that feels like an extremely intrusive refactor across all GPU
> generations with a high chance of introducing regressions and not much value
> to end users.
> 
> For now I would like to just focus on making the current code work well with
> minimal refactoring, ie. just get the current soft IH ring implementation to
> work reliably with retry faults.
> 
> In the meantime if you have a good idea how to refactor this code to make it
> cleaner without breaking it, I'm happy to listen and we can make a plan how to
> do that in a future series.

I can play with that refactor later, now that Christian gave a green light.

For this patch - it looks good to me. I am somewhat confused by the 
endianess conversion in amdgpu_ih_ring_write() (why is that needed for a 
software ring?), but even if unecessary it can be improved later so:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>>>    	ih_regs = &ih->ih_regs;
>>>    	
>>>    	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>>>
>>> @@ -514,6 +518,9 @@ static void ih_v6_0_set_rptr(struct amdgpu_device
>>> *adev,>
>>>    {
>>>    
>>>    	struct amdgpu_ih_regs *ih_regs;
>>>
>>> +	if (ih == &adev->irq.ih_soft)
>>> +		return;
>>> +
>>>
>>>    	if (ih->use_doorbell) {
>>>    	
>>>    		/* XXX check if swapping is necessary on BE */
>>>    		*ih->rptr_cpu = ih->rptr;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c index 699c274d357e..9dbc20131410
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> @@ -410,6 +410,10 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device
>>> *adev,>
>>>    	struct amdgpu_ih_regs *ih_regs;
>>>    	
>>>    	wptr = le32_to_cpu(*ih->wptr_cpu);
>>>
>>> +
>>> +	if (ih == &adev->irq.ih_soft)
>>> +		goto out;
>>> +
>>>
>>>    	ih_regs = &ih->ih_regs;
>>>    	
>>>    	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>>>
>>> @@ -481,6 +485,9 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device
>>> *adev,>
>>>    static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>    
>>>    			       struct amdgpu_ih_ring *ih)
>>>    
>>>    {
>>>
>>> +	if (ih == &adev->irq.ih_soft)
>>> +		return;
>>> +
>>>
>>>    	struct amdgpu_ih_regs *ih_regs;
>>>    	
>>>    	if (ih->use_doorbell) {
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 6de9e87e04e1..bd332e8cc5bf
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> @@ -457,6 +457,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device
>>> *adev,>
>>>    	struct amdgpu_ih_regs *ih_regs;
>>>    	
>>>    	wptr = le32_to_cpu(*ih->wptr_cpu);
>>>
>>> +
>>> +	if (ih == &adev->irq.ih_soft)
>>> +		goto out;
>>> +
>>>
>>>    	ih_regs = &ih->ih_regs;
>>>    	
>>>    	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>>>
>>> @@ -527,6 +531,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device
>>> *adev,>
>>>    {
>>>    
>>>    	struct amdgpu_ih_regs *ih_regs;
>>>
>>> +	if (ih == &adev->irq.ih_soft)
>>> +		return;
>>> +
>>>
>>>    	if (ih->use_doorbell) {
>>>    	
>>>    		/* XXX check if swapping is necessary on BE */
>>>    		*ih->rptr_cpu = ih->rptr;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c index 4cd325149b63..e7ed37bb48e0
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> @@ -417,6 +417,10 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device
>>> *adev,>
>>>    		 */
>>>    		
>>>    		wptr = le32_to_cpu(*ih->wptr_cpu);
>>>
>>> +		if (ih == &adev->irq.ih_soft)
>>> +			goto out;
>>> +
>>> +
>>>
>>>    		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>>>    		
>>>    			goto out;
>>>    	
>>>    	}
> 
> 
> 
> 

