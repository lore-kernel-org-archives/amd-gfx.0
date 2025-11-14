Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CA9CE7B1B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 15:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEDA10EAB9;
	Fri, 14 Nov 2025 15:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EejjUjL8";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF7310EAB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 15:04:20 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so23360455e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763132659; x=1763737459; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SMgX6AbypYTljNnMiT7wM53fpPA055zzmHOGrcqpJ/A=;
 b=EejjUjL8YGOPhCvcnz9M05ZktImvb9eECvaXWCrev9SWgzhibSo+GrrQm7FPTbSBWj
 wGwvlbgA/4EwmWbR6tl3Gx49cymv/eZniPmzfOxWgTR5DImbiR7mMRRzG/exLa1j/zaQ
 S5ok3GQmZco4MhAf87pewHLc5CZOZjp4rCyyVqElSGbNrpfLH6yaZ5RhXkzymyZ0rKyF
 9TgcgK2anQAUg4x1Z7SHnhtVmFnQF3gvvHp1TH8NQf7qiwhhI2BUAUJe+XbSi0nNlAGK
 x6r6nr9+CBecdbTNn02Wom881diNBlUx53cr0udyugfUQWxYTLyUtajQ2bPLZGtXkVtF
 5iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763132659; x=1763737459;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMgX6AbypYTljNnMiT7wM53fpPA055zzmHOGrcqpJ/A=;
 b=O+dBe5I7D1aJZU9V7LUzDuWIVBJkLpK+pq44EympfLrkVpDSoEzanMcO06zWR3EjVa
 CEzJveWw8kBa9iG45RkcD4YH+QcMjTUtwNBVKfAOj3IQCa3MWzaaqmhtl/f8aL/l2gVy
 Mfmlr0mhpvm6/z/pn9tvqp9SJRrLKU/Ncr69XsjqV1ru8pqpPyrqevC6TxO3YkZvbqgc
 Ns3ZQKgWyZKATivtFwaKWBqeca1EC+K1QrWThOpUi+X95Fy0AkNoxvlX/TD19EvCh7p8
 UB2ALzB8Z4UDckIcKAVJkmIYoQwVIhShIwoFSPk3OkTuvZ1bb+k0nDccB4PqOJx0VARG
 3S2w==
X-Gm-Message-State: AOJu0Yxb8ybQT5mqpOu2cRzVgLe0Twl6KrWT15kL1pWHccXIxLtmwCjy
 N62NtpnKvERXRiwjlICzHiVvWzzHsWbXS7/kuOEFieUXq5VW2QHISHGC
X-Gm-Gg: ASbGncvzbGzX7IOu5n20UjYNSjSDJ5NeDHkmm8lF3TvXdhHXTxHRXVCklkMBYg6+tbh
 XMvAQ5pXo6WYz7zYBrsR5ljlVYiDWh5+iODOYs0fpTfTq6dqNxT0loNXGEiGpfRaCDnlQr5iAhS
 +Wxv6/dA0XQ3Suxh83jv0fc5RQkE0YWT//+IsEq79u33UH6/1llZ0Wm5BXSS0cUrmEz2jo//8Ka
 E1P7su3bncOgjCUPvyPPs8/aSVxjAnakRw443xQMdkTIG58tbGVbdSGI27j27QeIyeKhRzH55TT
 cL4BODgnnkw1Mg9DIX5+s+bdHvinAdfh/xhoIsf2fl2Wvs3528yqIqL2Ebxi1VPfLKgrgPsJ2Mp
 3jXoumYjzMAbLAgxfjRSsZnS9h0nZftVfhgh7fi+0WXRVKPgRl60xyTmXmDHvQdiANuam0hnxxT
 PSNVGxrFd9S5uCbNM4EvGIdLIcGWZDCERc4SaXPtkxkSfaryPTpzen5CwxixS3VcwJ9MjzBW6Ff
 /v8jFZlqh/Oir/NHCzWM7zTKKiFjIuVEfumLY69tSHf/hdr4pAAM1D9Gd5KpHWdx0Vwus2KfQ==
X-Google-Smtp-Source: AGHT+IHqGd4fJ1hGCAeK4otn05Cv8svtMGdloQoyUpJ6dCpBOd1EyIiYSmVKW2h9Vcv8o/D1PxTy7w==
X-Received: by 2002:a05:600c:138d:b0:475:d8b3:a9d5 with SMTP id
 5b1f17b1804b1-4778fe5de6fmr32950425e9.10.1763132658663; 
 Fri, 14 Nov 2025 07:04:18 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24e1:af00:ca8b:1d2c:125:e560?
 (20014C4E24E1AF00CA8B1D2C0125E560.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b12asm10257536f8f.10.2025.11.14.07.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:04:18 -0800 (PST)
Message-ID: <a82ec5c897465f4bdbbe1246ccdda7e4428db38f.camel@gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Use amdgpu by default on SI and CIK
 dedicated GPUs (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Fri, 14 Nov 2025 16:04:17 +0100
In-Reply-To: <CADnq5_PUb6_Ti=BfK++DNVD5JmDECJq-jFmQZms-T0QmB8L9qQ@mail.gmail.com>
References: <20251114120736.31310-1-timur.kristof@gmail.com>
 <72c36b2f-4996-48f0-bcfe-87faf4ffba29@amd.com>
 <CADnq5_PUb6_Ti=BfK++DNVD5JmDECJq-jFmQZms-T0QmB8L9qQ@mail.gmail.com>
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

On Fri, 2025-11-14 at 09:38 -0500, Alex Deucher wrote:
> I had already applied the CIK series, so I rebased this series and
> applied the documentation update and the SI patch.
>=20
> Thanks,
>=20
> Alex

Perfect, thank you!


>=20
> On Fri, Nov 14, 2025 at 7:16=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >=20
> > On 11/14/25 13:07, Timur Krist=C3=B3f wrote:
> > > Changed in v2 of the patch series:
> > > Updated documentation in Kconfig file.
> > >=20
> > > Now that the DC analog connector support and VCE1 support
> > > landed, amdgpu is at feature parity with the old radeon
> > > driver on SI and CIK dedicated GPUs.
> > >=20
> > > Let's enable amdgpu by default on SI and CIK dedicated GPUs.
> > >=20
> > > Why?
> > >=20
> > > Compared to the old radeon driver, amdgpu offers better
> > > performance, more display features through DC,
> > > as well as support for Vulkan 1.3 through RADV.
> > > (Note, although the hardware is 10 years old, the R9 290
> > > still appears in the Steam hardware survey for Linux
> > > at a modest 0.25%.)
> > >=20
> > > What can these GPUs actually do on amdgpu?
> > >=20
> > > Hawaii (eg. R9 390X) can even play modern games such as
> > > Baldur's Gate 3 or Cyberpunk 2077 and gives a decent user
> > > experience considering the age of the hardware.
> > > Tahiti and Pitcairn can play some modern games, albeit
> > > at lower resolutions and lower frame rates. They are
> > > mainly held back by a low amount of VRAM (2~3 GiB).
> > > The other SI and CIK "gaming" GPUs are mainly useful
> > > for playing games from their era (the mid-2010s)
> > > or less demanding games in general.
> > >=20
> > > CIK dedicated GPUs are the following:
> > >=20
> > > Hawaii (2013~2015):
> > > =C2=A0 Radeon R9 290 and 390 series
> > > Bonaire (2013~2016):
> > > =C2=A0 Radeon HD 7790/8870
> > > =C2=A0 Radeon R7 260/360/450, RX 455
> > > =C2=A0 FirePro W5100
> > > =C2=A0 various mobile GPUs
> > >=20
> > > SI dedicated GPUs are the following:
> > >=20
> > > Tahiti (2012~2014):
> > > =C2=A0 Radeon HD 7870 XT, 7950, 7970, 7990, 8950, 8970, 8990
> > > =C2=A0 Radeon R9 280, 280X
> > > =C2=A0 FirePro W8000, W9000, D500, D700, S9000, S9050, S10000
> > > Pitcairn (2012~2015):
> > > =C2=A0 Radeon HD 7850, 7870, 7970M, 8870, 8970M
> > > =C2=A0 Radeon R9 265, 270/370 series, M290X, M390
> > > =C2=A0 FirePro W5000, W7000, D300, R5000, S7000
> > > Cape Verde (2012~2016):
> > > =C2=A0 Radeon HD 7730, 7750, 7770, 8730, 8760
> > > =C2=A0 Radeon R7 250E, 250X, 350, 450
> > > =C2=A0 FirePro W600, W4100, M4000, M6000
> > > Oland (2013~2019):
> > > =C2=A0 Radeon HD 8570, 8670
> > > =C2=A0 Radeon R5 240, 250, 330, 340, 350, 430, 520, 610
> > > =C2=A0 FirePro W2100
> > > =C2=A0 various mobile GPUs
> > > Hainan (2013~2016):
> > > =C2=A0 various mobile GPUs
> >=20
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the
> > entire series.
> >=20
> > I think Alex already merged the CIK switch, but that should be
> > trivial to resolve.
> >=20
> > Thanks,
> > Christian.
> >=20
> > >=20
> > > Timur Krist=C3=B3f (4):
> > > =C2=A0 drm/radeon: Refactor how SI and CIK support is determined
> > > =C2=A0 drm/amdgpu: Refactor how SI and CIK support is determined
> > > =C2=A0 drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs (v2)
> > > =C2=A0 drm/amdgpu: Use amdgpu by default on SI dedicated GPUs (v2)
> > >=20
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 24 ++--
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 160 ++++++++++++++---=
-
> > > ------
> > > =C2=A0drivers/gpu/drm/radeon/radeon_drv.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 81 +++++++-----
> > > =C2=A03 files changed, 162 insertions(+), 103 deletions(-)
> > >=20
> >=20
