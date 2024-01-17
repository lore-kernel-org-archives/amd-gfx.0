Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33430C4725D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 23:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2ED10E905;
	Wed, 17 Jan 2024 23:45:03 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D1310E904
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705535097; x=1706139897; i=friedrich.vock@gmx.de;
 bh=ZKfYeIumDAvQ6V4aKQUZFdodIMpJMKbf5sDLItMGFQo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=trDxuEuXzjg+oLX2NhBJb+iwOIVOBboUyY13MoWV+EAx3zTxS0vYO58qu2wHabs/
 e6dWw7XdMZXPjjplpRlqwysKqrVLymlX2dgPr4ngZY2PCNKfq81wsjMT1ATySMVS9
 ZuU8XkSpD/Yziiuxcvh1HMPaqoepq+bj1wJlUKFJRdxJOgi414nqEtzVStZcNM2d5
 wLVItvRM8demgR3JibQObxB3bAYE5u3b0GtaAiBbHZfdYbqQyHEORZGs+9hawQ506
 fRMKu5uHe8jarK2KpWFTWqRHmMGyUNNJ4iwwBNERH39qhW0cqYW5u+KHC4oWCRKyd
 zLlFqXq4nIBai9M7eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1rP9eu3Vds-003P4U; Thu, 18
 Jan 2024 00:44:56 +0100
Message-ID: <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
Date: Thu, 18 Jan 2024 00:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p4t03NWMQwIq08KYVi6UfrbwOjehkl/TK33E5GM5JXGwIFaTrD4
 8arKVMQElnK5I6IWfiDMDAp0SofZpkaUR0YuGLbVK68ZOPvjVPiIud1EYpSLVLVXVR4cuF0
 PznLum3IlJp2wHP2CB5CE5aJ+G8KZTTSUXdtOGz2ZVRQxus0cc5LCapnCfaCgj4CLPmP9nr
 IAFcsQBstjWgYkB6LPWJw==
UI-OutboundReport: notjunk:1;M01:P0:lceBreR0QBw=;1BxeaAvac9ckAnOJ81noyajk1Yx
 BD3pCWQQy1KOGn2efB5t0rynP6vlItxHg7lzFhhjW4Z7cjfaTMKutr/IDGGGmPeiDT4NJNoDS
 5Q7Q+j8C4mFCfO19sV/A5XP5riiTJ3M/g6ZwSjfHGTiasncIo0M2hmuUKcMX37ZYp5uaRXnBt
 noJV0nfLTY4La9BewvicB0IN/J0WRD0sP4aFly68ngDY44FaniCdg19NBe6LsxheSuHr11jZg
 +8KZSv8jmLVsUMNXTVhFx8pOtCqJVZG//j9Skdv4tlGSF50hbYfwong1z04QgZM/DX6Xpk+DL
 jLq4jop+G5HToq7LLooegQ+zdFZoDesQo7AD3xThjEMwOFQH3RlQ7emFRXoNXVHhNWYDWI0Yy
 AIVTNT7thItGuEdHXLrOwoAvW8ABxDEyWZpBfO5Nnr7MQAE29c3UNNkWo3MeLF2hjpXQ8fnqZ
 gUdiuF8IxcQ+d62zWDIo/878DDIPgUoj4JbQqjtYhLcThBCXehGPlmAjjbZjguSVHJpJfSl5I
 pKxR2G6EjA9Gv1BwRzgV+NR4xY6aEUpCiKMZjjLceDTq7ZDpHGHkCaSG4WfP6uuN3lq6GOIkq
 FjZq1RU6J4Owyb5waokZbWMNyRZTkARTzR0asForzkDJuEsiVSPQgcvevVpU/txoiYxsIapik
 9jRpZuXw9zcOUQQ/jEbl06tzKZYcd3OXlMLuZAOdacQzlIwunx9jNVzYz4H6Sm7ZdH2cJQSf1
 tjqwwdtlAtzATRKrV0bKFQwJ0Ll92vHNB2YGua+xPl5NhjUButCM+50MpijUWc1QtJjGPgPL9
 qnQHPfXE587c2AVbQiEn7KupCcNc0lXEuHP1XYJC6B5OVQsBI6GeEt5udBhSl894ND9mLUusB
 IpjkuvVyEiHEcW/1CyTHgG7gDu7E8gr8iVBQS0K3Borjc1byBS0wAXQ3H3lpjfomRrwvYXYCA
 /jn8w4gWj6JiVb31u7lObU1/ukY=
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

On 18.01.24 00:00, Alex Deucher wrote:
> On Wed, Jan 17, 2024 at 7:36=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 16.01.24 um 11:31 schrieb Friedrich Vock:
>>> On 16.01.24 08:03, Christian K=C3=B6nig wrote:
>>>> Am 15.01.24 um 12:18 schrieb Friedrich Vock:
>>>>> [SNIP]
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>> +        tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>> Well that is an extremely bad idea. We already reset the overflow
>>>>>> after reading the WPTR.
>>>>> This is not resetting the overflow bit. This is resetting a "clear
>>>>> overflow" bit. I don't have the hardware docs, but the name (and my
>>>>> observations) strongly suggest that setting this bit actually preven=
ts
>>>>> the hardware from setting the overflow bit ever again.
>>>> Well that doesn't make any sense at all. The hardware documentation
>>>> clearly states that this bit is write only and should always read as
>>>> zero.
>>>>
>>>> Setting this bit will clear the overflow flag in the WPTR register an=
d
>>>> clearing it has no effect at all.
>>>>
>>>> I could only ping the hw engineer responsible for this block to doubl=
e
>>>> check if the documentation is somehow outdated, but I really doubt so=
.
>>>>
>>> I see. I wish I had access to the documentation,
>> Well, doesn't Valve has an NDA in place?
>>
>>> but I don't, so all I
>>> can do is tell you what I observe the hardware doing. I've tested this
>>> on both a Steam Deck (OSSYS 5.2.0) and an RX 6700 XT (OSSYS 5.0.3). On
>>> both systems, launching a bunch of shaders that cause page faults lead=
s
>>> to lots of "[gfxhub] page fault" messages in dmesg, followed by an
>>> "amdgpu: IH ring buffer overflow".
>> Well that is certainly a bug, maybe even the same thing we have seen on
>> Vega and MI.
>>
>> What we could do is to try to apply the same workaround to re-route the
>> page faults to a different IH ring.
>>
>> See those patches here as well:
>>
>> commit 516bc3d8dd7965f1a8a3ea453857f14d95971e62
>> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Date:   Fri Nov 2 15:00:16 2018 +0100
>>
>>       drm/amdgpu: reroute VMC and UMD to IH ring 1
>>
>>       Page faults can easily overwhelm the interrupt handler.
>>
>>       So to make sure that we never lose valuable interrupts on the
>> primary ring
>>       we re-route page faults to IH ring 1.
>>
>> commit b849aaa41c914a0fd88003f88cb04420a873c624
>> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Date:   Mon Mar 4 19:34:34 2019 +0100
>>
>>       drm/amdgpu: also reroute VMC and UMD to IH ring 1 on Vega 20
>>
>>       Same patch we alredy did for Vega10. Just re-route page faults to=
 a
>> separate
>>       ring to avoid drowning in interrupts.
>>
>>> If I re-launch the same set of shaders after the GPU has soft-recovere=
d,
>>> the "amdgpu: IH ring buffer overflow" message is missing, even though
>>> the same amount of page faults should've been triggered at roughly the
>>> same rate. Running with this patch applied makes more "amdgpu: IH ring
>>> buffer overflow" messages appear after relaunching the faulting shader=
s
>>> (but not when processing any non-faulting work).
>> That is actually the expected behavior. There should be a limit on the
>> number of faults written to the ring so that the ring never overflows.
>>
>>> The only possible conclusion I can draw from this is that clearing tha=
t
>>> bit *does* have an effect, and I don't think it's far-fetched to assum=
e
>>> the IH ring buffer overflows still happen after re-launching the
>>> faulting shaders but go undetected so far.
>> Well that can only mean that the hw documentation is incorrect.
>>
>> Either the value is not write only trigger bit as documented or we need
>> an additional read of the register for it to take effect or something
>> like this.
>>
>>>>> Right now, IH overflows, even if they occur repeatedly, only get
>>>>> registered once. If not registering IH overflows can trivially lead =
to
>>>>> system crashes, it's amdgpu's current handling that is broken.
>>>> It's years that we last tested this but according to the HW
>>>> documentation this should work fine.
>>>>
>>>> What could potentially happen is that the IH has silenced the source
>>>> of the overflow. We never implemented resetting those, but in this
>>>> case that here won't help either.
>>>>
>>> If the IH silenced the page faults (which quite clearly cause the
>>> overflow here), then how are the page faults still logged in dmesg?
>> There should be a hardware rate limit for the page faults, e.g. there
>> can only be X faults reported in N clock cycles and then a delay is
>> inserted.
> @Christian Koenig  Is that tied to xnack (i.e., noretry)?  The default
> is noretry=3D1 on gfx10.3 and newer.  But it can be overridden.  It was
> not set on some older kernels, maybe that is the problem?  @Friedrich
> Vock does setting amdgpu.noretry=3D1 fix the issue?


No, amdgpu.noretry=3D1 does not change anything.

Regards,
Friedrich

> Alex
>
>>>>> The possibility of a repeated IH overflow in between reading the wpt=
r
>>>>> and updating the rptr is a good point, but how can we detect that at
>>>>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
>>>>> then, because we're guaranteed to miss any overflows that happen whi=
le
>>>>> the bit is set.
>>>> When an IH overflow is signaled we clear that flag by writing 1 into
>>>> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>>>>
>>>> What can of course happen is that the IH ring buffer overflows more
>>>> than this single entry and we process IVs which are potentially
>>>> corrupted, but we won't miss any additional overflows since we only
>>>> start processing after resetting the flag.
>>>>
>>>> An IH overflow is also something you should *never* see in a
>>>> production system. This is purely for driver bringup and as fallback
>>>> when there is a severe incorrect programming of the HW.
>>>>
>>>> The only exception of that is page fault handling on MI products
>>>> because of a hardware bug, to mitigate this we are processing page
>>>> faults on a separate IH ring on those parts.
>>>>
>>>> On all other hw generations the IH should have some rate limit for th=
e
>>>> number of faults generated per second, so that the CPU is always able
>>>> to catch up.
>>> I'm wondering if there is another bug in here somewhere. Your
>>> explanation of how it's supposed to work makes a lot of sense, but fro=
m
>>> what I can tell it doesn't work that way when I test it.
>>>
>>>  From the printk_ratelimit stats it would seem like >2000 faults arriv=
e
>>> in less than a second, so perhaps your theory about fault interrupt
>>> ratelimiting not working is correct (but it's hard for me to verify wh=
at
>>> is going on without the documentation).
>> I'm going to ping the relevant engineer and putting someone on the task
>> to take a look.
>>
>> Thanks,
>> Christian.
>>
>>> Regards,
>>> Friedrich
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Friedrich
>>>>>
>>>>>> When you clear the overflow again when updating the RPTR you could
>>>>>> loose another overflow which might have happened in between and so
>>>>>> potentially process corrupted IVs.
>>>>>>
>>>>>> That can trivially crash the system.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>    }
>>>>>>>
>>>>>>>    static int cik_ih_early_init(void *handle)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>> index b8c47e0cf37a..076559668573 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
>>>>>>> *adev,
>>>>>>>        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> -
>>>>>>> +    ih->overflow =3D true;
>>>>>>>
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_dev=
ice
>>>>>>> *adev,
>>>>>>>    static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>> +
>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    static int cz_ih_early_init(void *handle)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>> index aecad530b10a..1a5e668643d1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> -
>>>>>>> +    ih->overflow =3D true;
>>>>>>>
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                    struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>> +
>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    static int iceland_ih_early_init(void *handle)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>> index d9ed7332d805..ce8f7feec713 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_devi=
ce
>>>>>>> *adev,
>>>>>>>        tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>> +    ih->overflow =3D true;
>>>>>>> +
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>    }
>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>
>>>>>>>        if (ih->use_doorbell) {
>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>            ih_regs =3D &ih->ih_regs;
>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>> index 8fb05eae340a..668788ad34d9 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_devi=
ce
>>>>>>> *adev,
>>>>>>>        tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>> +    ih->overflow =3D true;
>>>>>>> +
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>    }
>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>
>>>>>>>        if (ih->use_doorbell) {
>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>            ih_regs =3D &ih->ih_regs;
>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>> index e64b33115848..0bdac923cb4d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>        tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>> +    ih->overflow =3D true;
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>    }
>>>>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>
>>>>>>>        if (ih =3D=3D &adev->irq.ih_soft)
>>>>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>            ih_regs =3D &ih->ih_regs;
>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
>>>>>>> *adev,
>>>>>>>            tmp =3D RREG32(IH_RB_CNTL);
>>>>>>>            tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>            WREG32(IH_RB_CNTL, tmp);
>>>>>>> +        ih->overflow =3D true;
>>>>>>>        }
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>    }
>>>>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_dev=
ice
>>>>>>> *adev,
>>>>>>>    static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>> +
>>>>>>>        WREG32(IH_RB_RPTR, ih->rptr);
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32(IH_RB_CNTL);
>>>>>>> +        tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>> +        WREG32(IH_RB_CNTL, tmp);
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    static int si_ih_early_init(void *handle)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>> index 917707bba7f3..6f5090d3db48 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_dev=
ice
>>>>>>> *adev,
>>>>>>>        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> +    ih->overflow =3D true;
>>>>>>>
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>> +
>>>>>>>        if (ih->use_doorbell) {
>>>>>>>            /* XXX check if swapping is necessary on BE */
>>>>>>>            *ih->rptr_cpu =3D ih->rptr;
>>>>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>        } else {
>>>>>>>            WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    static int tonga_ih_early_init(void *handle)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>> index d364c6dd152c..bb005924f194 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>        tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>> +    ih->overflow =3D true;
>>>>>>>
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>
>>>>>>>        if (ih =3D=3D &adev->irq.ih_soft)
>>>>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>            ih_regs =3D &ih->ih_regs;
>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>> index ddfc6941f9d5..bb725a970697 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>        tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>> +    ih->overflow =3D true;
>>>>>>>
>>>>>>>    out:
>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>    static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>    {
>>>>>>> +    u32 tmp;
>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>
>>>>>>>        if (ih =3D=3D &adev->irq.ih_soft)
>>>>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>            ih_regs =3D &ih->ih_regs;
>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>        }
>>>>>>> +
>>>>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLE=
AR
>>>>>>> bit),
>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>> +     */
>>>>>>> +    if (ih->overflow) {
>>>>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEA=
R,
>>>>>>> 0);
>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>> +        ih->overflow =3D false;
>>>>>>> +    }
>>>>>>>    }
>>>>>>>
>>>>>>>    /**
>>>>>>> --
>>>>>>> 2.43.0
>>>>>>>
