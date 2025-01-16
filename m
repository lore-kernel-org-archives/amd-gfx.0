Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F22DC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA1410EA0E;
	Thu, 16 Jan 2025 21:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="htNGU1eL";
	dkim-atps=neutral
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9BA10EA0E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:32:13 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2162b5d2e1fso2922525ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 13:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737063132; x=1737667932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iE4e0zlJ5uqGWcHFLx7UDgOoIwT6wXR0u+0HEplefZI=;
 b=htNGU1eL5R48MlMIqln/jsZLcIYY6sYNN8m0rycSKKUMxS5wuGLlNMkrQFL6gvAt5d
 lYc51RBNPHA/1Ztk2+t1bUHeyq4PiRabI2rd4aYo7vCKmXb0XBY+njpjCwgP2MGdBAIt
 1eDf08o+//5ak8mEVKY52ngjnROrclpgquK0QijoSGftEYw3nZUDDauihdc+I1TdBdHf
 YafjC1n7fUXbqkQSTl9xPtflMmUdgkOZxTi21QP+i86FEM4Lndd5x5/r203RmM5h6HWg
 3h7Z/CDigZSFGfiHKFPPoLJcqzsTBNcZm0j13nslO/dydsJxKoi6awQmXdvn2zSGIJgP
 nTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737063132; x=1737667932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iE4e0zlJ5uqGWcHFLx7UDgOoIwT6wXR0u+0HEplefZI=;
 b=liOMWMdZLONS8CQ1HFL0vpqpcWnsFg48uAdtkj2X1PGh7ppwKaT3jAbHgiuKenJoUh
 Kw/pRyjF4uVjCrK3snjzED9XfuAmEKzYmI2zjox4xAejwOOJsXpohQum1GU5B5AKvFgY
 mwM8pnkjBIWiBzY4B2xBSZyTXpchs8xOXnWmteuyFUYljEeDNXei9OM+mUxv0c5r3qVy
 W/WcD8NE4yFwxlKvNM/ZSH8IsXKBH3UgYXIhK0radRi3HWSHARnTHLy8ys8rY0TPOx2i
 gVKQJVd5pvDJJDaKXktsMKFbHGiKWEG1+ifzvptGsoYC/SCM0uoBBXVNSo25UlgiuKaM
 Htkw==
X-Gm-Message-State: AOJu0YwC8hM3MR+UEF4ifaGKG9WUTz7U5cZ1QPQlXAx7uUaqpLuKxYr8
 z9MuHPzbU5kpo1Bt/yyVfzri7HkzEkvAELXU3GkvLaxttvzFPeJXENbpdVnIZTYfV6g/KmYXnOk
 1zkt0/TUvL5Av/XNFU46JJmwJHw6NeQ==
X-Gm-Gg: ASbGncu78ICRW/p8djYj6bVcFbUs7BLR1/5Uktu84Skke34zwRbWoqhvP8H+7eQht12
 krmuWTbfKwWBXYdhpa2Qhh3Pz8QWqg+iMZnj92A==
X-Google-Smtp-Source: AGHT+IFN0nrGWSujU3X7FUvqWAVmt1KzWo5DiDOFrrLg0C04i7QjWPJyEw2LXcfMZbxAgB5B4nbFnWWS6JjeJCYr2l0=
X-Received: by 2002:a17:903:41c2:b0:216:6590:d477 with SMTP id
 d9443c01a7336-21c35538df7mr1400625ad.2.1737063132544; Thu, 16 Jan 2025
 13:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20250116182921.1730696-1-superm1@kernel.org>
In-Reply-To: <20250116182921.1730696-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 16:32:00 -0500
X-Gm-Features: AbW1kvY7HPX3D21PQePB7bpYkQe4xj4dpbP4LaEOPWT1je7ZPoL_9fkrDRvGNKg
Message-ID: <CADnq5_NDhxidmtNhi5rONuZQv-vQF-gYanrVuFU0XYJA-RDqqw@mail.gmail.com>
Subject: Re: [RFC] drm/amd: Drop gttsize module parameter
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Jan 16, 2025 at 1:29=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When not set `gttsize` module parameter by default will get the
> value to use for the GTT pool from the TTM page limit, which is
> set by a separate module parameter.
>
> This inevitably leads to people not sure which one to set when they
> want more addressable memory for the GPU, and you'll end up seeing
> instructions online saying to set both.
>
> Drop the amdgpu module parameter and related code for it.  This way
> if users want to change the amount of addressable memory they can
> change it solely in TTM.
>

I suspect we probably want to keep it for compatibility with users
that still use this option to change their GTT size.

Alex


> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 -------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 ---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 9 ++-------
>  4 files changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5e55a44f9eef..e728974114bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -164,7 +164,6 @@ extern int amdgpu_modeset;
>  extern unsigned int amdgpu_vram_limit;
>  extern int amdgpu_vis_vram_limit;
>  extern int amdgpu_gart_size;
> -extern int amdgpu_gtt_size;
>  extern int amdgpu_moverate;
>  extern int amdgpu_audio;
>  extern int amdgpu_disp_priority;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3774d12ebc4a..1b62b843e5fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2031,13 +2031,6 @@ static int amdgpu_device_check_arguments(struct am=
dgpu_device *adev)
>                 amdgpu_gart_size =3D -1;
>         }
>
> -       if (amdgpu_gtt_size !=3D -1 && amdgpu_gtt_size < 32) {
> -               /* gtt size must be greater or equal to 32M */
> -               dev_warn(adev->dev, "gtt size (%d) too small\n",
> -                                amdgpu_gtt_size);
> -               amdgpu_gtt_size =3D -1;
> -       }
> -
>         /* valid range is between 4 and 9 inclusive */
>         if (amdgpu_vm_fragment_size !=3D -1 &&
>             (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4))=
 {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b911653dd8b6..62b09c518665 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -141,7 +141,6 @@ enum AMDGPU_DEBUG_MASK {
>  unsigned int amdgpu_vram_limit =3D UINT_MAX;
>  int amdgpu_vis_vram_limit;
>  int amdgpu_gart_size =3D -1; /* auto */
> -int amdgpu_gtt_size =3D -1; /* auto */
>  int amdgpu_moverate =3D -1; /* auto */
>  int amdgpu_audio =3D -1;
>  int amdgpu_disp_priority;
> @@ -279,14 +278,6 @@ module_param_named(vis_vramlimit, amdgpu_vis_vram_li=
mit, int, 0444);
>  MODULE_PARM_DESC(gartsize, "Size of kernel GART to setup in megabytes (3=
2, 64, etc., -1=3Dauto)");
>  module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
>
> -/**
> - * DOC: gttsize (int)
> - * Restrict the size of GTT domain (for userspace use) in MiB for testin=
g.
> - * The default is -1 (Use 1/2 RAM, minimum value is 3GB).
> - */
> -MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes=
 (-1 =3D auto)");
> -module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> -
>  /**
>   * DOC: moverate (int)
>   * Set maximum buffer migration rate in MB/s. The default is -1 (8 MB/s)=
.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index e6fc89440210..e3fee81d8646 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1957,13 +1957,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>                  (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024))=
);
>
> -       /* Compute GTT size, either based on TTM limit
> -        * or whatever the user passed on module init.
> -        */
> -       if (amdgpu_gtt_size =3D=3D -1)
> -               gtt_size =3D ttm_tt_pages_limit() << PAGE_SHIFT;
> -       else
> -               gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> +       /* Compute GTT size, based on TTM limit */
> +       gtt_size =3D ttm_tt_pages_limit() << PAGE_SHIFT;
>
>         /* Initialize GTT memory pool */
>         r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
> --
> 2.48.0
>
