Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB96C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 11:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E4310E114;
	Mon, 25 Apr 2022 11:14:51 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C501E10E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:14:50 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id n8so26327435plh.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZZ3ZTP14HW+mAtxsm3OOntx+sajSXY+mvr7ahvrmnXs=;
 b=IWQcOccE5y7QIpxlpjY/fhhokSZgCMq0Iv/iOI4GeThvHE6dPrcPekOtyHCvEUyc+u
 9LnB5Lu6qFbayxekj+zBFW7COlbuSeGc/ktQnGhAN2rV5aM3fl+UjbawxK80kDbdl4Zj
 VYzlvkmFvZgt/4UHdjVTeS3fLJ24ErshAUicODo1/labB0FYmtMUoS4GMYX2tQN38Pdc
 QUB8y9tTIvmVUmoMJdNN4kSGYuFGZMKyENFeJlv3T3Vc1aRYlz7GJREpYpUz4WVbih1z
 m27ZsEMU7H64sG1Dn0+EyBYt39LRXpcdGbkykQwpgTZ3ynjmmJ7Hd/0fSkvqUlnFFmFL
 6n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZZ3ZTP14HW+mAtxsm3OOntx+sajSXY+mvr7ahvrmnXs=;
 b=WWgAmblxaeB6Oi89agonu7H1+aU5MzxQk8rPuxS9OnaZ4z5UxS9OH4sn3N2e6fiBjU
 Xj2oitljIX5bXbPADS0Xa+7zkmz2NbDNM8Rrx1ZBtAkNBigS2W1WvdG7sJn1H3nLRevl
 WUkqGkZLJOIC5mgyqAcamjIWG4mAJrEtVZo08n5RESujOTE8Q2DFU7cYtQbqZg0QtQRR
 D88hIn2hNLMzxzq9xalLKw407nMo45wKqFLNg0S2a/WFePYZETV7fPvyfy+pwWXOMThn
 O+3v8um/kesxJSccSdUt4MdLiENzbZMAGl6N56HlZwB4/eqmb8jfaN1YtyQhFpERYMCR
 93iQ==
X-Gm-Message-State: AOAM5329lsu1EzxzJwAkjbm0mDZnYaYpbBvvmfaP/PoZCsXcTirtQxf3
 TWQTdgT9MAfuVq1spIFkIjOGvs027IU1FTg24geyzFuiDA1I3g==
X-Google-Smtp-Source: ABdhPJxeBNrxAQ5e0DyEYk7BjHKUb9AYnChlacma055b67JcSlOB0idtCt814Eqe5Be3sqHjewWP+AH2iOR6mYlDAfE=
X-Received: by 2002:a17:90b:3a88:b0:1d2:acbc:dca5 with SMTP id
 om8-20020a17090b3a8800b001d2acbcdca5mr30655493pjb.188.1650885290175; Mon, 25
 Apr 2022 04:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHuoZzFfXgM35b65pXxAtFoyTFKGYGO2NT7kKZ1-oNN9A@mail.gmail.com>
 <16232337-ce8f-70e1-169b-6ff8d78e2d39@gmail.com>
In-Reply-To: <16232337-ce8f-70e1-169b-6ff8d78e2d39@gmail.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 19:14:39 +0800
Message-ID: <CAHpOOhHDdkXgUGj-3_nPKk0pYoEVEpHFrt+ixhnG8RDU57fVGQ@mail.gmail.com>
Subject: Re: [PATCH] Set the 64-bit address of the wptr of SDMA doorbell
 properly
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

Sorry for the confusion. I misread the code, but it still seems to me
it is a valid issue. What the patch tries to do is to fix the
following pattern:

-                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));

I agree with you that ring->wptr is an offset to the ring. Just
looking at the above lines it seems that they are incorrect when
ring->wptr is larger than 1GB.

As you pointed out that ring->wptr cannot be larger than (1 << 24), it
can be resolved via either (1) fixing the patterns in the provided
patch, or (2) clamping the results to (1 << 24) - 1 and getting rid of
lower_32_bits() / higher_32_bits() at all.

What's your suggestion of moving forward?

Thanks,
Haohui

On Mon, Apr 25, 2022 at 7:02 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 25.04.22 um 11:15 schrieb Haohui Mai:
> > Computing the address of the doorbell should be done before instead of =
after
> > separating the 64-bit address into the higher and lower half. The
> > current code sets the MMIO registers incorrectly if the address of the
> > doorbell is above 1G.
>
> That doesn't make any sense at all. The address of the doorbell is
> completely irrelevant to the value you write into it.
>
> What we could do is to stop using the lower_32_bits() function, since
> the WPTR can't handle more than 16, 20 or 24 bits (IIRC) depending on hw
> generation anyway.
>
> Regards,
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
