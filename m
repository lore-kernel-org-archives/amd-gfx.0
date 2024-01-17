Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32DCC47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 12:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAA310E491;
	Wed, 17 Jan 2024 12:28:51 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D842D10E08F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 12:28:45 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-337c4f0f9daso304706f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 04:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494464; x=1706099264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PS2tRtupjIsjXXxxBLRFiknRUKZNWvwJpQWy7EdlkL4=;
 b=OJvCqhDNv97+C6g+lZhDEld2PmHAKCbX9IyuZAz40jRkZ2jtPLOxiI2ULcA9FZRoYU
 31elriUcTAPSFhe6z9T23Q2rj/nSDuO25sqxltCz48qUPPyK8NADS82hixMOF8m79KKy
 a9KNj7L5noTZBj7FbhSDg8q2rVgMDNy2iy5hoKLL+XPrVyV9UOLLZG/DJmcuyqocJ+va
 WdenqSGyCeeF53OrQ0RCEQIxwp6x9ELuKFu05/p762pSdXqg6M4QuwrJdo28zSUPrcG6
 oZbi87pO54+XYqqNj5nDblRLht1o5KrRzYlMKGFP+62MbzwsEDWgQozTWc7s/U0ELip+
 oDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494464; x=1706099264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PS2tRtupjIsjXXxxBLRFiknRUKZNWvwJpQWy7EdlkL4=;
 b=vyf9RNN/u69goQqJEbgcpe6EIg3tdmxOE5FqAkJx+A9KeiwE2O0SBXUGnld3RXtpRc
 2oktFsHjZPUI72fFKaF0mC0Yz9qLQkh36RXknJ9TjAb0WvUZ+FWZhcs18bsI91lyxAxI
 CsKBYlNgMARKYEKYjwXREZLykY6idkox/nyphvAhX+2HAFNAZ3y0KqqUiRWsI5EEM9VK
 4tDYTXRXe+/NLhJryeLXa6rbqibZ49YzhRS4HVTUN87eS7xRKN+xmkzwdLvOfR2Pb/qP
 37ROqmDjqgzFRH5Drwz5A99+2V5aUG4TWeaRJiyBNRlUc/QYAnW9w+YJzHIVOmGokdqc
 OAMQ==
X-Gm-Message-State: AOJu0Yx0K98KuZ0SugncKrm6QhRiuCRKtT8R+nAKDpctvEQxSTyC4mV4
 f8bVEQXA+TbGc/232QIBgxw=
X-Google-Smtp-Source: AGHT+IEXQ/XF4JjNzW423LhQrrr5DSpcoAjIPAr5JzdG96+ujas+iiaRmz+3NGivSrVonhNj+mWZSw==
X-Received: by 2002:a5d:5982:0:b0:337:aa48:dbe7 with SMTP id
 n2-20020a5d5982000000b00337aa48dbe7mr2908672wri.5.1705494463931; 
 Wed, 17 Jan 2024 04:27:43 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a056000008e00b00333359b522dsm1565428wrx.77.2024.01.17.04.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 04:27:43 -0800 (PST)
Message-ID: <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
Date: Wed, 17 Jan 2024 13:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.01.24 um 11:31 schrieb Friedrich Vock:
> On 16.01.24 08:03, Christian König wrote:
>> Am 15.01.24 um 12:18 schrieb Friedrich Vock:
>>> [SNIP]
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>
>>>> Well that is an extremely bad idea. We already reset the overflow
>>>> after reading the WPTR.
>>>
>>> This is not resetting the overflow bit. This is resetting a "clear
>>> overflow" bit. I don't have the hardware docs, but the name (and my
>>> observations) strongly suggest that setting this bit actually prevents
>>> the hardware from setting the overflow bit ever again.
>>
>> Well that doesn't make any sense at all. The hardware documentation
>> clearly states that this bit is write only and should always read as
>> zero.
>>
>> Setting this bit will clear the overflow flag in the WPTR register and
>> clearing it has no effect at all.
>>
>> I could only ping the hw engineer responsible for this block to double
>> check if the documentation is somehow outdated, but I really doubt so.
>>
> I see. I wish I had access to the documentation,

Well, doesn't Valve has an NDA in place?

> but I don't, so all I
> can do is tell you what I observe the hardware doing. I've tested this
> on both a Steam Deck (OSSYS 5.2.0) and an RX 6700 XT (OSSYS 5.0.3). On
> both systems, launching a bunch of shaders that cause page faults leads
> to lots of "[gfxhub] page fault" messages in dmesg, followed by an
> "amdgpu: IH ring buffer overflow".

Well that is certainly a bug, maybe even the same thing we have seen on 
Vega and MI.

What we could do is to try to apply the same workaround to re-route the 
page faults to a different IH ring.

See those patches here as well:

commit 516bc3d8dd7965f1a8a3ea453857f14d95971e62
Author: Christian König <christian.koenig@amd.com>
Date:   Fri Nov 2 15:00:16 2018 +0100

     drm/amdgpu: reroute VMC and UMD to IH ring 1

     Page faults can easily overwhelm the interrupt handler.

     So to make sure that we never lose valuable interrupts on the 
primary ring
     we re-route page faults to IH ring 1.

commit b849aaa41c914a0fd88003f88cb04420a873c624
Author: Christian König <christian.koenig@amd.com>
Date:   Mon Mar 4 19:34:34 2019 +0100

     drm/amdgpu: also reroute VMC and UMD to IH ring 1 on Vega 20

     Same patch we alredy did for Vega10. Just re-route page faults to a 
separate
     ring to avoid drowning in interrupts.

>
> If I re-launch the same set of shaders after the GPU has soft-recovered,
> the "amdgpu: IH ring buffer overflow" message is missing, even though
> the same amount of page faults should've been triggered at roughly the
> same rate. Running with this patch applied makes more "amdgpu: IH ring
> buffer overflow" messages appear after relaunching the faulting shaders
> (but not when processing any non-faulting work).

That is actually the expected behavior. There should be a limit on the 
number of faults written to the ring so that the ring never overflows.

>
> The only possible conclusion I can draw from this is that clearing that
> bit *does* have an effect, and I don't think it's far-fetched to assume
> the IH ring buffer overflows still happen after re-launching the
> faulting shaders but go undetected so far.

Well that can only mean that the hw documentation is incorrect.

Either the value is not write only trigger bit as documented or we need 
an additional read of the register for it to take effect or something 
like this.

>>> Right now, IH overflows, even if they occur repeatedly, only get
>>> registered once. If not registering IH overflows can trivially lead to
>>> system crashes, it's amdgpu's current handling that is broken.
>>
>> It's years that we last tested this but according to the HW
>> documentation this should work fine.
>>
>> What could potentially happen is that the IH has silenced the source
>> of the overflow. We never implemented resetting those, but in this
>> case that here won't help either.
>>
> If the IH silenced the page faults (which quite clearly cause the
> overflow here), then how are the page faults still logged in dmesg?

There should be a hardware rate limit for the page faults, e.g. there 
can only be X faults reported in N clock cycles and then a delay is 
inserted.

>>>
>>> The possibility of a repeated IH overflow in between reading the wptr
>>> and updating the rptr is a good point, but how can we detect that at
>>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
>>> then, because we're guaranteed to miss any overflows that happen while
>>> the bit is set.
>>
>> When an IH overflow is signaled we clear that flag by writing 1 into
>> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>>
>> What can of course happen is that the IH ring buffer overflows more
>> than this single entry and we process IVs which are potentially
>> corrupted, but we won't miss any additional overflows since we only
>> start processing after resetting the flag.
>>
>> An IH overflow is also something you should *never* see in a
>> production system. This is purely for driver bringup and as fallback
>> when there is a severe incorrect programming of the HW.
>>
>> The only exception of that is page fault handling on MI products
>> because of a hardware bug, to mitigate this we are processing page
>> faults on a separate IH ring on those parts.
>>
>> On all other hw generations the IH should have some rate limit for the
>> number of faults generated per second, so that the CPU is always able
>> to catch up.
>
> I'm wondering if there is another bug in here somewhere. Your
> explanation of how it's supposed to work makes a lot of sense, but from
> what I can tell it doesn't work that way when I test it.
>
> From the printk_ratelimit stats it would seem like >2000 faults arrive
> in less than a second, so perhaps your theory about fault interrupt
> ratelimiting not working is correct (but it's hard for me to verify what
> is going on without the documentation).

I'm going to ping the relevant engineer and putting someone on the task 
to take a look.

Thanks,
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
>>> Regards,
>>> Friedrich
>>>
>>>>
>>>> When you clear the overflow again when updating the RPTR you could
>>>> loose another overflow which might have happened in between and so
>>>> potentially process corrupted IVs.
>>>>
>>>> That can trivially crash the system.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>   }
>>>>>
>>>>>   static int cik_ih_early_init(void *handle)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> index b8c47e0cf37a..076559668573 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
>>>>> *adev,
>>>>>       tmp = RREG32(mmIH_RB_CNTL);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32(mmIH_RB_CNTL, tmp);
>>>>> -
>>>>> +    ih->overflow = true;
>>>>>
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_device
>>>>> *adev,
>>>>>   static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                  struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>> +
>>>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   static int cz_ih_early_init(void *handle)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> index aecad530b10a..1a5e668643d1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>>> amdgpu_device *adev,
>>>>>       tmp = RREG32(mmIH_RB_CNTL);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32(mmIH_RB_CNTL, tmp);
>>>>> -
>>>>> +    ih->overflow = true;
>>>>>
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>>> amdgpu_device *adev,
>>>>>   static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>> +
>>>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   static int iceland_ih_early_init(void *handle)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>> index d9ed7332d805..ce8f7feec713 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device
>>>>> *adev,
>>>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>> +    ih->overflow = true;
>>>>> +
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>>   }
>>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>>> amdgpu_device *adev,
>>>>>   static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>>       struct amdgpu_ih_regs *ih_regs;
>>>>>
>>>>>       if (ih->use_doorbell) {
>>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>>> amdgpu_device *adev,
>>>>>           ih_regs = &ih->ih_regs;
>>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>       }
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>> index 8fb05eae340a..668788ad34d9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device
>>>>> *adev,
>>>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>> +    ih->overflow = true;
>>>>> +
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>>   }
>>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>>> amdgpu_device *adev,
>>>>>   static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>>       struct amdgpu_ih_regs *ih_regs;
>>>>>
>>>>>       if (ih->use_doorbell) {
>>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>>> amdgpu_device *adev,
>>>>>           ih_regs = &ih->ih_regs;
>>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>       }
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> index e64b33115848..0bdac923cb4d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>>> amdgpu_device *adev,
>>>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>> +    ih->overflow = true;
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>>   }
>>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>>> amdgpu_device *adev,
>>>>>   static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>>       struct amdgpu_ih_regs *ih_regs;
>>>>>
>>>>>       if (ih == &adev->irq.ih_soft)
>>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>>> amdgpu_device *adev,
>>>>>           ih_regs = &ih->ih_regs;
>>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>       }
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
>>>>> *adev,
>>>>>           tmp = RREG32(IH_RB_CNTL);
>>>>>           tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>           WREG32(IH_RB_CNTL, tmp);
>>>>> +        ih->overflow = true;
>>>>>       }
>>>>>       return (wptr & ih->ptr_mask);
>>>>>   }
>>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_device
>>>>> *adev,
>>>>>   static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                  struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>> +
>>>>>       WREG32(IH_RB_RPTR, ih->rptr);
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32(IH_RB_CNTL);
>>>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>> +        WREG32(IH_RB_CNTL, tmp);
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   static int si_ih_early_init(void *handle)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> index 917707bba7f3..6f5090d3db48 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device
>>>>> *adev,
>>>>>       tmp = RREG32(mmIH_RB_CNTL);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32(mmIH_RB_CNTL, tmp);
>>>>> +    ih->overflow = true;
>>>>>
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>>> amdgpu_device *adev,
>>>>>   static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                     struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>> +
>>>>>       if (ih->use_doorbell) {
>>>>>           /* XXX check if swapping is necessary on BE */
>>>>>           *ih->rptr_cpu = ih->rptr;
>>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>>> amdgpu_device *adev,
>>>>>       } else {
>>>>>           WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>       }
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   static int tonga_ih_early_init(void *handle)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> index d364c6dd152c..bb005924f194 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>>> amdgpu_device *adev,
>>>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>> +    ih->overflow = true;
>>>>>
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>>> amdgpu_device *adev,
>>>>>   static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>>       struct amdgpu_ih_regs *ih_regs;
>>>>>
>>>>>       if (ih == &adev->irq.ih_soft)
>>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>>> amdgpu_device *adev,
>>>>>           ih_regs = &ih->ih_regs;
>>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>       }
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>> index ddfc6941f9d5..bb725a970697 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>>> amdgpu_device *adev,
>>>>>       tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>       tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>> +    ih->overflow = true;
>>>>>
>>>>>   out:
>>>>>       return (wptr & ih->ptr_mask);
>>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>>> amdgpu_device *adev,
>>>>>   static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>   {
>>>>> +    u32 tmp;
>>>>>       struct amdgpu_ih_regs *ih_regs;
>>>>>
>>>>>       if (ih == &adev->irq.ih_soft)
>>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>>> amdgpu_device *adev,
>>>>>           ih_regs = &ih->ih_regs;
>>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>       }
>>>>> +
>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEAR
>>>>> bit),
>>>>> +     * reset it here to detect more overflows if they occur.
>>>>> +     */
>>>>> +    if (ih->overflow) {
>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 
>>>>> 0);
>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>> +        ih->overflow = false;
>>>>> +    }
>>>>>   }
>>>>>
>>>>>   /**
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>>
>>

