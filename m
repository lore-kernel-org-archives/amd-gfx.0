Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F58C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 11:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A64910E6BA;
	Mon, 25 Apr 2022 11:52:17 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2E110E6BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:52:15 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id kq17so5950740ejb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=RRuZu1gKtEpDLe/cmRr6oPFF5XPKJxif1ZL9Ksu6vSw=;
 b=EwuriLwFTkpxXr8dnU6Nk78i7gAlCyQWwGAl2JsBcRmvyhDh2hCq6kccNrMevirUUd
 z16jPrpOI71OBpfWcs4kVA5qL3g4McaAOMsO9rbH5soW95m77LsFf5T3APiuYKI9U/FT
 mRWVtb8STorzwhP4JX+d8t/aktTnNeyfUuUfm0tHbxoEe4Zo/MWp7q3GkPaZgyd2PDX0
 4zyyWovVyaSdVC+Opps0KJj18lS01bU8wcSy8Crdif2ZYtzW7FAmHJ08T9TsdTPluLoh
 MSKMuzJ1VC5Pqf84iZSxZwn5ugkTzWNCLAMprq0b1FE1kHndPGGA5A8A15f+6TfGVqKv
 dZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RRuZu1gKtEpDLe/cmRr6oPFF5XPKJxif1ZL9Ksu6vSw=;
 b=bA7Ow4Fm3VOvkd5zvUIB3CX69/ARHF/3KtGziTI+3WwJVuN2F/SF+yjabQrur2O5K8
 QT2jM1+e/dKtw1ImxjvisTI9pRmSMCYTPr9q9ZDwWB3KrM02n6O+SMrQ1zBStFCFCayP
 FtGFn3lVbd6I+g+Mr1hSe9A8m+mI2Isw/gKhTZqKYBld5WOES2h0Yw1xRdkZxFDSTKbm
 MPCX6cXK/fd8+18CwC7ed7KwKsbzmVGQEjJzJUwX728C/p/+InnaAgvTpSPllm0alc0W
 0++YF8AmIPzMbz0q0LRcdsqAmES3EiX2pc9CBYNkBx4GaG8bhB3knMY7oLy0gMnw/G09
 zE6g==
X-Gm-Message-State: AOAM5307GQMGaz+F2GHPXeuI/e6KPNGtyyfEo0roZPVBtSOzxtmbH0qC
 nWbthOdsvH3OyKZ6V3u8EvM=
X-Google-Smtp-Source: ABdhPJzaseFNgn6E2iknAcBUv0k4SKxgRTtwN9rM39mjK3/tfbUpGpALSleRy4V3YIx9ey2kPIPJJQ==
X-Received: by 2002:a17:907:7b92:b0:6db:71f1:fc20 with SMTP id
 ne18-20020a1709077b9200b006db71f1fc20mr15352494ejc.343.1650887534363; 
 Mon, 25 Apr 2022 04:52:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:7284:dbdc:d72b:7ea1?
 ([2a02:908:1252:fb60:7284:dbdc:d72b:7ea1])
 by smtp.gmail.com with ESMTPSA id
 22-20020a508e16000000b00425c9d1704bsm3510307edw.4.2022.04.25.04.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 04:52:13 -0700 (PDT)
Message-ID: <6b9f94ea-695b-22d7-5d95-e3d3f45c4ef3@gmail.com>
Date: Mon, 25 Apr 2022 13:52:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] Fix incorrect calculations of the wptr of the
 doorbells
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAHpOOhHgvsM0YzuhP+9j=PsJLp5s2t9xCmcCOg+LvSiQX8rqug@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhHgvsM0YzuhP+9j=PsJLp5s2t9xCmcCOg+LvSiQX8rqug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.22 um 13:47 schrieb Haohui Mai:
> Updated the commit messages based on the previous discussion.

Please drop all the changes for pre SDMA v4 hardware (e.g. the ones with 
only a 32bit register), so that we only have the changes for the 64bit 
hw versions in here.

Apart from that looks good to me.

Thanks,
Christian.

>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/si_dma.c    | 4 ++--
>   7 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index c8ebd108548d..df863d346995 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
>    struct amdgpu_device *adev = ring->adev;
>
>    WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
>   }
>
>   static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> @@ -487,7 +487,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
>    WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
>
>    ring->wptr = 0;
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
>
>    /* enable DMA RB */
>    WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 1d8bbcbd7a37..b83fd00466fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
> amdgpu_ring *ring)
>   {
>    struct amdgpu_device *adev = ring->adev;
>
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> lower_32_bits(ring->wptr) << 2);
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> lower_32_bits(ring->wptr << 2));
>   }
>
>   static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> @@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
>    WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
>
>    ring->wptr = 0;
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
>
>    /* enable DMA RB */
>    rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 4ef4feff5649..557a7d5174b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>    if (ring->use_doorbell) {
>    u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
>    /* XXX check if swapping is necessary on BE */
> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
> - WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr) << 2);
> + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> + WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2));
>    } else if (ring->use_pollmem) {
>    u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
>
> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
> + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
>    } else {
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> lower_32_bits(ring->wptr) << 2);
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> lower_32_bits(ring->wptr << 2));
>    }
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index d7e8f7232364..ff86c43b63d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>
>    DRM_DEBUG("Using doorbell -- "
>    "wptr_offs == 0x%08x "
> - "lower_32_bits(ring->wptr) << 2 == 0x%08x "
> - "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
> + "lower_32_bits(ring->wptr << 2) == 0x%08x "
> + "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>    ring->wptr_offs,
>    lower_32_bits(ring->wptr << 2),
>    upper_32_bits(ring->wptr << 2));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index a8d49c005f73..627eb1f147c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>    if (ring->use_doorbell) {
>    DRM_DEBUG("Using doorbell -- "
>    "wptr_offs == 0x%08x "
> - "lower_32_bits(ring->wptr) << 2 == 0x%08x "
> - "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
> + "lower_32_bits(ring->wptr << 2) == 0x%08x "
> + "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>    ring->wptr_offs,
>    lower_32_bits(ring->wptr << 2),
>    upper_32_bits(ring->wptr << 2));
> @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>
>    if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
> for wptr */
>    WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> -        lower_32_bits(ring->wptr) << 2);
> +        lower_32_bits(ring->wptr << 2));
>    WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> -        upper_32_bits(ring->wptr) << 2);
> +        upper_32_bits(ring->wptr << 2));
>    }
>
>    doorbell = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
> mmSDMA0_GFX_DOORBELL));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 824eace69884..a5eb82bfeaa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
> amdgpu_ring *ring)
>    if (ring->use_doorbell) {
>    DRM_DEBUG("Using doorbell -- "
>    "wptr_offs == 0x%08x "
> - "lower_32_bits(ring->wptr) << 2 == 0x%08x "
> - "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
> + "lower_32_bits(ring->wptr << 2) == 0x%08x "
> + "upper_32_bits(ring->wptr << 2) == 0x%08x\n",
>    ring->wptr_offs,
>    lower_32_bits(ring->wptr << 2),
>    upper_32_bits(ring->wptr << 2));
> @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>    WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
>
>    if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
> for wptr */
> - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> lower_32_bits(ring->wptr) << 2);
> - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> upper_32_bits(ring->wptr) << 2);
> + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> lower_32_bits(ring->wptr << 2));
> + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> upper_32_bits(ring->wptr << 2));
>    }
>
>    doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_DOORBELL));
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 195b45bcb8ad..0af11d3b00e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -57,7 +57,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
>    u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;
>
>    WREG32(DMA_RB_WPTR + sdma_offsets[me],
> -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
>   }
>
>   static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
> @@ -175,7 +175,7 @@ static int si_dma_start(struct amdgpu_device *adev)
>    WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);
>
>    ring->wptr = 0;
> - WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2);
> + WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
>    WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
>
>    ring->sched.ready = true;
> --
> 2.25.1

