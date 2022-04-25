Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E91EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 12:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A042610E493;
	Mon, 25 Apr 2022 12:19:20 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A2410E493
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 12:19:20 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id s14so26583321plk.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FuVr8Av9LHLLhOiPYvkts51ZJhEAogLg/W/TEHfhV40=;
 b=T3NEc+qfKJRvL2U/odQ7/j2Va5mNwm8pIY6/WpxMe0S6WYrsJQCA4cowFKju9obS8E
 CZnKmmpw92oA4yna34uuDvSxHo39NJVAvbAcH3dDr/HdaIpOf7XpipUg9ci2arh/tiNA
 m7gGAQ2SXuINDWlicDAKx9k+qeu5vJe8kSIQlL/z7dJS+HfzWbhkTdGU9tivHPnDCGlc
 XgeIG5ndgg1GFxVjuCD6UaKwnX/CcgnmtWpUCE3cTqocAVvph75Rky+5/k3oPKRz9hfe
 Nzf48BfsoeN2YSRq94x4KkUbFHCmC4zNmgy4H8IrxZwSJeIo3oacRtBeXqGawvHXex6J
 lAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FuVr8Av9LHLLhOiPYvkts51ZJhEAogLg/W/TEHfhV40=;
 b=YNDl0fWFCuHHXw4vQTTAyRuCCrIAnWOTaHyjcO5v5nqE5S3ln9PDhlm4T93PLTfoCN
 HFrTqrf1D2KB/MjLs+lLwi4r8ZmwjZ59qAOqdSYxBmLcRukRyBDIlJr8J3GHJCOz1+lX
 eOfOstmZRgydYV8XYJhye4WUfzkA9/44buzSavt7x3zffSeV0S4vCsS0ebFHJBN2eKp8
 OMaXTkK5dwm5cSevTxTC5axNPVsEftfkVqwDZjuRAzErwfZLInB6zpa0FAUVqGA/v93w
 C9pRlCh57Za17P+n16xm6DszhLvWxP5xom5FVj2DWCLwqA1FsuF4q/5C8A2z3QAZjhXH
 0UoA==
X-Gm-Message-State: AOAM5324aU6WSx0MhptmJcHCiPeHEU5hryA6TXSORoFUlmydjuvRLJn+
 hRS12wItAYfpYIXqomxI6Sj05q50wwlxIi+DYo4FUwydlThhVA==
X-Google-Smtp-Source: ABdhPJxUXdJimuHKr9R2h+A4ABxsHEi20opvzTRBX6ZJFgz16G8+828C30LFKXAJDgMORuMm/2a0fA6/yeu1IOqbTak=
X-Received: by 2002:a17:902:8506:b0:154:8692:a7ac with SMTP id
 bj6-20020a170902850600b001548692a7acmr17827948plb.10.1650889159673; Mon, 25
 Apr 2022 05:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHgvsM0YzuhP+9j=PsJLp5s2t9xCmcCOg+LvSiQX8rqug@mail.gmail.com>
 <6b9f94ea-695b-22d7-5d95-e3d3f45c4ef3@gmail.com>
In-Reply-To: <6b9f94ea-695b-22d7-5d95-e3d3f45c4ef3@gmail.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 20:19:06 +0800
Message-ID: <CAHpOOhE7r+m=t3qY3aYLdU2AKp+SBiaL2=M1D45bK=HpE7OB3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix incorrect calculations of the wptr of the
 doorbells
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: emily.deng@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dropped the changes of older generations.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d7e8f7232364..ff86c43b63d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
amdgpu_ring *ring)

                DRM_DEBUG("Using doorbell -- "
                                "wptr_offs =3D=3D 0x%08x "
-                               "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%0=
8x "
-                               "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%0=
8x\n",
+                               "lower_32_bits(ring->wptr << 2) =3D=3D 0x%0=
8x "
+                               "upper_32_bits(ring->wptr << 2) =3D=3D 0x%0=
8x\n",
                                ring->wptr_offs,
                                lower_32_bits(ring->wptr << 2),
                                upper_32_bits(ring->wptr << 2));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index a8d49c005f73..627eb1f147c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
amdgpu_ring *ring)
        if (ring->use_doorbell) {
                DRM_DEBUG("Using doorbell -- "
                                "wptr_offs =3D=3D 0x%08x "
-                               "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%0=
8x "
-                               "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%0=
8x\n",
+                               "lower_32_bits(ring->wptr << 2) =3D=3D 0x%0=
8x "
+                               "upper_32_bits(ring->wptr << 2) =3D=3D 0x%0=
8x\n",
                                ring->wptr_offs,
                                lower_32_bits(ring->wptr << 2),
                                upper_32_bits(ring->wptr << 2));
@@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *a=
dev)

                if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
register write for wptr */
                        WREG32(sdma_v5_0_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR),
-                              lower_32_bits(ring->wptr) << 2);
+                              lower_32_bits(ring->wptr << 2));
                        WREG32(sdma_v5_0_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR_HI),
-                              upper_32_bits(ring->wptr) << 2);
+                              upper_32_bits(ring->wptr << 2));
                }

                doorbell =3D RREG32_SOC15_IP(GC,
sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 824eace69884..a5eb82bfeaa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
amdgpu_ring *ring)
        if (ring->use_doorbell) {
                DRM_DEBUG("Using doorbell -- "
                                "wptr_offs =3D=3D 0x%08x "
-                               "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%0=
8x "
-                               "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%0=
8x\n",
+                               "lower_32_bits(ring->wptr << 2) =3D=3D 0x%0=
8x "
+                               "upper_32_bits(ring->wptr << 2) =3D=3D 0x%0=
8x\n",
                                ring->wptr_offs,
                                lower_32_bits(ring->wptr << 2),
                                upper_32_bits(ring->wptr << 2));
@@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *a=
dev)
                WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);

                if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
register write for wptr */
-                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
                }

                doorbell =3D RREG32_SOC15_IP(GC,
sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
--
2.25.1

On Mon, Apr 25, 2022 at 7:52 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 25.04.22 um 13:47 schrieb Haohui Mai:
> > Updated the commit messages based on the previous discussion.
>
> Please drop all the changes for pre SDMA v4 hardware (e.g. the ones with
> only a 32bit register), so that we only have the changes for the 64bit
> hw versions in here.
>
> Apart from that looks good to me.
>
> Thanks,
> Christian.
>
> >
> > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
> >   drivers/gpu/drm/amd/amdgpu/si_dma.c    | 4 ++--
> >   7 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > index c8ebd108548d..df863d346995 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > @@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ri=
ng *ring)
> >    struct amdgpu_device *adev =3D ring->adev;
> >
> >    WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> > +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
> >   }
> >
> >   static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32=
_t count)
> > @@ -487,7 +487,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device=
 *adev)
> >    WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 4=
0);
> >
> >    ring->wptr =3D 0;
> > - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wpt=
r) << 2);
> > + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wpt=
r << 2));
> >
> >    /* enable DMA RB */
> >    WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > index 1d8bbcbd7a37..b83fd00466fe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > @@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
> > amdgpu_ring *ring)
> >   {
> >    struct amdgpu_device *adev =3D ring->adev;
> >
> > - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > lower_32_bits(ring->wptr) << 2);
> > + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > lower_32_bits(ring->wptr << 2));
> >   }
> >
> >   static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint3=
2_t count)
> > @@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_devic=
e *adev)
> >    WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 4=
0);
> >
> >    ring->wptr =3D 0;
> > - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wpt=
r) << 2);
> > + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wpt=
r << 2));
> >
> >    /* enable DMA RB */
> >    rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > index 4ef4feff5649..557a7d5174b0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
> > amdgpu_ring *ring)
> >    if (ring->use_doorbell) {
> >    u32 *wb =3D (u32 *)&adev->wb.wb[ring->wptr_offs];
> >    /* XXX check if swapping is necessary on BE */
> > - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
> > - WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr) << 2);
> > + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> > + WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2));
> >    } else if (ring->use_pollmem) {
> >    u32 *wb =3D (u32 *)&adev->wb.wb[ring->wptr_offs];
> >
> > - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
> > + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> >    } else {
> > - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > lower_32_bits(ring->wptr) << 2);
> > + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > lower_32_bits(ring->wptr << 2));
> >    }
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > index d7e8f7232364..ff86c43b63d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
> > amdgpu_ring *ring)
> >
> >    DRM_DEBUG("Using doorbell -- "
> >    "wptr_offs =3D=3D 0x%08x "
> > - "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> > - "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
> > + "lower_32_bits(ring->wptr << 2) =3D=3D 0x%08x "
> > + "upper_32_bits(ring->wptr << 2) =3D=3D 0x%08x\n",
> >    ring->wptr_offs,
> >    lower_32_bits(ring->wptr << 2),
> >    upper_32_bits(ring->wptr << 2));
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > index a8d49c005f73..627eb1f147c2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
> > amdgpu_ring *ring)
> >    if (ring->use_doorbell) {
> >    DRM_DEBUG("Using doorbell -- "
> >    "wptr_offs =3D=3D 0x%08x "
> > - "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> > - "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
> > + "lower_32_bits(ring->wptr << 2) =3D=3D 0x%08x "
> > + "upper_32_bits(ring->wptr << 2) =3D=3D 0x%08x\n",
> >    ring->wptr_offs,
> >    lower_32_bits(ring->wptr << 2),
> >    upper_32_bits(ring->wptr << 2));
> > @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_devic=
e *adev)
> >
> >    if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
> > for wptr */
> >    WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> > -        lower_32_bits(ring->wptr) << 2);
> > +        lower_32_bits(ring->wptr << 2));
> >    WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> > -        upper_32_bits(ring->wptr) << 2);
> > +        upper_32_bits(ring->wptr << 2));
> >    }
> >
> >    doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
> > mmSDMA0_GFX_DOORBELL));
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > index 824eace69884..a5eb82bfeaa8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
> > amdgpu_ring *ring)
> >    if (ring->use_doorbell) {
> >    DRM_DEBUG("Using doorbell -- "
> >    "wptr_offs =3D=3D 0x%08x "
> > - "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> > - "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
> > + "lower_32_bits(ring->wptr << 2) =3D=3D 0x%08x "
> > + "upper_32_bits(ring->wptr << 2) =3D=3D 0x%08x\n",
> >    ring->wptr_offs,
> >    lower_32_bits(ring->wptr << 2),
> >    upper_32_bits(ring->wptr << 2));
> > @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_devic=
e *adev)
> >    WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> > mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
> >
> >    if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write
> > for wptr */
> > - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> > lower_32_bits(ring->wptr) << 2);
> > - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> > upper_32_bits(ring->wptr) << 2);
> > + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> > lower_32_bits(ring->wptr << 2));
> > + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> > upper_32_bits(ring->wptr << 2));
> >    }
> >
> >    doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> > mmSDMA0_GFX_DOORBELL));
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > index 195b45bcb8ad..0af11d3b00e7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > @@ -57,7 +57,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *=
ring)
> >    u32 me =3D (ring =3D=3D &adev->sdma.instance[0].ring) ? 0 : 1;
> >
> >    WREG32(DMA_RB_WPTR + sdma_offsets[me],
> > -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> > +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
> >   }
> >
> >   static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
> > @@ -175,7 +175,7 @@ static int si_dma_start(struct amdgpu_device *adev)
> >    WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);
> >
> >    ring->wptr =3D 0;
> > - WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) << 2)=
;
> > + WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr << 2))=
;
> >    WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
> >
> >    ring->sched.ready =3D true;
> > --
> > 2.25.1
>
