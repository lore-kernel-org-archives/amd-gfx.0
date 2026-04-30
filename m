Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F697FF8875
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 12:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2B110E43F;
	Thu, 30 Apr 2026 12:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQ++gzsI";
	dkim-atps=neutral
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99CC10E43F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 12:48:07 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-95c92e7151bso24013241.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 05:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777553287; cv=none;
 d=google.com; s=arc-20240605;
 b=VZM7LkUY2L1wdWx4kqTgE1YAXqas0CfCprSmCEBIL68CfbmWAWvMbnwc1slWWazSHQ
 C3PrGOaD3R5FeKGtzozQtpvUfZ1xl1O+d24bTZjfgQ7mFeBxDkseSBZlFGVVXiQZr2v2
 jrKWZE2AaIFoszih5BO7sEEtc+PUStj8fmrmk4VTwCy9ncfix758dj50e46Fb785Cm05
 +MlVzUVFMXrzbl0Ep1dDjaDGNA+6UC5e9r9xPvM2FWVXrBPq0NINn0ucQrcEsl/EX3oQ
 wqCMx3tA2uN5spTWS+6QuT241y0MvnYNB3gHnrtr3BVj2+t7/9FlJ/0D+D1ekHi+nIlV
 4dQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GQZnpvCJ6kEvhdexmWAhzzMWBTp0HnMhiUpZs0FTA+Y=;
 fh=f3kMsUauhrfwQyAQBQowma7HlEsyKi3/UEGFB0/u9S0=;
 b=KfFfmpzvzn5aYJM1xU+r69g3W9oNkmUrIffeEwWB6h9oYIIFdOyHFF+UHGMdms2emC
 Xb2zg2QZ+tC77B1gl3jzi3RbgKBRmx8svJi8Zqz5bshGZXcS/DCOwo3nsvfAnlBSwgiR
 xMeMvL3ZwQeLZmSU4MxjMxasmNNwDOjATTizsM+gQObeEFAkIF0bbAtx3LRFh8iraNjT
 NtwSC0HbpHBvb2WJKXRVaxRYcNe3jMUH6np56tOe3+Q4EMB31LVN++pGzzWi5ZbG4Cs9
 H76PbiRA/Pt9DF5OokK4YuMynVBOY+eh1Xb9n2arBXXAVBk8hBm4tbX4l3uTzXqZ22pH
 92JQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777553287; x=1778158087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQZnpvCJ6kEvhdexmWAhzzMWBTp0HnMhiUpZs0FTA+Y=;
 b=UQ++gzsIepXwxDJxfzjEAeSLUj4FqhIQhNSschjtUIElo0jyTMDx2QPN9D0KDz0lmL
 dTuMGW0Z3v3xXrA+WscJiTJb8mVk5v02hSY7vbt1BDdF52NMSBz01w61B2IOF6/9UIlM
 rz0/qHdpYHoZUXhrEDxD5+zQ3WirOqkoM06ee8OdLApL3HULWPxvWbfstEXVhud6KfVX
 4K+NySQCUkc1O1yNVPIiQDFzWJdZ+AES29KQ4ikVrEttExeJKIFrsLxg9m4EregUHb9n
 nEjPWakIn9B7bWygd99orvMm5Fzevb71OyMjBrpuPFEHMUIa93sWO3SGA9lyoCz8cV1E
 lhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777553287; x=1778158087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GQZnpvCJ6kEvhdexmWAhzzMWBTp0HnMhiUpZs0FTA+Y=;
 b=Od8+8M2+hjnoG3mn5S+E+qP8gszb0h/Pr1hn0vDANh8vVTRkghoI4amhacsVisOzn2
 BA0bg7BBjtHXnwo3jnpZTYgd0oOc97PI2va8w7vHPYz+A9j1wd1im5EkuhQdEJFbbzbb
 ZqeRas82uHlDxvos6oGSobdRdrgML5XCQu1cKSFw8qP4J6V+tCP1bly5W3f1lcmzqulK
 GWWxNvRc+rgBRlk/eU4W4ANgkpKKvnchWfY1tPOVQJgWvVA5EL7yL8YBgokJi3/y2Ikt
 CJkeKZwceFVgzOWECWRn87WNUVr2sTYXxMd6AD4iwT6UCpQHt8ouU1FrqI7bOUFUWVEz
 o4lQ==
X-Gm-Message-State: AOJu0YwS47t+Nq5TpKLr/NQ2CqipFKDyxYj2frU5RXGAfnyaA/AN/gbN
 vQEXvshhJU+N9ZV0BbYe7ppg+6dRonNO9Isal983Zy+MKRypce7nCexSmVzCkBil5Cto6YS2GCy
 OTF64w27/ezl0tng09TeaPRsTK3k3eOQ=
X-Gm-Gg: AeBDietJjCE8SG4jhRIqVXT3SAAAIuCIqzp0T44VwwUfOkmMia4u+xUc7hnQhEx84OU
 bSav5xlBuKnt8NFpWukKalJpd8fJi2ZEgaGWeR+71izo9QbmOulIdud0dF8QQwUPyetf9sN3k7R
 fND/rzqCk66AETUeE2Z8MLn/pF6s7bZ8B569eNdNL/mjOx0GlGLjTTRkl0X2zLj/ge16HDwMCY1
 cgYDD6u++bwRiJq8wHv8axyW1A1JiVCFvQX9P39YfQ8850JwYu3oOBBY6SfXU4tSVCDez6deTmC
 LOCjUDYvGUONRz+yRAV56bHvj1ntBajTyUQqcDjbRcgsuMsMHriWliynrGK3M2qZqNK1bCfSeWh
 p72H2
X-Received: by 2002:a05:6102:30b6:b0:611:82b:add6 with SMTP id
 ada2fe7eead31-62ad5cef573mr313723137.8.1777553286508; Thu, 30 Apr 2026
 05:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260430055527.4026042-1-lijo.lazar@amd.com>
 <20260430055527.4026042-2-lijo.lazar@amd.com>
In-Reply-To: <20260430055527.4026042-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2026 08:47:53 -0400
X-Gm-Features: AVHnY4IABSbGy9yZOK_rH4JqIGu8DEwTcKXiazqps_9OQB5NYZsz93SMap-vaic
Message-ID: <CADnq5_M3=yCSv=+6j09iYp=YB2UivevVKAZY5iG1ku6bb38BqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Use helper to set gart size
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Christian.Koenig@amd.com
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

On Thu, Apr 30, 2026 at 2:04=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Find the default size required and use the helper funcction to set gart s=
ize.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 24 +++++++---------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  5 +---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 28 +++++++-----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 30 ++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 34 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 40 +++++++++++---------------
>  7 files changed, 66 insertions(+), 100 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index e1ace7d44ffd..8523833a74fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -707,20 +707,16 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *=
adev)
>         adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1) {
> -               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -               default:
> -                       adev->gmc.gart_size =3D 512ULL << 20;
> -                       break;
> -               case IP_VERSION(10, 3, 1):   /* DCE SG support */
> -               case IP_VERSION(10, 3, 3):   /* DCE SG support */
> -               case IP_VERSION(10, 3, 6):   /* DCE SG support */
> -               case IP_VERSION(10, 3, 7):   /* DCE SG support */
> -                       adev->gmc.gart_size =3D 1024ULL << 20;
> -                       break;
> -               }
> -       } else {
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(10, 3, 1):   /* DCE SG support */
> +       case IP_VERSION(10, 3, 3):   /* DCE SG support */
> +       case IP_VERSION(10, 3, 6):   /* DCE SG support */
> +       case IP_VERSION(10, 3, 7):   /* DCE SG support */
> +               amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +               break;
> +       default:
> +               amdgpu_gmc_set_gart_size(adev, SZ_512M);
> +               break;
>         }
>
>         gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 94d6631ce0bc..16388e3caea3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -709,10 +709,7 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *a=
dev)
>                 adev->gmc.visible_vram_size =3D adev->gmc.real_vram_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1)
> -               adev->gmc.gart_size =3D 512ULL << 20;
> -       else
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       amdgpu_gmc_set_gart_size(adev, SZ_512M);
>
>         gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index 5bdd4b9b7893..586703ec0dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -765,10 +765,7 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *a=
dev)
>                 adev->gmc.visible_vram_size =3D adev->gmc.real_vram_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1) {
> -               adev->gmc.gart_size =3D 512ULL << 20;
> -       } else
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       amdgpu_gmc_set_gart_size(adev, SZ_512M);
>
>         gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index cc272a96fcef..af6944d2d330 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -328,24 +328,18 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *a=
dev)
>         adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1) {
> -               switch (adev->asic_type) {
> -               case CHIP_HAINAN:    /* no MM engines */
> -               default:
> -                       adev->gmc.gart_size =3D 256ULL << 20;
> -                       break;
> -               case CHIP_VERDE:    /* UVD, VCE do not support GPUVM */
> -               case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
> -               case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
> -               case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
> -                       adev->gmc.gart_size =3D 1024ULL << 20;
> -                       break;
> -               }
> -       } else {
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       switch (adev->asic_type) {
> +       case CHIP_VERDE:    /* UVD, VCE do not support GPUVM */
> +       case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
> +       case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
> +       case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
> +               amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +               break;
> +       case CHIP_HAINAN:    /* no MM engines */
> +       default:
> +               amdgpu_gmc_set_gart_size(adev, SZ_256M);
> +               break;
>         }
> -
> -       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
>         gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index fb5e33c8a5ee..93cf283191fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -394,27 +394,21 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *a=
dev)
>         adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1) {
> -               switch (adev->asic_type) {
> -               case CHIP_TOPAZ:     /* no MM engines */
> -               default:
> -                       adev->gmc.gart_size =3D 256ULL << 20;
> -                       break;
> +       switch (adev->asic_type) {
>  #ifdef CONFIG_DRM_AMDGPU_CIK
> -               case CHIP_BONAIRE: /* UVD, VCE do not support GPUVM */
> -               case CHIP_HAWAII:  /* UVD, VCE do not support GPUVM */
> -               case CHIP_KAVERI:  /* UVD, VCE do not support GPUVM */
> -               case CHIP_KABINI:  /* UVD, VCE do not support GPUVM */
> -               case CHIP_MULLINS: /* UVD, VCE do not support GPUVM */
> -                       adev->gmc.gart_size =3D 1024ULL << 20;
> -                       break;
> +       case CHIP_BONAIRE: /* UVD, VCE do not support GPUVM */
> +       case CHIP_HAWAII:  /* UVD, VCE do not support GPUVM */
> +       case CHIP_KAVERI:  /* UVD, VCE do not support GPUVM */
> +       case CHIP_KABINI:  /* UVD, VCE do not support GPUVM */
> +       case CHIP_MULLINS: /* UVD, VCE do not support GPUVM */
> +               amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +               break;
>  #endif
> -               }
> -       } else {
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       case CHIP_TOPAZ:     /* no MM engines */
> +       default:
> +               amdgpu_gmc_set_gart_size(adev, SZ_256M);
> +               break;
>         }
> -
> -       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
>         gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 963d5b0fa87b..1d3ddffd5a11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -585,27 +585,21 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *a=
dev)
>         adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1) {
> -               switch (adev->asic_type) {
> -               case CHIP_POLARIS10: /* all engines support GPUVM */
> -               case CHIP_POLARIS11: /* all engines support GPUVM */
> -               case CHIP_POLARIS12: /* all engines support GPUVM */
> -               case CHIP_VEGAM:     /* all engines support GPUVM */
> -               default:
> -                       adev->gmc.gart_size =3D 256ULL << 20;
> -                       break;
> -               case CHIP_TONGA:   /* UVD, VCE do not support GPUVM */
> -               case CHIP_FIJI:    /* UVD, VCE do not support GPUVM */
> -               case CHIP_CARRIZO: /* UVD, VCE do not support GPUVM, DCE =
SG support */
> -               case CHIP_STONEY:  /* UVD does not support GPUVM, DCE SG =
support */
> -                       adev->gmc.gart_size =3D 1024ULL << 20;
> -                       break;
> -               }
> -       } else {
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       switch (adev->asic_type) {
> +       case CHIP_TONGA:   /* UVD, VCE do not support GPUVM */
> +       case CHIP_FIJI:    /* UVD, VCE do not support GPUVM */
> +       case CHIP_CARRIZO: /* UVD, VCE do not support GPUVM, DCE SG suppo=
rt */
> +       case CHIP_STONEY:  /* UVD does not support GPUVM, DCE SG support =
*/
> +               amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +               break;
> +       case CHIP_POLARIS10: /* all engines support GPUVM */
> +       case CHIP_POLARIS11: /* all engines support GPUVM */
> +       case CHIP_POLARIS12: /* all engines support GPUVM */
> +       case CHIP_VEGAM:     /* all engines support GPUVM */
> +       default:
> +               amdgpu_gmc_set_gart_size(adev, SZ_256M);
> +               break;
>         }
> -
> -       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
>         gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index aca7841173f3..ced0f3941863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1731,31 +1731,25 @@ static int gmc_v9_0_mc_init(struct amdgpu_device =
*adev)
>         adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
>
>         /* set the gart size */
> -       if (amdgpu_gart_size =3D=3D -1) {
> -               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -               case IP_VERSION(9, 0, 1):  /* all engines support GPUVM *=
/
> -               case IP_VERSION(9, 2, 1):  /* all engines support GPUVM *=
/
> -               case IP_VERSION(9, 4, 0):
> -               case IP_VERSION(9, 4, 1):
> -               case IP_VERSION(9, 4, 2):
> -               case IP_VERSION(9, 4, 3):
> -               case IP_VERSION(9, 4, 4):
> -               case IP_VERSION(9, 5, 0):
> -               default:
> -                       adev->gmc.gart_size =3D 512ULL << 20;
> -                       break;
> -               case IP_VERSION(9, 1, 0):   /* DCE SG support */
> -               case IP_VERSION(9, 2, 2):   /* DCE SG support */
> -               case IP_VERSION(9, 3, 0):
> -                       adev->gmc.gart_size =3D 1024ULL << 20;
> -                       break;
> -               }
> -       } else {
> -               adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(9, 1, 0):   /* DCE SG support */
> +       case IP_VERSION(9, 2, 2):   /* DCE SG support */
> +       case IP_VERSION(9, 3, 0):
> +               amdgpu_gmc_set_gart_size(adev, SZ_1G);
> +               break;
> +       case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
> +       case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
> +       case IP_VERSION(9, 4, 0):
> +       case IP_VERSION(9, 4, 1):
> +       case IP_VERSION(9, 4, 2):
> +       case IP_VERSION(9, 4, 3):
> +       case IP_VERSION(9, 4, 4):
> +       case IP_VERSION(9, 5, 0):
> +       default:
> +               amdgpu_gmc_set_gart_size(adev, SZ_512M);
> +               break;
>         }
>
> -       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
> -
>         gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
>
>         return 0;
> --
> 2.49.0
>
