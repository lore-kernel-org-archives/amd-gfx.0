Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F87ECAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F6210E4AF;
	Mon, 15 Sep 2025 13:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eZKEojRG";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B1E10E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:27:01 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b04271cfc3eso527488966b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757942820; x=1758547620; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mC3uJEYtRWw4J5xGhnxA1nw054/s9vUZBftezMIIGsQ=;
 b=eZKEojRGa0osVm1IQAksCG/lpk7nw0irYmxZzEMKTR5/XM4gQ+qpgeZdBtFPAcaixr
 BBRuhhIVF6fZ20rsitCUeGfjiRmtHluFmeXMFD42B4NLFnaqLEAA2uS0NR5bMPrRN+UH
 jkUPzg3pP5rEwdMZi3FixUsC3irbq1dPJWVYdBtecnnwdB/qFsofH5qfQIe4FdkfzRKQ
 +D7fJNP4jxNoAYSJn1qzeLHS72TB+Nch3OfeuOqaaOzwmy1UFnrVthOqxby/KxQMQZkj
 UCtYfZ7QgF18fdjiSI16CL8NjOWtJK2xEMvGBALS0EUfgmy8H5XaLBosML5Vp9k0z4Ek
 iSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942820; x=1758547620;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mC3uJEYtRWw4J5xGhnxA1nw054/s9vUZBftezMIIGsQ=;
 b=b6epDhs1y3rO8PUQYScR/yH9WkYuKY1t1gaDxVyr7Trk3z+R9XlcNOBIcLOWgcQIXT
 uUEfm5cdo7zCYs+xSGAoV7wFxRpyf9VjMxubYkUNlm5qWJf3VF/XN+6RwMlt3xOnbR7f
 vDCXS2dsqa8ijiFaqbgrg9HTqKj7kxNmfg4klgNh6Rh1knBG2pj2HNZrf0MGukG8098s
 a0YEqzDxjWx8SaiZ1RzKUQM1Pz0L1d8xqYMThuSftZkPW9RqIlmvIqFU6QBfRYoenPtH
 iBQJ38JiAQgxMAsvcf1Yl4s8MZ7i3wqRdMqEdmQ7z9Pxn6btqBUgWlh7vgPAIyp2j4Mz
 4rxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfNcsf7M1G0qeJVeupu0aArCqAHzzDRViVhAeyDAFemXjaRri2rcvBZF3POzlaPFK7BLIk4SiU@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0AzAnGTrtncCUjoDyUzNPizuqN76GPXUlHKTm8F/IKheHm0s6
 s+Spuyl5o0Tsc0teFflmiQVhVO7LrBJYIPLPFLE5Zp7lSsR4EVOYOXnl
X-Gm-Gg: ASbGncvzo+eyGe1elBgHxSy5DXr3ez6KR1C53ce/Fh4uGmF8Y2FSUtKRCQ5LvpIrKHa
 LlhcHYOLsijaJTBasogXdsPrBSzMtsWL4Kbg0XtBl56RGnV5hiVQXYdDunWXx/xvtq1E+JlOY2s
 XVAPDHKMDXZDIpLuAQKsaRrnryr8NgfSTYeYhAwNbKlTiWWjOIHdQXwbQqQiPuJL1X1wQyIwoW2
 ij/qIW1yO0qFIXpgQAQA2jzNC/eO3h4WUXI/L2Yhpf8ZJ617En6+3QI3YLulQwCmXkWw3E9Ax0r
 4OivjtQWtqgxYH1uUREgUFf2GJ1ei1JdcixiCTz0UKqx88/Rbn+LYmJql7F1khHZnxyY/VKD31f
 4Q9y3J9WjwzjhA/8Dg8lNGAMmn7brvuEfAUIZC1EaKy5nzEMeG8tmXY/YozaYBGofO2SqMhqTeS
 8aSVkfgh4dxx2FQg==
X-Google-Smtp-Source: AGHT+IHW9DAjESKzStY1QTDNosbFpUWZGiFtvT3kHZ+QxedmmvYvrx2ixbXLFnf28b6SBqcTuaM8Cw==
X-Received: by 2002:a17:906:7951:b0:b04:61aa:6adc with SMTP id
 a640c23a62f3a-b07c353e8acmr1288725466b.7.1757942820130; 
 Mon, 15 Sep 2025 06:27:00 -0700 (PDT)
Received: from ?IPv6:2a0a:f640:1501:b1db:c5c6:e8a1:c6ef:dac9?
 ([2a0a:f640:1501:b1db:c5c6:e8a1:c6ef:dac9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32dd5a9sm935845066b.57.2025.09.15.06.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 06:26:59 -0700 (PDT)
Message-ID: <f0daeb2ed2fb50641c1f99780f4b24910a9ecd94.camel@gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
From: timur.kristof@gmail.com
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
Date: Mon, 15 Sep 2025 15:26:57 +0200
In-Reply-To: <CADnq5_MP84wSK2d1MWXhO9A0ow43Fqbv6DU8ykESNZA0q3648Q@mail.gmail.com>
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
 <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
 <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
 <8acbb3b27a933b60b17b06a03454cc171f1cefc8.camel@gmail.com>
 <CADnq5_Ny2WpNtZGSSNY7VtcH8vysgmNOvNCYrNR4efzLAuqVzQ@mail.gmail.com>
 <8d3396b17fddc8f192c12878b6d01cff8ec7af76.camel@gmail.com>
 <CADnq5_MP84wSK2d1MWXhO9A0ow43Fqbv6DU8ykESNZA0q3648Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Mon, 2025-09-15 at 09:25 -0400, Alex Deucher wrote:
> On Mon, Sep 15, 2025 at 9:23=E2=80=AFAM <timur.kristof@gmail.com> wrote:
> >=20
> > On Mon, 2025-09-15 at 09:07 -0400, Alex Deucher wrote:
> > > On Sat, Sep 13, 2025 at 1:28=E2=80=AFAM <timur.kristof@gmail.com> wro=
te:
> > > >=20
> > > > On Fri, 2025-09-12 at 15:38 -0400, Alex Deucher wrote:
> > > > > On Thu, Sep 11, 2025 at 2:18=E2=80=AFPM Alex Deucher
> > > > > <alexdeucher@gmail.com>
> > > > > wrote:
> > > > > >=20
> > > > > > On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher
> > > > > > <alexander.deucher@amd.com> wrote:
> > > > > > >=20
> > > > > > > SDMA 5.2.x has increased transfer limits.
> > > > > > >=20
> > > > > > > v2: fix harder, use shifts to make it more obvious
> > > > > > >=20
> > > > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > ---
> > > > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> > > > > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > index a8e39df29f343..bf227eadbe487 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > > > @@ -2065,11 +2065,11 @@ static void
> > > > > > > sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
> > > > > > > =C2=A0}
> > > > > > >=20
> > > > > > > =C2=A0static const struct amdgpu_buffer_funcs
> > > > > > > sdma_v5_2_buffer_funcs =3D
> > > > > > > {
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_max_bytes =3D 0x4=
00000,
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_max_bytes =3D 1 <=
< 30,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_num_dw =3D 7=
,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .emit_copy_buffer =
=3D sdma_v5_2_emit_copy_buffer,
> > > > > > >=20
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fill_max_bytes =3D 0x4=
00000,
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fill_max_bytes =3D 1 <=
< 30,
> > > > > >=20
> > > > > > The hw docs and PAL differ here.=C2=A0 I've asked the hw
> > > > > > designers
> > > > > > to
> > > > > > clarify.
> > > > >=20
> > > > > The HW team verified that the hardware supports the extended
> > > > > range
> > > > > for
> > > > > both copies and fills.
> > > > >=20
> > > > > Alex
> > > >=20
> > > > Hi Alex,
> > > >=20
> > > > This is still pretty confusing.
> > > > According to PAL, only SDMA v6 has the extended range for
> > > > fills,
> > > > and it
> > > > can do 4 bytes fewer.
> > > >=20
> > > > Are you sure that PAL is wrong about this?
> > >=20
> > > I can talk to the PAL team as well.=C2=A0 I talked to the hardware
> > > designers and they verified that the hardware has the higher
> > > limit.
> > > It's the same underlying hardware so it makes sense that both
> > > copies
> > > and fills would have the same limit.
> >=20
> > I am worried that they found some issues with it and that's why
> > they
> > didn't enable it.
>=20
> No objections from me.
>=20
> >=20
> > >=20
> > > >=20
> > > > For reference:
> > > > https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/s=
dma/gfx10/gfx10DmaCmdBuffer.cpp
> > > > https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/s=
dma/gfx12/gfx12DmaCmdBuffer.cpp
> > > >=20
> > > > MaxCopySize on GFX10: 1 << 22
> > > > MaxCopySize on GFX10.3+: 1 << 30
> > > >=20
> > > > MaxFillSize on GFX10-10.3: (1 << 22 - 1) & ~3
> > > > MaxFillSize on GFX11+: (1 << 30 - 1) & ~3
> > > > This makes sense because they program the count field in the
> > > > packet
> > > > using the byte count minus four.
> > >=20
> > > They are setting up the packet for dword fill rather than byte
> > > fill
> > > so
> > > count becomes dword aligned:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 // Because we will set fillsize =3D 2, the low two=
 bits of our
> > > "count" are ignored, but we still program
> > > =C2=A0=C2=A0=C2=A0 // this in terms of bytes.
> >=20
> > Yes. I thought we would prefer to use dword fill in the kernel as
> > well,
> > isn't that the case? I thought dword fill is faster and everything
> > that
> > the kernel fills would be already dword aligned. Am I missing
> > something?
>=20
> Yes, the kernel could be switched to use dword fills as well.
>=20

Oh, I see.
I thought the kernel already used dword fills.
If it doesn't, I can write a patch to do so.
