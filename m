Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE944C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 07:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C545C10E0A2;
	Tue, 16 Jan 2024 07:05:01 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A749C10E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 07:05:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-40e857ce704so1438855e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 23:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705388639; x=1705993439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+9hqiO/a/yAImlapzKy9nyuBSc+vgHNFVY0puoEe5Q=;
 b=a4VFIVRVBwRp5RzXRlaPD0aCzOn/yl3I2KSiwBV4w5tiTiy0kRz7lGXUr4D8NKTDBD
 jKADTC9FriF/Ygjvv9Wg7hQ2GIHLZJ8Lwm99sMKumn99lx01a1/1L297kjSroP0L5VIa
 f0P48Y7u86DfYpOv5rbQinpybZan2RQqhbMVs/+BXmsw5DyuWOhqS4OBZtTnsID8+wFb
 NkPPFyOQYm7j2kxxD3mZBXvkr6Vn7GEvMupFZjxigJzRCDcZARGuBE0gmmyOEA6/aj9F
 oPTmYZ084I5yN1FMEHbOW9bByIWkwJJDhhPvMu68AhEpo8ZiuRadYIgJ8dzbjv9e8+pN
 kvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705388639; x=1705993439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L+9hqiO/a/yAImlapzKy9nyuBSc+vgHNFVY0puoEe5Q=;
 b=RY3H/NpWtXRL3UrxvGKMsgcFN6rWOicGMLAiDH+IToRi619XPrgoP8/XLsH6hHwJgM
 mC3Z+lu8oau+y7uJkX5H/+NTdGYNLVJIlSE2UWrRJCp8dLObZjgH/XCs7nv0LSlLduDr
 RqIiQLmvy5bwFkingLFMaR45nke5UvVc1NAgt2sfyidXCMVYXgZfg/KV4gXXjQD0S19o
 p5LtR7RVLdhApvTrn1by833YVs+UAIVg/ua9Wdx9XC/nuPlhsFBgmcERqZU7MhI3e5jQ
 f4oohZ+GKbw+wmrDbfbQ7mcZSqcEruStdOGymonD0qz5ECJbSzcOSsw/yuVtspLvNW6i
 cSRw==
X-Gm-Message-State: AOJu0YwDdQGkA18glYaYKxPa0NZ8lzqVVOnhy5fAmBpbBbtzfj1yUQGd
 /7aOFUW9B9jJbmpjYGzE3nI=
X-Google-Smtp-Source: AGHT+IGgR94QexAHb6814SYUSYS3y5+1vjXofY2FmaiQKDAotXhcQ6VmU0gZdJC1h/5ZvtYdDRz2Nw==
X-Received: by 2002:a05:600c:3106:b0:40e:545a:4b5f with SMTP id
 g6-20020a05600c310600b0040e545a4b5fmr2471599wmo.126.1705388638921; 
 Mon, 15 Jan 2024 23:03:58 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b0040e4746d80fsm18244277wmq.19.2024.01.15.23.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 23:03:58 -0800 (PST)
Message-ID: <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
Date: Tue, 16 Jan 2024 08:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Joshua Ashton <joshua@froggi.es>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 12:18 schrieb Friedrich Vock:
> Adding the original Ccs from the thread since they seemed to be missing
> in the reply.
>
> On 15.01.24 11:55, Christian König wrote:
>> Am 14.01.24 um 14:00 schrieb Friedrich Vock:
>>> Allows us to detect subsequent IH ring buffer overflows as well.
>>
>> Well that suggested handling here is certainly broken, see below.
>>
>>>
>>> Cc: Joshua Ashton <joshua@froggi.es>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: stable@vger.kernel.org
>>>
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 13 +++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 14 +++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 14 +++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 13 +++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 13 +++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 12 ++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/si_ih.c      | 12 ++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 13 +++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 12 ++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 12 ++++++++++++
>>>   11 files changed, 128 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> index 508f02eb0cf8..6041ec727f06 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
>>>       unsigned        rptr;
>>>       struct amdgpu_ih_regs    ih_regs;
>>>
>>> +    bool overflow;
>>> +
>>>       /* For waiting on IH processing at checkpoint. */
>>>       wait_queue_head_t wait_process;
>>>       uint64_t        processed_timestamp;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> index 6f7c031dd197..807cc30c9e33 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> @@ -204,6 +204,7 @@ static u32 cik_ih_get_wptr(struct amdgpu_device
>>> *adev,
>>>           tmp = RREG32(mmIH_RB_CNTL);
>>>           tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>           WREG32(mmIH_RB_CNTL, tmp);
>>> +        ih->overflow = true;
>>>       }
>>>       return (wptr & ih->ptr_mask);
>>>   }
>>> @@ -274,7 +275,19 @@ static void cik_ih_decode_iv(struct
>>> amdgpu_device *adev,
>>>   static void cik_ih_set_rptr(struct amdgpu_device *adev,
>>>                   struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>> +
>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>
>> Well that is an extremely bad idea. We already reset the overflow
>> after reading the WPTR.
>
> This is not resetting the overflow bit. This is resetting a "clear
> overflow" bit. I don't have the hardware docs, but the name (and my
> observations) strongly suggest that setting this bit actually prevents
> the hardware from setting the overflow bit ever again.

Well that doesn't make any sense at all. The hardware documentation 
clearly states that this bit is write only and should always read as zero.

Setting this bit will clear the overflow flag in the WPTR register and 
clearing it has no effect at all.

I could only ping the hw engineer responsible for this block to double 
check if the documentation is somehow outdated, but I really doubt so.

> Right now, IH overflows, even if they occur repeatedly, only get
> registered once. If not registering IH overflows can trivially lead to
> system crashes, it's amdgpu's current handling that is broken.

It's years that we last tested this but according to the HW 
documentation this should work fine.

What could potentially happen is that the IH has silenced the source of 
the overflow. We never implemented resetting those, but in this case 
that here won't help either.

>
> The possibility of a repeated IH overflow in between reading the wptr
> and updating the rptr is a good point, but how can we detect that at
> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
> then, because we're guaranteed to miss any overflows that happen while
> the bit is set.

When an IH overflow is signaled we clear that flag by writing 1 into the 
OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.

What can of course happen is that the IH ring buffer overflows more than 
this single entry and we process IVs which are potentially corrupted, 
but we won't miss any additional overflows since we only start 
processing after resetting the flag.

An IH overflow is also something you should *never* see in a production 
system. This is purely for driver bringup and as fallback when there is 
a severe incorrect programming of the HW.

The only exception of that is page fault handling on MI products because 
of a hardware bug, to mitigate this we are processing page faults on a 
separate IH ring on those parts.

On all other hw generations the IH should have some rate limit for the 
number of faults generated per second, so that the CPU is always able to 
catch up.

Regards,
Christian.

>
> Regards,
> Friedrich
>
>>
>> When you clear the overflow again when updating the RPTR you could
>> loose another overflow which might have happened in between and so
>> potentially process corrupted IVs.
>>
>> That can trivially crash the system.
>>
>> Regards,
>> Christian.
>>
>>>   }
>>>
>>>   static int cik_ih_early_init(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> index b8c47e0cf37a..076559668573 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
>>> *adev,
>>>       tmp = RREG32(mmIH_RB_CNTL);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32(mmIH_RB_CNTL, tmp);
>>> -
>>> +    ih->overflow = true;
>>>
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_device
>>> *adev,
>>>   static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>                  struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>> +
>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   static int cz_ih_early_init(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> index aecad530b10a..1a5e668643d1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>> amdgpu_device *adev,
>>>       tmp = RREG32(mmIH_RB_CNTL);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32(mmIH_RB_CNTL, tmp);
>>> -
>>> +    ih->overflow = true;
>>>
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>> amdgpu_device *adev,
>>>   static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>                   struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>> +
>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   static int iceland_ih_early_init(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> index d9ed7332d805..ce8f7feec713 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device
>>> *adev,
>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +    ih->overflow = true;
>>> +
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>>   }
>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>> amdgpu_device *adev,
>>>   static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>                      struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>>       struct amdgpu_ih_regs *ih_regs;
>>>
>>>       if (ih->use_doorbell) {
>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>> amdgpu_device *adev,
>>>           ih_regs = &ih->ih_regs;
>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>       }
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> index 8fb05eae340a..668788ad34d9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device
>>> *adev,
>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +    ih->overflow = true;
>>> +
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>>   }
>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>> amdgpu_device *adev,
>>>   static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>                      struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>>       struct amdgpu_ih_regs *ih_regs;
>>>
>>>       if (ih->use_doorbell) {
>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>> amdgpu_device *adev,
>>>           ih_regs = &ih->ih_regs;
>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>       }
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> index e64b33115848..0bdac923cb4d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>> amdgpu_device *adev,
>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +    ih->overflow = true;
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>>   }
>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>> amdgpu_device *adev,
>>>   static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>                      struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>>       struct amdgpu_ih_regs *ih_regs;
>>>
>>>       if (ih == &adev->irq.ih_soft)
>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>> amdgpu_device *adev,
>>>           ih_regs = &ih->ih_regs;
>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>       }
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> index 9a24f17a5750..ff35056d2b54 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
>>> *adev,
>>>           tmp = RREG32(IH_RB_CNTL);
>>>           tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>           WREG32(IH_RB_CNTL, tmp);
>>> +        ih->overflow = true;
>>>       }
>>>       return (wptr & ih->ptr_mask);
>>>   }
>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_device
>>> *adev,
>>>   static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>                  struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>> +
>>>       WREG32(IH_RB_RPTR, ih->rptr);
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32(IH_RB_CNTL);
>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>> +        WREG32(IH_RB_CNTL, tmp);
>>> +    }
>>>   }
>>>
>>>   static int si_ih_early_init(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> index 917707bba7f3..6f5090d3db48 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device
>>> *adev,
>>>       tmp = RREG32(mmIH_RB_CNTL);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32(mmIH_RB_CNTL, tmp);
>>> +    ih->overflow = true;
>>>
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>> amdgpu_device *adev,
>>>   static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>                     struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>> +
>>>       if (ih->use_doorbell) {
>>>           /* XXX check if swapping is necessary on BE */
>>>           *ih->rptr_cpu = ih->rptr;
>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>> amdgpu_device *adev,
>>>       } else {
>>>           WREG32(mmIH_RB_RPTR, ih->rptr);
>>>       }
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   static int tonga_ih_early_init(void *handle)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> index d364c6dd152c..bb005924f194 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>> amdgpu_device *adev,
>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +    ih->overflow = true;
>>>
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>> amdgpu_device *adev,
>>>   static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>                      struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>>       struct amdgpu_ih_regs *ih_regs;
>>>
>>>       if (ih == &adev->irq.ih_soft)
>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>> amdgpu_device *adev,
>>>           ih_regs = &ih->ih_regs;
>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>       }
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> index ddfc6941f9d5..bb725a970697 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>> amdgpu_device *adev,
>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +    ih->overflow = true;
>>>
>>>   out:
>>>       return (wptr & ih->ptr_mask);
>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>> amdgpu_device *adev,
>>>   static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>                      struct amdgpu_ih_ring *ih)
>>>   {
>>> +    u32 tmp;
>>>       struct amdgpu_ih_regs *ih_regs;
>>>
>>>       if (ih == &adev->irq.ih_soft)
>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>> amdgpu_device *adev,
>>>           ih_regs = &ih->ih_regs;
>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>       }
>>> +
>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>> bit),
>>> +     * reset it here to detect more overflows if they occur.
>>> +     */
>>> +    if (ih->overflow) {
>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>> +        ih->overflow = false;
>>> +    }
>>>   }
>>>
>>>   /**
>>> -- 
>>> 2.43.0
>>>
>>

