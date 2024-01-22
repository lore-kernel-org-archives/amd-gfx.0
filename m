Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF4CC4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 10:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60AC10E672;
	Mon, 22 Jan 2024 10:21:38 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8392810E672
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705918885; x=1706523685; i=friedrich.vock@gmx.de;
 bh=Kcnm/u3J9pXQg1A9T4nI0I4MORqnQGH1crZyNfaFHfg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=sAwMhCsIbWkJJkPxQ4JDvyPWc5eqgUVdzU4BHvCrKe0/UyHbhn/+XlNPvs4Aoudn
 xxziw/0ezjJLleFijDBuS4ST1mteiJKoMGqCHWZwDi/+P9e2KJ+L6dNo+KK9xvw5i
 Bb2zUx545DyT1FIhHRkYipDaOyAMg+Ft1iS4EBSk6fgKgOtdLn2rlFa20puViZTYK
 ZnW5tQxTprnKeVyijtbSmu1heEcLim3Bkqn69mMnnGdSDHznGm9CazjIMgdiPrjW/
 0mTe0UudC8RM13+vEwjQpeYBHBwhQOKxRUPxixclbQjSLlC8Tcb0Bm42ShM7XwPAr
 aPucDq7Lt1g2dWMOVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1rjyPq3cr8-00Pxf9; Mon, 22
 Jan 2024 11:21:25 +0100
Message-ID: <60efdecd-0957-4e06-9f1e-7343dff87a8a@gmx.de>
Date: Mon, 22 Jan 2024 11:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
 <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
 <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 xsDNBGPTxTYBDACuXf97Zpb1IttAOHjNRHW77R759ueDHfkZT/SkWjtlwa4rMPoVdJIte9ZY
 +5Ht5+MLdq+Pjd/cbvfqrS8Q+BBwONaVzjDP35lQdim5sJ/xBqm/sozQbGVLJ/szoYhGY+va
 my9lym47Z14xVGH1rhHcXLgZ0FHbughbxmwX77P/BvdI1YrjIk/0LJReph27Uko8WRa3zh6N
 vAxNk6YKsQj4UEO30idkjmpw6jIN2qU7SyqKmsI+XnB9RrUyisV/IUGGuQ4RN0Rjtqd8Nyhy
 2qQGr8tnbDWEQOcdSCvE/bnSrhaX/yrGzwKoJZ8pMyWbkkAycD72EamXH13PU7A3RTCrzNJa
 AKiCvSA9kti4MRkoIbE+wnv1sxM+8dkDmqEY1MsXLTJ4gAkCnmsdGYz80AQ2uyXD06D8x/jR
 RcwbRbsQM5LMSrXA0CDmNXbt5pst7isDbuoBu1zerqy2ba+rf6sxnSnCzQR6SuE0GB7NYV8A
 lrNVyQlMModwmrY2AO3rxxcAEQEAAc0mRnJpZWRyaWNoIFZvY2sgPGZyaWVkcmljaC52b2Nr
 QGdteC5kZT7CwQ4EEwEIADgWIQT3VIkd33wSl/TfALOvWjJVL7qFrgUCY9PFNgIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgAAKCRCvWjJVL7qFro7GC/9PfV0ICDbxBoILGLM6OXXwqgoC
 HkAsBEXE/5cS68TT++YXMHCetXpFfBIwTe8FlBcbhtylSYIUhFLmjiGfgoXy5S87l9osOp1G
 y3+RNbFoz4OJvqcXX5BqFK5KHh7iL/Q6BaZB9u3es0ifFt5YMwhDgcCbYaLUlTPbl+5m+/ie
 Eori0ASylvhz3EdB11sMqN9CmoKvBEVnkdiydDMuFvpEi08WB8ZC8qckiuwrLOIa4/JB54E2
 QyGw0KgBT4ApeMmkKurS3UOsrAwoKKP/0rgWsBFVnXrBIOEL+7/HGqSSDboLAjt1qE967yxM
 3Qzt1FUBU9db2biFW7O3TmXP31SyPwVYWfeETa4MT9A8EyjfWF66+sfPXREsBvqRTin3kEst
 IlbMdSNijCjKZz9XPCaKwx3hJaD5VEs3gPsKa9qXOQftfTqt+SI0nYBw3sdT2+wWJCeyZ3aE
 L0Us8uMILncTxVAhX2a8pUvGrbtuyW2qqEFId1OSfWlrLZEuv8+631fOwM0EY9PFNgEMAKx2
 G48lrQ1bLAWgjq3syyswS80e70M+/Fbxb2aBKRHw5XbpSPYr9FLE3MPdgvUtt+fiK2xA69bk
 i86sfSV2KNhRuiS2rb1h/jfmTlxfimBezHv6xnzVuHJNd87vL35lqd0D6B5zvnzzP9CjpXq/
 o7isfiA2FMSOI1OnrHEw9pbEd1B26cgS+mIGhDf/gBI6MtsPuN8xMUyybtpUSSVi3b4oRkge
 +vwwbMn+vwvhN39kjcISAT+jFWNupDybFIs8cYNWA7MkWJAIuqSjMydE0l1+c8eF7nnvzY2o
 2GGarFmxNO4CHuh3JoMFfY4wlKjmDlk+FJ5UfIFelVmOiVPLGrSL8ggcubnOS75VjDvDTQgY
 tjDvLuUmOj1vYSmPSE9PjDMhrpx1LcSOHyV+aX0NQeHP869A/YLjwQbOJBJVIN+XdsGlnwG5
 teXXxU9uwFDqYPAneHp4As5OKovOCIzNj6EB4MIZIpTGgYQBIN4xrwL0YsjvPm2i1RyBPTpf
 UKvjVQARAQABwsD2BBgBCAAgFiEE91SJHd98Epf03wCzr1oyVS+6ha4FAmPTxTYCGwwACgkQ
 r1oyVS+6ha4Hlgv/Z2q6pSxeCjK/g20vub8Gvg09jNYAle3FTaJD2Jd/MhUs6s9Y5StWtiDf
 hw27O8bhJan1W4hrngQceR2EcvKxejroVhu3UI2b9ElM5aphD2IolOWqfwPXeUetIgaMNqTl
 GJ9rGx+k8HCpchW4QVZfWn7yM+IymCwOYov+36vMMHd8gdQ0BxMiT2WLDzCWwDb+/PYMfOiq
 AoPBV5EQ2K3x85wl9N4OxiQdGWi9+/0KJyMPYoGlFqCdPdvvbpFe4XD6YOBr3HmVOFCWtLcW
 Bm+BCucpo93VhjNVqZ+cuN/tlS+Px8kl0qW9J3Q8fwWhgz69v5YdiOczQza/zQu3YrcYapBD
 kQXSmDju1Yd4jIGeZ8vf+dnmbX78mpj3nBmYLhIs5lszAH634uoWyJqMLs77WG1pkk0utvwh
 Zvq4r6fbLIuofLsboYKQxUJuX5uRSK4/hWXEETUTxxvkA/hiuhsdMbDWIZWFp8yuoZvR2itT
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2O1LviDAyPiag7cg547qIixzhdUCvpVX0lbSG/8oot/bbz8/H0w
 IyVwunMuoSVgsxEZhBHW6YEA7Ie1YjGoXoDW3Oql9KhUy6J0PCUe5ILQPGqQr60bthQUamr
 xnpBnBT4r8VfdJunYnqNOfSDZGs/8RLANTaJVbAbKJdypt50y3wYLx57t6PVVPGNSPotNDw
 NegQ6JO7L+I3vlla5n7/w==
UI-OutboundReport: notjunk:1;M01:P0:chd1QhZ8h1M=;LgogizQQIQlZPyAmHhBknH4YPLw
 eV22tTyLvMQssM5+XgLvumUuBM25Gy8/gQktDvyNgJyil5iu68D8naDxNMCtrAT++0yCR6SNH
 3kfsr37VoI9n8yLU4xpHRGxLmyucplx6esnmlh3CXHJQBWSWUtRf6/qMVhap05SwSgPixxLhL
 Q6i2+Y6LDHEgFmwvpgsFh07PPc+eqTCL7xqJ6c3h6FgnC1coxxZBJ/nmoYaXPFV2fkBVTlCK5
 Vxhuk2h6ACJwxiwa/YB6O4HrO0W1TBSEExcSGLvtVND9tCtPdAeqINb1Kc2DHktd5yxrF0Uhb
 Jh97fFIrZIXX+H77pXfktGXUibjeRn8I4DA+0GCtb8cZMw7OPO6N1hBgKx6do5BRP4J1TSVd1
 E/ZQIi5Q79NhzuqnFadaVFtMhR16t3u2WlcFkzdu/WuIvBwZJ7no7tpEYU/LmWL/2VLzwBbmQ
 /P765Jn0Faa2A4DejfVX3tspKCmWqn5GUgn7VjFAscSlEXIfzplhpVdUew3sjZWfrUIHl9TVU
 hfnhAkcVxNDC6ZutVUEVajokH99LFc4dGQ5RH6eZJk3j8SpUCxlCeiDPK6Klvpg2tQSRC+pBf
 UcZ4Wxyk/OcWciEehX+H/Cm5FI9qOzcTr6bt9EMpsqiRrQcXuR811VVIz9rjPi6UvLNc/c9mg
 Hm+OiQwhjieOwy4VxL4iOzlVc2TnKExfecGmNhQO6LebtIoywtkxBasz6FWafRjasqwm4GGFE
 UXAKpQInWQsebjWjlGzn57RgeXC/0AslUnrZfIuVbFs7U1DCm6mIM/h0MXw/u9zty76/Il7lu
 WtixkXH7Y0oNZ/MNrzOgDDtXSHMwQZuGYK8unalU+VytQLcNhdV16iBEvIxspembytc96ioKi
 84MNkgywUeAXYjom8+vvxWbew29jJFzr20sN0TwO7oLVYxKKcSSpj/VnZbecfGTG1vbLrbHRV
 x8s3+HTUIlvM8yfNKtjnT6eYcHM=
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

On 22.01.24 11:10, Christian K=C3=B6nig wrote:
> Am 19.01.24 um 20:18 schrieb Felix Kuehling:
>> On 2024-01-18 07:07, Christian K=C3=B6nig wrote:
>>> Am 18.01.24 um 00:44 schrieb Friedrich Vock:
>>>> On 18.01.24 00:00, Alex Deucher wrote:
>>>>> [SNIP]
>>>>>>>>> Right now, IH overflows, even if they occur repeatedly, only get
>>>>>>>>> registered once. If not registering IH overflows can trivially
>>>>>>>>> lead to
>>>>>>>>> system crashes, it's amdgpu's current handling that is broken.
>>>>>>>> It's years that we last tested this but according to the HW
>>>>>>>> documentation this should work fine.
>>>>>>>>
>>>>>>>> What could potentially happen is that the IH has silenced the
>>>>>>>> source
>>>>>>>> of the overflow. We never implemented resetting those, but in thi=
s
>>>>>>>> case that here won't help either.
>>>>>>>>
>>>>>>> If the IH silenced the page faults (which quite clearly cause the
>>>>>>> overflow here), then how are the page faults still logged in dmesg=
?
>>>>>> There should be a hardware rate limit for the page faults, e.g.
>>>>>> there
>>>>>> can only be X faults reported in N clock cycles and then a delay is
>>>>>> inserted.
>>>>> @Christian Koenig=C2=A0 Is that tied to xnack (i.e., noretry)? The d=
efault
>>>>> is noretry=3D1 on gfx10.3 and newer.=C2=A0 But it can be overridden.=
 It was
>>>>> not set on some older kernels, maybe that is the problem? @Friedrich
>>>>> Vock does setting amdgpu.noretry=3D1 fix the issue?
>>>>
>>>>
>>>> No, amdgpu.noretry=3D1 does not change anything.
>>>
>>> Well the good news first the hw engineer answered rather quickly.
>>> The bad news is that the hardware really doesn't work as documented
>>> in multiple ways.
>>>
>>> First of all the CLEAR bit is a level and not a trigger, so the
>>> intention to clear it is indeed correct. For now please modify this
>>> patch so that the CLEAR bit is set and cleared directly after
>>> setting it, this way we should be able to detect further overflows
>>> immediately.
>>>
>>> Then the APU the Steam Deck uses simply doesn't have the filter
>>> function for page faults in the hardware, the really bad news is it
>>> also doesn't have the extra IH rings where we could re-route the
>>> faults to prevent overflows.
>>>
>>> That full explains the behavior you have been seeing, but doesn't
>>> really provide a doable solution to mitigate this problem.
>>>
>>> I'm going to dig deeper into the hw documentation and specification
>>> to see if we can use a different feature to avoid the overflow.
>>
>> If we're not enabling retry faults, then each wave front should
>> generate at most one fault. You should be able to avoid overflows by
>> making the IH ring large enough to accommodate one fault per wave front=
.
>
> That is the exact same argument our HW engineers came up with when we
> asked why the APU is missing all those nice IH ring overflow avoidance
> features the dGPUs have :)
>
I can reproduce IH overflows on my RX 6700 XT dGPU as well FWIW.

> The only problem with this approach is that on Navi when a wave is
> blocked by waiting on a fault you can't kill it using soft recovery
> any more (at least when my understanding is correct).
>
Killing page-faulted waves via soft recovery works. From my testing on
Deck, it seems to take a bit of time, but if you try for long enough
soft recovery eventually succeeds.

Regards,
Friedrich

>>
>> If the faults are coming from SDMA, that may be another problem. I'm
>> not sure whether it can generate multiple no-retry faults from the
>> same queue.
>
> Regarding faults the SDMA is relatively harmless compared to the 3D
> engine, IIRC the resolve queue is something like 128 entries deep. So
> you never see more than those 128 faults if I'm not completely mistaken.
>
> Sunil is setting up a test system for this in an AMD lab and will play
> around with a few HW features to mitigate the issue. I still hope that
> we can completely avoid the overflow altogether.
>
> Regards,
> Christian.
>
>>
>> Regards,
>> =C2=A0 Felix
>>
>>
>>>
>>> Thanks,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> Friedrich
>>>>
>>>>> Alex
>>>>>
>>>>>>>>> The possibility of a repeated IH overflow in between reading
>>>>>>>>> the wptr
>>>>>>>>> and updating the rptr is a good point, but how can we detect
>>>>>>>>> that at
>>>>>>>>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit
>>>>>>>>> at all
>>>>>>>>> then, because we're guaranteed to miss any overflows that
>>>>>>>>> happen while
>>>>>>>>> the bit is set.
>>>>>>>> When an IH overflow is signaled we clear that flag by writing 1
>>>>>>>> into
>>>>>>>> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>>>>>>>>
>>>>>>>> What can of course happen is that the IH ring buffer overflows
>>>>>>>> more
>>>>>>>> than this single entry and we process IVs which are potentially
>>>>>>>> corrupted, but we won't miss any additional overflows since we
>>>>>>>> only
>>>>>>>> start processing after resetting the flag.
>>>>>>>>
>>>>>>>> An IH overflow is also something you should *never* see in a
>>>>>>>> production system. This is purely for driver bringup and as
>>>>>>>> fallback
>>>>>>>> when there is a severe incorrect programming of the HW.
>>>>>>>>
>>>>>>>> The only exception of that is page fault handling on MI products
>>>>>>>> because of a hardware bug, to mitigate this we are processing pag=
e
>>>>>>>> faults on a separate IH ring on those parts.
>>>>>>>>
>>>>>>>> On all other hw generations the IH should have some rate limit
>>>>>>>> for the
>>>>>>>> number of faults generated per second, so that the CPU is
>>>>>>>> always able
>>>>>>>> to catch up.
>>>>>>> I'm wondering if there is another bug in here somewhere. Your
>>>>>>> explanation of how it's supposed to work makes a lot of sense,
>>>>>>> but from
>>>>>>> what I can tell it doesn't work that way when I test it.
>>>>>>>
>>>>>>> =C2=A0From the printk_ratelimit stats it would seem like >2000 fau=
lts
>>>>>>> arrive
>>>>>>> in less than a second, so perhaps your theory about fault interrup=
t
>>>>>>> ratelimiting not working is correct (but it's hard for me to
>>>>>>> verify what
>>>>>>> is going on without the documentation).
>>>>>> I'm going to ping the relevant engineer and putting someone on
>>>>>> the task
>>>>>> to take a look.
>>>>>>
>>>>>> Thanks,
>>>>>> Christian.
>>>>>>
>>>>>>> Regards,
>>>>>>> Friedrich
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Friedrich
>>>>>>>>>
>>>>>>>>>> When you clear the overflow again when updating the RPTR you
>>>>>>>>>> could
>>>>>>>>>> loose another overflow which might have happened in between
>>>>>>>>>> and so
>>>>>>>>>> potentially process corrupted IVs.
>>>>>>>>>>
>>>>>>>>>> That can trivially crash the system.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 static int cik_ih_early_init(void *handle)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>>> index b8c47e0cf37a..076559668573 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>>>>>>>>> -
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void cz_ih_set_rptr(struct amdgpu_device *=
adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> +
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->=
rptr);
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmI=
H_RB_CNTL);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNT=
L, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 static int cz_ih_early_init(void *handle)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>>> index aecad530b10a..1a5e668643d1 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>>>>>>>>> -
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void iceland_ih_set_rptr(struct amdgpu_dev=
ice *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih=
)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> +
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->=
rptr);
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmI=
H_RB_CNTL);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNT=
L, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 static int iceland_ih_early_init(void *handle)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>>> index d9ed7332d805..ce8f7feec713 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_=
regs->ih_rb_cntl);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih=
_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>> +
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void ih_v6_0_set_rptr(struct amdgpu_device=
 *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih=
_regs;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>>>>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
h_regs =3D &ih->ih_regs;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_=
KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 /**
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>>> index 8fb05eae340a..668788ad34d9 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_=
regs->ih_rb_cntl);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih=
_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>> +
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void ih_v6_1_set_rptr(struct amdgpu_device=
 *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih=
_regs;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>>>>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
h_regs =3D &ih->ih_regs;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_=
KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 /**
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>>> index e64b33115848..0bdac923cb4d 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_=
regs->ih_rb_cntl);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih=
_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void navi10_ih_set_rptr(struct amdgpu_devi=
ce *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih=
_regs;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.=
ih_soft)
>>>>>>>>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
h_regs =3D &ih->ih_regs;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_=
KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 /**
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
mp =3D RREG32(IH_RB_CNTL);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
mp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(IH_RB_CNTL, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D t=
rue;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void si_ih_set_rptr(struct amdgpu_device *=
adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> +
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_RPTR, ih->rp=
tr);
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(IH_=
RB_CNTL);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp &=3D ~IH_RB_CN=
TL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_CNTL,=
 tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 static int si_ih_early_init(void *handle)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>>> index 917707bba7f3..6f5090d3db48 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device
>>>>>>>>>>> *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void tonga_ih_set_rptr(struct amdgpu_devic=
e *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu=
_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> +
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* XXX check if swapping is necessary on BE */
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
ih->rptr_cpu =3D ih->rptr;
>>>>>>>>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmI=
H_RB_CNTL);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNT=
L, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 static int tonga_ih_early_init(void *handle)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>>> index d364c6dd152c..bb005924f194 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_=
regs->ih_rb_cntl);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih=
_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void vega10_ih_set_rptr(struct amdgpu_devi=
ce *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih=
_regs;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.=
ih_soft)
>>>>>>>>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
h_regs =3D &ih->ih_regs;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_=
KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 /**
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>>> index ddfc6941f9d5..bb725a970697 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_=
regs->ih_rb_cntl);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih=
_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 out:
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_ma=
sk);
>>>>>>>>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0 static void vega20_ih_set_rptr(struct amdgpu_devi=
ce *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
amdgpu_ih_ring *ih)
>>>>>>>>>>> =C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih=
_regs;
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.=
ih_soft)
>>>>>>>>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
h_regs =3D &ih->ih_regs;
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=
REG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus s=
et the
>>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>>> bit),
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overf=
lows if they occur.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_=
KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FI=
ELD(tmp, IH_RB_CNTL,
>>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>>> 0);
>>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D f=
alse;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>>>
>>>>>>>>>>> =C2=A0=C2=A0 /**
>>>>>>>>>>> --
>>>>>>>>>>> 2.43.0
>>>>>>>>>>>
>>>
>
