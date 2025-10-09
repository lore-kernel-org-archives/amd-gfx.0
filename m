Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106F0CCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE51510EB06;
	Thu,  9 Oct 2025 19:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FJR0Klb4";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423DA10EB06
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:38:17 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2697051902fso1908005ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038697; x=1760643497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5agXhBEIp9f7ExW0KrgP/zEl6N9IeqnVfbGs9KPGu/E=;
 b=FJR0Klb4TzIYEizFpVwNmbWfmnFlPHeTUd+O3k5BvdxRIfZ4X3S6yGX3h+CZxFoH1k
 DF56/+A1nSqspxBiPvIS59bakXLYBHRRnL57Q2o1qgfcJhcObK04Xs6A060Cj1BN+fTC
 NRIG2FWzKsZ2rBP01lcO1ROOEiYc7ov0TQio89nGHjjJKMH/49VWpVFQ0+K1OqLt6Zom
 dYDZINfNIXbF4XrpUt9SBDZuv8yeyHRwxT5TKJIpFBEMDr8n3VRuNo7H3pCGuOfu0VIk
 7qfng2boF5Xrz+IFJKV7j2K0VpRqyWWJIh6mfFqQagAJGOk5hwoHiETNZy0i98qOpJ7U
 5McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038697; x=1760643497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5agXhBEIp9f7ExW0KrgP/zEl6N9IeqnVfbGs9KPGu/E=;
 b=BVsXjjwrVo/AgoGrDbaEGeFr0ffKydDnVsqTSZjVNGJTTESLqKSVLHs1aXKUBoi5BD
 /sswqUVZ9KhTTx37/E+rKnzg5REsE3/r0QA8h+R0CiXELilr0tV7JU7H0fUQzExDDde6
 rIDFV2eqVR4VtRQL4O5waN7qsiNSmj+BKwS0fv3VtZQLbpQjFP6apHf5ffh68i+MhSOJ
 l1vXvkK3+ZUCCiNyLpw6/NHbSVIOtQsHev1lIMqT5P/lJeBhVekkbZ7L6L6hL3dIK4wS
 2jAEYUcoGlBD4hBIPgVvemLquFfh7+BrbQR3fNrMyiMYlYlxfMHX3F2Tl5NOQ6Ju9ALa
 sLRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcpMiU5TD1GEj2J3+dYPt2EXIpc5PJ8o+WFdpgUdsLdUB9ueiVSIDf/iti0VsXFbttD2k/HxDQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyB2Lijao/CvdCNlJ1miom3z8+19lteZU8udGEkiXrfHj4Yi6pU
 CyomewZc/ZUov7BDo1llYjoHL4zIt5jLN4jokLY20OgwGDGsb96jnEz0aPPvXvNgG7LLcXnC2tQ
 qLt9OMc1xhLdg8YUWFX/akqjfOYHRZ2o=
X-Gm-Gg: ASbGncvJTy26fBg7GCIZQHqdkO5Vf266OVj4l2I1ccS7DwylFdNxbfhwsTjFqNhUQtt
 qvLwnDMhN2BHa+99y+JXnb5m0GyyD9nrPjcDS+mHdtHUP0U6WQRK/NXq/7jEVyMrUM1ezvNkO9S
 ncomIyNabv2iXrhGZr8MpXGMbwHfMxWrngmE7IhmfGkLc+eKCWUhxcU9nOPFjo8srag0ViAkdAy
 Os5ws7E23DuhKIi9tmx1ivyDJPvTozLRAs5IZSwXQ==
X-Google-Smtp-Source: AGHT+IE59xWAjPx/MbuB8ntS3cS8H9oCmf5clJ+9+e3y7lGhIkRYMwlsRWbfPMUz6exM73EyTHMsObfystD9ueOWY4k=
X-Received: by 2002:a17:902:f541:b0:276:76e1:2e78 with SMTP id
 d9443c01a7336-29027336d54mr68481345ad.10.1760038696818; Thu, 09 Oct 2025
 12:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-4-timur.kristof@gmail.com>
 <221fd37b-e2a4-419c-9ac7-bb9eea0b4f78@amd.com>
 <3b1e453fd8595afb0b4c98855a7a06ba940925a4.camel@gmail.com>
In-Reply-To: <3b1e453fd8595afb0b4c98855a7a06ba940925a4.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:38:05 -0400
X-Gm-Features: AS18NWAfZIzIMhiyfl2F2oilXRXNWxT23Hpex6UB81AUgwagpH9kZEMhRuq1uHU
Message-ID: <CADnq5_OFyAQgZdE7_u9JubGKgxTU89rJLJYwW1hMOi6be0nBzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Set stricter clock dividers on DCE
 6-10
To: timur.kristof@gmail.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, alex.hung@amd.com, 
 harry.wentland@amd.com, siqueira@igalia.com
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

On Sun, Sep 28, 2025 at 7:39=E2=80=AFPM <timur.kristof@gmail.com> wrote:
>
> On Sun, 2025-09-28 at 16:14 +0200, Christian K=C3=B6nig wrote:
> >
> >
> > On 26.09.25 20:26, Timur Krist=C3=B3f wrote:
> > > Set stricter dividers to stabilize the PLL's feedback loop.
> > > In practice, the actual output isn't exactly the target
> > > clock, but slowly oscillates around it. This makes it
> > > more stable.
> > >
> > > The values here are taken from the non-DC code.
> >
> > There are also a bunch of other restrictions which need to be kept in
> > mind.
> >
> > For example what is the minimum feedback divider value the DC code
> > uses?
>
> As far as I see DC doesn't have minimum / maximum limits for the
> feedback divider right now, though I can add that in a future patch if
> necessary.
>
> >
> > We once had a longer discussion with the PLL HW engineers to get this
> > working because at least the display code we used as reference back
> > then got it wrong.
>
> After this series is reviewed, I can look through the other
> restrictions in the amdgpu_atombios_get_clock_info function and write
> another patch series to add those restrictions to DC.
>

The PPLL limits from radeon and the non-DC code were based on the PLL
registers, i.e., what the hardware limit in the register was.  I'm not
sure what the practical limits really are per se.  I.e., if the whole
range is really usable or not.  I would tend to defer to DC.

Alex

> >
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > > b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > > index b4f5b4a6331a..00f25e2ee081 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > > @@ -1700,6 +1700,13 @@ bool dce110_clk_src_construct(
> > >                     clk_src->cs_mask->PLL_POST_DIV_PIXCLK;
> > >     calc_pll_cs_init_data.min_pll_ref_divider =3D     1;
> > >     calc_pll_cs_init_data.max_pll_ref_divider =3D     clk_src-
> > > >cs_mask->PLL_REF_DIV;
> > > +
> > > +   if (ctx->dce_version <=3D DCE_VERSION_10_0) {
> > > +           /* Set stricter dividers to stabilize the PLL's
> > > feedback loop on old HW. */
> > > +           calc_pll_cs_init_data.min_pix_clk_pll_post_divider
> > > =3D 2;
> > > +           calc_pll_cs_init_data.min_pll_ref_divider =3D 2;
> > > +   }
> > > +
> > >     /* when 0 use minInputPxlClkPLLFrequencyInKHz from
> > > firmwareInfo*/
> > >     calc_pll_cs_init_data.min_override_input_pxl_clk_pll_freq_
> > > khz =3D       0;
> > >     /* when 0 use maxInputPxlClkPLLFrequencyInKHz from
> > > firmwareInfo*/
