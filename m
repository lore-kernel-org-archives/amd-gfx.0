Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16376C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 11:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A189210E202;
	Mon, 25 Apr 2022 11:53:25 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431E610E4C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:53:25 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id k27so2882966edk.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 04:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=4R26GetzVDLlNiV73xcjbx1lkk56KMGOW+ef50dYB4o=;
 b=c7lrBuZ7yvItsdncPPeihdvavrDvp9OAfAZ5otH52VCg48Cgm9wJ/BEmDahWU6fR9f
 Jr3niC+vce/yzsJCUSbzYQqmJZ758sez7vpqRTctyfPX5ujT9qcECvBYqoZap5T2CTus
 8voaqrJFVPObnwbqlu1gHFwJfmnvYaZusRrfEkbAF7xBK3PFCGcWqsW7ywtwNseIT5Oy
 gB74bTBisF4eeERfFKJmXdQNJAA+WBp8cDC1PsL/ULWhR0ktOpFwH12F3uSMFUT+2g0E
 4IuV6wCi3bVVQJxg3B6cZwHNvoE7k+HJIB+DEgjFyREE5yX5c5EJq+ZJ8xuCmbtnP0iz
 3CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4R26GetzVDLlNiV73xcjbx1lkk56KMGOW+ef50dYB4o=;
 b=5+j7AWuYAFkZEpoUQcyZGaQ1B44MXnrxrSEWoGEVA878ksLquLYqikbCcQTVVqwLWs
 C+VTRBdItN/ZHVD7Dm5H/Q2Cj+ogcX59Is9NphWszGGl1b/joSYL7HflKYQGnn+rEY54
 beGGgEcuzkvuR9zXimMer4jdkJB+GH+OXnqZz7fDHmSygQocmdEgMc/nCt/6jM7j4uaI
 K9rzSnKtVVDzEp42GOZ5MQU1IGmJr2ynyq4BVqyVglO5SoU9MxRTWHexnH+wS10n8juK
 1qWZxwTCG+pTh+O/OJjlHKc/akOJeQH8UdOoIvSD7AVPGUhy2vEFF3/0VMQGUE6vBVOg
 AjcQ==
X-Gm-Message-State: AOAM533jiEv1WC/V+YIOPecWlQWe3E4Khdtc2Psii2ysIzgJ3/w3YOvt
 wWU73rHJh0rFH8XpX3Kz8uI=
X-Google-Smtp-Source: ABdhPJzAeHIrCQ/ebKvWOSlPG73NsdP9QNom3H/xNigCtHc+8Mfr7Nt8taFjVRHYTXKe8kFZvFs9sg==
X-Received: by 2002:aa7:dc53:0:b0:421:d085:9a0d with SMTP id
 g19-20020aa7dc53000000b00421d0859a0dmr18632152edu.0.1650887603668; 
 Mon, 25 Apr 2022 04:53:23 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:7284:dbdc:d72b:7ea1?
 ([2a02:908:1252:fb60:7284:dbdc:d72b:7ea1])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a50a456000000b00422a4841c61sm4631094edb.58.2022.04.25.04.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 04:53:23 -0700 (PDT)
Message-ID: <ff41e2a0-ae1a-7394-0060-aed4ab542927@gmail.com>
Date: Mon, 25 Apr 2022 13:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] Remove redundant lower_32_bits() calls when settings
 SDMA doorbell
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAHpOOhHdH8=zEGu1oX_7DGTotO7pnXLk_XGyKddk89iaTJ1rKw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhHdH8=zEGu1oX_7DGTotO7pnXLk_XGyKddk89iaTJ1rKw@mail.gmail.com>
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

Am 25.04.22 um 13:49 schrieb Haohui Mai:
> I kept the original clamping for CIK / SI in this patch.

I don't really care much about them. Keep it as you like, it's only for 
the older hw generations anyway.

Regards,
Christian.

>
> Please let me know if you want to remove them.
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 5 ++---
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/si_dma.c    | 5 ++---
>   4 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index df863d346995..cf99f6d07b49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -194,8 +194,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
>   {
>    struct amdgpu_device *adev = ring->adev;
>
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> -        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], (ring->wptr <<
> 2) & 0x3fffc);
>   }
>
>   static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> @@ -487,7 +486,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
>    WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
>
>    ring->wptr = 0;
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
>
>    /* enable DMA RB */
>    WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index b83fd00466fe..84b57b06b20c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
> amdgpu_ring *ring)
>   {
>    struct amdgpu_device *adev = ring->adev;
>
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> lower_32_bits(ring->wptr << 2));
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
>   }
>
>   static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> @@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
>    WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
>
>    ring->wptr = 0;
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
>
>    /* enable DMA RB */
>    rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 557a7d5174b0..c86f181623f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>    if (ring->use_doorbell) {
>    u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
>    /* XXX check if swapping is necessary on BE */
> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> - WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2));
> + WRITE_ONCE(*wb, ring->wptr << 2);
> + WDOORBELL32(ring->doorbell_index, ring->wptr << 2);
>    } else if (ring->use_pollmem) {
>    u32 *wb = (u32 *)&adev->wb.wb[ring->wptr_offs];
>
> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> + WRITE_ONCE(*wb, ring->wptr << 2);
>    } else {
> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> lower_32_bits(ring->wptr << 2));
> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
>    }
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 0af11d3b00e7..2f95235bbfb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -56,8 +56,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
>    struct amdgpu_device *adev = ring->adev;
>    u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;
>
> - WREG32(DMA_RB_WPTR + sdma_offsets[me],
> -        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
> + WREG32(DMA_RB_WPTR + sdma_offsets[me], (ring->wptr << 2) & 0x3fffc);
>   }
>
>   static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
> @@ -175,7 +174,7 @@ static int si_dma_start(struct amdgpu_device *adev)
>    WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);
>
>    ring->wptr = 0;
> - WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2));
> + WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
>    WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
>
>    ring->sched.ready = true;
> --
> 2.25.1

