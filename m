Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD4C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 13:17:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6292E10E2C6;
	Mon, 15 Jan 2024 13:17:20 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9141810E2AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 13:17:19 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so34939655e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 05:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705324638; x=1705929438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sHqmYqO5l3paTKNamis6Xb+V+7+ixFL4LbDY6Cz+krc=;
 b=VgDvUcwWtR4SO0Li9FES7RfEaDZqH298rnrgcpEJ0Xwdq9Tq7HqjPBuhXoUNakeWSL
 U/YQfwRZvY79qlsED3v0gGXLMQdb6CKl8x+9MxEB+k9yMYGITupFeuiQUyUISVeZ97Pt
 tTQR5rsbQMrWBEbkJ6WGiwb/KLeomO72ZrxfaaFJfScxKF/xr8BqifpNJU2/lM2Q9umE
 Lom7c76j2LZtwMsiUhCZpuJa0j2eccTsxB8smu/HWDd0GgAOOCSiwfAYici6ZAvzhZIe
 igEL5TaApFckLQLYVPR8aPOyDkSgcwDPM/ZoUS/S1g6lLpDusGTiEutQ/BrP+/WJAF3o
 nP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705324638; x=1705929438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sHqmYqO5l3paTKNamis6Xb+V+7+ixFL4LbDY6Cz+krc=;
 b=WoysIMFCuH9NhsCoECThAAFTzghTKOfT1WyQbHGSkB6UsrVcvg32mmtBOqzuLqKOh/
 zZ4TqoYPHvN8Gcv9X9H8TWk9suYJiPGd/BdiMdifjOTjk0/1FmEnMFlYcSGZh6SOb8Vg
 ypRMojGM++NV4b+S350oCXO/DPkPLCbLGkr2K5s42hQKcUiNSDu2k3bm62ohgX7btA6h
 S9Jvro7AuVSIIa+IWyDp8/NEHzKAw9KSnPABtKxKvdg8aYJGVPUTUCg1B82ZWtrrFLsH
 a50nMOd4+hWTNgSieYJqa4gbaslCCxfa+fXNniCYiqgOeZC8ohzCsUFWlp7B9NQkn74M
 PpQQ==
X-Gm-Message-State: AOJu0YyIF7KU3tWsnGU2LACFdj0/H+w0T6MezzC0vusbhZrSuA0Gbevo
 DrdQRM1H1wvNxBAinZRhENc=
X-Google-Smtp-Source: AGHT+IF0N2e36ubvxurfilESzO/eDrAEfGCaNhwTPAdvH8TPC2r9AYiOFLA9g9pfTc4Rbiog9sOPQA==
X-Received: by 2002:a05:600c:6a8d:b0:40e:74db:87ad with SMTP id
 jl13-20020a05600c6a8d00b0040e74db87admr1454113wmb.65.1705324637756; 
 Mon, 15 Jan 2024 05:17:17 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a05600c4fd500b0040e34ca648bsm16032717wmq.0.2024.01.15.05.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 05:17:17 -0800 (PST)
Message-ID: <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
Date: Mon, 15 Jan 2024 14:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel@daenzer.net>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 12:37 schrieb Joshua Ashton:
> On 1/15/24 09:40, Christian König wrote:
>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>> We need to bump the karma of the drm_sched job in order for the context
>>> that we just recovered to get correct feedback that it is guilty of
>>> hanging.
>>
>> Big NAK to that approach, the karma handling is completely deprecated.
>>
>> When you want to signal execution errors please use the fence error 
>> code.
>
> The fence error code does not result in ctx's being marked as guilty, 
> only the karma path does.
>
> See drm_sched_increase_karma.
>
> Are you proposing that we instead mark contexts as guilty with the 
> fence error ourselves here?

No, I'm proposing to completely abandon the concept of guilty contexts. 
Basically what we should do is to return an error from the CS IOCTL 
whenever a previous submission resulted in a fatal error as suggested by 
Marek.

That we query the context for guilty was just a design decision we 
copied over from our closed source drivers which turned out to 
absolutely not solving anything.

Marek can probably comment as well why the whole idea of querying the 
kernel if something fatal happens instead of just rejecting submissions 
is broken by design.

>>
>>> Without this feedback, the application may keep pushing through the 
>>> soft
>>> recoveries, continually hanging the system with jobs that timeout.
>>
>> Well, that is intentional behavior. Marek is voting for making soft 
>> recovered errors fatal as well while Michel is voting for better 
>> ignoring them.
>>
>> I'm not really sure what to do. If you guys think that soft recovered 
>> hangs should be fatal as well then we can certainly do this.
>
> They have to be!
>
> As Marek and I have pointed out, applications that hang or fault will 
> just hang or fault again, especially when they use things like draw 
> indirect, buffer device address, descriptor buffers, etc.

Ok, well then I now have two people (Marek and you) saying that soft 
recovery should be fatal while Michel is saying that soft recovery being 
non fatal improves stability for him :)

Should we somehow make that configurable or depend it on if that's the 
display server or if it's an user application?

Regards,
Christian.

>
> The majority of apps these days have a lot of side effects and 
> persistence between frames and submissions.
>
> - Joshie 🐸✨
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> There is an accompanying Mesa/RADV patch here
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
>>> to properly handle device loss state when VRAM is not lost.
>>>
>>> With these, I was able to run Counter-Strike 2 and launch an 
>>> application
>>> which can fault the GPU in a variety of ways, and still have Steam +
>>> Counter-Strike 2 + Gamescope (compositor) stay up and continue
>>> functioning on Steam Deck.
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: André Almeida <andrealmeid@igalia.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 25209ce54552..e87cafb5b1c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct 
>>> amdgpu_ring *ring, struct amdgpu_job *job)
>>>           dma_fence_set_error(fence, -ENODATA);
>>>       spin_unlock_irqrestore(fence->lock, flags);
>>> +    if (job->vm)
>>> +        drm_sched_increase_karma(&job->base);
>>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>>       while (!dma_fence_is_signaled(fence) &&
>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>
>
>

