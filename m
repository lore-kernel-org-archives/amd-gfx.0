Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5FBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 12:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6F510E789;
	Mon, 25 Apr 2022 12:44:22 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482AC10E789
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 12:44:22 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id c12so26742385plr.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KqsuzFOSziTcu5nEG/bHs8u71eOr/s7lk1Wl2/iher4=;
 b=MvjETy6QpVtqERLcAZJ37TmYH6rO9e5FZ5dk/g2eEPO6HxEXPqIjKm3EQ0a0TA/VZ+
 B8qLgiVizGWoCzC9Zf+5Fax04c2FuqSq8t7eD1pFM257ylTUjHbBkXE9ZxfJ6E2udml1
 NDA9oDxhcNStF0d7lrFOPruQFwodwd/0Wh+5Jc6f4UtIjV1+utd3TpoCU71US8GgnNKx
 4t5U0ORD7yW/bE3wWQLKsG0paVEJ/aLJGV9ALPRFf75LAEbYIvsbEz2JBwDe2rJcsRbq
 /KGMoAy43+9o62uof4d8adnhDwljBl/GKrIAP870oU1BUSpyBkNCn6Yo2mtSGkeoh9xG
 AMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KqsuzFOSziTcu5nEG/bHs8u71eOr/s7lk1Wl2/iher4=;
 b=IGu7S/4IM6+MymdLaPO+mmHZMA6fouwcnwoxLAjn11Ba0GukZcNFhva1cDWtaVhF28
 cf1cxq0b0LN+3e7PCy3bqaZCsCVXSQ0gsEFLbkm47mXTfzedrlmGThlacPjkEUBw1CDd
 jFHcqZX0CUQMuM6dMf7Hdx+CfZLsHhA8+3bBUVDrAHYoXrEwNm5WFH2eumRzW/TyJBih
 AtnHvM8FZVscdNJvV41EsyThMEsdrQF5E27183qwPkZnlRkCOUeQsTLFlQoalGH+HtM5
 5Is1d/eQY4eimKMJX3oVYbUhWriOzXVoW1nmsIA5+kGCaIdaSjxQSajEUHLShac2nUik
 CX/g==
X-Gm-Message-State: AOAM5317PNAI2U3O7zZOrSyMWopzvwf43gIZYmvsXA3fniGLwQEVaFso
 JxkOVaVW8kUTKtDr+HJNlVOykCw4vzgiJy5iE1csfrp09Cw=
X-Google-Smtp-Source: ABdhPJyPp1e3d5116a96Bg1X/4hRbyzthKp2vi8RENupFHnolAjx7XS+axveVGx0w1wyXg+LhFAv9wRxuQldOKniXws=
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id
 b12-20020a17090a488c00b001c7b62e8e8cmr31067686pjh.157.1650890661652; Mon, 25
 Apr 2022 05:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHgvsM0YzuhP+9j=PsJLp5s2t9xCmcCOg+LvSiQX8rqug@mail.gmail.com>
 <6b9f94ea-695b-22d7-5d95-e3d3f45c4ef3@gmail.com>
 <CAHpOOhE7r+m=t3qY3aYLdU2AKp+SBiaL2=M1D45bK=HpE7OB3g@mail.gmail.com>
 <33ff47fa-b719-faae-a63d-4a5c31213f93@gmail.com>
 <CAHpOOhFmZ+oSB0Jskwuho2rDP1V4t9tzMboKA1cMLYsotdUw0g@mail.gmail.com>
In-Reply-To: <CAHpOOhFmZ+oSB0Jskwuho2rDP1V4t9tzMboKA1cMLYsotdUw0g@mail.gmail.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 20:44:08 +0800
Message-ID: <CAHpOOhFAaNqO6PgtHADMFG-AUiJYiAmTRAcWajuQoYZ=6-mgWw@mail.gmail.com>
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

Your prompt reviews are highly appreciated. Thanks.

A little bit off-topic -- I'm not too familiar with the whole process.
Just wondering, what else needs to be done in order to ensure the
patches get picked up in the next available merge window?

Thanks,
Haohui

On Mon, Apr 25, 2022 at 8:41 PM Haohui Mai <ricetons@gmail.com> wrote:
>
> This patch fixes the issue where the driver miscomputes the 64-bit
> values of the wptr of the SDMA doorbell when initializing the
> hardware. SDMA engines v4 and later on have full 64-bit registers for
> wptr thus they should be set properly.
>
> Older generation hardwares like CIK / SI have only 16 / 20 / 24bits
> for the WPTR, where the calls of lower_32_bits() will be removed in a
> following patch.
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index d7e8f7232364..ff86c43b63d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>
>                 DRM_DEBUG("Using doorbell -- "
>                                 "wptr_offs =3D=3D 0x%08x "
> -                               "lower_32_bits(ring->wptr) << 2 =3D=3D 0x=
%08x "
> -                               "upper_32_bits(ring->wptr) << 2 =3D=3D 0x=
%08x\n",
> +                               "lower_32_bits(ring->wptr << 2) =3D=3D 0x=
%08x "
> +                               "upper_32_bits(ring->wptr << 2) =3D=3D 0x=
%08x\n",
>                                 ring->wptr_offs,
>                                 lower_32_bits(ring->wptr << 2),
>                                 upper_32_bits(ring->wptr << 2));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index a8d49c005f73..627eb1f147c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 DRM_DEBUG("Using doorbell -- "
>                                 "wptr_offs =3D=3D 0x%08x "
> -                               "lower_32_bits(ring->wptr) << 2 =3D=3D 0x=
%08x "
> -                               "upper_32_bits(ring->wptr) << 2 =3D=3D 0x=
%08x\n",
> +                               "lower_32_bits(ring->wptr << 2) =3D=3D 0x=
%08x "
> +                               "upper_32_bits(ring->wptr << 2) =3D=3D 0x=
%08x\n",
>                                 ring->wptr_offs,
>                                 lower_32_bits(ring->wptr << 2),
>                                 upper_32_bits(ring->wptr << 2));
> @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device =
*adev)
>
>                 if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
> register write for wptr */
>                         WREG32(sdma_v5_0_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR),
> -                              lower_32_bits(ring->wptr) << 2);
> +                              lower_32_bits(ring->wptr << 2));
>                         WREG32(sdma_v5_0_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI),
> -                              upper_32_bits(ring->wptr) << 2);
> +                              upper_32_bits(ring->wptr << 2));
>                 }
>
>                 doorbell =3D RREG32_SOC15_IP(GC,
> sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 824eace69884..a5eb82bfeaa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
> amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 DRM_DEBUG("Using doorbell -- "
>                                 "wptr_offs =3D=3D 0x%08x "
> -                               "lower_32_bits(ring->wptr) << 2 =3D=3D 0x=
%08x "
> -                               "upper_32_bits(ring->wptr) << 2 =3D=3D 0x=
%08x\n",
> +                               "lower_32_bits(ring->wptr << 2) =3D=3D 0x=
%08x "
> +                               "upper_32_bits(ring->wptr << 2) =3D=3D 0x=
%08x\n",
>                                 ring->wptr_offs,
>                                 lower_32_bits(ring->wptr << 2),
>                                 upper_32_bits(ring->wptr << 2));
> @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device =
*adev)
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
>
>                 if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
> register write for wptr */
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
>                 }
>
>                 doorbell =3D RREG32_SOC15_IP(GC,
> sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> --
> 2.25.1
>
> On Mon, Apr 25, 2022 at 8:33 PM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 25.04.22 um 14:19 schrieb Haohui Mai:
> > > Dropped the changes of older generations.
> > >
> > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> >
> > Please update the commit messages to include all the background we just
> > discussed.
> >
> > With that done the series is Reviewed-by: Christian K=C3=B6nig
> > <christian.koenig@amd.com>
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
> > >   3 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > index d7e8f7232364..ff86c43b63d1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > > @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
> > > amdgpu_ring *ring)
> > >
> > >                  DRM_DEBUG("Using doorbell -- "
> > >                                  "wptr_offs =3D=3D 0x%08x "
> > > -                               "lower_32_bits(ring->wptr) << 2 =3D=
=3D 0x%08x "
> > > -                               "upper_32_bits(ring->wptr) << 2 =3D=
=3D 0x%08x\n",
> > > +                               "lower_32_bits(ring->wptr << 2) =3D=
=3D 0x%08x "
> > > +                               "upper_32_bits(ring->wptr << 2) =3D=
=3D 0x%08x\n",
> > >                                  ring->wptr_offs,
> > >                                  lower_32_bits(ring->wptr << 2),
> > >                                  upper_32_bits(ring->wptr << 2));
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > index a8d49c005f73..627eb1f147c2 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > > @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
> > > amdgpu_ring *ring)
> > >          if (ring->use_doorbell) {
> > >                  DRM_DEBUG("Using doorbell -- "
> > >                                  "wptr_offs =3D=3D 0x%08x "
> > > -                               "lower_32_bits(ring->wptr) << 2 =3D=
=3D 0x%08x "
> > > -                               "upper_32_bits(ring->wptr) << 2 =3D=
=3D 0x%08x\n",
> > > +                               "lower_32_bits(ring->wptr << 2) =3D=
=3D 0x%08x "
> > > +                               "upper_32_bits(ring->wptr << 2) =3D=
=3D 0x%08x\n",
> > >                                  ring->wptr_offs,
> > >                                  lower_32_bits(ring->wptr << 2),
> > >                                  upper_32_bits(ring->wptr << 2));
> > > @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_dev=
ice *adev)
> > >
> > >                  if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
> > > register write for wptr */
> > >                          WREG32(sdma_v5_0_get_reg_offset(adev, i,
> > > mmSDMA0_GFX_RB_WPTR),
> > > -                              lower_32_bits(ring->wptr) << 2);
> > > +                              lower_32_bits(ring->wptr << 2));
> > >                          WREG32(sdma_v5_0_get_reg_offset(adev, i,
> > > mmSDMA0_GFX_RB_WPTR_HI),
> > > -                              upper_32_bits(ring->wptr) << 2);
> > > +                              upper_32_bits(ring->wptr << 2));
> > >                  }
> > >
> > >                  doorbell =3D RREG32_SOC15_IP(GC,
> > > sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > index 824eace69884..a5eb82bfeaa8 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
> > > amdgpu_ring *ring)
> > >          if (ring->use_doorbell) {
> > >                  DRM_DEBUG("Using doorbell -- "
> > >                                  "wptr_offs =3D=3D 0x%08x "
> > > -                               "lower_32_bits(ring->wptr) << 2 =3D=
=3D 0x%08x "
> > > -                               "upper_32_bits(ring->wptr) << 2 =3D=
=3D 0x%08x\n",
> > > +                               "lower_32_bits(ring->wptr << 2) =3D=
=3D 0x%08x "
> > > +                               "upper_32_bits(ring->wptr << 2) =3D=
=3D 0x%08x\n",
> > >                                  ring->wptr_offs,
> > >                                  lower_32_bits(ring->wptr << 2),
> > >                                  upper_32_bits(ring->wptr << 2));
> > > @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_dev=
ice *adev)
> > >                  WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i=
,
> > > mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
> > >
> > >                  if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use
> > > register write for wptr */
> > > -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> > > mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> > > -                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> > > mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> > > +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> > > mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> > > +                       WREG32(sdma_v5_2_get_reg_offset(adev, i,
> > > mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> > >                  }
> > >
> > >                  doorbell =3D RREG32_SOC15_IP(GC,
> > > sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> > > --
> > > 2.25.1
> > >
> > > On Mon, Apr 25, 2022 at 7:52 PM Christian K=C3=B6nig
> > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >> Am 25.04.22 um 13:47 schrieb Haohui Mai:
> > >>> Updated the commit messages based on the previous discussion.
> > >> Please drop all the changes for pre SDMA v4 hardware (e.g. the ones =
with
> > >> only a 32bit register), so that we only have the changes for the 64b=
it
> > >> hw versions in here.
> > >>
> > >> Apart from that looks good to me.
> > >>
> > >> Thanks,
> > >> Christian.
> > >>
> > >>> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > >>> ---
> > >>>    drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 4 ++--
> > >>>    drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
> > >>>    drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 8 ++++----
> > >>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
> > >>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 8 ++++----
> > >>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++----
> > >>>    drivers/gpu/drm/amd/amdgpu/si_dma.c    | 4 ++--
> > >>>    7 files changed, 20 insertions(+), 20 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>> index c8ebd108548d..df863d346995 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > >>> @@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgp=
u_ring *ring)
> > >>>     struct amdgpu_device *adev =3D ring->adev;
> > >>>
> > >>>     WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > >>> -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> > >>> +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
> > >>>    }
> > >>>
> > >>>    static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, u=
int32_t count)
> > >>> @@ -487,7 +487,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_de=
vice *adev)
> > >>>     WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr=
 >> 40);
> > >>>
> > >>>     ring->wptr =3D 0;
> > >>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring-=
>wptr) << 2);
> > >>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring-=
>wptr << 2));
> > >>>
> > >>>     /* enable DMA RB */
> > >>>     WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>> index 1d8bbcbd7a37..b83fd00466fe 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > >>> @@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct
> > >>> amdgpu_ring *ring)
> > >>>    {
> > >>>     struct amdgpu_device *adev =3D ring->adev;
> > >>>
> > >>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > >>> lower_32_bits(ring->wptr) << 2);
> > >>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > >>> lower_32_bits(ring->wptr << 2));
> > >>>    }
> > >>>
> > >>>    static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, =
uint32_t count)
> > >>> @@ -465,7 +465,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_d=
evice *adev)
> > >>>     WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr=
 >> 40);
> > >>>
> > >>>     ring->wptr =3D 0;
> > >>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring-=
>wptr) << 2);
> > >>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], lower_32_bits(ring-=
>wptr << 2));
> > >>>
> > >>>     /* enable DMA RB */
> > >>>     rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE=
, 1);
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>> index 4ef4feff5649..557a7d5174b0 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > >>> @@ -389,14 +389,14 @@ static void sdma_v3_0_ring_set_wptr(struct
> > >>> amdgpu_ring *ring)
> > >>>     if (ring->use_doorbell) {
> > >>>     u32 *wb =3D (u32 *)&adev->wb.wb[ring->wptr_offs];
> > >>>     /* XXX check if swapping is necessary on BE */
> > >>> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
> > >>> - WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr) << 2)=
;
> > >>> + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> > >>> + WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr << 2))=
;
> > >>>     } else if (ring->use_pollmem) {
> > >>>     u32 *wb =3D (u32 *)&adev->wb.wb[ring->wptr_offs];
> > >>>
> > >>> - WRITE_ONCE(*wb, (lower_32_bits(ring->wptr) << 2));
> > >>> + WRITE_ONCE(*wb, (lower_32_bits(ring->wptr << 2)));
> > >>>     } else {
> > >>> - WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > >>> lower_32_bits(ring->wptr) << 2);
> > >>> + WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
> > >>> lower_32_bits(ring->wptr << 2));
> > >>>     }
> > >>>    }
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>> index d7e8f7232364..ff86c43b63d1 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > >>> @@ -772,8 +772,8 @@ static void sdma_v4_0_ring_set_wptr(struct
> > >>> amdgpu_ring *ring)
> > >>>
> > >>>     DRM_DEBUG("Using doorbell -- "
> > >>>     "wptr_offs =3D=3D 0x%08x "
> > >>> - "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> > >>> - "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
> > >>> + "lower_32_bits(ring->wptr << 2) =3D=3D 0x%08x "
> > >>> + "upper_32_bits(ring->wptr << 2) =3D=3D 0x%08x\n",
> > >>>     ring->wptr_offs,
> > >>>     lower_32_bits(ring->wptr << 2),
> > >>>     upper_32_bits(ring->wptr << 2));
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>> index a8d49c005f73..627eb1f147c2 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > >>> @@ -394,8 +394,8 @@ static void sdma_v5_0_ring_set_wptr(struct
> > >>> amdgpu_ring *ring)
> > >>>     if (ring->use_doorbell) {
> > >>>     DRM_DEBUG("Using doorbell -- "
> > >>>     "wptr_offs =3D=3D 0x%08x "
> > >>> - "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> > >>> - "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
> > >>> + "lower_32_bits(ring->wptr << 2) =3D=3D 0x%08x "
> > >>> + "upper_32_bits(ring->wptr << 2) =3D=3D 0x%08x\n",
> > >>>     ring->wptr_offs,
> > >>>     lower_32_bits(ring->wptr << 2),
> > >>>     upper_32_bits(ring->wptr << 2));
> > >>> @@ -774,9 +774,9 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_d=
evice *adev)
> > >>>
> > >>>     if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register w=
rite
> > >>> for wptr */
> > >>>     WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> > >>> -        lower_32_bits(ring->wptr) << 2);
> > >>> +        lower_32_bits(ring->wptr << 2));
> > >>>     WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI=
),
> > >>> -        upper_32_bits(ring->wptr) << 2);
> > >>> +        upper_32_bits(ring->wptr << 2));
> > >>>     }
> > >>>
> > >>>     doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,=
 i,
> > >>> mmSDMA0_GFX_DOORBELL));
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>> index 824eace69884..a5eb82bfeaa8 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > >>> @@ -295,8 +295,8 @@ static void sdma_v5_2_ring_set_wptr(struct
> > >>> amdgpu_ring *ring)
> > >>>     if (ring->use_doorbell) {
> > >>>     DRM_DEBUG("Using doorbell -- "
> > >>>     "wptr_offs =3D=3D 0x%08x "
> > >>> - "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> > >>> - "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n",
> > >>> + "lower_32_bits(ring->wptr << 2) =3D=3D 0x%08x "
> > >>> + "upper_32_bits(ring->wptr << 2) =3D=3D 0x%08x\n",
> > >>>     ring->wptr_offs,
> > >>>     lower_32_bits(ring->wptr << 2),
> > >>>     upper_32_bits(ring->wptr << 2));
> > >>> @@ -672,8 +672,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_d=
evice *adev)
> > >>>     WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
> > >>> mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
> > >>>
> > >>>     if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register w=
rite
> > >>> for wptr */
> > >>> - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> > >>> lower_32_bits(ring->wptr) << 2);
> > >>> - WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> > >>> upper_32_bits(ring->wptr) << 2);
> > >>> + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
> > >>> lower_32_bits(ring->wptr << 2));
> > >>> + WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
> > >>> upper_32_bits(ring->wptr << 2));
> > >>>     }
> > >>>
> > >>>     doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev,=
 i,
> > >>> mmSDMA0_GFX_DOORBELL));
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>> index 195b45bcb8ad..0af11d3b00e7 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > >>> @@ -57,7 +57,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ri=
ng *ring)
> > >>>     u32 me =3D (ring =3D=3D &adev->sdma.instance[0].ring) ? 0 : 1;
> > >>>
> > >>>     WREG32(DMA_RB_WPTR + sdma_offsets[me],
> > >>> -        (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
> > >>> +        (lower_32_bits(ring->wptr << 2)) & 0x3fffc);
> > >>>    }
> > >>>
> > >>>    static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
> > >>> @@ -175,7 +175,7 @@ static int si_dma_start(struct amdgpu_device *a=
dev)
> > >>>     WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);
> > >>>
> > >>>     ring->wptr =3D 0;
> > >>> - WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr) <=
< 2);
> > >>> + WREG32(DMA_RB_WPTR + sdma_offsets[i], lower_32_bits(ring->wptr <<=
 2));
> > >>>     WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
> > >>>
> > >>>     ring->sched.ready =3D true;
> > >>> --
> > >>> 2.25.1
> >
