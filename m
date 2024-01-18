Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5643AC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 12:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC0610E14C;
	Thu, 18 Jan 2024 12:08:17 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4215910E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 12:08:16 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-40e5afc18f5so78181175e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 04:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705579635; x=1706184435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBezNArkMLwTxlYqXs/8q87MapNcG5cLoZHoZWtRpcE=;
 b=EBjMUpL2cSeeLuhXkr0CxsA9DwYioQCoL017xG9wdZdLG70ceSpcM7fusKpKwgx8I3
 Xhn4yUJN5Pb+QfBZU33x42ZXnVyu7dh02tRTc8vJfgT5N2Kd9hPkLO2q/mZjE5nTBTU8
 nvvTct/UMONg7WFdR9oa1om2t9dheeiDOmRdQ/aobyape9PWD1tHpSM58230M6GFC2gR
 QZQwRRWqqu+4cAL2IWMwucxSb5tFDPAqZEjyWUv4rHrn59Sgm+A4uYgQk9NJnnPNYDRD
 ATxcuP8XRNda0qOWu+YS+txfVD5LchdrTOtLVAB/m0wfa0KN4xXLpyDbolNUM+NjQHd4
 jzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705579635; x=1706184435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBezNArkMLwTxlYqXs/8q87MapNcG5cLoZHoZWtRpcE=;
 b=UZkX7510mMNw0w9B52TDGReZ+i57WWX//QlmGHTZZODpwNHOC42gYX3jMqEZMh4a3P
 k0PhoQCU0D42IIZM66NaSnUJImc+csLGN1RuubAN/mCQ2bkS5fLIJ6NujCIq4N40QjgB
 Z7sBzFrX1R44K79LjMohXkWFn+/Pi8WgefrfTcEWjFcNiHlvjMVAocaXnqOriEAbOUaF
 4J6RDzq+G8JxvzX6mFzYMf5M0mgCC362G1vMxcOAC2kABHKWQIXK3wYhewp1aflc7/m5
 frTrRbaZKe0BPlQB4DLnbWRNrGZByx6e1Zy50AO2FsXukt2JSdJX10JGMkI8ADGBDAKS
 CBeg==
X-Gm-Message-State: AOJu0YwMf8+smoKNfXTbE28sw2ZgU4RtZqwFJN383wTpLDWlgVTEcVSf
 EqM87s+lLr3g3nj10kMFEKtsqXRVbkH6+Blm42E2HbIc4+dP+2vVtQynOZAJKXw=
X-Google-Smtp-Source: AGHT+IGWZBDDrQAD9vhZXZuSEEPmORwPQhwIg6KPczy4YZpjAY0wkdhz/3+5IWRnHo0+akvK/zsQZw==
X-Received: by 2002:a05:600c:2353:b0:40e:86eb:9e7e with SMTP id
 19-20020a05600c235300b0040e86eb9e7emr419458wmq.142.1705579634255; 
 Thu, 18 Jan 2024 04:07:14 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05600c510800b0040e624995f1sm24376949wms.8.2024.01.18.04.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 04:07:13 -0800 (PST)
Message-ID: <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
Date: Thu, 18 Jan 2024 13:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
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

Am 18.01.24 um 00:44 schrieb Friedrich Vock:
> On 18.01.24 00:00, Alex Deucher wrote:
>> [SNIP]
>>>>>> Right now, IH overflows, even if they occur repeatedly, only get
>>>>>> registered once. If not registering IH overflows can trivially 
>>>>>> lead to
>>>>>> system crashes, it's amdgpu's current handling that is broken.
>>>>> It's years that we last tested this but according to the HW
>>>>> documentation this should work fine.
>>>>>
>>>>> What could potentially happen is that the IH has silenced the source
>>>>> of the overflow. We never implemented resetting those, but in this
>>>>> case that here won't help either.
>>>>>
>>>> If the IH silenced the page faults (which quite clearly cause the
>>>> overflow here), then how are the page faults still logged in dmesg?
>>> There should be a hardware rate limit for the page faults, e.g. there
>>> can only be X faults reported in N clock cycles and then a delay is
>>> inserted.
>> @Christian Koenig  Is that tied to xnack (i.e., noretry)?  The default
>> is noretry=1 on gfx10.3 and newer.  But it can be overridden. It was
>> not set on some older kernels, maybe that is the problem? @Friedrich
>> Vock does setting amdgpu.noretry=1 fix the issue?
>
>
> No, amdgpu.noretry=1 does not change anything.

Well the good news first the hw engineer answered rather quickly. The 
bad news is that the hardware really doesn't work as documented in 
multiple ways.

First of all the CLEAR bit is a level and not a trigger, so the 
intention to clear it is indeed correct. For now please modify this 
patch so that the CLEAR bit is set and cleared directly after setting 
it, this way we should be able to detect further overflows immediately.

Then the APU the Steam Deck uses simply doesn't have the filter function 
for page faults in the hardware, the really bad news is it also doesn't 
have the extra IH rings where we could re-route the faults to prevent 
overflows.

That full explains the behavior you have been seeing, but doesn't really 
provide a doable solution to mitigate this problem.

I'm going to dig deeper into the hw documentation and specification to 
see if we can use a different feature to avoid the overflow.

Thanks,
Christian.

>
> Regards,
> Friedrich
>
>> Alex
>>
>>>>>> The possibility of a repeated IH overflow in between reading the 
>>>>>> wptr
>>>>>> and updating the rptr is a good point, but how can we detect that at
>>>>>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
>>>>>> then, because we're guaranteed to miss any overflows that happen 
>>>>>> while
>>>>>> the bit is set.
>>>>> When an IH overflow is signaled we clear that flag by writing 1 into
>>>>> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>>>>>
>>>>> What can of course happen is that the IH ring buffer overflows more
>>>>> than this single entry and we process IVs which are potentially
>>>>> corrupted, but we won't miss any additional overflows since we only
>>>>> start processing after resetting the flag.
>>>>>
>>>>> An IH overflow is also something you should *never* see in a
>>>>> production system. This is purely for driver bringup and as fallback
>>>>> when there is a severe incorrect programming of the HW.
>>>>>
>>>>> The only exception of that is page fault handling on MI products
>>>>> because of a hardware bug, to mitigate this we are processing page
>>>>> faults on a separate IH ring on those parts.
>>>>>
>>>>> On all other hw generations the IH should have some rate limit for 
>>>>> the
>>>>> number of faults generated per second, so that the CPU is always able
>>>>> to catch up.
>>>> I'm wondering if there is another bug in here somewhere. Your
>>>> explanation of how it's supposed to work makes a lot of sense, but 
>>>> from
>>>> what I can tell it doesn't work that way when I test it.
>>>>
>>>>  From the printk_ratelimit stats it would seem like >2000 faults 
>>>> arrive
>>>> in less than a second, so perhaps your theory about fault interrupt
>>>> ratelimiting not working is correct (but it's hard for me to verify 
>>>> what
>>>> is going on without the documentation).
>>> I'm going to ping the relevant engineer and putting someone on the task
>>> to take a look.
>>>
>>> Thanks,
>>> Christian.
>>>
>>>> Regards,
>>>> Friedrich
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>> Friedrich
>>>>>>
>>>>>>> When you clear the overflow again when updating the RPTR you could
>>>>>>> loose another overflow which might have happened in between and so
>>>>>>> potentially process corrupted IVs.
>>>>>>>
>>>>>>> That can trivially crash the system.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static int cik_ih_early_init(void *handle)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>> index b8c47e0cf37a..076559668573 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
>>>>>>>> *adev,
>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>> -
>>>>>>>> +    ih->overflow = true;
>>>>>>>>
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct 
>>>>>>>> amdgpu_device
>>>>>>>> *adev,
>>>>>>>>    static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>> +
>>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static int cz_ih_early_init(void *handle)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>> index aecad530b10a..1a5e668643d1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>> -
>>>>>>>> +    ih->overflow = true;
>>>>>>>>
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                    struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>> +
>>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static int iceland_ih_early_init(void *handle)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>> index d9ed7332d805..ce8f7feec713 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct 
>>>>>>>> amdgpu_device
>>>>>>>> *adev,
>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>> +    ih->overflow = true;
>>>>>>>> +
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>    }
>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>
>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>        }
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>> index 8fb05eae340a..668788ad34d9 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct 
>>>>>>>> amdgpu_device
>>>>>>>> *adev,
>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>> +    ih->overflow = true;
>>>>>>>> +
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>    }
>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>
>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>        }
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>> index e64b33115848..0bdac923cb4d 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>> +    ih->overflow = true;
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>    }
>>>>>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>
>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>        }
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
>>>>>>>> *adev,
>>>>>>>>            tmp = RREG32(IH_RB_CNTL);
>>>>>>>>            tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>            WREG32(IH_RB_CNTL, tmp);
>>>>>>>> +        ih->overflow = true;
>>>>>>>>        }
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>    }
>>>>>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct 
>>>>>>>> amdgpu_device
>>>>>>>> *adev,
>>>>>>>>    static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>> +
>>>>>>>>        WREG32(IH_RB_RPTR, ih->rptr);
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32(IH_RB_CNTL);
>>>>>>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>> +        WREG32(IH_RB_CNTL, tmp);
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static int si_ih_early_init(void *handle)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>> index 917707bba7f3..6f5090d3db48 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct 
>>>>>>>> amdgpu_device
>>>>>>>> *adev,
>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>> +    ih->overflow = true;
>>>>>>>>
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>> +
>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>            /* XXX check if swapping is necessary on BE */
>>>>>>>>            *ih->rptr_cpu = ih->rptr;
>>>>>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>        } else {
>>>>>>>>            WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>        }
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static int tonga_ih_early_init(void *handle)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>> index d364c6dd152c..bb005924f194 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>> +    ih->overflow = true;
>>>>>>>>
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>
>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>        }
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>> index ddfc6941f9d5..bb725a970697 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>> +    ih->overflow = true;
>>>>>>>>
>>>>>>>>    out:
>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>    static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>    {
>>>>>>>> +    u32 tmp;
>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>
>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>        }
>>>>>>>> +
>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>> OVERFLOW_CLEAR
>>>>>>>> bit),
>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>> +     */
>>>>>>>> +    if (ih->overflow) {
>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,
>>>>>>>> 0);
>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>> +        ih->overflow = false;
>>>>>>>> +    }
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    /**
>>>>>>>> -- 
>>>>>>>> 2.43.0
>>>>>>>>

