Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11827C3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 09:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EFB10E94A;
	Thu,  3 Apr 2025 09:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ma2llwoV";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8200610E96E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 09:11:00 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so416819f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743671459; x=1744276259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r77ur/o/bsmRwnNcfqKwdp8r5Uc73kVG2XNBX/0+5R4=;
 b=ma2llwoV2kzH2D3l6gkkRCxf/vIC+CtpqL8+F++GYmpW+i0NDVib0uMIcNwnHmHvXA
 u8aLVx6qK4PCZy8WPDnAzw5/NHr1ZcB3RTWAIsEwYdhriq5nC7/EOxOMcrpOD/B1Wf41
 G02wBw5f3aQE6XDmG6eUY34JbBOZaKdZCVlA6vr/vLerf2d0DS4B8bbUB/CgUzOwWvAY
 M+O73Sq7x4fiJMl1lyMTQxzz3u7ixCE3JyQAzMI3BrNF+z8pfj3/edRr8CcZGuuICOWo
 oQlUj6Xl8ittmcyjXlRWMH0Hm0EnE2QVpLO5QjWDExIIcqQUbDYoMP4P0/fLPtt39VuX
 1EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743671459; x=1744276259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r77ur/o/bsmRwnNcfqKwdp8r5Uc73kVG2XNBX/0+5R4=;
 b=Qpw6yWm4wVANjIaY2HJDGl/MIZvItZrXwozLQirMyZz+gOmclDIMnjIYTVrKzWK5ES
 8uu2a5nLpc2BNlHMjH0vJg2SIG3tZ+cP5Se0NsJ8ykAxHR+Ll5hvgIyOcGHO5HsSrM4o
 jL//LP0yz7TZ/LT8OwKARMUSy+6qKnaKMHScj8iqSM0tTxmAmxcezQ4EeGVWtTo7SUmM
 nE9s1sjBxFz11Qx8PF00BOPefXRg6EWFwxp3LLMvmgsnFwbX38C0k9/52Z2gAwtdbkJy
 XE6bvszA9n8ji8GYD9rfVB72Dj7TOu3SmNeI8ibpgdiSN5ulIkk2bXp4+rtqJxKaUVdr
 Oa8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP5zb5WuU+qMPTZV1iIJGXZMVtzVA8ecoMzT+9d+4AR0ZxYsWpiwvOmbeu0lRHsYjhPuD/V7y8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIVTuK5Ev7NEeknAqMY5F2I+SFPZzQYVnCYcEUJX4mracccfN5
 1XAVjVSKIv/9IuZ0XTW3LFKFjveDCXrWPwVXLL8eidVZ+OD92t94knNsgPkC
X-Gm-Gg: ASbGncvyMB1GT6A7Hfkw11bLuy5jQkSplmz4//4zK377G/20FPuYEXAnZbSajPkEoYF
 PgJ09pqItEfvCzIOY075neYf62wP2544IfRUy/XM1vc7AcF3DjvKrRpRPiH045ECMGsSvMijNjI
 2WACWU2gKoKlfP1DvRuJRhN4Rjc7aLtiTxFYarq4ep2uDhHBuLrrdqlhMJsLMNDJt8j9bofRw4J
 PFhYHzXrdJgSFJby+3Hr1zUvN9rRzHZnAuCElfobbO1T9AsPteiZli9eHdnnKpCRBfBruiQVBd9
 7maTdFbvJIS7HktB0Rw7UoNcrCDwLjO5js6vOsI2obtxTQ5y10aH4PiqRy1niONk88v4El7QWw=
 =
X-Google-Smtp-Source: AGHT+IEHiDbjJ4GjDaDlHMDglsgvrPri6iJiRs+Hv8sl/pMKQat9mz2hWp3KGE6aM+XeyKT72EYUsg==
X-Received: by 2002:a05:6000:2210:b0:39c:266c:423 with SMTP id
 ffacd0b85a97d-39c295857b8mr5174304f8f.0.1743671458861; 
 Thu, 03 Apr 2025 02:10:58 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ed7sm1208904f8f.8.2025.04.03.02.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 02:10:58 -0700 (PDT)
Message-ID: <fa41a078-c0ba-4e32-8580-13130d3b33f7@gmail.com>
Date: Thu, 3 Apr 2025 11:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders v2
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250402140213.13455-1-christian.koenig@amd.com>
 <9cb453c9-0ece-44d8-8bc7-6221aed0c059@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <9cb453c9-0ece-44d8-8bc7-6221aed0c059@amd.com>
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

Am 03.04.25 um 05:15 schrieb SRINIVASAN SHANMUGAM:
>
> On 4/2/2025 7:32 PM, Christian König wrote:
>> Otherwise triggering sysfs multiple times without other submissions in
>> between only runs the shader once.
>>
>> v2: add some comment
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index f64675b2ab75..9a24be43e035 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1439,9 +1439,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>       struct amdgpu_device *adev = ring->adev;
>>       struct drm_gpu_scheduler *sched = &ring->sched;
>>       struct drm_sched_entity entity;
>> +    static atomic_t counter;
>>       struct dma_fence *f;
>>       struct amdgpu_job *job;
>>       struct amdgpu_ib *ib;
>> +    void * owner;
>>       int i, r;
>>         /* Initialize the scheduler entity */
>> @@ -1452,9 +1454,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>           goto err;
>>       }
>>   -    r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
>> -                     64, 0,
>> -                     &job);
>> +    /*
>> +     * Use some unique dummy value as the owner to make sure we execute
>> +     * the cleaner shader on each submission. The value just need to change
>> +     * for each submission and is otherwise meaningless.
>> +     */
>> +    owner = (unsigned long)atomic_inc_return(&counter),
>
> Should this "atomic_inc_return()" needs to be casted to (void*), as it is return type is int?

No, I had that in the first version of the patch but it's actually sufficient to cast it to a long (which has the same number of bits as void*).

Regards,
Christian.

>
> Regards,
> Srini
>
>> +
>> +    r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
>> +                     64, 0, &job);
>>       if (r)
>>           goto err;
>>   

