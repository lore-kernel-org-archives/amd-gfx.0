Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5C0CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3C310E4AC;
	Mon, 15 Sep 2025 13:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iE+0bAzM";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DCE10E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:23:50 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so714649066b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757942628; x=1758547428; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bf8O8DyfBsawQReRgz18yTs9npv93jERahwAAQKELds=;
 b=iE+0bAzMYRxC5eg+UDGehspM2x4JwcwGor8dLQ2uSgz2MrA7CkF/NShDZbMstFVWTA
 XyZeoZrp7jogjOO8lkTxGdIJ8jsG5Nvt3sz0rQhJIzrKFSh478+euxNLeCPOBxqlBJFR
 cNmDB0j8gSApQFHoKIUA5I0fpqPqP2oqqzkb3EmzOr6io0IbjJeVzMw6htQmpkWONY40
 qqfGd0JN2r5c9Wl3LBou+6kE1888n/gfNkes/2qA5R7z/VzwvoLu9t2TVz5TlYCiYgy/
 O3GvUYvgBv6h54dq3evsuxNdGQIMpQFUnhOoUZdDNX666DSfH+e7ZebV/6iDiME5JTu4
 qQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942628; x=1758547428;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bf8O8DyfBsawQReRgz18yTs9npv93jERahwAAQKELds=;
 b=UljdsAPRWCVKZ3HxcObX3OhTOdEVboWNS218tLcr/9U5xg2rnIl6fOZD1dngRpKdDL
 s7S6/pCXmLdv4taBSX5ctYzy9mNPA/htn7AIJARqYzLEv2+P5Csav+xxYJ8kocD9IFU9
 exWtEWX9ucDf3k0Tpjw9hO7Woc3uIjv9huG4SnuSJK4pw1ZzBN30++mDONHJwEXSxJaZ
 lFzHK7IAoqohI5kRJjkzfrSy/Z3qDmcZ0EbhB7vDBo9DvUhx7QgeWAx2hBoXNGZeYXp/
 EYO5yrMXlyeH7OXCLUKIlKz2uruZf4AT/d5XIM7z5dU+363AqC2UkWshu+4TnYzN2fXY
 MSLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuDpiBl0mC6CXxa0vdCGWq52egk169laYAz9iLbBFn+yICnh5Jeg5nBm6+oQp8xUdIY0GD8MCt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGb125UgQjWheW2/RmDBcJ60BmQH+nXuMiJiRX1jf+KB5pWeXg
 zL3OvzAcKGR9l/UhZoKBqJ8+NkRQVcUX2uQhQ0qXH1iQ95SnhMDI0Fec
X-Gm-Gg: ASbGnctuaeFymUmgwxcKjljnaj0V7OHvlNeEdyIcGHq7/jbmvfS/mKd/5ARQA4CgIYr
 Duu6ApwJHRjaJga8D0DiMMyD1zQZ5X1dBXpvPA0y9buG7sJxo2hzC28m1PTF0bNqekb+064FsS5
 Mdz5CeqmFFnmAHSVX/wMFE6zgtOLkMv3nHDd79DczWd8SsJruUOD0q2NQsvj7jpORz2dpkW9gYf
 6c7KeS5wuUOTpIAWenzgrmCSDMiqQDAoGth5jf9Sq798cKWKDliyDeDWMkceA1dxXvgk8LBzIkX
 Ugnpkyox9IdqnClaC7tgB5XYnoi2inTDPIk3fnnXAq4UplErr4CBYarGbkPel5Qx3hth+sA4L8Q
 IqQMISUUBw2e72cc+X2r519j5n5+QwFkkoOm5Xxvbu8wCFmmWd7WN5yKsXBidjjNvphExtSlqJ2
 R+6DCMWLWhSNEdiBAMehnH/eMl
X-Google-Smtp-Source: AGHT+IECqGHZoMkwSvHX1Ie93xmgbITJLNdt22Ggnygt1W/UdQXlMUb1YUo0LHYag2atlog6/498/g==
X-Received: by 2002:a17:907:989:b0:b04:6e94:f317 with SMTP id
 a640c23a62f3a-b07c35fb4c3mr1009903866b.34.1757942628033; 
 Mon, 15 Sep 2025 06:23:48 -0700 (PDT)
Received: from ?IPv6:2a0a:f640:1501:b1db:c5c6:e8a1:c6ef:dac9?
 ([2a0a:f640:1501:b1db:c5c6:e8a1:c6ef:dac9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b3128506sm947524066b.28.2025.09.15.06.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 06:23:47 -0700 (PDT)
Message-ID: <8d3396b17fddc8f192c12878b6d01cff8ec7af76.camel@gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
From: timur.kristof@gmail.com
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
Date: Mon, 15 Sep 2025 15:23:45 +0200
In-Reply-To: <CADnq5_Ny2WpNtZGSSNY7VtcH8vysgmNOvNCYrNR4efzLAuqVzQ@mail.gmail.com>
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
 <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
 <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
 <8acbb3b27a933b60b17b06a03454cc171f1cefc8.camel@gmail.com>
 <CADnq5_Ny2WpNtZGSSNY7VtcH8vysgmNOvNCYrNR4efzLAuqVzQ@mail.gmail.com>
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

On Mon, 2025-09-15 at 09:07 -0400, Alex Deucher wrote:
> On Sat, Sep 13, 2025 at 1:28=E2=80=AFAM <timur.kristof@gmail.com> wrote:
> >=20
> > On Fri, 2025-09-12 at 15:38 -0400, Alex Deucher wrote:
> > > On Thu, Sep 11, 2025 at 2:18=E2=80=AFPM Alex Deucher
> > > <alexdeucher@gmail.com>
> > > wrote:
> > > >=20
> > > > On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher
> > > > <alexander.deucher@amd.com> wrote:
> > > > >=20
> > > > > SDMA 5.2.x has increased transfer limits.
> > > > >=20
> > > > > v2: fix harder, use shifts to make it more obvious
> > > > >=20
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > ---
> > > > > =C2=A0drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> > > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > index a8e39df29f343..bf227eadbe487 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > > > @@ -2065,11 +2065,11 @@ static void
> > > > > sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
> > > > > =C2=A0}
> > > > >=20
> > > > > =C2=A0static const struct amdgpu_buffer_funcs
> > > > > sdma_v5_2_buffer_funcs =3D
> > > > > {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_max_bytes =3D 0x40000=
0,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_max_bytes =3D 1 << 30=
,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_num_dw =3D 7,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .emit_copy_buffer =3D =
sdma_v5_2_emit_copy_buffer,
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fill_max_bytes =3D 0x40000=
0,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fill_max_bytes =3D 1 << 30=
,
> > > >=20
> > > > The hw docs and PAL differ here.=C2=A0 I've asked the hw designers
> > > > to
> > > > clarify.
> > >=20
> > > The HW team verified that the hardware supports the extended
> > > range
> > > for
> > > both copies and fills.
> > >=20
> > > Alex
> >=20
> > Hi Alex,
> >=20
> > This is still pretty confusing.
> > According to PAL, only SDMA v6 has the extended range for fills,
> > and it
> > can do 4 bytes fewer.
> >=20
> > Are you sure that PAL is wrong about this?
>=20
> I can talk to the PAL team as well.=C2=A0 I talked to the hardware
> designers and they verified that the hardware has the higher limit.
> It's the same underlying hardware so it makes sense that both copies
> and fills would have the same limit.

I am worried that they found some issues with it and that's why they
didn't enable it.

>=20
> >=20
> > For reference:
> > https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdma/=
gfx10/gfx10DmaCmdBuffer.cpp
> > https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdma/=
gfx12/gfx12DmaCmdBuffer.cpp
> >=20
> > MaxCopySize on GFX10: 1 << 22
> > MaxCopySize on GFX10.3+: 1 << 30
> >=20
> > MaxFillSize on GFX10-10.3: (1 << 22 - 1) & ~3
> > MaxFillSize on GFX11+: (1 << 30 - 1) & ~3
> > This makes sense because they program the count field in the packet
> > using the byte count minus four.
>=20
> They are setting up the packet for dword fill rather than byte fill
> so
> count becomes dword aligned:
>=20
> =C2=A0=C2=A0=C2=A0 // Because we will set fillsize =3D 2, the low two bit=
s of our
> "count" are ignored, but we still program
> =C2=A0=C2=A0=C2=A0 // this in terms of bytes.

Yes. I thought we would prefer to use dword fill in the kernel as well,
isn't that the case? I thought dword fill is faster and everything that
the kernel fills would be already dword aligned. Am I missing
something?

Thanks,
Timur
