Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107B1C4707C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 11:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC72B10E25A;
	Mon, 15 Jan 2024 11:37:55 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A330010E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 11:37:54 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33674f60184so8588007f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705318673; x=1705923473; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTOdc5bDe9TOqL9Ql33LV9TRfUB/nJ9yP/VTvwM7f+8=;
 b=Z28HH0CDwRPRh2BkxLgiWym9L66sY/0SZTxzsD+APazJb0BXEDqAwg4g8EokYg3x9N
 t0lI05WvbRJtOs5GHKZD2vVLL8D+kvPvxIooQEQBO6AvE1wSQlB63S2vULCD63VuWmb9
 p6JbslIZ4zBeJPRDQWTiJfjZiCXKr2BxV8Jt8th413pIAmvMEAqUDucicHth/pu09MxD
 z8lJnA5MhdSiEAqnRaz8tKAQJo7Kfzuncti43WRok4VY0vsD7VLT7wvB7fcQPzNKJBXt
 MISoDvUxX6CePgEcIJNfXXfnxffLtjUPtKQNb5ebyt2oJULwHIGdak1JNjWVBeKfiVn/
 EXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705318673; x=1705923473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTOdc5bDe9TOqL9Ql33LV9TRfUB/nJ9yP/VTvwM7f+8=;
 b=u4N2NXbeYB4QjgxFpUHNEEUoc3UOqa4EZZ+ppAc1qBdEbb75I54UJXyR7VstTczZSO
 TnORZobaV/5qV/j08dFtLWfl3qyBOdzqeLw43D83SOrPjTq9qILtZP452IBZB2e+e7Yi
 k3kNhW6YRvb4A0tPs1Lipa4R5n6nE1T+8VC7bdEy1c1tFkpH40VntyPcFOOBQ7igtb+g
 s6PBnhH9khCbFjOFyHxWbcNaFG5mfkWFAcXLbgUoD7ipFByQigHYZIhIS27iWJNClJh9
 G2OTIdJH3vDKr5G76oJL4PhYVLDPxS8vi2hFEmYuTgFim+0wEM+nUqWHeLBZ7YLzKkeJ
 IQFg==
X-Gm-Message-State: AOJu0Yy+wruzYBHafssObCFtVl0AGSSKiOTWbBOOtqZFBQU6V4PPmYAm
 t9brAd3tFbi74Yo+bbubmnz5lmUtt5JF7kM9PIacHNe5N44=
X-Google-Smtp-Source: AGHT+IE24kKJ6tsPrEOCvFY+UPRRBt4V5a0xnkUBRJyD4lDsOhaSzdKeMYOrmk5xuVYr2hq5IlKoCA==
X-Received: by 2002:a05:6000:1247:b0:337:4698:5bcb with SMTP id
 j7-20020a056000124700b0033746985bcbmr2734185wrx.119.1705318672360; 
 Mon, 15 Jan 2024 03:37:52 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 h10-20020adf9cca000000b00337afd67f40sm57092wre.1.2024.01.15.03.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 03:37:52 -0800 (PST)
Message-ID: <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
Date: Mon, 15 Jan 2024 11:37:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
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
 stable@vger.kernel.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 09:40, Christian König wrote:
> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>> We need to bump the karma of the drm_sched job in order for the context
>> that we just recovered to get correct feedback that it is guilty of
>> hanging.
> 
> Big NAK to that approach, the karma handling is completely deprecated.
> 
> When you want to signal execution errors please use the fence error code.

The fence error code does not result in ctx's being marked as guilty, 
only the karma path does.

See drm_sched_increase_karma.

Are you proposing that we instead mark contexts as guilty with the fence 
error ourselves here?

> 
>> Without this feedback, the application may keep pushing through the soft
>> recoveries, continually hanging the system with jobs that timeout.
> 
> Well, that is intentional behavior. Marek is voting for making soft 
> recovered errors fatal as well while Michel is voting for better 
> ignoring them.
> 
> I'm not really sure what to do. If you guys think that soft recovered 
> hangs should be fatal as well then we can certainly do this.

They have to be!

As Marek and I have pointed out, applications that hang or fault will 
just hang or fault again, especially when they use things like draw 
indirect, buffer device address, descriptor buffers, etc.

The majority of apps these days have a lot of side effects and 
persistence between frames and submissions.

- Joshie 🐸✨

> 
> Regards,
> Christian.
> 
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
> 


