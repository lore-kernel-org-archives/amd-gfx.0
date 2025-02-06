Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031B9C02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C6010E89B;
	Thu,  6 Feb 2025 15:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZedvFT5";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3322010E88B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 15:25:25 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9dcc3f944so200384a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2025 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738855524; x=1739460324; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lovM2dQ7+isRiyZMtiXxIdos+1tRhNydBriUslBq6sU=;
 b=lZedvFT5oHIIMLoDb7SE04uYV/nhERijevunVKUygqLRfFHe3+Catsh3ZYmuMuO6v/
 91qA5g9P+YR7D+di8l7jbDQyg6F4Q2/r/lsM9PU3YrPo+ng8v2K0+pqMzpsQ2VYF6wvJ
 j+a+OA2+crDq5meJ4QG0i/0rfPix32DDSngE/+ILItyfUyM8lxiE2dkYlSdGqh9+/k7E
 bS52ZIvXUvKLWoSsxhYCmwILvqxTdYTVHTiDiBMSHBfD9tdNQaCZERU3Aav6ytNUGUZC
 6lLnOSjhfy863YVnDb7O/AXeP9+6PRI3atOBZvU8CdSR/uYFgnmH4HVgCkI+LCQZuun5
 ajhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738855524; x=1739460324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lovM2dQ7+isRiyZMtiXxIdos+1tRhNydBriUslBq6sU=;
 b=T7NpjKaarCxPFm/H1pUcdSdT3Hc7eO16inbzxWMnqS/RGR030mYa3zfi1nSK7Pu8A2
 zz9ytN4b+WedSj4rJznsvF5H1AMNV4OfMwFiVYxj1oY5aG4jwvQymkkOM7YGsQ/dBrBk
 gpr44z656ztJivNs4xVHp5WbagZabe8NVWVfFZpuxss64GwouY3frV1JKbXxrjuSzrO0
 JI+4/nxWLRvM/LXPkz7XRFVhdbl0YI3cYN6XyTLvhMwQPiUh0HlSTMF5ciAs1PV7fglZ
 ygLhDEqhkgeDPZhkYGLD4YsilxwE0qKpeXGkazzk8VAkE4ak2jLUw5FbTUY19C/eLaYH
 ONag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+F5xCYhqHJVcf3Sn/dTW9tievESJzsYqedBO2SvxqUAtZZeUyxSR3mOtxseE7VXM19t2uzx9M@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNoIXJia/BJQ7c/pKIqXrb4tqjYzMiQufKwqb/Zb/sN6hw8hCZ
 yH0HgTTvqADe0wG/rO+a8j/31CNknTODdUDTW3MtsB4eINgCpgppSoOk0b1fZEtOESU4LB5e1Hg
 iWpxSD6THpygrKUu5znEfFStuqgY=
X-Gm-Gg: ASbGncuMzbWvAWYGqquJAnlJXMh0DdkCDnVjUVclFVFPL0AhIJjo6VQlokOqpIkqbdV
 vhJ2yM9Sb/mMh4yyj/lHAs+8+LoqLlnZxmzyaB7JeZI4PhCK4f9YPoqUM7njnoCFPGDc5AbWR
X-Google-Smtp-Source: AGHT+IHuI16ADdOnU24K2u7BnSVXC4mezOKNNHKl2nrRJdua2cCxXc0buHO+kMaqQ2OStq8P9CXHCRVPD9TDdmF1Pos=
X-Received: by 2002:a17:90b:3c4b:b0:2f2:a9bd:afe9 with SMTP id
 98e67ed59e1d1-2f9e0750a1bmr4417089a91.2.1738855524533; Thu, 06 Feb 2025
 07:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
 <20250203214349.1400867-5-alexander.deucher@amd.com>
 <afca7790-5a0d-44bc-9d4c-9c3eaea078d9@amd.com>
In-Reply-To: <afca7790-5a0d-44bc-9d4c-9c3eaea078d9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Feb 2025 10:25:13 -0500
X-Gm-Features: AWEUYZl6ZGgHj19NmabwXEdAbG8pyvWkkOdsJyWYmWebJQv33PjYE3yEDC8a7MI
Message-ID: <CADnq5_NkDg3VB1eNm7-VbwpcobPs_M=nnw0jycpXr7oxXD_3Xg@mail.gmail.com>
Subject: Re: [PATCH 05/11] drm/amdgpu/sdma5.2: use
 amdgpu_gfx_off_ctrl_immediate()
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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

On Thu, Feb 6, 2025 at 10:17=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 2/4/2025 3:13 AM, Alex Deucher wrote:
> > In begin_use/end_use use amdgpu_gfx_off_ctrl_immediate()
> > rather than amdgpu_gfx_off_ctrl() as we don't need the
> > extra delay before we allow gfxoff again.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Won't this cause unnecessary GFX allows since sdma jobs could also be
> used for clearing the buffers?

The calls are already there, this just switches to gfxoff allow
sooner, reducing the time where gfxoff is disallowed.  Should save a
bit of power.

Alex

>
> Thanks,
> Lijo
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index b1818e87889a2..7f2e1962b5755 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1882,7 +1882,7 @@ static void sdma_v5_2_ring_begin_use(struct amdgp=
u_ring *ring)
> >        * doorbells when entering PG.  If you remove this, update
> >        * sdma_v5_2_ring_set_wptr() as well!
> >        */
> > -     amdgpu_gfx_off_ctrl(adev, false);
> > +     amdgpu_gfx_off_ctrl_immediate(adev, false);
> >  }
> >
> >  static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
> > @@ -1893,7 +1893,7 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_=
ring *ring)
> >        * disallow GFXOFF in some cases leading to
> >        * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
> >        */
> > -     amdgpu_gfx_off_ctrl(adev, true);
> > +     amdgpu_gfx_off_ctrl_immediate(adev, true);
> >  }
> >
> >  static void sdma_v5_2_print_ip_state(struct amdgpu_ip_block *ip_block,=
 struct drm_printer *p)
>
