Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE30AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 09:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DD310F9F4;
	Thu, 28 Apr 2022 09:10:08 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A45310F962
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 09:10:06 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id 15so3493987pgf.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kxsl7Adc91kKoldTKopb1s99YvMGYJw7zwfX9N8vtQw=;
 b=EGpAif0ECwul0G7lRF+7gyGYwVc5rc1nadaEkyWhNDJV39swr4J8evCbqrLVqrLa9f
 41uhNUoODqRz5Wr3xEjB5uCavmNxEhp/f6aGf9ILFPBmd05ccix5N3eoIaMWfvYQXPcS
 61rO0vm1IbkZ+trM0AoOQ/VumKpgBnMlG00zIMknpfw5MkHCnb3AWisesIWoTfvfLfEv
 o6TGag+CxJ4uk+2K6IhH+/pLpWMNHisoZQ5WzycPQZ79sAvaVCFNv12LaGHFpMTyFdon
 GUHyeeu1ado7abHb8SpWae13hWnzaoMHX11xfft4e3wfGc25fjCtTAl1KymmUgEFA3LB
 Ac2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kxsl7Adc91kKoldTKopb1s99YvMGYJw7zwfX9N8vtQw=;
 b=HbrhzcMVHCpCwvYzG1oVObdO1sx8YTuW54r9yR0SdyJzles3b2fCOkIskWmPWHMzmM
 hu4S0inmepFFqhQAcGz2vnMVLekCzG9mbgyZl1JjxLhm0nXBuLqsKM3HCFh7bXtQ16Xx
 XpZN3oRzUIql+6upKZIQdmcf4Jz6wlkxS19ZQs0N9nj2OcRii4XtLWVmwV8zGUQKEuSK
 ZsCiXFNKrvuGZr7MbborpCL4gpO8YH1QYezEKpzCk4EVWYYFjauZ4NVTM9FuSabczNs+
 DMRwrTqlnY75RCSza6M7dyCir+OCHQOH60DpM/VXQzQJ8ufyCLaLUxss+yvvJ6knnFiq
 Vg+w==
X-Gm-Message-State: AOAM533/jliiN6FwWGgjbN9gW2Cenn1iUHFdx79bAzZwWm89uRlfXUvE
 r6CWchjRX2Bt3dDQlN2jTT9aPmrFfT13NoqTtKY=
X-Google-Smtp-Source: ABdhPJwrjqI0fz7GGRLZzu6cwU7POjyzKJkRRcXpQmuDHde6t861PGPGZvjzkWezSUc8dIno59Tvz92pylMJZGX5W8w=
X-Received: by 2002:a63:7702:0:b0:3ab:4d62:b68b with SMTP id
 s2-20020a637702000000b003ab4d62b68bmr16454759pgc.452.1651137005880; Thu, 28
 Apr 2022 02:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220428021109.2571-1-ricetons@gmail.com>
 <05b5464c-9d2c-844a-ef0a-818d04ed9592@gmail.com>
 <YmpRi8LXk2Z9o1Dh@lang-desktop>
In-Reply-To: <YmpRi8LXk2Z9o1Dh@lang-desktop>
From: Haohui Mai <ricetons@gmail.com>
Date: Thu, 28 Apr 2022 17:09:54 +0800
Message-ID: <CAHpOOhHdN_eb5u=M9FUTX==r4He3dik--tXHHJ39dKGfcYPi2A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
To: Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Haohui Mai <haohui@alt-chain.io>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma_v5_2_gfx_resume() sets the bit to unhalts the engine for each
SDMA instance.
sdma_v5_2_ctx_switch_disable_all() halts the engine.

Do you mean that the engine should be halted when
adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT?

~Haohui

On Thu, Apr 28, 2022 at 4:34 PM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 04/28/ , Christian K=C3=B6nig wrote:
> > Adding a few more people to review this.
> >
> > Am 28.04.22 um 04:11 schrieb ricetons@gmail.com:
> > > From: Haohui Mai <haohui@alt-chain.io>
> > >
> > > The patch fully deactivates the DMA engine before setting up the ring
> > > buffer to avoid potential data races and crashes.
> > >
> > > Signed-off-by: Haohui Mai <haohui@alt-chain.io>
> >
> > From my side this is Acked-by: Christian K=C3=B6nig <christian.koenig@a=
md.com>,
> > but I'm not so deeply into the hardware programming sequence to fully j=
udge.
> >
> > Enabling the engine first and then setting it up is certainly incorrect=
, but
> > could be that I'm missing something else. So please guys take a look as
> > well.
> >
> > Thanks,
> > Christian.
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 110 +++++++++++++---------=
---
> > >   1 file changed, 59 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_2.c
> > > index 013d2dec81d0..a22aafd2d7f6 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdg=
pu_ring *ring, u64 addr, u64 se
> > >     }
> > >   }
> > > -
> > >   /**
> > >    * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > >    *
> > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_de=
vice *adev)
> > >   }
> > >   /**
> > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context =
switch
> > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma en=
gines
> > > + * context switch for an instance
> > >    *
> > >    * @adev: amdgpu_device pointer
> > > - * @enable: enable/disable the DMA MEs context switch.
> > > + * @instance_idx: the index of the SDMA instance
> > >    *
> > > - * Halt or unhalt the async dma engines context switch.
> > > + * Unhalt the async dma engines context switch.
> > >    */
> > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, =
bool enable)
> > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_d=
evice *adev, int instance_idx)
> > >   {
> > >     u32 f32_cntl, phase_quantum =3D 0;
> > > -   int i;
> > > +
> > > +   if (WARN_ON(instance_idx >=3D adev->sdma.num_instances)) {
> > > +           return;
> > > +   }
> > >     if (amdgpu_sdma_phase_quantum) {
> > >             unsigned value =3D amdgpu_sdma_phase_quantum;
> > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct =
amdgpu_device *adev, bool enable)
> > >             phase_quantum =3D
> > >                     value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> > >                     unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > > -   }
> > > -
> > > -   for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > -           if (enable && amdgpu_sdma_phase_quantum) {
> > > -                   WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_PHASE0_QUANTUM),
> > > -                          phase_quantum);
> > > -                   WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_PHASE1_QUANTUM),
> > > -                          phase_quantum);
> > > -                   WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_PHASE2_QUANTUM),
> > > -                          phase_quantum);
> > > -           }
> > > -           if (!amdgpu_sriov_vf(adev)) {
> > > -                   f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_CNTL));
> > > -                   f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > -                                   AUTO_CTXSW_ENABLE, enable ? 1 : 0=
);
> > > -                   WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
CNTL), f32_cntl);
> > > -           }
> > > +           WREG32_SOC15_IP(GC,
> > > +                   sdma_v5_2_get_reg_offset(adev, instance_idx, mmSD=
MA0_PHASE0_QUANTUM),
> > > +                   phase_quantum);
> > > +           WREG32_SOC15_IP(GC,
> > > +                   sdma_v5_2_get_reg_offset(adev, instance_idx, mmSD=
MA0_PHASE1_QUANTUM),
> > > +               phase_quantum);
> > > +           WREG32_SOC15_IP(GC,
> > > +                   sdma_v5_2_get_reg_offset(adev, instance_idx, mmSD=
MA0_PHASE2_QUANTUM),
> > > +               phase_quantum);
> > >     }
> > > +   if (!amdgpu_sriov_vf(adev)) {
> > > +           f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, instan=
ce_idx, mmSDMA0_CNTL));
> > > +           f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > +                           AUTO_CTXSW_ENABLE, 1);
> > > +           WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDM=
A0_CNTL), f32_cntl);
> > > +   }
> > >   }
> > >   /**
> > > - * sdma_v5_2_enable - stop the async dma engines
> > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines con=
text switch
> > >    *
> > >    * @adev: amdgpu_device pointer
> > > - * @enable: enable/disable the DMA MEs.
> > >    *
> > > - * Halt or unhalt the async dma engines.
> > > + * Halt the async dma engines context switch.
> > >    */
> > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable=
)
> > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *a=
dev)
> > >   {
> > >     u32 f32_cntl;
> > >     int i;
> > > -   if (!enable) {
> > > -           sdma_v5_2_gfx_stop(adev);
> > > -           sdma_v5_2_rlc_stop(adev);
> > > -   }
> > > +   if (amdgpu_sriov_vf(adev))
> > > +           return;
> > > -   if (!amdgpu_sriov_vf(adev)) {
> > > -           for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > -                   f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_F32_CNTL));
> > > -                   f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CN=
TL, HALT, enable ? 0 : 1);
> > > -                   WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
F32_CNTL), f32_cntl);
> > > -           }
> > > +   for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > +           f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_CNTL));
> > > +           f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > +                           AUTO_CTXSW_ENABLE, 0);
> > > +           WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f=
32_cntl);
> > >     }
> > >   }
> > > +/**
> > > + * sdma_v5_2_halt - stop the async dma engines
> > > + *
> > > + * @adev: amdgpu_device pointer
> > > + *
> > > + * Halt the async dma engines.
> > > + */
> > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > +{
> > > +   sdma_v5_2_gfx_stop(adev);
> > > +   sdma_v5_2_rlc_stop(adev);
> > > +}
>
> Following codes are missing in halt/unhalt,
>
> f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1=
);
> WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
>
> Probably AMDGPU_FW_LOAD_DIRECT(sdma_v5_2_load_microcode) needs these code=
s.
>
> Regards,
> Lang
>
> > > +
> > >   /**
> > >    * sdma_v5_2_gfx_resume - setup and start the async dma engines
> > >    *
> > >    * @adev: amdgpu_device pointer
> > >    *
> > >    * Set up the gfx DMA ring buffers and enable them.
> > > + * It assumes that the dma engine is stopped for each instance.
> > > + * The function enables the engine and preemptions sequentially for =
each instance.
> > > + *
> > >    * Returns 0 for success, error for failure.
> > >    */
> > >   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_de=
vice *adev)
> > >             ring->sched.ready =3D true;
> > > -           if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn=
't need below to lines */
> > > -                   sdma_v5_2_ctx_switch_enable(adev, true);
> > > -                   sdma_v5_2_enable(adev, true);
> > > -           }
> > > +           sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> > >             r =3D amdgpu_ring_test_ring(ring);
> > >             if (r) {
> > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu=
_device *adev)
> > >     int i, j;
> > >     /* halt the MEs */
> > > -   sdma_v5_2_enable(adev, false);
> > > +   sdma_v5_2_halt(adev);
> > >     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > >             if (!adev->sdma.instance[i].fw)
> > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *=
adev)
> > >     int r =3D 0;
> > >     if (amdgpu_sriov_vf(adev)) {
> > > -           sdma_v5_2_ctx_switch_enable(adev, false);
> > > -           sdma_v5_2_enable(adev, false);
> > > +           sdma_v5_2_ctx_switch_disable_all(adev);
> > > +           sdma_v5_2_halt(adev);
> > >             /* set RB registers */
> > >             r =3D sdma_v5_2_gfx_resume(adev);
> > > @@ -881,12 +891,10 @@ static int sdma_v5_2_start(struct amdgpu_device=
 *adev)
> > >             amdgpu_gfx_off_ctrl(adev, false);
> > >     sdma_v5_2_soft_reset(adev);
> > > -   /* unhalt the MEs */
> > > -   sdma_v5_2_enable(adev, true);
> > > -   /* enable sdma ring preemption */
> > > -   sdma_v5_2_ctx_switch_enable(adev, true);
> > > -   /* start the gfx rings and rlc compute queues */
> > > +   /* Soft reset supposes to disable the dma engine and preemption.
> > > +    * Now start the gfx rings and rlc compute queues.
> > > +    */
> > >     r =3D sdma_v5_2_gfx_resume(adev);
> > >     if (adev->in_s0ix)
> > >             amdgpu_gfx_off_ctrl(adev, true);
> > > @@ -1340,8 +1348,8 @@ static int sdma_v5_2_hw_fini(void *handle)
> > >     if (amdgpu_sriov_vf(adev))
> > >             return 0;
> > > -   sdma_v5_2_ctx_switch_enable(adev, false);
> > > -   sdma_v5_2_enable(adev, false);
> > > +   sdma_v5_2_ctx_switch_disable_all(adev);
> > > +   sdma_v5_2_halt(adev);
> > >     return 0;
> > >   }
> >
