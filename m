Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473EDCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 13:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E255D10E8A2;
	Thu, 18 Sep 2025 13:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAtS8/I+";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EF910E8A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:15:42 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-265f97930baso1499445ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758201342; x=1758806142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RasaXRYoTov957p2EKq0m05wVRacOzOcmfpjSEkGiBY=;
 b=OAtS8/I+oG4wjO1eqhgtzA870Z2fVSXAnkdjipTgHJS7gfV6FOzCikd1KMy3a77Pmy
 UlJV896dLrbMSa7IMz0ivfpWMxrV407OVdED37y7eHgbPh5o/mRoEcKzqDM7x+RZPm3t
 aBoW3noSuyKleWMWKQtoydf+9BvgcAlVpvnd6qnhSmZUo+Idu+34dvjyRlyV5oO+cjtv
 VjEX8/JgAFAuybs/LPSJz7KChTh0AxUvqVczjHS63cVqwP9vNHrABAkEnR+yumupc+HJ
 9nH145luSiZcsM1iGS7Y7usRi95QJyMLrYNFsrGxJTjcqMd/AhDDSyzPvnkuzdp5FSFT
 31AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758201342; x=1758806142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RasaXRYoTov957p2EKq0m05wVRacOzOcmfpjSEkGiBY=;
 b=rma3aBMWM83YqsSyLxs0/15WNwAjMJNXO846dm98P+5fV8Ku8ehvNmd/xKP+r3Sjdp
 MQ1tKFviOmXOOZwQFTdpecRngRO2GwWUsuoX8YrqPNXlid+jCbDTKrdexoHaZCyzBXdT
 HBQDtqOo3kR1Uzgt5bw/y3fxmRBq6F8FfF59CdIRudZ6ccE2U/B69WnOz+ZqE67Wl+Dp
 UaorHA3Rf8HgM5JBbwc1xv3H8ar2f3O/b2Sk0WZfksg8F9uB6hPSDi/cy0p1AChZgjUi
 P0BYURABOSmC8ZJfJXyoe9c4U6NMtic8y4QGbbGHR1X83C+MD4C6mfgs8a9+6H75rt5j
 LgIw==
X-Gm-Message-State: AOJu0YwJNmylWXQjWUoGwPcvgs8PgCu/mxcN8KFEftzlda2LUOF9alZv
 2IySUG7syugS9YuAmJttNwKibjZyFrMc22ZFdvLxF9eWJ907+yGH+ksNcYhQWe18TlKbrpGuno+
 qEfB1Xtli24rNtOwUJl2YSeNLOGefHWI=
X-Gm-Gg: ASbGncsdP60qyfcv3OfDD2jJiAkDPqXbL+L+DJLf2ZWEs7UT0ozl3ytw7uO4Uj0fip1
 dantYE6bJbxTnecYKE01zrAB0hwICr40bnEr3kVhzvS1ffdZDRAkbE83pg//TiCuCw/e6jI+wPb
 7/+D87NhTMr3LcCcMMg86fa0f5RONWBR2ZDtl1+vfRShyNkFedW0gsJfRL8bkCxExo5gD+vX0na
 LCdfQO2FqlCGZbmuTjCpVuk6Qc=
X-Google-Smtp-Source: AGHT+IFax5Dfrpy91oIDrnvioXuDiOrJdZxEvifNuT+MVbXtnVyG3fzNI5GV1aZWNjhe297YgQCAJffuGztHHNUIAEs=
X-Received: by 2002:a17:903:320e:b0:24c:c445:87c2 with SMTP id
 d9443c01a7336-2681286bac1mr37075995ad.4.1758201341667; Thu, 18 Sep 2025
 06:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250918123038.3099984-1-lijo.lazar@amd.com>
In-Reply-To: <20250918123038.3099984-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 09:15:29 -0400
X-Gm-Features: AS18NWDa86J2UYz3jv10ob0B1IeHGKolH3vIn4x6SHZdD8xguptcno_pPDD4Fbg
Message-ID: <CADnq5_OxSQQ+O0md1DE3RZCKUZu9f9=p=sYKiw1XX8b5vha85w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix vbios build number parsing logic
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Mangesh.Gadre@amd.com, Jesse.Zhang@amd.com
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

On Thu, Sep 18, 2025 at 9:09=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> It's not necessary that the build string and atom header section has a
> difference of 32 bytes. Use the remaining bytes in the section as copy
> limit.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 1c994d0cc50b..7cc7aec1bff3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1498,7 +1498,7 @@ static void atom_get_vbios_build(struct atom_contex=
t *ctx)
>  {
>         unsigned char *atom_rom_hdr;
>         unsigned char *str;
> -       uint16_t base;
> +       uint16_t base, len;
>
>         base =3D CU16(ATOM_ROM_TABLE_PTR);
>         atom_rom_hdr =3D CSTR(base);
> @@ -1511,8 +1511,9 @@ static void atom_get_vbios_build(struct atom_contex=
t *ctx)
>         while (str < atom_rom_hdr && *str++)
>                 ;
>
> -       if ((str + STRLEN_NORMAL) < atom_rom_hdr)
> -               strscpy(ctx->build_num, str, STRLEN_NORMAL);
> +       len =3D min(atom_rom_hdr - str, STRLEN_NORMAL);
> +       if (len)
> +               strscpy(ctx->build_num, str, len);
>  }
>
>  struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s)
> --
> 2.49.0
>
