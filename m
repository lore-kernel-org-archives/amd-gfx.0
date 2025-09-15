Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758E5CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 161E810E4A0;
	Mon, 15 Sep 2025 13:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kJEhxOoJ";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A060C10E4A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:07:17 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-262346a67c9so4071695ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757941637; x=1758546437; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbfFmXH06ruRttzMU52EVy7mpZbioomjj9i0aeK0rX0=;
 b=kJEhxOoJdJMW2HVAoE2/eLAdDP25KAqCvBuc7z6HYNPFtq12OOe3uFiBi+NI0cx0hL
 /I6kn5mIS0NYxMJmbl/nYhwBMTBRPtfjnhOwdOE6VzAspvqsIv8DHbxDftExBdKtTfp1
 2SQqTHZQPAIi2q5bTwAbSTF78M0XvpMjEVp+630HREeDOJCcxcU0FHZ8BJ6jcy9xk+0u
 MKXCfZjOBVN7Gh/8iFVACupuCVtqqCgPcQSGBmo17C4j39pQhbR28JSqWlDsNynXVjD/
 86gJoZv9ykBtIe5Q6Zrgj2l8qSff8iq7asLVTgiyLTdSGhxKuHTuemy2xvl8kTTNyP0E
 4DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757941637; x=1758546437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbfFmXH06ruRttzMU52EVy7mpZbioomjj9i0aeK0rX0=;
 b=QavLbzru1hREvUkT0eD5l7Gxxou2NWTSdGVA2xqV0R01T1srfCmftc9EymqkDvDMoB
 H8Toz5A62t03Dllmj+SQCPQo/pF+zQJMu8II/RrxnIYlefCyaUI9ZjvEDi0DKmmntrVv
 1Iwd4Ufi+rFASQsidsmOF9PItlE5Skhu97oHPTFUzosLd/4oqeuQYjn6wSrTJapAxuuU
 RZi5SoNLkK25KvTip3IhJbzI3ug6zIRdb0KRv+oM+ifoQc7R5RQ+Sap3l3Bx1Gt26xuX
 mFe9IVkDGRR4pM8gxQJqKeWZ1FE9MReOKhQqO65JG2jTLys/q+EsrEKUc8bM98pGd1BD
 hh/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWelnj1c9VVFdd9uVH8MKELbzQDQ9Up5a3DsgEMGzQ0BDrRFo0ovjXlsSLdcx7G1mexNZ2cGIuK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyglFG2jbdNzEINeM7f5ZO3CMWXa6tXklPr+Rqfd5eoiW4ounMo
 WiWwZZP+IU0BQsmZ/Czz/irN6ej4OeDy2DhMENKMJicZdscR5CGgcvrSN5U6lfYkwM97GVYOkpl
 p5zqD0KdU1AyIZkn7RiCdeocxgKOmhj4=
X-Gm-Gg: ASbGncsFsRVlS6mvtqrk2P5w2Ok41+cPwoMgyWoVcdhEsA36q/1rxxLUwTByRNZJj6j
 CTUpK7oeuCNCT2ZvjnEsiLH8O8knEnoeTaz7Kq0xWu1RnNfL6mlj26tc8Lc3DOFVdYu3Zk3/e+V
 54l7DCFAnYhB9LTLDU0ueYSLe0s0KSz+qyNhaEYnFfic6qKRY3hDlpscGG6R9aQDFpyy/wYxogV
 V+BgUCPvRZlw6RjMg==
X-Google-Smtp-Source: AGHT+IEauUtHy9MpUfTI3RbZw3c6vrOrT37iWOTRnSL20kFZikXwfRgBt89O4n8Ac5mlP9A2rdZ85ZauRlbVPpdzC1g=
X-Received: by 2002:a17:903:1c3:b0:263:cd95:9c8a with SMTP id
 d9443c01a7336-263cd95a9f0mr43649255ad.3.1757941636886; Mon, 15 Sep 2025
 06:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
 <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
 <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
 <8acbb3b27a933b60b17b06a03454cc171f1cefc8.camel@gmail.com>
In-Reply-To: <8acbb3b27a933b60b17b06a03454cc171f1cefc8.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 09:07:04 -0400
X-Gm-Features: Ac12FXzYlQjZclh90VDAym3TowP_piNat7j3ExI8mBb5PoHOVJJJst3XYaUQ3-k
Message-ID: <CADnq5_Ny2WpNtZGSSNY7VtcH8vysgmNOvNCYrNR4efzLAuqVzQ@mail.gmail.com>
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

On Sat, Sep 13, 2025 at 1:28=E2=80=AFAM <timur.kristof@gmail.com> wrote:
>
> On Fri, 2025-09-12 at 15:38 -0400, Alex Deucher wrote:
> > On Thu, Sep 11, 2025 at 2:18=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com>
> > wrote:
> > >
> > > On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher
> > > <alexander.deucher@amd.com> wrote:
> > > >
> > > > SDMA 5.2.x has increased transfer limits.
> > > >
> > > > v2: fix harder, use shifts to make it more obvious
> > > >
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > index a8e39df29f343..bf227eadbe487 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > @@ -2065,11 +2065,11 @@ static void
> > > > sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
> > > >  }
> > > >
> > > >  static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs =3D
> > > > {
> > > > -       .copy_max_bytes =3D 0x400000,
> > > > +       .copy_max_bytes =3D 1 << 30,
> > > >         .copy_num_dw =3D 7,
> > > >         .emit_copy_buffer =3D sdma_v5_2_emit_copy_buffer,
> > > >
> > > > -       .fill_max_bytes =3D 0x400000,
> > > > +       .fill_max_bytes =3D 1 << 30,
> > >
> > > The hw docs and PAL differ here.  I've asked the hw designers to
> > > clarify.
> >
> > The HW team verified that the hardware supports the extended range
> > for
> > both copies and fills.
> >
> > Alex
>
> Hi Alex,
>
> This is still pretty confusing.
> According to PAL, only SDMA v6 has the extended range for fills, and it
> can do 4 bytes fewer.
>
> Are you sure that PAL is wrong about this?

I can talk to the PAL team as well.  I talked to the hardware
designers and they verified that the hardware has the higher limit.
It's the same underlying hardware so it makes sense that both copies
and fills would have the same limit.

>
> For reference:
> https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdma/gf=
x10/gfx10DmaCmdBuffer.cpp
> https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdma/gf=
x12/gfx12DmaCmdBuffer.cpp
>
> MaxCopySize on GFX10: 1 << 22
> MaxCopySize on GFX10.3+: 1 << 30
>
> MaxFillSize on GFX10-10.3: (1 << 22 - 1) & ~3
> MaxFillSize on GFX11+: (1 << 30 - 1) & ~3
> This makes sense because they program the count field in the packet
> using the byte count minus four.

They are setting up the packet for dword fill rather than byte fill so
count becomes dword aligned:

    // Because we will set fillsize =3D 2, the low two bits of our
"count" are ignored, but we still program
    // this in terms of bytes.

Alex
