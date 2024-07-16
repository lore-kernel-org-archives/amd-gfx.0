Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED8C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 18:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1611A10E44F;
	Tue, 16 Jul 2024 18:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OVjtXqtI";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648F610E299
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 18:43:48 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-810197638fcso169973241.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721155427; x=1721760227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pW39S5IP5sRwzdRR4GBEoaTGzItLvoiqfzWNythWzps=;
 b=OVjtXqtIN5eUcHSz9oQ+O3c5AlwY5kD5rEwcXUAJ9s0jFoGFIkwT34tcRYzNNgTR8y
 7hCZXOX3OXLGwdcjF0fAXNud1+hnNAnjbXZSxhAdar8ND8Tf2/TY2lcxwDigSaWGUsT5
 XnydUs+LPTom5jyXMizUXIq3usOSyrh0ZT7zs+4W5230Lkz+Gs4MF4q+XQP/EymVYCLF
 i+7fKGt/H2Ad0prvVzOiDpoRoh9rGNVgDPVDafrF4tb98RH24mWNpPoM7JTMHWGswfYe
 bsyhhPIr+O8bGq6MQoVnM/EffuO8FIKyvDHNJ+0xDQ+89JPnzUyAyGPzqnmgKTi745Cv
 D4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155427; x=1721760227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pW39S5IP5sRwzdRR4GBEoaTGzItLvoiqfzWNythWzps=;
 b=DcnbrJA0LPWi3QE0XQ4qJnqgNCCW7OCYa4b078OTz0cH1IVShrxSWt0PBt4aQfBoC9
 zEuU3Utx4W87vhBQDnuQHJoQfZT6hJ4wITSo7bl0lgZJl+sK/UPRhjsg1HFS7L4TguCl
 MSRP271WxEUnNlNsjZlASJvtoV3GQjJNYWms52XCON9+j/UViyL7WKo6RYV1tMsZ9H9i
 8DFiOqeqYcdE8DzLsEcqe6OZHeUUfxWB/baOXYK1tGukSTAwedChKgB3LQxNwtG5REEk
 EZHOyT2/+XN2sxvDmY33ySCjGzHoFhB5+NQ9g5zcqKOaush+R1L78deRHThmI/vwPiNB
 hJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQb9aDFh8xZARBonLnqqTZh8NHYedBp47P0Fo8qjVtWIMBazPHAEiWhC5cDrGgrTSTMz/JJXLJgEgfsKrBMi7rpTb8id+g0Tq9bsSeQA==
X-Gm-Message-State: AOJu0Yxoikvm+a3dNprGSuzuZH8P97+2TBg94UtayHfWupXkZodF08gG
 L/LoWgTCpakvLsEtalrOsWh3P2uOQEzaBi4pX0NbrrVyi/au1lb0COMl8DVV95dWIZoIspX2Yoc
 U0fACpzG8vSVISI7aw8jXcB9jGks=
X-Google-Smtp-Source: AGHT+IG+Srqy8fIwO4tgA1mtQjSzNnt1BrKZsjQuKfHwSRYne6qh6nnvl5vLCR2prQZxnXkVhaQ24Q2qj6c1zUU7DS8=
X-Received: by 2002:a05:6122:1686:b0:4f2:f2e1:5f04 with SMTP id
 71dfb90a1353d-4f4d714aef4mr2255695e0c.8.1721155425445; Tue, 16 Jul 2024
 11:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240716155449.3203419-1-alexander.deucher@amd.com>
 <7ee9f17f-8a75-4818-b54d-efb71a1cd92c@gmx.de>
In-Reply-To: <7ee9f17f-8a75-4818-b54d-efb71a1cd92c@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jul 2024 14:43:31 -0400
Message-ID: <CADnq5_N22Czw6ykD15JQYijMq-PzS6ys2n8BtstLqB-LOFgFOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma5.2: Update wptr registers as well as
 doorbell
To: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 16, 2024 at 2:30=E2=80=AFPM Friedrich Vock <friedrich.vock@gmx.=
de> wrote:
>
> On 16.07.24 17:54, Alex Deucher wrote:
> > We seem to have a case where SDMA will sometimes miss a doorbell
> > if GFX is entering the powergating state when the doorbell comes in.
> > To workaround this, we can update the wptr via MMIO, however,
> > this is only safe because we disallow gfxoff in begin_ring() for
> > SDMA 5.2 and then allow it again in end_ring().
> >
> > Enable this workaround while we are root causing the issue with
> > the HW team.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/3440
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Looks like it works for me.
> Tested-by: Friedrich Vock <friedrich.vock@gmx.de>
>
> Is there a particular reason you chose to still go with the doorbell
> path plus updating the wptr via MMIO instead of setting
> ring->use_doorbell to false? The workaround shipping in SteamOS does
> that - if that has some adverse effects or something like that we should
> probably stop :)

Either way would work I think.  I just wanted to call out in the patch
that any access to SDMA or GFX MMIO needs to be done while gfxoff is
disallowed (via ring begin_use in this case), otherwise, you will hang
if gfx is in the off state.  If you want to go with disabling the
doorbell, we should double check that there are not any other places
where we access MMIO registers directly in the !doorbell case.  I
don't think there are, but I didn't look too closely.

Alex

>
> Thanks,
> Friedrich
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 7e475d9b554e..3c37e3cd3cbf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -225,6 +225,14 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_=
ring *ring)
> >               DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
> >                               ring->doorbell_index, ring->wptr << 2);
> >               WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
> > +             /* SDMA seems to miss doorbells sometimes when powergatin=
g kicks in.
> > +              * Updating the wptr directly will wake it. This is only =
safe because
> > +              * we disallow gfxoff in begin_use() and then allow it ag=
ain in end_use().
> > +              */
> > +             WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_G=
FX_RB_WPTR),
> > +                    lower_32_bits(ring->wptr << 2));
> > +             WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_G=
FX_RB_WPTR_HI),
> > +                    upper_32_bits(ring->wptr << 2));
> >       } else {
> >               DRM_DEBUG("Not using doorbell -- "
> >                               "mmSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> > @@ -1707,6 +1715,10 @@ static void sdma_v5_2_ring_begin_use(struct amdg=
pu_ring *ring)
> >        * but it shouldn't hurt for other parts since
> >        * this GFXOFF will be disallowed anyway when SDMA is
> >        * active, this just makes it explicit.
> > +      * sdma_v5_2_ring_set_wptr() takes advantage of this
> > +      * to update the wptr because sometimes SDMA seems to miss
> > +      * doorbells when entering PG.  If you remove this, update
> > +      * sdma_v5_2_ring_set_wptr() as well!
> >        */
> >       amdgpu_gfx_off_ctrl(adev, false);
> >   }
