Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B85C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 07:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C1310E38A;
	Tue, 16 Jan 2024 07:18:49 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B91110E099
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 07:18:47 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-40e85595298so1561305e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705389466; x=1705994266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BW+W+dIv4lN7r4SC9Umj94UHkB8iKRe5wxYPF0vpeL0=;
 b=CQ/q2WS8IVecxOG9A5b6WMmETtaLxvDDhlPMpn5+KGG5b56s0rWuCEUBWH3kfBEosL
 iKp5L5o9U7kXp0oyWc0GGjiKq2YOqK/srXjEX1ASlvuI9rWT10qNOe3PBrzxyoYa77Zi
 XYbMPc6xF0q5IfmJTln+Ht35zNVgXAUXTu1i65CFOzxGVZRv3VUsQlWlgrWP9u1LtN+5
 dp5plRgg2RtTq3HEG5/WnJRn7V3js2jalfmxOhhFCkyMzPgePKQm+yh3mA5q+zUxjpry
 OpbXC5PwMUt6SI2K+/p4zvr1SIuh9SuBz96NqTe46cwGdP3eMQOVe1Rwlvy3XkzIz8UQ
 M7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705389466; x=1705994266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BW+W+dIv4lN7r4SC9Umj94UHkB8iKRe5wxYPF0vpeL0=;
 b=iBQL6qlUSww/oLyWQWEUs3sWAQLtoJtrwHLfecWbpx8mQUdt9TU8DKn0iRt/NniRR/
 VQ9dH1Ch853xhW3x3kuIORuiF7XF/K/GD5ISPIZP8wdjo/CzlGy8ML6bcFFfYyjnMoh+
 KaydFF08TaLzE8Fg3MSLsJ7t5q7mm0RelEsCrIRoK4Z3K0Ic9v/lXI/DR/3hxkD9pkE0
 S4xN76zr3NCdGQYPDteRxgZNzVBik+dkTqJgpv1Du3dmyf3OK4yq7yTaCiZ39z2zv3tn
 ninOimz9/lpHxqUkKAVw2kX2t+EBxOnGp5QXsX2ZmCaEK8NrXlnpy2zlyaL4YMYUOmiz
 eHbg==
X-Gm-Message-State: AOJu0YyFJkqC3w3W2tWNHrZGBpUGaDmELexqoMkkm8KGsgDyjF0hLVfi
 Gi597V1D7cNH+TRKghJgzH4=
X-Google-Smtp-Source: AGHT+IEFTD9mOGuy4O+1A27ae4lkNbmqjc8773lZH0WP+R2mfsYFBKQ9T5aqV8so5vOj3q10koJtkQ==
X-Received: by 2002:a05:600c:4314:b0:40e:43dd:1e47 with SMTP id
 p20-20020a05600c431400b0040e43dd1e47mr2015713wme.261.1705389465598; 
 Mon, 15 Jan 2024 23:17:45 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0040d8ff79fd8sm18255442wmb.7.2024.01.15.23.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 23:17:45 -0800 (PST)
Message-ID: <3df101b7-8df6-44a0-8c53-aaec480a1907@gmail.com>
Date: Tue, 16 Jan 2024 08:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <20240114130008.868941-2-friedrich.vock@gmx.de>
 <ef01b29e-8529-43d2-befc-a3e3d8eaccf9@gmail.com>
 <8e81fd02-c5e3-4c0c-bb8f-b81217863ce2@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <8e81fd02-c5e3-4c0c-bb8f-b81217863ce2@gmx.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 12:19 schrieb Friedrich Vock:
> On 15.01.24 11:26, Christian König wrote:
>> Am 14.01.24 um 14:00 schrieb Friedrich Vock:
>>> If the IH ring buffer overflows, it's possible that fence signal events
>>> were lost. Check each ring for progress to prevent job timeouts/GPU
>>> hangs due to the fences staying unsignaled despite the work being done.
>>
>> That's completely unnecessary and in some cases even harmful.
> How is it harmful? The only effect it can have is prevent unnecessary
> GPU hangs, no? It's not like it hides any legitimate errors that you'd
> otherwise see.

We have no guarantee that all ring buffers are actually fully 
initialized to allow fence processing.

Apart from that fence processing is the least of your problems when an 
IV overflow occurs. Other interrupt source which are not repeated are 
usually for more worse.

>>
>> We already have a timeout handler for that and overflows point to
>> severe system problem so they should never occur in a production system.
>
> IH ring buffer overflows are pretty reliably reproducible if you trigger
> a lot of page faults, at least on Deck. Why shouldn't enough page faults
> in quick succession be able to overflow the IH ring buffer?

At least not on recent hw generations. Since gfx9 we have a rate limit 
on the number of page faults generated.

What could maybe do as well is to change the default of vm_fault_stop, 
but for your case that would be even worse in production.

>
> The fence fallback timer as it is now is useless for this because it
> only gets triggered once after 0.5s. I guess an alternative approach
> would be to make a timer trigger for each work item in flight every
> 0.5s, but why should that be better than just handling overflow errors
> as they occur?

That is intentional. As I said an IH overflow just points out that there 
is something massively wrong in the HW programming.

After gfx9 the IH should never produce overflow any more, otherwise 
either the ratelimit doesn't work or isn't enabled for some reason or 
the IH ring buffer is just to small.

Regards,
Christian.

>
> Regards,
> Friedrich
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Cc: Joshua Ashton <joshua@froggi.es>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: stable@vger.kernel.org
>>>
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> index f3b0aaf3ebc6..2a246db1d3a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>>> @@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev,
>>> struct amdgpu_ih_ring *ih)
>>>   {
>>>       unsigned int count;
>>>       u32 wptr;
>>> +    int i;
>>>
>>>       if (!ih->enabled || adev->shutdown)
>>>           return IRQ_NONE;
>>> @@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device
>>> *adev, struct amdgpu_ih_ring *ih)
>>>           ih->rptr &= ih->ptr_mask;
>>>       }
>>>
>>> +    /* If the ring buffer overflowed, we might have lost some fence
>>> +     * signal interrupts. Check if there was any activity so the 
>>> signal
>>> +     * doesn't get lost.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>> +            struct amdgpu_ring *ring = adev->rings[i];
>>> +
>>> +            if (!ring || !ring->fence_drv.initialized)
>>> +                continue;
>>> +            amdgpu_fence_process(ring);
>>> +        }
>>> +    }
>>> +
>>>       amdgpu_ih_set_rptr(adev, ih);
>>>       wake_up_all(&ih->wait_process);
>>>
>>> -- 
>>> 2.43.0
>>>
>>

