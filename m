Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB03BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 11:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456CF10E205;
	Mon, 25 Apr 2022 11:20:56 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E374810E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:20:54 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id bv19so28948064ejb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9/dX9giPqh60+9WMKdjgpZYSQLchsN/BOYTohfmybwc=;
 b=PPUwq3tPE1RSXcE8SP2wg1oA0aTCkkzeLc0+GYoTgtJKc8nttmXpfSCXd7Xa3bd1k9
 KELhsIpkLL6euIZ2QWRVc+Fi8cl24fdripMyRvCOOnYFwWLPb+sxFZbPQwIs+oBAr3kF
 3KKZIYC531+PTgzgNSA8XYeaih+PWUQfdak7ZenKcCYryFItvAqIRg7eCWJkSM6nldW2
 zKDdtmljcwUBmyQim9nIr0VTjQDcmTm1dWe4FPTew/WV8hwSzH2uOiYpQB/sVGmUGQJx
 RaFm29K/+jDUkDf8boRAyQPideMBjJzBitzMRirnWPcHthzKUm+bqi7Q20/0n1ivzv23
 8G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9/dX9giPqh60+9WMKdjgpZYSQLchsN/BOYTohfmybwc=;
 b=CTbLJxl4rtpTaiqfVi6etddpgYYCellZ1krnYvD9rZq7+vKUvADFb2fDKc5K7o9XVw
 qwie2P4mkMdoi43wHyX7fD1+LzCEdcC/xqoSZ4r7t5/cwYJCqJY8wjfQImBA0bLcR1JE
 1qXjm2uZUhK74f2yLIvC3Ox5l3Qb03tqcsB7Cgl2d4tYOdOejjThRUltQ8mPYwGOdMwQ
 IgRFhs3okvVt+3uPgDoXbBs433tTKP1XgKSMVTVoB2at9KJz1GA6RsOjx70XgOQ54vsI
 T39egpkg3LRpTqOGp4LHPPPkWkCDxii6MUhUuMP/hxt4R6OCZ4/HDc6eaY14tq2x4bw0
 nitw==
X-Gm-Message-State: AOAM532YkCncG02W1jbL5greLe73GnHj+mLWkcnh8Fno3/KQygKOWlg3
 lfaAuww0zcGtSCOdox16Bpk=
X-Google-Smtp-Source: ABdhPJxSGaVTXAfT20CNF0kAvlYZ38I0QxKDCdzvY/KskkSrd/NWI0jbkFhlLpBdgDfJn/6Z6n8fTQ==
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr4158993ejc.524.1650885653353; 
 Mon, 25 Apr 2022 04:20:53 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:7284:dbdc:d72b:7ea1?
 ([2a02:908:1252:fb60:7284:dbdc:d72b:7ea1])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a170906785000b006f2d8530459sm3351983ejm.112.2022.04.25.04.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 04:20:52 -0700 (PDT)
Message-ID: <a539d83a-d83d-a99a-7a12-f9183569bbbc@gmail.com>
Date: Mon, 25 Apr 2022 13:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Set the 64-bit address of the wptr of SDMA doorbell
 properly
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>
References: <CAHpOOhHuoZzFfXgM35b65pXxAtFoyTFKGYGO2NT7kKZ1-oNN9A@mail.gmail.com>
 <16232337-ce8f-70e1-169b-6ff8d78e2d39@gmail.com>
 <CAHpOOhHDdkXgUGj-3_nPKk0pYoEVEpHFrt+ixhnG8RDU57fVGQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhHDdkXgUGj-3_nPKk0pYoEVEpHFrt+ixhnG8RDU57fVGQ@mail.gmail.com>
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
Cc: emily.deng@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.22 um 13:14 schrieb Haohui Mai:
> Sorry for the confusion. I misread the code, but it still seems to me
> it is a valid issue. What the patch tries to do is to fix the
> following pattern:
>
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));

Ah, yes that's indeed a bug.

>
> I agree with you that ring->wptr is an offset to the ring. Just
> looking at the above lines it seems that they are incorrect when
> ring->wptr is larger than 1GB.
>
> As you pointed out that ring->wptr cannot be larger than (1 << 24), it
> can be resolved via either (1) fixing the patterns in the provided
> patch, or (2) clamping the results to (1 << 24) - 1 and getting rid of
> lower_32_bits() / higher_32_bits() at all.
>
> What's your suggestion of moving forward?

It depends on the hardware generation. We used to have a bunch of older 
hardware where the wptr was one 32bit register where actually only 16,20 
or 24bits where used.

Then we have the newer hardware which has two 32bit registers for the 
WPTR and those really have 64bits in them.

Clamping the value actually doesn't much sense because the hardware will 
do it anyway and if the value is larger than supported it won't work 
either way.

So my suggestion is that you generate one patch where you fix all the 
lower/upper and shift mixup for the 64bit cases.

And then maybe another patch where all the lower+masking for the 32bit 
cases is removed as a cleanup.

Regards,
Christian.

>
> Thanks,
> Haohui
>
> On Mon, Apr 25, 2022 at 7:02 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 25.04.22 um 11:15 schrieb Haohui Mai:
>>> Computing the address of the doorbell should be done before instead of after
>>> separating the 64-bit address into the higher and lower half. The
>>> current code sets the MMIO registers incorrectly if the address of the
>>> doorbell is above 1G.
>> That doesn't make any sense at all. The address of the doorbell is
>> completely irrelevant to the value you write into it.
>>
>> What we could do is to stop using the lower_32_bits() function, since
>> the WPTR can't handle more than 16, 20 or 24 bits (IIRC) depending on hw
>> generation anyway.
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Haohui Mai <ricetons@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
>>>    drivers/gpu/drm/amd/amdgpu/si_dma.c    | 4 ++--
>>>    7 files changed, 20 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> index c8ebd108548d..df863d346995 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> @@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
>>>     struct amdgpu_device *adev = ring->adev;
>>>
>>>     WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
>>> -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
>>> +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
>>>    }
>>>
>>>    static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>> @@ -487,7 +487,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
>>>     WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
>>>
>>>     ring->wptr = 0;
>>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
>>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
>>>
>>>     /* enable DMA RB */
>>>     WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> index 1d8bbcbd7a37..b83fd00466fe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> @@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
>>> amdgpu_ring *ring)
>>>    {
>>>     struct amdgpu_device *adev = ring->adev;
>>>
>>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
>>> lower_32_bits(ring->wptr) << 2);
>>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
>>> lower_32_bits(ring->wptr << 2));
>>>    }
>>>
>>>    static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>> @@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
>>>     WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
>>>
>>>     ring->wptr = 0;
>>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
>>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
>>>
>>>     /* enable DMA RB */
>>>     rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> index 4ef4feff5649..557a7d5174b0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> @@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
>>> amdgpu_ring *ring)
>>>     if (ring->use_doorbell) {
>>>     u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
>>>     /* XXX check if swapping is necessary on BE */
>>> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
>>> - WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr) << 2);
>>> + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
>>> + WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2));
>>>     } else if (ring->use_pollmem) {
>>>     u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
>>>
>>> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
>>> + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
>>>     } else {
>>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
>>> lower_32_bits(ring->wptr) << 2);
>>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
>>> lower_32_bits(ring->wptr << 2));
>>>     }
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index d7e8f7232364..ff86c43b63d1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
>>> amdgpu_ring *ring)
>>>
>>>     DRM_DEBUG("Using doorbell -- "
>>>     "wptr_offs == 0x%08x "
>>> - "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>>> - "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>>> + "lower_32_bits(ring->wptr << 2) == 0x%08x "
>>> + "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>>>     ring->wptr_offs,
>>>     lower_32_bits(ring->wptr << 2),
>>>     upper_32_bits(ring->wptr << 2));
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index a8d49c005f73..627eb1f147c2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
>>> amdgpu_ring *ring)
>>>     if (ring->use_doorbell) {
>>>     DRM_DEBUG("Using doorbell -- "
>>>     "wptr_offs == 0x%08x "
>>> - "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>>> - "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>>> + "lower_32_bits(ring->wptr << 2) == 0x%08x "
>>> + "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>>>     ring->wptr_offs,
>>>     lower_32_bits(ring->wptr << 2),
>>>     upper_32_bits(ring->wptr << 2));
>>> @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>>>
>>>     if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
>>> for wptr */
>>>     WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
>>> -        lower_32_bits(ring->wptr) << 2);
>>> +        lower_32_bits(ring->wptr << 2));
>>>     WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
>>> -        upper_32_bits(ring->wptr) << 2);
>>> +        upper_32_bits(ring->wptr << 2));
>>>     }
>>>
>>>     doorbell = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
>>> mmSDMA0_GFX_DOORBELL));
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index 824eace69884..a5eb82bfeaa8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
>>> amdgpu_ring *ring)
>>>     if (ring->use_doorbell) {
>>>     DRM_DEBUG("Using doorbell -- "
>>>     "wptr_offs == 0x%08x "
>>> - "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>>> - "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>>> + "lower_32_bits(ring->wptr << 2) == 0x%08x "
>>> + "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>>>     ring->wptr_offs,
>>>     lower_32_bits(ring->wptr << 2),
>>>     upper_32_bits(ring->wptr << 2));
>>> @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>>>     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
>>> mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
>>>
>>>     if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
>>> for wptr */
>>> - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
>>> lower_32_bits(ring->wptr) << 2);
>>> - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
>>> upper_32_bits(ring->wptr) << 2);
>>> + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
>>> lower_32_bits(ring->wptr << 2));
>>> + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
>>> upper_32_bits(ring->wptr << 2));
>>>     }
>>>
>>>     doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
>>> mmSDMA0_GFX_DOORBELL));
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> index 195b45bcb8ad..0af11d3b00e7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> @@ -57,7 +57,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
>>>     u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;
>>>
>>>     WREG32(DMA_RB_WPTR + sdma_offsets[me],
>>> -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
>>> +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
>>>    }
>>>
>>>    static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
>>> @@ -175,7 +175,7 @@ static int si_dma_start(struct amdgpu_device *adev)
>>>     WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);
>>>
>>>     ring->wptr = 0;
>>> - WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
>>> + WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
>>>     WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
>>>
>>>     ring->sched.ready = true;
>>> --
>>> 2.25.1

