Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FD6C36014
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 11:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729D810E0B4;
	Tue,  1 Apr 2025 11:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZ/tD83s";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4C110E0B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 11:09:26 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso51344405e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Apr 2025 04:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743505765; x=1744110565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQ+cOsWzS3rYjnxHRMwqvBi67eKF0eghBmGNe8hd3Go=;
 b=BZ/tD83sY9ro6l1In7BNRZ3gzAgE84x3sf0BtvVp1KpGETuYRkPJ8ZzyqwKkWE291v
 brcXN1sik+r7c4iNoHUufsS/LyGWw/25h0cDg56JAm84oOAU2iE0ntbKjf1LudyIcJV5
 uCxhdnO1eIvDJcDPXzujw17AewljV907pRzCrRZtkIOoS06lzJZUMeLV5IC+lm66m9lZ
 ee3o4kI2qWMXmiFzfLN96V/zaCTbIp8qFTSnwCwWfSsdCipBPUxOEwObVk+2NCQXOc5u
 MnHir2g8GxMmbnETvFT8Th+8pBA/mg12nme0M06i4Pswkw1T8QmN0Cac5nEyj64ai/rh
 XDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743505765; x=1744110565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dQ+cOsWzS3rYjnxHRMwqvBi67eKF0eghBmGNe8hd3Go=;
 b=nX0+lcsAkSZSVohVj3CxqvSrZdOsHhmxmiDgHZjhzKdYcaEQYOy1sg4gXfODQOBSLC
 U8j+sledN7lH/FMu7Hb0Or4GGpRJH6/OELIx2e4Pp3LgLnbRStG4QVOko/wTw8S2cuOF
 +css0kOyqC2k5gjkFXlltSol9fxRmU9lcGx8BMzd328JFkCxiQxbsZx3ObXjtqTgVhpO
 Z9dwgTi80JTbnXY7j78pWYfb+b5dtNX7RRAB3IOLPbXaUBsT0jD6o78BFL++CbU8CLn3
 e8ypo9qyzYti50UpKzWY6/6HersYfBpuF2yw9zTP4jDSx3rb1M5JJm2BwtCxX1CWsOaE
 4I1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxrzChs17wtr/RWSc5IzXivfb+g5g7OlKhvPdA8wdfdo/bCN8FVD1O0f7SWhkKSNUWK8IkvaOk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrTzkDdOJlgF7YFjEiHr1xzq6yNE+XzcQTUoaGh5FQWdVoISkd
 eLCMMPlqLLjcQPRXVC2wh/ZEL1nRjone1Hw9UkJXzv/Ge1LSnS5z
X-Gm-Gg: ASbGncvPrtfeedMF+EeDpczQG6TdpJL2HARbw2M9bhkB8mNtqKwVyU25sS7Dj5icR/X
 yfGdW1QMPrSqZ45OjMGfbtucKwOL2tE/IBq/c9fugrYPQQevFPrg+eudERNaMpoV+e/RQV/gc6/
 2wjSK8aplMnrbqENVs23OBt0faBwg2yFt9KR2yHGlVMLXkI1rzcqcczEDDBhN3QMajCucmrqpgc
 TUqiolAuT6MGXIgzxcKHGmuS89FVAsilMCbNYKEwqxyfKE4fcpmX1i5jIz7AB6T16n1+qwgVFYF
 rBsAJ7sWlN7iVHVLFGqZ73zRog5tsxFw3oopQ30QSxwhNh2wstnuCH4bfR4U/pY21XVs3qMhFA=
 =
X-Google-Smtp-Source: AGHT+IFgow6a3wckxtkWqgeRyvX6ieloo4xOD/lv/1/zXjGxjmtvr47CzOwND+ajJueov8FzCMIv/w==
X-Received: by 2002:a05:600c:21a:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43dd09fd1c0mr104477295e9.17.1743505765070; 
 Tue, 01 Apr 2025 04:09:25 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000f48sm151514895e9.37.2025.04.01.04.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:09:24 -0700 (PDT)
Message-ID: <9350af1d-ca58-4fb7-8032-459b15d71a45@gmail.com>
Date: Tue, 1 Apr 2025 13:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250331130152.2342-1-christian.koenig@amd.com>
 <7a95710e-e761-4650-bd4d-f6e0282ecfae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <7a95710e-e761-4650-bd4d-f6e0282ecfae@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 01.04.25 um 12:32 schrieb SRINIVASAN SHANMUGAM:
> On 3/31/2025 6:31 PM, Christian König wrote:
>> Otherwise triggering sysfs multiple times without other submissions in
>> between only runs the shader once.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index f64675b2ab75..9d81eeef61e8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1439,6 +1439,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>       struct amdgpu_device *adev = ring->adev;
>>       struct drm_gpu_scheduler *sched = &ring->sched;
>>       struct drm_sched_entity entity;
>> +    static atomic_t counter;
>>       struct dma_fence *f;
>>       struct amdgpu_job *job;
>>       struct amdgpu_ib *ib;
>> @@ -1452,9 +1453,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>           goto err;
>>       }
>>   -    r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
>> -                     64, 0,
>> -                     &job);
>> +    r = amdgpu_job_alloc_with_ib(ring->adev, &entity,
>> +                     (void *)(long)atomic_inc_return(&counter),
>> +                     64, 0, &job);
>
> Hi Christian,
>
> Should we need to  implement guards or checks to ensure that the counter does not excessively increment or reach an undesirable state. or resetting of the counter may be necessary?

Good that you ask, but no we don't need anything like that.

Basically the owner just need to be unique, e.g. just a large random number would do it as well. And when the atomic wraps around it just goes back to zero again.

But we should probably add a comment to explain that here.

Going to update the patch.

Thanks,
Christian.

>
> Best regards,
> Srini
>
>>       if (r)
>>           goto err;
>>   

