Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F38C3601E
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 13:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C3C10E20B;
	Sun, 13 Apr 2025 13:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a+Ms76pW";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE5210E20B
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 13:00:04 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff62f9b6e4so607782a91.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744549204; x=1745154004; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8IoT+GTuqguhEW+doSrfUw7lwlQAWAtea3cHJYWDrg=;
 b=a+Ms76pWsLAO2rLIUPYA1TuY2+KUKY2fvAsC5SnaAamAlyglnmAIHPBelseW5GZhFE
 zcK6PSiyqbcvyl65HUE0+UsIHg2iKwE3DbwgBuBB33GtDggLNRbybDvPXjTcsHHx0kTq
 D7WyJSebVlL/xq8PSzQaOjrtyGLioGPLdcM/ziZkN8lcfkm7dMXeND0+s2Hcy7KUXKkG
 AsIKbezimpT8VTMGiSGgpN/tJmrcncBLjDj6nX3Y7pAPsDiBVmkcVGEbaTl9v6ySTifj
 zVkm2B7s9qSz/RPyPNSHzSIjvEAKthlQk2TgrqeWlc0YCAPn8DHZOcQ1Kvlrg0nG7rOI
 BXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744549204; x=1745154004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8IoT+GTuqguhEW+doSrfUw7lwlQAWAtea3cHJYWDrg=;
 b=Z4vVXPm/buV1QGgE80ZlYDHt+i6SYEVTGJucIQ8QI3VH+62jtS1Ea1Ptd3wkQhsX3v
 BGkZpHePdu+6FbLBTu5L+42/nhK6HvCc7OH5nv+t/UDB77A4gWJZUd5FPtlma873d6O4
 lAdflbU9xTy9O3VEETIFClCpwemxTfHFOPzOCCYemgUIrxo2dmtps/gAalDFx5Qn/Dfn
 s61dCg6SISAkYkUfxT31Ar/RUpAv5k0M1qqCLLnixaeREOFv/5cV/AaTgBvhMBvqEaeD
 RF8eM5qCLyKJft8mTndnS7Jn20R1Zo8ySddBnrMYCqPlL8TUG/xWJBSxYj1gQW6LfPhk
 0Qnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhxiPs0oAj81564TUqHpR77rsRpR679QEkUUSeCQ09FL7cExOTVIT6dbCfuOJPtjuVtQLs0oIM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybBs+nhvDqyc3SY7YM9OT37SzeYP5X8fy5dBJYjp4ASxLTbC0z
 3yCfqz24W/Nf52aCKX5SK9/3CwHtQDt2pzYoiStyb9lmTuWJTCqi4+E2zu/OR6Xck0bkx4pK5Zp
 Gt9DaF+90FPRV/9LunJvCWQHCDpY=
X-Gm-Gg: ASbGncupDxSRzWFI2ofi/TagVfxEkm/YGEqT52cXo4Nj5Z2vuwaurgi5+9v9/6987MV
 PgcK6atgXBpmyxTHaReDAbisaEtligooqg4+wv1Y7Na3NoT0s/vg963CJCWQvqrAxTxE0xxHbOU
 2QPE0ntma6R2nATCC5sGSPsg==
X-Google-Smtp-Source: AGHT+IFMgL28/FyOMxfxSMA9aIQfNe1dFZVbLBGBEIxr32BU4uh00iiKiHXpv4v1nP4YwXoNrbgEX9SYtFBseP5f0XQ=
X-Received: by 2002:a17:90b:1a8f:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-308237a3f31mr4703103a91.8.1744549203774; Sun, 13 Apr 2025
 06:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250412204420.3027587-1-siqueira@igalia.com>
In-Reply-To: <20250412204420.3027587-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 13 Apr 2025 08:59:52 -0400
X-Gm-Features: ATxdqUGLxg54Fu47SE5BYpOZeC9LBf7Ix0OJTs3hCgy1uacLXAIiiFMgYzt0Ldc
Message-ID: <CADnq5_OipWCgXVF2pGH4dtaV8WAvPHUaP4imW+uNBNNHXWBv4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove PACKET2 from amdgpu since it is not
 used
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Sat, Apr 12, 2025 at 4:44=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> It looks like that CP_PACKET2 is from the radeon GPU driver and was
> brought to amdgpu, but it was never used. This commit removes PACKET2
> and related defines from amdgpu.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cikd.h   | 5 -----
>  drivers/gpu/drm/amd/amdgpu/nvd.h    | 5 -----
>  drivers/gpu/drm/amd/amdgpu/sid.h    | 5 -----
>  drivers/gpu/drm/amd/amdgpu/soc15d.h | 5 -----
>  drivers/gpu/drm/amd/amdgpu/vid.h    | 5 -----
>  5 files changed, 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdg=
pu/cikd.h
> index 8aca4f2734f2..793e072fac8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cikd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
> @@ -220,11 +220,6 @@
>  #define PACKET0(reg, n)        ((PACKET_TYPE0 << 30) |                  =
       \
>                          ((reg) & 0xFFFF) |                     \
>                          ((n) & 0x3FFF) << 16)
> -#define CP_PACKET2                     0x80000000
> -#define                PACKET2_PAD_SHIFT               0
> -#define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> -
> -#define PACKET2(v)     (CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
>
>  #define PACKET3(op, n) ((PACKET_TYPE3 << 30) |                         \
>                          (((op) & 0xFF) << 8) |                         \
> diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgp=
u/nvd.h
> index 56f1bfac0b20..2b1cd5622182 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> @@ -39,11 +39,6 @@
>  #define PACKET0(reg, n)        ((PACKET_TYPE0 << 30) |                  =
       \
>                          ((reg) & 0xFFFF) |                     \
>                          ((n) & 0x3FFF) << 16)
> -#define CP_PACKET2                     0x80000000
> -#define                PACKET2_PAD_SHIFT               0
> -#define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> -
> -#define PACKET2(v)     (CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
>
>  #define PACKET3(op, n) ((PACKET_TYPE3 << 30) |                         \
>                          (((op) & 0xFF) << 8) |                         \
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgp=
u/sid.h
> index cbd4f8951cfa..e6da0ecd4058 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -327,11 +327,6 @@
>  #define PACKET0(reg, n) ((PACKET_TYPE0 << 30) |                         =
       \
>                           ((reg) & 0xFFFF) |                            \
>                           ((n) & 0x3FFF) << 16)
> -#define CP_PACKET2                     0x80000000
> -#define                PACKET2_PAD_SHIFT               0
> -#define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> -
> -#define PACKET2(v)     (CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))

It's still used on SI.  from gfx_v6_0.c

        .nop =3D 0x80000000,

Alex

>  #define RADEON_PACKET_TYPE3 3
>  #define PACKET3(op, n) ((RADEON_PACKET_TYPE3 << 30) |                  \
>                          (((op) & 0xFF) << 8) |                         \
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/am=
dgpu/soc15d.h
> index a5000c171c02..a4c49e184c4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -41,11 +41,6 @@
>  #define PACKET0(reg, n)        ((PACKET_TYPE0 << 30) |                  =
       \
>                          ((reg) & 0xFFFF) |                     \
>                          ((n) & 0x3FFF) << 16)
> -#define CP_PACKET2                     0x80000000
> -#define                PACKET2_PAD_SHIFT               0
> -#define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> -
> -#define PACKET2(v)     (CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
>
>  #define PACKET3(op, n) ((PACKET_TYPE3 << 30) |                         \
>                          (((op) & 0xFF) << 8) |                         \
> diff --git a/drivers/gpu/drm/amd/amdgpu/vid.h b/drivers/gpu/drm/amd/amdgp=
u/vid.h
> index b61f6b838ec2..f20553c61ada 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vid.h
> @@ -96,11 +96,6 @@
>  #define PACKET0(reg, n)        ((PACKET_TYPE0 << 30) |                  =
       \
>                          ((reg) & 0xFFFF) |                     \
>                          ((n) & 0x3FFF) << 16)
> -#define CP_PACKET2                     0x80000000
> -#define                PACKET2_PAD_SHIFT               0
> -#define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> -
> -#define PACKET2(v)     (CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
>
>  #define PACKET3(op, n) ((PACKET_TYPE3 << 30) |                         \
>                          (((op) & 0xFF) << 8) |                         \
> --
> 2.49.0
>
