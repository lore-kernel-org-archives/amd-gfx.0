Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6001CC47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 11:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31C010E730;
	Tue, 23 Jan 2024 11:35:18 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5E610E730
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 11:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706009705; x=1706614505; i=friedrich.vock@gmx.de;
 bh=9HGjSAbdsYBGmExs58cQcEOjygAMXItJ7/2ktY5IsNc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=EHsxgMqQ6HOjT8T82O5opdcmbYJoBOKupWPXiK1wB3ckv9FXku7H5nWmGaoHyjj3
 BGM4ZMvdIxFvn3a0jYHKHlHgH91SX5NlsrZY1/soywSfzp1Z8UdhNg64bPHo2d5qz
 3Hkg4wb87I5BjQuhry7gMqBAiDrfrdteN9yWhQa+WbRWvw3LjRiS9orgfNuTraK90
 D0AlayAJ+IS8NQ0EUoBMH6Qkwu0unPDzcPhQlR/4qg/RiCmt4Q7y+5ghWw8Xe+yyw
 gq1rG5+tw75eQ84nhC1szaLhZnMA4d1AlhWX9b9su3D1JN4FgmHzdIyI+s31k6bMy
 Va5NuEZj6w4DsuRSfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.113.218]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1rMik83oto-00EOYo; Tue, 23
 Jan 2024 12:35:05 +0100
Message-ID: <e8d1bca4-61f1-4b44-b70b-c66f8b095860@gmx.de>
Date: Tue, 23 Jan 2024 12:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>, Felix Kuehling <felix.kuehling@amd.com>,
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
 <60efdecd-0957-4e06-9f1e-7343dff87a8a@gmx.de>
 <098e975b-2271-4f11-9549-40bc2c444a28@gmx.de>
 <d45b23d1-ab1d-4285-8b18-a0eebaa2d871@amd.com>
 <dc8506c4-9114-473e-bfdc-8a24f2264392@froggi.es>
 <2906c98e-47fe-4a39-b32d-9d060d571076@amd.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <2906c98e-47fe-4a39-b32d-9d060d571076@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QmufN9iw/rOhlWIP5uu6Z9h2fKRZzaOhUEDJwuRAlzfQ6WNsKy7
 hlDFAHgENo5nuHybjhe9IlBXm4J6oyy+rL0R3V+F6woyNtJJ8ydv6deAWaxQkpWwnkyhGwc
 xxNoHrYLDCjmlrQTNSzYh/PZSd5+rOyW8A3DKG83DPevINs0N+qnWBta0M5aLblqZUueEmH
 ZRt7TlPy7yi0SMe646xtw==
UI-OutboundReport: notjunk:1;M01:P0:ow7peAaBgJA=;IUXe8r0B5BEQWTl2a2TC7C1lS/L
 ydxnome/db9TW22QaJusuZam/Da/+U3xves5mcvT3PH1NFQuIS8ak8l3QslglX14evyvFgaI0
 2wmlAaX3d41VZvAk0yPkNC4KlAisLQ1gfBCvNFVLAdjkjIRwTNofroz/fJGQyKBVww6SBo+KT
 k2A0cIVNRvu3myzUo2Kpl2ajM2JHIKoHURtvNDURpQHaQUHNiEaT1EX4JFQtEt1X9R8ZHnqid
 /BQAQ6SUUL08T1wdulHiKcCbI6oZwSvLhVBCs85o2TIUnAC17rRnxVHPztl/AgitJmrop9ADH
 Y4H+3zt9O8+OloSb1VJ9GqDHo/eRYYymZOyUx9YAizEqkKqLkYaXrncFoQwGW0HR0L2N4i/uC
 FeJtiGWSryHHXu+lXaMIqstIA1uZasQOeBxeRghUpSW7yWQ1JZN6lrGkbWk133HQe4pEL40c8
 zaAvntXCUVwI200b0UyRpi4aZMzXcxACxC98ilOTW6/PcfZjXz92T4nlqdGzyWXtlUtjmH82v
 j4ovYgUTHuPU+DvMIq2ubbHf6GxTR7odnavEfw4caNb2Q/3vYH61lm/2NEwmhSWnfJw2BfVQG
 GzDccOu5LUgbEesYFvjFBoroB/d0WxfLH3HIP4hFTF0+IoiTFRamesuSjC5cb5bSOyEjUdJ+P
 SjYa/MF20ojc+cxMl9iXUuwU3CyByNL/SdXG/OfeFVzzZaPkydI7XHPO5sZbnCIoGFV0h1IRy
 LOJABoDUhV27yLTeEm6NXv5tElxdabkzcG3YypePnJNVgQ3YPsZWKo+A9+yeHKMrHfBrhE6pc
 DND3LguUu2qAZoM6oZ1Bh9La9Ihfb1PXOacueDR0HU0t0uwKyaykMbAIlHikj+u6/roOADUTR
 bljH8XhWUPOZKNTRKlDT8+QfehndpMGeQ71mrcsdSomlR9OHw+LdEjM4/ymFRZOJ1cBQKCbsr
 3YVA3I9ZWkfVaTBQsCvY7LfvtK8=
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 23.01.24 10:36, Christian K=C3=B6nig wrote:
>
>
> Am 22.01.24 um 23:39 schrieb Joshua Ashton:
>> [SNIP]
>>>>
>>>> Most work submissions in practice submit more waves than the number o=
f
>>>> wave slots the GPU has.
>>>> As far as I understand soft recovery, the only thing it does is
>>>> kill all
>>>> active waves. This frees up the CUs so more waves are launched, which
>>>> can fault again, and that leads to potentially lots of faults for a
>>>> single wave slot in the end.
>>>
>>> Exactly that, but killing each wave takes a moment since we do that
>>> in a loop with a bit delay in there.
>>>
>>> So the interrupt handler should at least in theory have time to
>>> catch up.
>>
>> I don't think there is any delay in that loop is there?
>
> Mhm, looks like I remember that incorrectly.
>
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0while (!dma_fence_is_signaled(fence) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_to_n=
s(ktime_sub(deadline, ktime_get())) > 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring->funcs->soft_recovery(r=
ing, vmid);
>>
>> (soft_recovery function does not have a delay/sleep/whatever either)
>>
>> FWIW, two other changes we did in SteamOS to make recovery more
>> reliable on VANGOGH was:
>>
>> 1) Move the timeout determination after the spinlock setting the
>> fence error.
>
> Well that should not really have any effect.
>
>>
>> 2) Raise the timeout from 0.1s to 1s.
>
> Well that's not necessarily a good idea. If the SQ isn't able to
> respond in 100ms then I would really go into a hard reset.
>
> Waiting one extra second is way to long here.

Bumping the timeout seemed to be necessary in order to reliably
soft-recover from hangs with page faults. (Being able to soft-recover
from these is actually a really good thing, because if e.g. games
accidentally trigger faults, it won't kill a user's entire system.)

However, the bump I had in mind was more moderate: Currently the timeout
is 10ms (=3D0.01s). Bumping that to 0.1s already improves reliability
enough. I agree that waiting a full second before giving up might be a
bit too long.

Regards,
Friedrich

>
> Regards,
> Christian.
>
>>
>> - Joshie =F0=9F=90=B8=E2=9C=A8
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>> Friedrich
>>
>
