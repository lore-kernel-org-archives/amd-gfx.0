Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A42C5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 06:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823E010E10F;
	Mon, 11 Mar 2024 06:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nApuKhzc";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9EE10E10F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 06:46:02 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5139d80f8b6so1621620e87.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Mar 2024 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710139560; x=1710744360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qll/LXCj9io37xmVDKRD/JmJOJFmsP9Qd8oxeZeNLK0=;
 b=nApuKhzctcLmTAfCOxxa3g+9zEa8ny14YiWqbRJbqJHqN1O88NmodoZtZ7DjGdDazX
 LHPca1wkVNdqo61b3F7tBn2xJMHpAclE6uA0T/CQJgTTiiwpvCcNcdOAaUN7wsNRWSe6
 utvpbIXx7uv1O0vkAUcTUcbTcXFImI6FpK21CF3Rd0vjLnpivOnqq9DeW/jsYOBH676d
 UI2ylYKGGSmLEPjeylTTo9bWmopLgLbw5kqaqotdYGLX92rknr0QyW71fPI/xkjR8L9P
 CvNCeR4cySRz4d/34cROQFEr+DdQpJ9xDZcdDWBoexFI1aTmmGYlNt+3rnzsF+fHDj77
 nTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710139560; x=1710744360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qll/LXCj9io37xmVDKRD/JmJOJFmsP9Qd8oxeZeNLK0=;
 b=C6+CHpnnFgqWyN9EyG0cOlavTyNYMT5i+5NWwXRwOOmdfTX4xGd+bMKBuRKCmV9FZW
 y0d8h652CS6JMGlfMnaFpKlVY+yUpGG6dASyvpb0scJVHIDUtrIu0OJfH36CTEt32MqI
 8jLdwZmUkUAV2SG+x9XUZTWbLszhhvS5z6eALSQwaKQpX+9C+CAJcjKSbKqim59BrETY
 TdEcbCHjRBNTCxl4IS5rL6skEiyua5pIRDeLD5rpAG6dgih5/2kvkyqYeaVDbgzoG3i/
 7gmPiPzbRAagjXhPFbUSDWOx5mMyjESvQxEyxlewCj2EFxz8/0yaIRH/lvuAshw1+W7Q
 XYJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrZhudH9GxKCcm20Dzc5wTbpQteTruZarNHntzu/0SPp+Vm8xvi6wyjSiXhaejPq2L15bRZ7F3WAoGNV/lByFr4nbkow/Hl2LEUoG9wA==
X-Gm-Message-State: AOJu0Yx/81h9Q1unt7ijLpcC458L/9ND0jC/9Manm+9U3PgY6QkqC9N3
 p9G9oI2U5BMyOzalBEFbjCZdN2ozATQT8MJMvwSqRaofN8FOy0Fn
X-Google-Smtp-Source: AGHT+IFmvuglqGER74qi1M1YFUvf342Xos8X0iV57Box7xhAC8x2KwIhhEtZm8PvRD1wW5OWc5TJgA==
X-Received: by 2002:a19:911d:0:b0:513:994e:ace0 with SMTP id
 t29-20020a19911d000000b00513994eace0mr3576225lfd.15.1710139559803; 
 Sun, 10 Mar 2024 23:45:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c450f00b0041329a43941sm2643812wmo.19.2024.03.10.23.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 23:45:59 -0700 (PDT)
Message-ID: <c1f80459-bf9c-439f-bdba-e08f13aea272@gmail.com>
Date: Mon, 11 Mar 2024 07:46:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <20240307190447.33423-3-joshua@froggi.es>
 <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
 <d537a460-6e6e-4bda-895c-c687be00ac29@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d537a460-6e6e-4bda-895c-c687be00ac29@froggi.es>
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

Am 08.03.24 um 23:31 schrieb Joshua Ashton:
> It definitely takes much longer than 10-20ms in some instances.
>
> Some of these instances can even be shown in Freidrich's hang test 
> suite -- specifically when there are a lot of page faults going on.

Exactly that's the part I want to avoid. The context based recovery is 
to break out of shaders with endless loops.

When there are page faults going on I would rather recommend a hard 
reset of the GPU.

>
> The work (or parts of the work) could also be pending and not in any 
> wave yet, just hanging out in the ring. There may be a better solution 
> to that, but I don't know it.

Yeah, but killing anything of that should never take longer than what 
the original submission supposed to take.

In other words when we assume that we should have at least 20fps then we 
should never go over 50ms. And even at this point we have already waited 
much longer than that for the shader to complete.

If you really want to raise that this high I would rather say to make it 
configurable.

Regards,
Christian.

>
> Raising it to .5s still makes sense to me.
>
> - Joshie 🐸✨
>
> On 3/8/24 08:29, Christian König wrote:
>> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>>> Results in much more reliable soft recovery on
>>> Steam Deck.
>>
>> Waiting 500ms for a locked up shader is way to long I think. We could 
>> increase the 10ms to something like 20ms, but I really wouldn't go 
>> much over that.
>>
>> This here just kills shaders which are in an endless loop, when that 
>> takes longer than 10-20ms we really have a hardware problem which 
>> needs a full reset to resolve.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: André Almeida <andrealmeid@igalia.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 57c94901ed0a..be99db0e077e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct 
>>> amdgpu_ring *ring, unsigned int vmid,
>>>       spin_unlock_irqrestore(fence->lock, flags);
>>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>> -    deadline = ktime_add_us(ktime_get(), 10000);
>>> +    deadline = ktime_add_ms(ktime_get(), 500);
>>>       while (!dma_fence_is_signaled(fence) &&
>>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>>           ring->funcs->soft_recovery(ring, vmid);
>>
>

