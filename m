Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB23C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 13:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F1610F293;
	Wed, 27 Apr 2022 13:15:53 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD0A10F293
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 13:15:52 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id e189so1882416oia.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OUxVKk4cbOOCT3oMa+wPlELCo2P7Vb2M8rQVvy6lAUY=;
 b=G8df7Ow7QtWBKuPnw4B2ggQAqozam3HyY2MdkAG4KQqXk/Jqa6yLczuKA9IHNpUH/+
 26vbzykMztctk9A+HgNOFxXI5lh0I2x6xfLwZlGRhv5q7RuAInPaohLHHpV1qOosRd6Q
 URqqMAPrhjRFzT5BkRt1ezpS8R2JSrJem61qXA2l3rzMsgkFSW78ThTatZRbMtZr2kD6
 8K1IRPJEyu3jpWSKIryiqr7h984Ypu71cQYU93ny+cGHQfZBxJx/nI7SSYfkfcd6PeeC
 0KM9S44KG2loAzJCUkwuAN8CQ2EdGFnNS4luilIdJrtfgL/nwWcPgdOcip0CyqhuGUUU
 TDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OUxVKk4cbOOCT3oMa+wPlELCo2P7Vb2M8rQVvy6lAUY=;
 b=almIuqdc2LIuz4Wz8wG/Q5WqftdorNdxseLqIdc3gUWAe4S1VHDyVDJwAnOSo7F0rm
 XrwDx9ny1ra+zpb3Emrxhu9ukDSN2xPgsgVoGSi+MtA6Bepn8UyEwPPjaNcmruk2gPjY
 I/6awVKsWxMfJnw1gxUaiSSUK/T/AAtlVufltpqMSkcVRP0SoeI7erBiu0grMn2Gdf1M
 tyjcQbGHs+4wZHNIsz+mZTcU41V4ytp9VMQWKZm5W7VHTkXGhzJ4ApHiPrzB221CewPc
 i1I/mUMXrgjVPhi3M0n4eXlXARP2ChRlppyR/05vgn3JNqgiqI5fjarUdhACtJh5ixAl
 VKOg==
X-Gm-Message-State: AOAM531DuXadokr73KxtzAqiBT1Y/0xQVYUXUSMfwhdPwOZIwcJ2fHGG
 0tiyxmlkQPgFQ6PIwZr9YhmFjxRHsdcTQbMHACQ=
X-Google-Smtp-Source: ABdhPJwe9WhUxa5XckohAA56J//XD5OwWbd/kI1xAMGRBMtYHqEkGkVH1GlxpJWqoNTYRy05QbiwpeHiG9cD/C0XbAQ=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr8662462oiw.253.1651065351743; Wed, 27
 Apr 2022 06:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220427123113.29345-1-ricetons@gmail.com>
In-Reply-To: <20220427123113.29345-1-ricetons@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Apr 2022 09:15:40 -0400
Message-ID: <CADnq5_MWAc0xiVZdP_cDSS0=mb8wYt30FWFN9z0tSqTjFfpQwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
To: Haohui Mai <ricetons@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Haohui Mai <haohui@alt-chain.io>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 27, 2022 at 8:31 AM <ricetons@gmail.com> wrote:
>
> From: Haohui Mai <haohui@alt-chain.io>
>
> The patch fully deactivates the DMA engine before setting up the ring
> buffer to avoid potential data races and crashes.
>
> Signed-off-by: Haohui Mai <haohui@alt-chain.io>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 94 ++++++++++++++------------
>  1 file changed, 50 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 013d2dec81d0..cb3987dd3bda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>         }
>  }
>
> -
>  /**
>   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
>   *
> @@ -505,17 +504,19 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>  }
>
>  /**
> - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> + * context switch for an instance
>   *
>   * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs context switch.
> + * @i: the index of the SDMA instance
>   *
> - * Halt or unhalt the async dma engines context switch.
> + * Unhalt the async dma engines context switch.
>   */
> -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int i)
>  {
>         u32 f32_cntl, phase_quantum = 0;
> -       int i;
> +
> +       WARN_ON(i >= adev->sdma.num_instances);
>
>         if (amdgpu_sdma_phase_quantum) {
>                 unsigned value = amdgpu_sdma_phase_quantum;
> @@ -539,26 +540,44 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>                 phase_quantum =
>                         value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
>                         unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> -       }
>
> -       for (i = 0; i < adev->sdma.num_instances; i++) {
> -               if (enable && amdgpu_sdma_phase_quantum) {
> -                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> -                              phase_quantum);
> -                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> -                              phase_quantum);
> -                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> -                              phase_quantum);
> -               }
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> +                      phase_quantum);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> +                      phase_quantum);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> +                      phase_quantum);
> +       }
>
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> -                       f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -                                       AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> -               }
> +       if (!amdgpu_sriov_vf(adev)) {
> +               f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +               f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +                               AUTO_CTXSW_ENABLE, 1);
> +               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
>         }
> +}
>
> +/**
> + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Halt the async dma engines context switch.
> + */
> +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> +{
> +       u32 f32_cntl;
> +       int i;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
> +       for (i = 0; i < adev->sdma.num_instances; i++) {
> +               f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +               f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +                               AUTO_CTXSW_ENABLE, 0);
> +               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> +       }
>  }
>
>  /**
> @@ -571,21 +590,10 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>   */
>  static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>  {
> -       u32 f32_cntl;
> -       int i;
> -
>         if (!enable) {
>                 sdma_v5_2_gfx_stop(adev);
>                 sdma_v5_2_rlc_stop(adev);
>         }
> -
> -       if (!amdgpu_sriov_vf(adev)) {
> -               for (i = 0; i < adev->sdma.num_instances; i++) {
> -                       f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> -                       f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> -               }
> -       }

As this function no longer provides a way to enable anything, better
to rename it to something like sdma_v5_2_halt() and drop the enable
parameter.

Alex

>  }
>
>  /**
> @@ -594,6 +602,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>   * @adev: amdgpu_device pointer
>   *
>   * Set up the gfx DMA ring buffers and enable them.
> + * It assumes that the dma engine is stopped for each instance.
> + * The function enables the engine and preemptions sequentially for each instance.
> + *
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> @@ -737,10 +748,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>
>                 ring->sched.ready = true;
>
> -               if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> -                       sdma_v5_2_ctx_switch_enable(adev, true);
> -                       sdma_v5_2_enable(adev, true);
> -               }
> +               sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
>
>                 r = amdgpu_ring_test_ring(ring);
>                 if (r) {
> @@ -856,7 +864,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>         int r = 0;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               sdma_v5_2_ctx_switch_enable(adev, false);
> +               sdma_v5_2_ctx_switch_disable_all(adev);
>                 sdma_v5_2_enable(adev, false);
>
>                 /* set RB registers */
> @@ -881,12 +889,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>                 amdgpu_gfx_off_ctrl(adev, false);
>
>         sdma_v5_2_soft_reset(adev);
> -       /* unhalt the MEs */
> -       sdma_v5_2_enable(adev, true);
> -       /* enable sdma ring preemption */
> -       sdma_v5_2_ctx_switch_enable(adev, true);
>
> -       /* start the gfx rings and rlc compute queues */
> +       /* Soft reset supposes to disable the dma engine and preemption.
> +        * Now start the gfx rings and rlc compute queues.
> +        */
>         r = sdma_v5_2_gfx_resume(adev);
>         if (adev->in_s0ix)
>                 amdgpu_gfx_off_ctrl(adev, true);
> @@ -1340,7 +1346,7 @@ static int sdma_v5_2_hw_fini(void *handle)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       sdma_v5_2_ctx_switch_enable(adev, false);
> +       sdma_v5_2_ctx_switch_disable_all(adev);
>         sdma_v5_2_enable(adev, false);
>
>         return 0;
> --
> 2.25.1
>
