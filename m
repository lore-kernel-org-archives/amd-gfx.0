Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7391FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 09:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FF810FC07;
	Fri, 29 Apr 2022 09:03:10 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AC610FC07
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 09:03:09 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id q12so6033688pgj.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/jS7NRwH4z4q7wg3XppcGKqft2dHzmnNi39QsJlwPX8=;
 b=XDg8bfvlfZFbqZbUUEuTFj2PJD3T+mnJu9raElNemL+zU/hCy2q9baPSvt4GzbCYUv
 AgbVNLMCaGsSeaqgUbeZUKqjhpspy/OySlHCsRI8wE3F1dkg379TQYeXMBEcrXTB/Kxa
 mSKcQLVEGsX/xQ5RgYKcUoFR7viIPY0cs5UfQfadZ1F1s9hC7kQ1+sa0NN1Zl1Iz3iPp
 td6FGkRWLNFJ7Z9OKvHh3sRJtFtL2spZWMrbFezOCtFlaBlk9ernZGb609Nd+ow5m9EI
 t5tfO3VoybPcZ/GGp8B+CG9Pcq7x6DBXMuvrbF6wIQJH1EdnCOekKZCqXe5+BzJ0Onh9
 tBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/jS7NRwH4z4q7wg3XppcGKqft2dHzmnNi39QsJlwPX8=;
 b=HlYtWmxZAvL02X/ytdSKOU61/ERKg7gbnoM8/cW1EMsIoesGEI+QAyCVt9r9RjGw/t
 iyAXfBDAa7tT2FZjKpGq7Ppgh7tptKTmcOnNY36SILlj6XLbf6hSJ/WKtNhUM8pd17sk
 vh6paEqRRKMSjx23AH9/IgDsY+WXtRV8gke3VdTPbiG5xm7baureOJRRRkBSvecMScVp
 yke8tFfwhCrayTt0K/7XYlhJNGlNlJReDJI14r6VxpebPoocJ+4e8p5Ct071s9qDA2ha
 nU0EIkISaYFBU1MbEj7wOk6IXEte6DcHOnTSMX7KtaXzI6a6ZKgCWBaD0O0YkgJr+0yH
 IXZw==
X-Gm-Message-State: AOAM532byxTO52BqcECHEPkp2bMylGNbaeg08rtnzxtpNE6gAZjpZXN6
 k6DKWDVIa7UVp5PL1xh+ImZ64q2FlzO43K1+5C8=
X-Google-Smtp-Source: ABdhPJwv1AhBSp6HKEMLrWAA7THU4s65WBgQSkhhLoRy0ZyHCb1U8nrVSjotPj+j42JGz+4qiVNW+bRYZYZDYht40SY=
X-Received: by 2002:a05:6a00:851:b0:50d:62f6:5494 with SMTP id
 q17-20020a056a00085100b0050d62f65494mr16201011pfk.75.1651222989183; Fri, 29
 Apr 2022 02:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220428095327.10513-1-ricetons@gmail.com>
 <YmpsF4F109J3+zzH@lang-desktop>
 <CAHpOOhG76jY2NYWO-kTwvj7Jugu-e9S+hTW6N2HK8nR-k0+mQg@mail.gmail.com>
 <YmqfNbHqsuE/erWL@lang-desktop>
 <CAHpOOhEA-GEgLU9B8RrYo9VnATj62sqnRm+6e3NsHo2H02pD7g@mail.gmail.com>
 <Ymuin6/LGeiz4SE9@lang-desktop>
In-Reply-To: <Ymuin6/LGeiz4SE9@lang-desktop>
From: Haohui Mai <ricetons@gmail.com>
Date: Fri, 29 Apr 2022 17:02:58 +0800
Message-ID: <CAHpOOhEKWgi93gZy0517Lxgm0W3piiiXd4c5Bzb3_a_91x2Rjw@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry about that. But can you please confirm that the call of
sdma_v5_2_ctx_switch_disable_all() is still required to fully disable
the engine?

Thanks,
Haohui

On Fri, Apr 29, 2022 at 4:32 PM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 04/29/ , Haohui Mai wrote:
> > Thanks for pointing it out. The v5 patch added the code back.
> >
> > ~Haohui
>
> But you didn't remove the following codes added in v4.
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
> +               sdma_v5_2_ctx_switch_disable_all(adev);
> +               sdma_v5_2_halt(adev);
> +
>
> sdma_v5_2_halt() has been called in sdma_v5_2_load_microcode().
>
> No need to call these two functions here.
>
> Regards,
> Lang
>
> > On Thu, Apr 28, 2022 at 10:05 PM Lang Yu <Lang.Yu@amd.com> wrote:
> > >
> > > On 04/28/ , Haohui Mai wrote:
> > > > If I understand correctly, the original code will disable the HALT =
bit
> > > > of the register mmSDMA0_F32_CNTL twice on other code paths -- one i=
n
> > > > the sdma_v5_2_ctx_switch_enable() and the other one in
> > > > sdma_v5_2_enable().
> > > >
> > > > The change ensures that the bit is only disabled once. Just wonderi=
ng,
> > > > which one is the expected behavior?
> > > >
> > > > ~Haohui
> > >
> > > The HALT bit of the register mmSDMA0_F32_CNTL is not set/reset in ori=
ginal sdma_v5_2_ctx_switch_enable()
> > > (https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
gitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2F=
drivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Fsdma_v5_2.c%23L523&amp;data=3D05%7C01%=
7CLang.Yu%40amd.com%7C2df035ef6ad5411215a208da299c0253%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637868047861293833%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C=
&amp;sdata=3D%2FLpd6TUyxSe96rEzbyvV0zXNPZ%2BIokiT8KtGAKea8Co%3D&amp;reserve=
d=3D0)
> > >
> > > Regards,
> > > Lang
> > >
> > > > On Thu, Apr 28, 2022 at 6:27 PM Lang Yu <Lang.Yu@amd.com> wrote:
> > > > >
> > > > > On 04/28/ , ricetons@gmail.com wrote:
> > > > > > From: Haohui Mai <ricetons@gmail.com>
> > > > > >
> > > > > > The patch fully deactivates the DMA engine before setting up th=
e ring
> > > > > > buffer to avoid potential data races and crashes.
> > > > > >
> > > > > > The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.c=
om>.
> > > > > >
> > > > > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++---=
--------
> > > > > >  1 file changed, 62 insertions(+), 51 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/g=
pu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > index 013d2dec81d0..b000117b77d0 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struc=
t amdgpu_ring *ring, u64 addr, u64 se
> > > > > >       }
> > > > > >  }
> > > > > >
> > > > > > -
> > > > > >  /**
> > > > > >   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
> > > > > >   *
> > > > > > @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amd=
gpu_device *adev)
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > - * sdma_v5_2_ctx_switch_enable - stop the async dma engines co=
ntext switch
> > > > > > + * sdma_v5_2_ctx_switch_enable_for_instance - start the async =
dma engines
> > > > > > + * context switch for an instance
> > > > > >   *
> > > > > >   * @adev: amdgpu_device pointer
> > > > > > - * @enable: enable/disable the DMA MEs context switch.
> > > > > > + * @instance_idx: the index of the SDMA instance
> > > > > >   *
> > > > > > - * Halt or unhalt the async dma engines context switch.
> > > > > > + * Unhalt the async dma engines context switch.
> > > > > >   */
> > > > > > -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *=
adev, bool enable)
> > > > > > +static void sdma_v5_2_ctx_switch_enable_for_instance(struct am=
dgpu_device *adev, int instance_idx)
> > > > > >  {
> > > > > >       u32 f32_cntl, phase_quantum =3D 0;
> > > > > > -     int i;
> > > > > > +
> > > > > > +     if (WARN_ON(instance_idx >=3D adev->sdma.num_instances)) =
{
> > > > > > +             return;
> > > > > > +     }
> > > > > >
> > > > > >       if (amdgpu_sdma_phase_quantum) {
> > > > > >               unsigned value =3D amdgpu_sdma_phase_quantum;
> > > > > > @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(s=
truct amdgpu_device *adev, bool enable)
> > > > > >               phase_quantum =3D
> > > > > >                       value << SDMA0_PHASE0_QUANTUM__VALUE__SHI=
FT |
> > > > > >                       unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIF=
T;
> > > > > > -     }
> > > > > > -
> > > > > > -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > > > > -             if (enable && amdgpu_sdma_phase_quantum) {
> > > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_off=
set(adev, i, mmSDMA0_PHASE0_QUANTUM),
> > > > > > -                            phase_quantum);
> > > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_off=
set(adev, i, mmSDMA0_PHASE1_QUANTUM),
> > > > > > -                            phase_quantum);
> > > > > > -                     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_off=
set(adev, i, mmSDMA0_PHASE2_QUANTUM),
> > > > > > -                            phase_quantum);
> > > > > > -             }
> > > > > >
> > > > > > -             if (!amdgpu_sriov_vf(adev)) {
> > > > > > -                     f32_cntl =3D RREG32(sdma_v5_2_get_reg_off=
set(adev, i, mmSDMA0_CNTL));
> > > > > > -                     f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA=
0_CNTL,
> > > > > > -                                     AUTO_CTXSW_ENABLE, enable=
 ? 1 : 0);
> > > > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, =
mmSDMA0_CNTL), f32_cntl);
> > > > > > -             }
> > > > > > +             WREG32_SOC15_IP(GC,
> > > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_i=
dx, mmSDMA0_PHASE0_QUANTUM),
> > > > > > +                     phase_quantum);
> > > > > > +             WREG32_SOC15_IP(GC,
> > > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_i=
dx, mmSDMA0_PHASE1_QUANTUM),
> > > > > > +                 phase_quantum);
> > > > > > +             WREG32_SOC15_IP(GC,
> > > > > > +                     sdma_v5_2_get_reg_offset(adev, instance_i=
dx, mmSDMA0_PHASE2_QUANTUM),
> > > > > > +                 phase_quantum);
> > > > > >       }
> > > > > >
> > > > > > +     if (!amdgpu_sriov_vf(adev)) {
> > > > > > +             f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev=
, instance_idx, mmSDMA0_CNTL));
> > > > > > +             f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > > +                             AUTO_CTXSW_ENABLE, 1);
> > > > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, instance_id=
x, mmSDMA0_CNTL), f32_cntl);
> > > > > > +     }
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > - * sdma_v5_2_enable - stop the async dma engines
> > > > > > + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engin=
es context switch
> > > > > >   *
> > > > > >   * @adev: amdgpu_device pointer
> > > > > > - * @enable: enable/disable the DMA MEs.
> > > > > >   *
> > > > > > - * Halt or unhalt the async dma engines.
> > > > > > + * Halt the async dma engines context switch.
> > > > > >   */
> > > > > > -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool =
enable)
> > > > > > +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_dev=
ice *adev)
> > > > > >  {
> > > > > >       u32 f32_cntl;
> > > > > >       int i;
> > > > > >
> > > > > > -     if (!enable) {
> > > > > > -             sdma_v5_2_gfx_stop(adev);
> > > > > > -             sdma_v5_2_rlc_stop(adev);
> > > > > > -     }
> > > > > > +     if (amdgpu_sriov_vf(adev))
> > > > > > +             return;
> > > > > >
> > > > > > -     if (!amdgpu_sriov_vf(adev)) {
> > > > > > -             for (i =3D 0; i < adev->sdma.num_instances; i++) =
{
> > > > > > -                     f32_cntl =3D RREG32(sdma_v5_2_get_reg_off=
set(adev, i, mmSDMA0_F32_CNTL));
> > > > > > -                     f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA=
0_F32_CNTL, HALT, enable ? 0 : 1);
> > > > > > -                     WREG32(sdma_v5_2_get_reg_offset(adev, i, =
mmSDMA0_F32_CNTL), f32_cntl);
> > > > > > -             }
> > > > > > +     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > > > > +             f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_CNTL));
> > > > > > +             f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> > > > > > +                             AUTO_CTXSW_ENABLE, 0);
> > > > > > +             WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
CNTL), f32_cntl);
> > > > > >       }
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * sdma_v5_2_halt - stop the async dma engines
> > > > > > + *
> > > > > > + * @adev: amdgpu_device pointer
> > > > > > + *
> > > > > > + * Halt the async dma engines.
> > > > > > + */
> > > > > > +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> > > > > > +{
> > > > > > +     sdma_v5_2_gfx_stop(adev);
> > > > > > +     sdma_v5_2_rlc_stop(adev);
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * sdma_v5_2_gfx_resume - setup and start the async dma engine=
s
> > > > > >   *
> > > > > >   * @adev: amdgpu_device pointer
> > > > > >   *
> > > > > >   * Set up the gfx DMA ring buffers and enable them.
> > > > > > + * It assumes that the dma engine is stopped for each instance=
.
> > > > > > + * The function enables the engine and preemptions sequentiall=
y for each instance.
> > > > > > + *
> > > > > >   * Returns 0 for success, error for failure.
> > > > > >   */
> > > > > >  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> > > > > > @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amd=
gpu_device *adev)
> > > > > >
> > > > > >               ring->sched.ready =3D true;
> > > > > >
> > > > > > -             if (amdgpu_sriov_vf(adev)) { /* bare-metal sequen=
ce doesn't need below to lines */
> > > > > > -                     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > > > -                     sdma_v5_2_enable(adev, true);
> > > > > > -             }
> > > > > > +             sdma_v5_2_ctx_switch_enable_for_instance(adev, i)=
;
> > > > > >
> > > > > >               r =3D amdgpu_ring_test_ring(ring);
> > > > > >               if (r) {
> > > > > > @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct =
amdgpu_device *adev)
> > > > > >       int i, j;
> > > > > >
> > > > > >       /* halt the MEs */
> > > > > > -     sdma_v5_2_enable(adev, false);
> > > > > > +     sdma_v5_2_halt(adev);
> > > > > >
> > > > > >       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > > > > >               if (!adev->sdma.instance[i].fw)
> > > > > > @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_de=
vice *adev)
> > > > > >       int r =3D 0;
> > > > > >
> > > > > >       if (amdgpu_sriov_vf(adev)) {
> > > > > > -             sdma_v5_2_ctx_switch_enable(adev, false);
> > > > > > -             sdma_v5_2_enable(adev, false);
> > > > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > > +             sdma_v5_2_halt(adev);
> > > > > >
> > > > > >               /* set RB registers */
> > > > > >               r =3D sdma_v5_2_gfx_resume(adev);
> > > > > > @@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_de=
vice *adev)
> > > > > >       }
> > > > > >
> > > > > >       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
) {
> > > > > > +             sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > > +             sdma_v5_2_halt(adev);
> > > > >
> > > > > You don't need call these functions here.
> > > > >
> > > > > In original code, you can see sdma_v5_2_load_microcode() calls
> > > > > sdma_v5_2_enable(adev, false) to halt the engine before load ucod=
e.
> > > > >
> > > > > What I mean is sdma_v5_2_halt(adev) should have no functional cha=
nge with
> > > > > original sdma_v5_2_enable(adev, false), like this,
> > > > >
> > > > > static void sdma_v5_2_halt(struct amdgpu_device *adev) {
> > > > >         u32 f32_cntl;
> > > > >         int i;
> > > > >
> > > > >         sdma_v5_2_gfx_stop(adev);
> > > > >         sdma_v5_2_rlc_stop(adev);
> > > > >
> > > > >         if (!amdgpu_sriov_vf(adev)) {
> > > > >                 for (i =3D 0; i < adev->sdma.num_instances; i++) =
{
> > > > >                         f32_cntl =3D RREG32(sdma_v5_2_get_reg_off=
set(adev, i, mmSDMA0_F32_CNTL));
> > > > >                         f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA=
0_F32_CNTL, HALT, 1);
> > > > >                         WREG32(sdma_v5_2_get_reg_offset(adev, i, =
mmSDMA0_F32_CNTL), f32_cntl);
> > > > >                 }
> > > > >         }
> > > > > }
> > > > >
> > > > > But you remove the codes to set the HLAT bit of register mmSDMA0_=
F32_CNTL.
> > > > >
> > > > > Regards,
> > > > > Lang
> > > > >
> > > > > >               r =3D sdma_v5_2_load_microcode(adev);
> > > > > >               if (r)
> > > > > >                       return r;
> > > > > > @@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_=
device *adev)
> > > > > >               amdgpu_gfx_off_ctrl(adev, false);
> > > > > >
> > > > > >       sdma_v5_2_soft_reset(adev);
> > > > > > -     /* unhalt the MEs */
> > > > > > -     sdma_v5_2_enable(adev, true);
> > > > > > -     /* enable sdma ring preemption */
> > > > > > -     sdma_v5_2_ctx_switch_enable(adev, true);
> > > > > >
> > > > > > -     /* start the gfx rings and rlc compute queues */
> > > > > > +     /* Soft reset supposes to disable the dma engine and pree=
mption.
> > > > > > +      * Now start the gfx rings and rlc compute queues.
> > > > > > +      */
> > > > > >       r =3D sdma_v5_2_gfx_resume(adev);
> > > > > >       if (adev->in_s0ix)
> > > > > >               amdgpu_gfx_off_ctrl(adev, true);
> > > > > > @@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle=
)
> > > > > >       if (amdgpu_sriov_vf(adev))
> > > > > >               return 0;
> > > > > >
> > > > > > -     sdma_v5_2_ctx_switch_enable(adev, false);
> > > > > > -     sdma_v5_2_enable(adev, false);
> > > > > > +     sdma_v5_2_ctx_switch_disable_all(adev);
> > > > > > +     sdma_v5_2_halt(adev);
> > > > > >
> > > > > >       return 0;
> > > > > >  }
> > > > > > --
> > > > > > 2.25.1
> > > > > >
