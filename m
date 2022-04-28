Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C742C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 13:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF58110EC96;
	Thu, 28 Apr 2022 13:26:45 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087E410EBE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 13:26:45 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id fv2so4312752pjb.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cx6atRW+yqodNBtL/udyLcdQr6SbzT9InDuuP5g85Mo=;
 b=YwkQMN1zpIbMKM8FTPTIIQI0Tv2WUbGtfxgc52nPPXRgZkgDNHajHAG09TSvPbmXUl
 /gzcfxAb1nZc3B5U8A77WVmddZmEw8+NeUl75moI9A9L8nGA0f6B6/pRi+siRuSkHlch
 GY/4ywplwPDG7x1M5Il2Rv8BQxzntEqh2HfmwkFkhr0cST3UMPl2iAg4u0RjU4BwPz42
 iGOmxmn7zq2NnGpdFnX6Q63+wpv7khHwNVsjm2ZpMMVdCBVnG+2Yvf7jOkk/eO4a8+rl
 AZZ4lQwVVvhGPStLmohidz0LCCbw9gCq1YXIgjy1pkFHWTtDOOzzFXNBSruB0T0TsgQ8
 dzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cx6atRW+yqodNBtL/udyLcdQr6SbzT9InDuuP5g85Mo=;
 b=7COkN8bkUB9jxC/AgBlpmll3sm33BRaAkWs9X+Ddnl7DyYfzH0r41XtILkp8Bkzh1I
 2noJwmzVJE8YmM1J98AIUyZ8DJ6KiWi0/vFmSTKBFsOIcMgpczRnSf33eTMGCGBijJks
 Cyf+rUY7e4WOEoGIPj3pDwtKKmpV+VjZIg8KURAz+I1S+HOs4pqqw3cAlASCBuJQiHz1
 /NmXFDWYft1nLhPUKpv/1B9YED7vbIwZXTiE1J+Wnj/+87OkLyq7GvBArNZVni3qhGyP
 SCp/A9koSy5SaiLxmWqzlcTbKVCUy8l+G08ecFPJYD8K28pgXddiVrkLDeOpkkiy4aU0
 Z5cQ==
X-Gm-Message-State: AOAM531BOUmM1PgAT7QJZksZMi4flK5Krr9yQvreGGS3bmCUu6X2ipbW
 EalFBgMtvqQCo58vE1p0Ynjhi2vJ5+vj4L7z+wc=
X-Google-Smtp-Source: ABdhPJw2MTqwqF8X+h764B34YcXBrMN30lRHpjqI63NleVdW4uqyoM6x8MPSE+nYeFK6oh67xIa+ZtIP0RwuiAFk/4k=
X-Received: by 2002:a17:903:2341:b0:15d:4055:d79f with SMTP id
 c1-20020a170903234100b0015d4055d79fmr11914812plh.108.1651152404518; Thu, 28
 Apr 2022 06:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220428095327.10513-1-ricetons@gmail.com>
 <YmpsF4F109J3+zzH@lang-desktop>
In-Reply-To: <YmpsF4F109J3+zzH@lang-desktop>
From: Haohui Mai <ricetons@gmail.com>
Date: Thu, 28 Apr 2022 21:26:33 +0800
Message-ID: <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
To: Lang Yu <Lang.Yu@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If I understand correctly, the original code will disable the HALT bit
of the register mmSDMA0_F32_CNTL twice on other code paths -- one in
the sdma_v5_2_ctx_switch_enable() and the other one in
sdma_v5_2_enable().

The change ensures that the bit is only disabled once. Just wondering,
which one is the expected behavior?

~Haohui

On Thu, Apr 28, 2022 at 6:27 PM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 04/28/ , ricetons@gmail.com wrote:
> > From: Haohui Mai <ricetons@gmail.com>
> >
> > The patch fully deactivates the DMA engine before setting up the ring
> > buffer to avoid potential data races and crashes.
> >
> > The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.
> >
> > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
> >  1 file changed, 62 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > index 013d2dec81d0..b000117b77d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> >       }
> >  }
> >
> > -
> >  /**
> >   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> >   *
> > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> >  }
> >
> >  /**
> > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > + * context switch for an instance
> >   *
> >   * @adev: amdgpu_device pointer
> > - * @enable: enable/disable the DMA MEs context switch.
> > + * @instance_idx: the index of the SDMA instance
> >   *
> > - * Halt or unhalt the async dma engines context switch.
> > + * Unhalt the async dma engines context switch.
> >   */
> > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> >  {
> >       u32 f32_cntl, phase_quantum = 0;
> > -     int i;
> > +
> > +     if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > +             return;
> > +     }
> >
> >       if (amdgpu_sdma_phase_quantum) {
> >               unsigned value = amdgpu_sdma_phase_quantum;
> > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> >               phase_quantum =
> >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > -     }
> > -
> > -     for (i = 0; i < adev->sdma.num_instances; i++) {
> > -             if (enable && amdgpu_sdma_phase_quantum) {
> > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > -                            phase_quantum);
> > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > -                            phase_quantum);
> > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > -                            phase_quantum);
> > -             }
> >
> > -             if (!amdgpu_sriov_vf(adev)) {
> > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > -                                     AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > -             }
> > +             WREG32_SOC15_IP(GC,
> > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > +                     phase_quantum);
> > +             WREG32_SOC15_IP(GC,
> > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > +                 phase_quantum);
> > +             WREG32_SOC15_IP(GC,
> > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > +                 phase_quantum);
> >       }
> >
> > +     if (!amdgpu_sriov_vf(adev)) {
> > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > +                             AUTO_CTXSW_ENABLE, 1);
> > +             WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > +     }
> >  }
> >
> >  /**
> > - * sdma_v5_2_enable - stop the async dma engines
> > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> >   *
> >   * @adev: amdgpu_device pointer
> > - * @enable: enable/disable the DMA MEs.
> >   *
> > - * Halt or unhalt the async dma engines.
> > + * Halt the async dma engines context switch.
> >   */
> > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> >  {
> >       u32 f32_cntl;
> >       int i;
> >
> > -     if (!enable) {
> > -             sdma_v5_2_gfx_stop(adev);
> > -             sdma_v5_2_rlc_stop(adev);
> > -     }
> > +     if (amdgpu_sriov_vf(adev))
> > +             return;
> >
> > -     if (!amdgpu_sriov_vf(adev)) {
> > -             for (i = 0; i < adev->sdma.num_instances; i++) {
> > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > -             }
> > +     for (i = 0; i < adev->sdma.num_instances; i++) {
> > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > +                             AUTO_CTXSW_ENABLE, 0);
> > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> >       }
> >  }
> >
> > +/**
> > + * sdma_v5_2_halt - stop the async dma engines
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Halt the async dma engines.
> > + */
> > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > +{
> > +     sdma_v5_2_gfx_stop(adev);
> > +     sdma_v5_2_rlc_stop(adev);
> > +}
> > +
> >  /**
> >   * sdma_v5_2_gfx_resume - setup and start the async dma engines
> >   *
> >   * @adev: amdgpu_device pointer
> >   *
> >   * Set up the gfx DMA ring buffers and enable them.
> > + * It assumes that the dma engine is stopped for each instance.
> > + * The function enables the engine and preemptions sequentially for each instance.
> > + *
> >   * Returns 0 for success, error for failure.
> >   */
> >  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> >
> >               ring->sched.ready = true;
> >
> > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > -                     sdma_v5_2_enable(adev, true);
> > -             }
> > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> >
> >               r = amdgpu_ring_test_ring(ring);
> >               if (r) {
> > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> >       int i, j;
> >
> >       /* halt the MEs */
> > -     sdma_v5_2_enable(adev, false);
> > +     sdma_v5_2_halt(adev);
> >
> >       for (i = 0; i < adev->sdma.num_instances; i++) {
> >               if (!adev->sdma.instance[i].fw)
> > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> >       int r = 0;
> >
> >       if (amdgpu_sriov_vf(adev)) {
> > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > -             sdma_v5_2_enable(adev, false);
> > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > +             sdma_v5_2_halt(adev);
> >
> >               /* set RB registers */
> >               r = sdma_v5_2_gfx_resume(adev);
> > @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> >       }
> >
> >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > +             sdma_v5_2_halt(adev);
>
> You don't need call these functions here.
>
> In original code, you can see sdma_v5_2_load_microcode() calls
> sdma_v5_2_enable(adev, false) to halt the engine before load ucode.
>
> What I mean is sdma_v5_2_halt(adev) should have no functional change with
> original sdma_v5_2_enable(adev, false), like this,
>
> static void sdma_v5_2_halt(struct amdgpu_device *adev) {
>         u32 f32_cntl;
>         int i;
>
>         sdma_v5_2_gfx_stop(adev);
>         sdma_v5_2_rlc_stop(adev);
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 for (i = 0; i < adev->sdma.num_instances; i++) {
>                         f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
>                         f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
>                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
>                 }
>         }
> }
>
> But you remove the codes to set the HLAT bit of register mmSDMA0_F32_CNTL.
>
> Regards,
> Lang
>
> >               r = sdma_v5_2_load_microcode(adev);
> >               if (r)
> >                       return r;
> > @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> >               amdgpu_gfx_off_ctrl(adev, false);
> >
> >       sdma_v5_2_soft_reset(adev);
> > -     /* unhalt the MEs */
> > -     sdma_v5_2_enable(adev, true);
> > -     /* enable sdma ring preemption */
> > -     sdma_v5_2_ctx_switch_enable(adev, true);
> >
> > -     /* start the gfx rings and rlc compute queues */
> > +     /* Soft reset supposes to disable the dma engine and preemption.
> > +      * Now start the gfx rings and rlc compute queues.
> > +      */
> >       r = sdma_v5_2_gfx_resume(adev);
> >       if (adev->in_s0ix)
> >               amdgpu_gfx_off_ctrl(adev, true);
> > @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> >       if (amdgpu_sriov_vf(adev))
> >               return 0;
> >
> > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > -     sdma_v5_2_enable(adev, false);
> > +     sdma_v5_2_ctx_switch_disable_all(adev);
> > +     sdma_v5_2_halt(adev);
> >
> >       return 0;
> >  }
> > --
> > 2.25.1
> >
