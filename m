Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD67C4706C
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jan 2024 22:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE0710E1C4;
	Sat, 13 Jan 2024 22:55:43 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3501110E1C4
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 22:55:42 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33770772136so4076462f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705186540; x=1705791340; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTM9dIGhg8HppSDbR++W5wyv6Uhch5Dm3NQVyrhOK78=;
 b=Eb5kx9rZUzRXdD9CMRJFq8hawubRegXVY1CnhCC0hJ7EA+taF6cCMQLdZSTceRxuJr
 pxoCqncvJNrvoyFeNrYL1mTigNXAG4J9BqyBm/9vraHxwrH2Mlg082RgfEptKPrxXMPo
 sIedPVwiDI+lQ7mHOK4tdIRubZD9A1ZdfnmNnjkz8TWgBdO4UPJ6ozVRChjbO8GtV3c0
 eXV3YsRJj4YgAqBJEN4YL02nEQ77OYn1ioB0QFjxZm5SwOstf1bZXo++LAvTQz/3yXGj
 dCyhJeAUjecDbcUGxSZ92VyCBHCgzNPutHs+laPEnyZCP8YTiS5rqWE6Y//C+0LS5R5J
 qgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705186540; x=1705791340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTM9dIGhg8HppSDbR++W5wyv6Uhch5Dm3NQVyrhOK78=;
 b=hD6j+fN/yObgdandbumpnJBHLUkyJs5Ifor2geMAhV0J6U4oshIMaXIfihia0ED/ek
 OIb382e6wpmvTVBXCSVXHOcw9J+QCm4JhT8nZfPa7UDx0bY/QUS3sgv9H2KG6eYc2dso
 7PEFy4dJoxxMxifY9IcvRy4+kgd3EJMJCHBEJvSZ45av3Y3DmOdrjX2C+SMlCxh1jgge
 YnTTRtLFIJi3LlefDv5PQg86S7uuVnxr7GcI8dOfz1sbXp2nm+3+CJmiVFkHQFUgNz8v
 59GzEjD0akf0ZlGO5dMhmKv/NWD/iE8hzZYdYYF25vSjoToJE5v0IS5hJ9KIFONdofpV
 PNew==
X-Gm-Message-State: AOJu0Yzn9OWddG8d9osl5H5Av6lAFSjhwEQQroqBITL0Al5GxkVsquUw
 WxHscA/TBiOD+CDreX+Kvv/KpTJF63Wq4A==
X-Google-Smtp-Source: AGHT+IG8ZY1qk1V1JAnqlGec7V3oUZ+ty3RypeJfghnR2SZyqgJBtll3AxF4Ol6z39eHoLmDmfmpPg==
X-Received: by 2002:adf:db48:0:b0:333:a28:bfc5 with SMTP id
 f8-20020adfdb48000000b003330a28bfc5mr2072386wrj.70.1705186540467; 
 Sat, 13 Jan 2024 14:55:40 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 q15-20020adfea0f000000b00336e6014263sm7701518wrm.98.2024.01.13.14.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jan 2024 14:55:40 -0800 (PST)
Message-ID: <a88f1d5f-c13c-4b46-9bba-f96d43bd4e1a@froggi.es>
Date: Sat, 13 Jan 2024 22:55:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <66f8848f-13c8-4293-a207-012eadbc9018@igalia.com>
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+Marek

On 1/13/24 21:35, André Almeida wrote:
> Hi Joshua,
> 
> Em 13/01/2024 11:02, Joshua Ashton escreveu:
>> We need to bump the karma of the drm_sched job in order for the context
>> that we just recovered to get correct feedback that it is guilty of
>> hanging.
>>
>> Without this feedback, the application may keep pushing through the soft
>> recoveries, continually hanging the system with jobs that timeout.
>>
>> There is an accompanying Mesa/RADV patch here
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
>> to properly handle device loss state when VRAM is not lost.
>>
>> With these, I was able to run Counter-Strike 2 and launch an application
>> which can fault the GPU in a variety of ways, and still have Steam +
>> Counter-Strike 2 + Gamescope (compositor) stay up and continue
>> functioning on Steam Deck.
>>
> 
> I sent a similar patch in the past, maybe you find the discussion 
> interesting:
> 
> https://lore.kernel.org/lkml/20230424014324.218531-1-andrealmeid@igalia.com/

Thanks, I had a peruse through that old thread.

Marek definitely had the right idea here, given he mentions:
"That supposedly depends on the compositor. There may be compositors for
very specific cases (e.g. Steam Deck)"

Given that is what I work on and also wrote this patch for that does 
basically the same thing as was proposed. :-)

For context though, I am less interested in Gamescope (the Steam Deck 
compositor) hanging (we don't have code that hangs, if we go down, it's 
likely Steam/CEF died with us anyway atm, can solve that battle some 
other day) and more about the applications run under it.

Marek is very right when he says applications that fault/hang will 
submit one IB after another that also fault/hang -- especially if they 
write to descriptors from the GPU (descriptor buffers), or use draw 
indirect or anything bindless or...
That's basically functionally equivalent to DOSing a system if it is not 
prevented.

And that's exactly what I see even in a simple test app doing a fault -> 
hang every frame.

Right now, given that soft recovery never marks a context as guilty, it 
means that every app I tested is never stopped from submitting garbage 
That holds true for basically any app that GPU hangs and makes soft 
recovery totally useless in my testing without this.

(That being said, without my patches, RADV treats *any* reset from the 
query as VK_ERROR_DEVICE_LOST, even if there was no VRAM lost and it was 
not guilty, so any faulting/hanging application causes every Vulkan app 
to die e_e. This is fixed in 
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050 )

- Joshie 🐸✨

> 
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: André Almeida <andrealmeid@igalia.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 25209ce54552..e87cafb5b1c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring 
>> *ring, struct amdgpu_job *job)
>>           dma_fence_set_error(fence, -ENODATA);
>>       spin_unlock_irqrestore(fence->lock, flags);
>> +    if (job->vm)
>> +        drm_sched_increase_karma(&job->base);
>>       atomic_inc(&ring->adev->gpu_reset_counter);
>>       while (!dma_fence_is_signaled(fence) &&
>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)

