Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBACAC587
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Sep 2025 05:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36C910E0A9;
	Sat, 13 Sep 2025 05:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="meufiD28";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF90C10E0A9
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Sep 2025 05:28:01 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-24c89867a17so26036605ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757741281; x=1758346081; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W3ldCaMOX0+OX6qHc0Svc9c9K0kmyDROUTAoueH9CdA=;
 b=meufiD28pNUvYA2i1jzvJsOJxyIoPuwoGXOAd3gInG3SPAlzGSxqpkTM+7ecAb6UJD
 2RWufSnH3538hlVZF+EvWvhuWA6XWp3R6xX88VAMRpM5zZFVeJX6vmEOf/PBlKUshekC
 EAQBmslunPN/nmCs7r6I16t1m6FcRt4AbhfghE4g9teXduqyGptt13d+tjHyae+AZMSv
 EyVw1BswX/cPdkaT6biYxGsJrA+0NO4sMZN07nxxB2oiWV8o2eUlQKUdxq4AMxzJdplK
 Q/ikUs4ozNlVHqW3t+BdldFVG2Qi8nhq+Sb7+xmUQ/Eep/eTFIPaojO1o02sxXiIVq+3
 00Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757741281; x=1758346081;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W3ldCaMOX0+OX6qHc0Svc9c9K0kmyDROUTAoueH9CdA=;
 b=jpmXw9k4vYvZ10TDxg31pm2PoYPGap7aEdTBxKrTHZlnIUkSuJLstTY6RXFOGaeM8w
 IyLojMOXAV87+rXhxJcqWp9H8OtADjKH+v49BlU1crmn5Z3ubQp3hSAG457J2YuTbIiL
 4c52mT0TTht+JS3rM4rlA7jeQiOCJGnrf7oUZwEzey0+EboYv6/qFi6gzkYRb2rO8y5I
 prOylyl50DIHbXpo/yJ3TWzyR/lgfq0v74YaErPthgyuZZJGSTch2PgHqtWTVvG1YUV4
 0QvlBh1YVl2Vhx5xR56ZdqdMcbvTUYBEy2dfDoeeSAarUcLYO9lm/dvV3lJBeGJP/e1t
 arFA==
X-Gm-Message-State: AOJu0YxAxUCCLxHWJE4M8o/Fm8cANHvEZJy/GTxzNMWxBXdtEChYay2i
 OfpF4K3/eMljZX9PhY4BtCP6vUa1MfAaD4rfFrJ2MIzrAf9c9Psis0x0
X-Gm-Gg: ASbGncsZfoIuUi8ouh4SRvPcKVs8oF94NAT6LI9iF2kk0n7OMy9sKD5l+8EILRXKHCM
 yvbtZ945GgRnXBEdbyflpkuw1cuFs+qRY6etnDFlw6YBSvPLiXFo9SA+nho0Hks+rB1fvHyobUg
 vL8xAGNCY9W4oeDLuo5LcGeNv65zyplu3/6XbC78meR0/y9YqkDRNyED15uk4EEpGdpGjbON/WQ
 iO19vwjOfgywjIPuGSXWd6rYNz0S4opaQAlwk7U654VKKKTTraj/AH2s9WjjcCQxr1z4o0OnYtj
 eCZZuWgJGc0afwVQ2MMdEn+pd+wBeBNXMkTy785BYEDRowU8MX6DUzDioEOJUYLN7LmrhzhpHtj
 FhoGUMIhp73Chf8IOiFul6EdGXmhDrpJEyX6M/RpN7wv46bPW36Bxts1Oj9cw+OAlQlOs3bffZw
 BU1g==
X-Google-Smtp-Source: AGHT+IFHLW00Z/OxGUErCreVPjbmJv2gg8gctX10HT2F7QMLNdhCALyKsOaoYhqLd53lORdWH7WIlw==
X-Received: by 2002:a17:902:d48a:b0:24c:7b94:2f57 with SMTP id
 d9443c01a7336-25d26865814mr57222315ad.36.1757741281058; 
 Fri, 12 Sep 2025 22:28:01 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:a3f1:d8a2:d12f:314d?
 ([2001:4c4e:24d7:a100:a3f1:d8a2:d12f:314d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3a84a744sm64511285ad.74.2025.09.12.22.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 22:28:00 -0700 (PDT)
Message-ID: <8acbb3b27a933b60b17b06a03454cc171f1cefc8.camel@gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma5.2: adjust SDMA limits
From: timur.kristof@gmail.com
To: Alex Deucher <alexdeucher@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Date: Sat, 13 Sep 2025 07:27:53 +0200
In-Reply-To: <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
References: <20250911172449.3340848-1-alexander.deucher@amd.com>
 <20250911172449.3340848-3-alexander.deucher@amd.com>
 <CADnq5_PNL_-YjyYQgNtz5xQKBxxXWdrvKzM6YT4wYZCOE=ooNQ@mail.gmail.com>
 <CADnq5_OgyiAZJudNfbx9Xt5uiXAXZV1Pe7d2bZPaaD4RdE0GSQ@mail.gmail.com>
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

On Fri, 2025-09-12 at 15:38 -0400, Alex Deucher wrote:
> On Thu, Sep 11, 2025 at 2:18=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om>
> wrote:
> >=20
> > On Thu, Sep 11, 2025 at 1:25=E2=80=AFPM Alex Deucher
> > <alexander.deucher@amd.com> wrote:
> > >=20
> > > SDMA 5.2.x has increased transfer limits.
> > >=20
> > > v2: fix harder, use shifts to make it more obvious
> > >=20
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > index a8e39df29f343..bf227eadbe487 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > > @@ -2065,11 +2065,11 @@ static void
> > > sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
> > > =C2=A0}
> > >=20
> > > =C2=A0static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs =
=3D
> > > {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_max_bytes =3D 0x400000,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_max_bytes =3D 1 << 30,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_num_dw =3D 7,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .emit_copy_buffer =3D sdma=
_v5_2_emit_copy_buffer,
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fill_max_bytes =3D 0x400000,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fill_max_bytes =3D 1 << 30,
> >=20
> > The hw docs and PAL differ here.=C2=A0 I've asked the hw designers to
> > clarify.
>=20
> The HW team verified that the hardware supports the extended range
> for
> both copies and fills.
>=20
> Alex

Hi Alex,

This is still pretty confusing.
According to PAL, only SDMA v6 has the extended range for fills, and it
can do 4 bytes fewer.

Are you sure that PAL is wrong about this?

For reference:
https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdma/gfx1=
0/gfx10DmaCmdBuffer.cpp
https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/hw/gfxip/sdma/gfx1=
2/gfx12DmaCmdBuffer.cpp

MaxCopySize on GFX10: 1 << 22
MaxCopySize on GFX10.3+: 1 << 30

MaxFillSize on GFX10-10.3: (1 << 22 - 1) & ~3
MaxFillSize on GFX11+: (1 << 30 - 1) & ~3
This makes sense because they program the count field in the packet
using the byte count minus four.

Thanks,
Timur
