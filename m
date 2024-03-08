Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78EFC54E41
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 22:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00840113999;
	Fri,  8 Mar 2024 22:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=froggi.es header.i=@froggi.es header.b="c4XllrK4";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F70A113707
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 22:31:30 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-33e804624a6so35092f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Mar 2024 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1709937089; x=1710541889; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50DxsdwMyzPE9tiAQwRIN4dgJdUxFYiNcUToxZaFv74=;
 b=c4XllrK4+ZtUt3XTxFwDWVNiPwjN0yyOJkGHgj2stBDMbrHy1DU809JIrsyO3kWouw
 aXLSNGyEUzLP7rfHl0vXbfGt91cys3g3iMEr2KWA8ByjgLIeeec3f0muSfUKE0V06srB
 Z77pXcGmSB/xxJfm0tMFaqNOTgBB/mtE5ZpkB+2H0B/qbuo67zMoJnMdTElQ4oBEAs3R
 ltwa/+WtR0BnEqnMe7jXjmv9wWiC53z2fvBw7D3k1wAVCHOGOetSeTzAtBHPLrLxhCqD
 0bm2jVZxAHB+mO6TRsq6fWTBDvovSNWmKhTlC6hh5XKSJdb9y4lkrKSBCwiH9K1cHaHq
 yWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709937089; x=1710541889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50DxsdwMyzPE9tiAQwRIN4dgJdUxFYiNcUToxZaFv74=;
 b=vP+TXcF2/W6jbRMFcGKK/jjg3k9ZFEBcPzwfJdL1tOasvLVeYSyvdDBK0VqMx4cdSe
 F67aRKYq1ETd3b/br/gJOP4Vgulp+lJTYT9jR7J/jL9PEtMqiYx4OIMSDbdqHq6uIVJK
 htPw+j1h/jEtQJOQSEkJ96Skn+OG3yb/BT16qiuuN4zDKdGlFSkV4B7U6PTr5vptSDcY
 zTk+q5OCwIjDuTviXQMQIhlomWLMtzbnyl3k0b7gJ5yoLBL43As5CaYsyAke+9Q1T0De
 sdCiOT0PljlEIKk0Tz5Iipyn5T8vEG2xFARZSlU+tdWTo/jslAdLithG2t0DJBmR8Y4u
 yG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGbSzqrZqtrcoAQDSa8F5TJ89ypQH3ecAuxpIWTYfg/hBMhMcpycePli/o0WbyrEKGwLVf62KcR5C97ubLaNmfLK0G8nZEOK65v/AEqw==
X-Gm-Message-State: AOJu0YxH5T9MfxrHU9ECR8TtgOMLbtdMmbtWBNN8LR6lwk/6VI6qre2L
 jeA/V+1v6NG2bD0jjeOBoPAxauPS/INy+O6NMNJfheyR8TbC5yjmuo1KLvdCjB8=
X-Google-Smtp-Source: AGHT+IG24Sujfd+INNz2C6N7SQAudMq8/DBjI1n/dwo8d0cQncfBjaIJyhKnrG3z3pDfVDoZ13jR3w==
X-Received: by 2002:adf:eac1:0:b0:33d:701f:d179 with SMTP id
 o1-20020adfeac1000000b0033d701fd179mr319305wrn.19.1709937088602; 
 Fri, 08 Mar 2024 14:31:28 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adf9dd2000000b0033e422d0963sm435714wre.41.2024.03.08.14.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 14:31:28 -0800 (PST)
Message-ID: <d537a460-6e6e-4bda-895c-c687be00ac29@froggi.es>
Date: Fri, 8 Mar 2024 22:31:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Increase soft recovery timeout to .5s
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <20240307190447.33423-3-joshua@froggi.es>
 <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <5f70caef-7c7e-4bad-9de9-f8f61bba2584@amd.com>
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

It definitely takes much longer than 10-20ms in some instances.

Some of these instances can even be shown in Freidrich's hang test suite 
-- specifically when there are a lot of page faults going on.

The work (or parts of the work) could also be pending and not in any 
wave yet, just hanging out in the ring. There may be a better solution 
to that, but I don't know it.

Raising it to .5s still makes sense to me.

- Joshie 🐸✨

On 3/8/24 08:29, Christian König wrote:
> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>> Results in much more reliable soft recovery on
>> Steam Deck.
> 
> Waiting 500ms for a locked up shader is way to long I think. We could 
> increase the 10ms to something like 20ms, but I really wouldn't go much 
> over that.
> 
> This here just kills shaders which are in an endless loop, when that 
> takes longer than 10-20ms we really have a hardware problem which needs 
> a full reset to resolve.
> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: André Almeida <andrealmeid@igalia.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 57c94901ed0a..be99db0e077e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -448,7 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring 
>> *ring, unsigned int vmid,
>>       spin_unlock_irqrestore(fence->lock, flags);
>>       atomic_inc(&ring->adev->gpu_reset_counter);
>> -    deadline = ktime_add_us(ktime_get(), 10000);
>> +    deadline = ktime_add_ms(ktime_get(), 500);
>>       while (!dma_fence_is_signaled(fence) &&
>>              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
>>           ring->funcs->soft_recovery(ring, vmid);
> 

