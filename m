Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DFCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 04:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7318010FB51;
	Fri, 29 Apr 2022 04:52:06 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E29A10FB51
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 04:52:05 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 d23-20020a17090a115700b001d2bde6c234so7104447pje.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KK7mOio1KKiu0w9wd5GYXqBYaS4bFk4PbbS++TOgueY=;
 b=Z2eHX/3UsbnYtBrW9ZE49k/O6gOijk08uDjOUFW9cZzLbwx12JTjfdFQ/s7S71eYbK
 5tDUu6wC2u3OOoOafNFhX97J6Z4TiecxKZ+b8eWVUTmwEjG4F5l52ky8Nlale+YIsFH5
 rrDTfwJlQ2uu/V3Fv5rrVlKuXvP7VwuXz5WlVzvLEtpgK9Amvd77e7eAgTyv6jW4VxgO
 cisjC/xCXJfdqxaoIUEkvpBgH26cJfCVSrwnITdZFtfPZemBYIYcSgQgixjOrbfS6HIj
 ZDmWLmRFXmGDiV9V6KUqCK+8YdSDEDVRDwDa+BmbZ36OcGysayCD5U18H/Vg1Mbr/yzJ
 jIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KK7mOio1KKiu0w9wd5GYXqBYaS4bFk4PbbS++TOgueY=;
 b=n+oDYR6FHySp7hCRx8tRRpaAKhMzonFUbCHEFlEwdisu4ZsR8uiAOftHZsa8f3kBpk
 wbxbI6dvSN2LGqMNNZw10lSzojpvxArPfNxdytxNpZyjsX0jMCuOE3e1J5lO9bl6Lph3
 GbPXHa3to6/n0A9ikODXREREI156NKUgX/KETVzhyjFoyC1fC4PXGOD2bVmSvrAUEBP6
 FWZ1u146FMYaCx8j5tW0/xUKe4OrtCATQJjE06a61Cti8ZBz8hzqI7Pr8c9TB+fltKUh
 VUostRWZVpKjZtQVUTvOA6kWvBb67KT3BKhMifXvHQQWMUrW8bJT5xRidBrBosZbfP0j
 LvXg==
X-Gm-Message-State: AOAM531/3x0TfTTr9W6jLnk3nGkqff37Kiy5w7AAjbQBfPK70bRFVoH5
 Tp7MdmGkWrNZbpDXxFYmpCdrsdR4qrGQTOkxpCVbcKwGlBi+SIAI
X-Google-Smtp-Source: ABdhPJzFDe3Kv1yhJ/bitwKlUkCmvJ32TM0m1rFP9r/nawWZ2zeMPHZWgtHSs+YqdTGh8u41ECbR/J1/0XXmj5JaEcw=
X-Received: by 2002:a17:90b:3904:b0:1da:2957:b5ee with SMTP id
 ob4-20020a17090b390400b001da2957b5eemr1886973pjb.59.1651207924974; Thu, 28
 Apr 2022 21:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220428095327.10513-1-ricetons@gmail.com>
 <YmpsF4F109J3+zzH@lang-desktop>
 <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
 <YmqfNbHqsuE/erWL@lang-desktop>
In-Reply-To: <YmqfNbHqsuE/erWL@lang-desktop>
From: Haohui Mai <ricetons@gmail.com>
Date: Fri, 29 Apr 2022 12:51:54 +0800
Message-ID: <CAHpOOhEA-GEgLU9B8RrYo9VnATj62sqnRm+6e3NsHo2H02pD7g@mail.gmail.com>
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

Thanks for pointing it out. The v5 patch added the code back.

~Haohui

On Thu, Apr 28, 2022 at 10:05 PM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 04/28/ , Haohui Mai wrote:
> > If I understand correctly, the original code will disable the HALT bit
> > of the register mmSDMA0_F32_CNTL twice on other code paths -- one in
> > the sdma_v5_2_ctx_switch_enable() and the other one in
> > sdma_v5_2_enable().
> >
> > The change ensures that the bit is only disabled once. Just wondering,
> > which one is the expected behavior?
> >
> > ~Haohui
>
> The HALT bit of the register mmSDMA0_F32_CNTL is not set/reset in original sdma_v5_2_ctx_switch_enable()
> (https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c#L523)
>
> Regards,
> Lang
>
> > On Thu, Apr 28, 2022 at 6:27 PM Lang Yu <Lang.Yu@amd.com> wrote:
> > >
> > > On 04/28/ , ricetons@gmail.com wrote:
> > > > From: Haohui Mai <ricetons@gmail.com>
> > > >
> > > > The patch fully deactivates the DMA engine before setting up the ring
> > > > buffer to avoid potential data races and crashes.
> > > >
> > > > The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.
> > > >
> > > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
> > > >  1 file changed, 62 insertions(+), 51 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > index 013d2dec81d0..b000117b77d0 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
> > > >       }
> > > >  }
> > > >
> > > > -
> > > >  /**
> > > >   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > > >   *
> > > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
> > > >  }
> > > >
> > > >  /**
> > > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> > > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> > > > + * context switch for an instance
> > > >   *
> > > >   * @adev: amdgpu_device pointer
> > > > - * @enable: enable/disable the DMA MEs context switch.
> > > > + * @instance_idx: the index of the SDMA instance
> > > >   *
> > > > - * Halt or unhalt the async dma engines context switch.
> > > > + * Unhalt the async dma engines context switch.
> > > >   */
> > > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> > > >  {
> > > >       u32 f32_cntl, phase_quantum = 0;
> > > > -     int i;
> > > > +
> > > > +     if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> > > > +             return;
> > > > +     }
> > > >
> > > >       if (amdgpu_sdma_phase_quantum) {
> > > >               unsigned value = amdgpu_sdma_phase_quantum;
> > > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> > > >               phase_quantum =
> > > >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> > > >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > > > -     }
> > > > -
> > > > -     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > -             if (enable && amdgpu_sdma_phase_quantum) {
> > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > > > -                            phase_quantum);
> > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > > > -                            phase_quantum);
> > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > > > -                            phase_quantum);
> > > > -             }
> > > >
> > > > -             if (!amdgpu_sriov_vf(adev)) {
> > > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > -                                     AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > > -             }
> > > > +             WREG32_SOC15_IP(GC,
> > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> > > > +                     phase_quantum);
> > > > +             WREG32_SOC15_IP(GC,
> > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> > > > +                 phase_quantum);
> > > > +             WREG32_SOC15_IP(GC,
> > > > +                     sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> > > > +                 phase_quantum);
> > > >       }
> > > >
> > > > +     if (!amdgpu_sriov_vf(adev)) {
> > > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> > > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > +                             AUTO_CTXSW_ENABLE, 1);
> > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> > > > +     }
> > > >  }
> > > >
> > > >  /**
> > > > - * sdma_v5_2_enable - stop the async dma engines
> > > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> > > >   *
> > > >   * @adev: amdgpu_device pointer
> > > > - * @enable: enable/disable the DMA MEs.
> > > >   *
> > > > - * Halt or unhalt the async dma engines.
> > > > + * Halt the async dma engines context switch.
> > > >   */
> > > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> > > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> > > >  {
> > > >       u32 f32_cntl;
> > > >       int i;
> > > >
> > > > -     if (!enable) {
> > > > -             sdma_v5_2_gfx_stop(adev);
> > > > -             sdma_v5_2_rlc_stop(adev);
> > > > -     }
> > > > +     if (amdgpu_sriov_vf(adev))
> > > > +             return;
> > > >
> > > > -     if (!amdgpu_sriov_vf(adev)) {
> > > > -             for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > -                     f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > > > -                     f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > > > -             }
> > > > +     for (i = 0; i < adev->sdma.num_instances; i++) {
> > > > +             f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> > > > +             f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > +                             AUTO_CTXSW_ENABLE, 0);
> > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> > > >       }
> > > >  }
> > > >
> > > > +/**
> > > > + * sdma_v5_2_halt - stop the async dma engines
> > > > + *
> > > > + * @adev: amdgpu_device pointer
> > > > + *
> > > > + * Halt the async dma engines.
> > > > + */
> > > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > > +{
> > > > +     sdma_v5_2_gfx_stop(adev);
> > > > +     sdma_v5_2_rlc_stop(adev);
> > > > +}
> > > > +
> > > >  /**
> > > >   * sdma_v5_2_gfx_resume - setup and start the async dma engines
> > > >   *
> > > >   * @adev: amdgpu_device pointer
> > > >   *
> > > >   * Set up the gfx DMA ring buffers and enable them.
> > > > + * It assumes that the dma engine is stopped for each instance.
> > > > + * The function enables the engine and preemptions sequentially for each instance.
> > > > + *
> > > >   * Returns 0 for success, error for failure.
> > > >   */
> > > >  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > >
> > > >               ring->sched.ready = true;
> > > >
> > > > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> > > > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > -                     sdma_v5_2_enable(adev, true);
> > > > -             }
> > > > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> > > >
> > > >               r = amdgpu_ring_test_ring(ring);
> > > >               if (r) {
> > > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
> > > >       int i, j;
> > > >
> > > >       /* halt the MEs */
> > > > -     sdma_v5_2_enable(adev, false);
> > > > +     sdma_v5_2_halt(adev);
> > > >
> > > >       for (i = 0; i < adev->sdma.num_instances; i++) {
> > > >               if (!adev->sdma.instance[i].fw)
> > > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > >       int r = 0;
> > > >
> > > >       if (amdgpu_sriov_vf(adev)) {
> > > > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > > > -             sdma_v5_2_enable(adev, false);
> > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > +             sdma_v5_2_halt(adev);
> > > >
> > > >               /* set RB registers */
> > > >               r = sdma_v5_2_gfx_resume(adev);
> > > > @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > >       }
> > > >
> > > >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > +             sdma_v5_2_halt(adev);
> > >
> > > You don't need call these functions here.
> > >
> > > In original code, you can see sdma_v5_2_load_microcode() calls
> > > sdma_v5_2_enable(adev, false) to halt the engine before load ucode.
> > >
> > > What I mean is sdma_v5_2_halt(adev) should have no functional change with
> > > original sdma_v5_2_enable(adev, false), like this,
> > >
> > > static void sdma_v5_2_halt(struct amdgpu_device *adev) {
> > >         u32 f32_cntl;
> > >         int i;
> > >
> > >         sdma_v5_2_gfx_stop(adev);
> > >         sdma_v5_2_rlc_stop(adev);
> > >
> > >         if (!amdgpu_sriov_vf(adev)) {
> > >                 for (i = 0; i < adev->sdma.num_instances; i++) {
> > >                         f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> > >                         f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> > >                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> > >                 }
> > >         }
> > > }
> > >
> > > But you remove the codes to set the HLAT bit of register mmSDMA0_F32_CNTL.
> > >
> > > Regards,
> > > Lang
> > >
> > > >               r = sdma_v5_2_load_microcode(adev);
> > > >               if (r)
> > > >                       return r;
> > > > @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
> > > >               amdgpu_gfx_off_ctrl(adev, false);
> > > >
> > > >       sdma_v5_2_soft_reset(adev);
> > > > -     /* unhalt the MEs */
> > > > -     sdma_v5_2_enable(adev, true);
> > > > -     /* enable sdma ring preemption */
> > > > -     sdma_v5_2_ctx_switch_enable(adev, true);
> > > >
> > > > -     /* start the gfx rings and rlc compute queues */
> > > > +     /* Soft reset supposes to disable the dma engine and preemption.
> > > > +      * Now start the gfx rings and rlc compute queues.
> > > > +      */
> > > >       r = sdma_v5_2_gfx_resume(adev);
> > > >       if (adev->in_s0ix)
> > > >               amdgpu_gfx_off_ctrl(adev, true);
> > > > @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> > > >       if (amdgpu_sriov_vf(adev))
> > > >               return 0;
> > > >
> > > > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > > > -     sdma_v5_2_enable(adev, false);
> > > > +     sdma_v5_2_ctx_switch_disable_all(adev);
> > > > +     sdma_v5_2_halt(adev);
> > > >
> > > >       return 0;
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
