Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3657BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 12:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5F110E76F;
	Mon, 25 Apr 2022 12:33:31 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C8610E766
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 12:33:30 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id r13so29331900ejd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=UeU0I8nvZAT48+mjyciqQr1c8zhx0Rj6fmkd2ljsiBw=;
 b=FjgA5l02Td8lgRYdO8qNflY+raeo5DdIeOnNfBoxFbYOWq4k+arrU1Tk5IXteP3U0h
 aS2SZPgG6BSdjs12TI8PPYEbHo/v9ywgtBmPvBGJPoVAncXbvp289/ZFq+fmOplrOkoP
 RE4OzyfhtQeoHz2VGnLWaVQmr9glX4zpoJ1/Z5k88efWjdvxkZPaN9g94EZNHZcUIB/p
 m7EqX5TKdW7oLYdtLB6dCxAnm/9+jZdhjutkQVxAH5A8pE1w3RDXO88HgVlROvZ5XXHm
 EsMwvKGmHPtc22JwsdwQdDi9MCC+k6rT5CEzDKmCUUfMjQGJaZO56sMzRvZj9X8ByXBD
 7wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=UeU0I8nvZAT48+mjyciqQr1c8zhx0Rj6fmkd2ljsiBw=;
 b=3AIqgtKuwAvKYNV9nBR9A0eknp5RSiWmDAcOSAg6ViYWXp8W8FS6ozvPxStZb781FK
 SQgL2N+tJ/NxPBjbt9Ga7DM+8S0d3yQOutJYNVUz+/YznRNtocNMvnFubQGSPDUw6GIh
 CJy8W74o3x1axhIRX4tUncTFjfMFb5q9L3kcMraaCXfVyWoueNvdXu63x5ysEzB4BuBS
 I+/7Kb4vDKZvuZjeexYeVrk7d2tOOkmrC72UUsmvG0CGr5qXq90WNvX+ihlv9TyOYixI
 wVSAAHwDHk7nODCTcXv1LgYEQKOgWmSKkUrmuSreZ9XodTYPU2EvvJ2NBR9O52yB+CmQ
 NzMg==
X-Gm-Message-State: AOAM531z+dS0hRvguSdiwnPc8KyqoIHshoYUNx2hpZIG6/bgwnTbF6kY
 s8wdLB3X6Ko29eh4Cm2a/vc=
X-Google-Smtp-Source: ABdhPJwaZYpLYfh8MQI7fBOvGjFJ8igxU2091jr3k92ktDlslsyxcME79V0Vu1L2FSxt/4Mq4+uQ3Q==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id
 qk20-20020a1709077f9400b006da64ecfabcmr16085829ejc.717.1650890008869; 
 Mon, 25 Apr 2022 05:33:28 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:7284:dbdc:d72b:7ea1?
 ([2a02:908:1252:fb60:7284:dbdc:d72b:7ea1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020aa7d54c000000b00423e004bf9asm4547194edr.86.2022.04.25.05.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 05:33:28 -0700 (PDT)
Message-ID: <33ff47fa-b719-faae-a63d-4a5c31213f93@gmail.com>
Date: Mon, 25 Apr 2022 14:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] Fix incorrect calculations of the wptr of the
 doorbells
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>
References: <CAHpOOhHgvsM0YzuhP+9j=PsJLp5s2t9xCmcCOg+LvSiQX8rqug@mail.gmail.com>
 <6b9f94ea-695b-22d7-5d95-e3d3f45c4ef3@gmail.com>
 <CAHpOOhE7r+m=t3qY3aYLdU2AKp+SBiaL2=M1D45bK=HpE7OB3g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhE7r+m=t3qY3aYLdU2AKp+SBiaL2=M1D45bK=HpE7OB3g@mail.gmail.com>
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

Am 25.04.22 um 14:19 schrieb Haohui Mai:
> Dropped the changes of older generations.
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>

Please update the commit messages to include all the background we just 
discussed.

With that done the series is Reviewed-by: Christian König 
<christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index d7e8f7232364..ff86c43b63d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>
>                  DRM_DEBUG("Using doorbell -- "
>                                  "wptr_offs == 0x%08x "
> -                               "lower_32_bits(ring->wptr) << 2 == 0x%08x "
> -                               "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
> +                               "lower_32_bits(ring->wptr << 2) == 0x%08x "
> +                               "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>                                  ring->wptr_offs,
>                                  lower_32_bits(ring->wptr << 2),
>                                  upper_32_bits(ring->wptr << 2));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index a8d49c005f73..627eb1f147c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>          if (ring->use_doorbell) {
>                  DRM_DEBUG("Using doorbell -- "
>                                  "wptr_offs == 0x%08x "
> -                               "lower_32_bits(ring->wptr) << 2 == 0x%08x "
> -                               "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
> +                               "lower_32_bits(ring->wptr << 2) == 0x%08x "
> +                               "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>                                  ring->wptr_offs,
>                                  lower_32_bits(ring->wptr << 2),
>                                  upper_32_bits(ring->wptr << 2));
> @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>
>                  if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
> register write for wptr */
>                          WREG32(sdma_v5_0_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR),
> -                              lower_32_bits(ring->wptr) << 2);
> +                              lower_32_bits(ring->wptr << 2));
>                          WREG32(sdma_v5_0_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI),
> -                              upper_32_bits(ring->wptr) << 2);
> +                              upper_32_bits(ring->wptr << 2));
>                  }
>
>                  doorbell = RREG32_SOC15_IP(GC,
> sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 824eace69884..a5eb82bfeaa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
> amdgpu_ring *ring)
>          if (ring->use_doorbell) {
>                  DRM_DEBUG("Using doorbell -- "
>                                  "wptr_offs == 0x%08x "
> -                               "lower_32_bits(ring->wptr) << 2 == 0x%08x "
> -                               "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
> +                               "lower_32_bits(ring->wptr << 2) == 0x%08x "
> +                               "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>                                  ring->wptr_offs,
>                                  lower_32_bits(ring->wptr << 2),
>                                  upper_32_bits(ring->wptr << 2));
> @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>                  WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
>
>                  if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
> register write for wptr */
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
>                  }
>
>                  doorbell = RREG32_SOC15_IP(GC,
> sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> --
> 2.25.1
>
> On Mon, Apr 25, 2022 at 7:52 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 25.04.22 um 13:47 schrieb Haohui Mai:
>>> Updated the commit messages based on the previous discussion.
>> Please drop all the changes for pre SDMA v4 hardware (e.g. the ones with
>> only a 32bit register), so that we only have the changes for the 64bit
>> hw versions in here.
>>
>> Apart from that looks good to me.
>>
>> Thanks,
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

