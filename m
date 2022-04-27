Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF70C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 12:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E69610F3D6;
	Wed, 27 Apr 2022 12:34:25 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C9B10F3D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 12:34:23 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id b12so1424809plg.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EemUD1mG241i/LdFRr0Uo3D8oelpn5aZEPed00lb0xI=;
 b=MJd7s9YmlAiRHX1qFgsKfMQNfNJ3u5h6FMzr0WQyUKQVhhGMLDfwDYpwTJrHlDEQhS
 zdcf4NNfkG3Ll/CVyKCewUAslZMZbVL+SSLdxlDRlKWdH4+ZSwwczGLSTXeOZHv0Gr2N
 fMxa2DBbK697kxNhE2YxGBtyht6cn0m2EH4ZBfQqDbOhLGmihyu604vM9HOz6iCDFEvn
 oWyepliV2ClayynoyMdWjKvRCailgtWB5jnmpGl9GcwcpVFozoC839RvAuS7eyZrdPD3
 onzkHQ1BkB9siU+h3XHrBx5NVV0u4DYr0zUKUaADqu9vy0uJPUZWfkzH8byPHhTK/TPP
 2qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EemUD1mG241i/LdFRr0Uo3D8oelpn5aZEPed00lb0xI=;
 b=rNnV+WYnL5b0DONksPBs6PtK4nbjX9l5ZJDwW8oKU4h75EsH6f8WEhBsUMYm3IjnU0
 gYppwMNBz45BwaQ8tYA7Cb5fqleJnJWH+9uI26Dr4XNdL7Gkoi6sj3DATnbSzghb3Iri
 giYoj9HFslPHcaFgiqaOqNeSvVHzrMRVjZ+RcYHh7kTXBjJnFnG1p+/U4vGGE/rftYu2
 xAQD0VOWBb1qTt3gwQnNZ+9/ddU0HN6ajjSXz7aC3MZcMxgodOrk5ODX9+ekwqJaM5IE
 NT7mNrYSMiFjYakFp7Pu/VsoxRl3ayvRHxcWI+oOdBi6eeKIiG8jy+HdjMPzxGVa19d+
 KxMQ==
X-Gm-Message-State: AOAM530/lF0W8pbcecq2XVzrbcp8vUklczG1WsWZs7/OQGHfjOnP/Fs8
 keDv9P31hMyJ6p3xxvJu9H1f1ykO0G2mq4jqYxgPHPoKvNTY1A==
X-Google-Smtp-Source: ABdhPJza/q8LaClh0RYPYvLiFbFayocUazJJLwceMaNjYEfj1HtOmKC/OcqYQeFbz6G17o1aTRUy/uaNEsf3x+zcKUg=
X-Received: by 2002:a17:902:8506:b0:154:8692:a7ac with SMTP id
 bj6-20020a170902850600b001548692a7acmr28610681plb.10.1651062862783; Wed, 27
 Apr 2022 05:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220427120947.29053-1-ricetons@gmail.com>
 <b4368e77-b566-d187-f2f5-2df3ba87b22f@amd.com>
In-Reply-To: <b4368e77-b566-d187-f2f5-2df3ba87b22f@amd.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Wed, 27 Apr 2022 20:34:11 +0800
Message-ID: <CAHpOOhHo79o0j-5pp-BoP9YwZ1x0g4fTdikktiG+gOrgqRfQRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I just found out that there are similar issues for sdma v5 and v4.
Will work on patches based on the feedbacks for this one.

On Wed, Apr 27, 2022 at 8:21 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Looks good of hand, but please run your patch through the checkpatch.pl
> script found in the linux kernel source.
>
> I haven't double checked, but of hand a few lines look a bit long.
>
> Christian.
>
> Am 27.04.22 um 14:09 schrieb ricetons@gmail.com:
> > From: Haohui Mai <ricetons@gmail.com>
> >
> > The patch fully deactivates the DMA engine before setting up the ring
> > buffer to avoid potential data races and crashes.
> >
> > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 88 +++++++++++++------------=
-
> >   1 file changed, 45 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 013d2dec81d0..61d58e515fe7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr, u64 se
> >       }
> >   }
> >
> > -
> >   /**
> >    * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> >    *
> > @@ -505,17 +504,18 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_devi=
ce *adev)
> >   }
> >
> >   /**
> > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context sw=
itch
> > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engi=
nes context switch for an instance
> >    *
> >    * @adev: amdgpu_device pointer
> > - * @enable: enable/disable the DMA MEs context switch.
> > + * @i: the index of the SDMA instance
> >    *
> > - * Halt or unhalt the async dma engines context switch.
> > + * Unhalt the async dma engines context switch.
> >    */
> > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bo=
ol enable)
> > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_dev=
ice *adev, int i)
> >   {
> >       u32 f32_cntl, phase_quantum =3D 0;
> > -     int i;
> > +
> > +     BUG_ON(i >=3D adev->sdma.num_instances);
> >
> >       if (amdgpu_sdma_phase_quantum) {
> >               unsigned value =3D amdgpu_sdma_phase_quantum;
> > @@ -539,26 +539,44 @@ static void sdma_v5_2_ctx_switch_enable(struct am=
dgpu_device *adev, bool enable)
> >               phase_quantum =3D
> >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
> >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> > +
> > +             WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_PHASE0_QUANTUM),
> > +                    phase_quantum);
> > +             WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_PHASE1_QUANTUM),
> > +                    phase_quantum);
> > +             WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_PHASE2_QUANTUM),
> > +                    phase_quantum);
> >       }
> >
> > -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > -             if (enable && amdgpu_sdma_phase_quantum) {
> > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_PHASE0_QUANTUM),
> > -                            phase_quantum);
> > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_PHASE1_QUANTUM),
> > -                            phase_quantum);
> > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_PHASE2_QUANTUM),
> > -                            phase_quantum);
> > -             }
> > +     if (!amdgpu_sriov_vf(adev)) {
> > +             f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_CNTL));
> > +             f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > +                             AUTO_CTXSW_ENABLE, 1);
> > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f=
32_cntl);
> > +     }
> > +}
> >
> > -             if (!amdgpu_sriov_vf(adev)) {
> > -                     f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_CNTL));
> > -                     f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > -                                     AUTO_CTXSW_ENABLE, enable ? 1 : 0=
);
> > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
CNTL), f32_cntl);
> > -             }
> > +/**
> > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines conte=
xt switch
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Halt the async dma engines context switch.
> > + */
> > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *ade=
v)
> > +{
> > +     u32 f32_cntl;
> > +     int i;
> > +     if (amdgpu_sriov_vf(adev)) {
> > +             return;
> >       }
> >
> > +     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > +             f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_CNTL));
> > +             f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > +                             AUTO_CTXSW_ENABLE, 0);
> > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f=
32_cntl);
> > +     }
> >   }
> >
> >   /**
> > @@ -571,21 +589,10 @@ static void sdma_v5_2_ctx_switch_enable(struct am=
dgpu_device *adev, bool enable)
> >    */
> >   static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> >   {
> > -     u32 f32_cntl;
> > -     int i;
> > -
> >       if (!enable) {
> >               sdma_v5_2_gfx_stop(adev);
> >               sdma_v5_2_rlc_stop(adev);
> >       }
> > -
> > -     if (!amdgpu_sriov_vf(adev)) {
> > -             for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > -                     f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_F32_CNTL));
> > -                     f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CN=
TL, HALT, enable ? 0 : 1);
> > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
F32_CNTL), f32_cntl);
> > -             }
> > -     }
> >   }
> >
> >   /**
> > @@ -594,6 +601,8 @@ static void sdma_v5_2_enable(struct amdgpu_device *=
adev, bool enable)
> >    * @adev: amdgpu_device pointer
> >    *
> >    * Set up the gfx DMA ring buffers and enable them.
> > + * It assumes that the dma engine is stopped for each instance. The fu=
nction enables the engine and preemptions sequentially for each instance.
> > + *
> >    * Returns 0 for success, error for failure.
> >    */
> >   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > @@ -737,10 +746,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_devi=
ce *adev)
> >
> >               ring->sched.ready =3D true;
> >
> > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn=
't need below to lines */
> > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > -                     sdma_v5_2_enable(adev, true);
> > -             }
> > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> >
> >               r =3D amdgpu_ring_test_ring(ring);
> >               if (r) {
> > @@ -856,7 +862,7 @@ static int sdma_v5_2_start(struct amdgpu_device *ad=
ev)
> >       int r =3D 0;
> >
> >       if (amdgpu_sriov_vf(adev)) {
> > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > +             sdma_v5_2_ctx_switch_disable_all(adev);
> >               sdma_v5_2_enable(adev, false);
> >
> >               /* set RB registers */
> > @@ -881,12 +887,8 @@ static int sdma_v5_2_start(struct amdgpu_device *a=
dev)
> >               amdgpu_gfx_off_ctrl(adev, false);
> >
> >       sdma_v5_2_soft_reset(adev);
> > -     /* unhalt the MEs */
> > -     sdma_v5_2_enable(adev, true);
> > -     /* enable sdma ring preemption */
> > -     sdma_v5_2_ctx_switch_enable(adev, true);
> >
> > -     /* start the gfx rings and rlc compute queues */
> > +     /* Soft reset supposes to disable the dma engine and preemption. =
Now start the gfx rings and rlc compute queues */
> >       r =3D sdma_v5_2_gfx_resume(adev);
> >       if (adev->in_s0ix)
> >               amdgpu_gfx_off_ctrl(adev, true);
> > @@ -1340,7 +1342,7 @@ static int sdma_v5_2_hw_fini(void *handle)
> >       if (amdgpu_sriov_vf(adev))
> >               return 0;
> >
> > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > +     sdma_v5_2_ctx_switch_disable_all(adev);
> >       sdma_v5_2_enable(adev, false);
> >
> >       return 0;
>
