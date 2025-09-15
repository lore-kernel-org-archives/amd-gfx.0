Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16521CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B2C10E4AE;
	Mon, 15 Sep 2025 13:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AWZVk2de";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EF710E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:25:29 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-260f41a85f3so4151875ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757942729; x=1758547529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOpDcdA9nNL8e+KM/1tWl0NQsTTJ7B1vdOKOO8TfV50=;
 b=AWZVk2deQn4cAxv1LS0Oyl8DYjiaMo85IrH/zY8sMQhbTQaMNFnex+P47kIjwy5g/e
 ud72rI3xhUuk1U8rIAG25oWG3cFNfNtWLDtMjXorw70ShppOzWU4ZYZdoGzZoY7da+Wt
 wqDRhUCVo66dAuTyIfK1y2AVIcNG5AQyhtCQItaSHSuT5kDyB+VLVTciF9uzSiwmbFbE
 gDq8Le/ll0L/1Gjzxy4ip0RKIPWyb/q15gJpAzEQ0WDc9uPMJApExG0hu8miVwYTGYOu
 tMh/8VMy5Nsdp1C+jd7xrN3E6kq/X9ZCUjzLMNeBz9Ygg5rnZI4z2WjQjKD0La9Mmreh
 aFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942729; x=1758547529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOpDcdA9nNL8e+KM/1tWl0NQsTTJ7B1vdOKOO8TfV50=;
 b=A+bny9KoAsN9g9YKl3nEuSagGS6GdVOIMRLdzdOvPrFWsrMT2jOKEmocDmb9/ks5oO
 nla84o79UVlJ3a0RyL1KPJcHfEqbrvkARW7OrtGcmgp2sLDl0hlVdl3XVj+ou3CM/h4E
 s0QcNr2QeTnzQ7Hkqz8HAtUjBWxjSKsyAN5nLbQTPJajsZwTcBgO7hSBYeIAhGr4vDtg
 nfJjtzjewYWCenpAvsFwprWZQ7fZZf1xLElIPjHtfnnnmmqMZoMTWo/9hd8iHFYsVX05
 3G9Xci05CjuTs5B+8yoF7AXBl+Vw40nUCToTuCvdCQBC4Had0sCZgnCDFsWHRD2goNQG
 WQtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV+Rtoq9FTtCUbhhjbfk3ctjclXxPJWvB/YPGj4pQjpBNVbpanTifADLMQlBg2BYd9WmYJNT7t@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxt4LwU2X5NUq8xN9k0mz2GeJFt8duqrtGUHsoB8ZQnULU7LeKY
 L7vjcR3+zwxJ4Obs8xboG7jd+FXDvaaAp/2gXl5L2givsTj/tgIrQaGlQX3kpG68PvrulVOHBnf
 odvBmDWyMfa0apZ+asa4qFK1sVNTDoOIgOA==
X-Gm-Gg: ASbGncsdSwL6GSSQuB62f6i/d50zXnWamEXoN0lZNQAzl9QIO6UFIgSECQRkSHpgsRs
 cwwptZy6Cwl4D1Th9rnyb+LTFsb1Lu3CnLiH+H4qF+fnMx0vMXKwQH+Q93+TkQT3VDgA/hMVoBj
 oXDZN3JvLdoA1nSPfRBGe9h9a9+rNM3IyQBhz4hRFOZOFSfmkUVrN401hES1jdG5HOSa/PyDAa8
 u4LrO6WaZOsQDUoN6gkKF1O1moe
X-Google-Smtp-Source: AGHT+IFNbNdcvjygWKrEheko6lI8CRZqezBkldGgsswj7bY39UTH9yjyOyGRolIVV4Xmud2XczcSk8Qujpjrcuj52NQ=
X-Received: by 2002:a17:903:ac5:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-25d27c1df3cmr81309285ad.6.1757942729148; Mon, 15 Sep 2025
 06:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
 <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
 <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
 <8acbb3b27a933b60b17b06a03454cc171f1cefc8.camel@gmail.com>
 <CADnq5_Ny2WpNtZGSSNY7VtcH8vysgmNOvNCYrNR4efzLAuqVzQ@mail.gmail.com>
 <8d3396b17fddc8f192c12878b6d01cff8ec7af76.camel@gmail.com>
In-Reply-To: <8d3396b17fddc8f192c12878b6d01cff8ec7af76.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 09:25:17 -0400
X-Gm-Features: Ac12FXzRsvq1xRNKdfaaK3HiYrKhYD5viv86J7lGJ5vlO2uP3uHOyOB7DD7RVYE
Message-ID: <CADnq5_MP84wSK2d1MWXhO9A0ow43Fqbv6DU8ykESNZA0q3648Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
To: timur.kristof@gmail.com
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com
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

On Mon, Sep 15, 2025 at 9:23=E2=80=AFAM <timur.kristof@gmail.com> wrote:
>
> On Mon, 2025-09-15 at 09:07 -0400, Alex Deucher wrote:
> > On Sat, Sep 13, 2025 at 1:28=E2=80=AFAM <timur.kristof@gmail.com> wrote=
:
> > >
> > > On Fri, 2025-09-12 at 15:38 -0400, Alex Deucher wrote:
> > > > On Thu, Sep 11, 2025 at 2:18=E2=80=AFPM Alex Deucher
> > > > <alexdeucher@gmail.com>
> > > > wrote:
> > > > >
> > > > > On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher
> > > > > <alexander.deucher@amd.com> wrote:
> > > > > >
> > > > > > SDMA 5.2.x has increased transfer limits.
> > > > > >
> > > > > > v2: fix harder, use shifts to make it more obvious
> > > > > >
> > > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > index a8e39df29f343..bf227eadbe487 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > @@ -2065,11 +2065,11 @@ static void
> > > > > > sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
> > > > > >  }
> > > > > >
> > > > > >  static const struct amdgpu_buffer_funcs
> > > > > > sdma_v5_2_buffer_funcs =3D
> > > > > > {
> > > > > > -       .copy_max_bytes =3D 0x400000,
> > > > > > +       .copy_max_bytes =3D 1 << 30,
> > > > > >         .copy_num_dw =3D 7,
> > > > > >         .emit_copy_buffer =3D sdma_v5_2_emit_copy_buffer,
> > > > > >
> > > > > > -       .fill_max_bytes =3D 0x400000,
> > > > > > +       .fill_max_bytes =3D 1 << 30,
> > > > >
> > > > > The hw docs and PAL differ here.  I've asked the hw designers
> > > > > to
> > > > > clarify.
> > > >
> > > > The HW team verified that the hardware supports the extended
> > > > range
> > > > for
> > > > both copies and fills.
> > > >
> > > > Alex
> > >
> > > Hi Alex,
> > >
> > > This is still pretty confusing.
> > > According to PAL, only SDMA v6 has the extended range for fills,
> > > and it
> > > can do 4 bytes fewer.
> > >
> > > Are you sure that PAL is wrong about this?
> >
> > I can talk to the PAL team as well.  I talked to the hardware
> > designers and they verified that the hardware has the higher limit.
> > It's the same underlying hardware so it makes sense that both copies
> > and fills would have the same limit.
>
> I am worried that they found some issues with it and that's why they
> didn't enable it.

No objections from me.

>
> >
> > >
> > > For reference:
> > > https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdm=
a/gfx10/gfx10DmaCmdBuffer.cpp
> > > https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdm=
a/gfx12/gfx12DmaCmdBuffer.cpp
> > >
> > > MaxCopySize on GFX10: 1 << 22
> > > MaxCopySize on GFX10.3+: 1 << 30
> > >
> > > MaxFillSize on GFX10-10.3: (1 << 22 - 1) & ~3
> > > MaxFillSize on GFX11+: (1 << 30 - 1) & ~3
> > > This makes sense because they program the count field in the packet
> > > using the byte count minus four.
> >
> > They are setting up the packet for dword fill rather than byte fill
> > so
> > count becomes dword aligned:
> >
> >     // Because we will set fillsize =3D 2, the low two bits of our
> > "count" are ignored, but we still program
> >     // this in terms of bytes.
>
> Yes. I thought we would prefer to use dword fill in the kernel as well,
> isn't that the case? I thought dword fill is faster and everything that
> the kernel fills would be already dword aligned. Am I missing
> something?

Yes, the kernel could be switched to use dword fills as well.

Alex
