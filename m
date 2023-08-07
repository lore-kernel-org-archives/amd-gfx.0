Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C95AC001DB
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 15:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA84510E1EF;
	Mon,  7 Aug 2023 15:24:06 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D4310E1EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 15:24:04 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-56c85b723cfso2729687eaf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Aug 2023 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691421843; x=1692026643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO+1l2DIMZ6/qNx0WN4VcE/HP7ueMq9zSUfnPrGUnY0=;
 b=hllQhAw02VcYUD4UCnI+6orzIgAabvEjVxWcSgZ5E3emZERV+b4ADwFH/brLun60rB
 5xeaV2y2yibNpkCyjkN5eTAaHSU8cpZNyMd4paAemGq5a5/y40IBjT9ESIMVla2tlVZE
 gC+LFZ3CUufONl8c9AfVhtyPipJc/fw5Hi6LhslkmVHi8QT2izlLaUkc4AgoMRM+4PE1
 OdWz3a0wz9tuc7Cy6vAUa07BCsufOiIEqzhjgDM4gLoNWAlzgwTl9+n72dmynxSXaSzh
 atNhEQDl1kKcr8UBiGdfi4TrTZfczg2FvkTaa2TbfWB/sYr9KjMPmzDVBKAlPNpAifAL
 3GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691421843; x=1692026643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO+1l2DIMZ6/qNx0WN4VcE/HP7ueMq9zSUfnPrGUnY0=;
 b=fyzbvlLVVghnayG6gn8hTzRpzqZ9k4UYM5sA30XikcRDiZxeYBp8wUBPTjT2apOb4N
 L6gGP1OmNF7HuMCxNJ3VsqEVKG4GOqRdXoN+fx+zBbcIbD1oACXi7vNa0oiVqCZvkVMf
 EUcPA+I/3kuqzjaTBoyASHXY2xzF8v4allwZS9x/AMK6wCMuau1f9uawL8eMISssChYh
 7R40dijUg69Cl/ixkF39SZsYxMbFJpicq5Jf4M15PytiMbyYhbAkQTM8o2knnqgeW/oV
 MkhuDqnKhs8XdwLzHiS+mwJ4xR+73JVG+KtBpEW2LJ4KTu5vG/S2okT4ph1K09SQAaoD
 mVTg==
X-Gm-Message-State: AOJu0YwgZpQbujBSMBWUBIlb5PAvryQwX1+YT2nQOJp8rYrP8W/58zYB
 edEp3WqNTx7asH3OxuHz/a8SJVKD+rp7smD7NUWHf29u
X-Google-Smtp-Source: AGHT+IHgjEyJcYfsQyiiLv+CzCLwM6QUbwlXsnn4Iy7gBiH+QRC643dwfywQOCQpYhiqE5HH0w1Tu4O0bzKFhaPF99k=
X-Received: by 2002:a4a:9208:0:b0:56c:e554:d7e6 with SMTP id
 f8-20020a4a9208000000b0056ce554d7e6mr8342947ooh.3.1691421843446; Mon, 07 Aug
 2023 08:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230727134712.2577353-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230727134712.2577353-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 11:23:52 -0400
Message-ID: <CADnq5_MWN_cKdSFKfdEjLYx-66B9b+HgNG0jdyvpf+_iY=4S1w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove the references of radeon_gem_ pread &
 pwrite ioctls
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 27, 2023 at 9:48=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Removing the functions of pread & pwrite & IOCTL defines, as their
> existence allows an authorized client to spam the system logs.
>
> 'Fixes: 6f9e0e87b71f ("drm/radeon: Fix ENOSYS with better fitting error c=
odes in radeon_gem.c")'
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon.h     |  4 ----
>  drivers/gpu/drm/radeon/radeon_drv.c |  2 --
>  drivers/gpu/drm/radeon/radeon_gem.c | 16 ----------------
>  3 files changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/rad=
eon.h
> index b1c3871f2a67..102f7e25faa6 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -2254,10 +2254,6 @@ int radeon_gem_pin_ioctl(struct drm_device *dev, v=
oid *data,
>                          struct drm_file *file_priv);
>  int radeon_gem_unpin_ioctl(struct drm_device *dev, void *data,
>                            struct drm_file *file_priv);
> -int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
> -                           struct drm_file *file_priv);
> -int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
> -                          struct drm_file *file_priv);
>  int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
>                                 struct drm_file *filp);
>  int radeon_gem_mmap_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index aa02697e5ea3..7fea9edafa67 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -555,8 +555,6 @@ static const struct drm_ioctl_desc radeon_ioctls_kms[=
] =3D {
>         DRM_IOCTL_DEF_DRV(RADEON_GEM_CREATE, radeon_gem_create_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(RADEON_GEM_MMAP, radeon_gem_mmap_ioctl, DRM_AUT=
H|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(RADEON_GEM_SET_DOMAIN, radeon_gem_set_domain_io=
ctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -       DRM_IOCTL_DEF_DRV(RADEON_GEM_PREAD, radeon_gem_pread_ioctl, DRM_A=
UTH),
> -       DRM_IOCTL_DEF_DRV(RADEON_GEM_PWRITE, radeon_gem_pwrite_ioctl, DRM=
_AUTH),
>         DRM_IOCTL_DEF_DRV(RADEON_GEM_WAIT_IDLE, radeon_gem_wait_idle_ioct=
l, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(RADEON_CS, radeon_cs_ioctl, DRM_AUTH|DRM_RENDER=
_ALLOW),
>         DRM_IOCTL_DEF_DRV(RADEON_INFO, radeon_info_ioctl, DRM_AUTH|DRM_RE=
NDER_ALLOW),
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 358d19242f4b..3fec3acdaf28 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -311,22 +311,6 @@ int radeon_gem_info_ioctl(struct drm_device *dev, vo=
id *data,
>         return 0;
>  }
>
> -int radeon_gem_pread_ioctl(struct drm_device *dev, void *data,
> -                          struct drm_file *filp)
> -{
> -       /* TODO: implement */
> -       DRM_ERROR("unimplemented %s\n", __func__);
> -       return -EOPNOTSUPP;
> -}
> -
> -int radeon_gem_pwrite_ioctl(struct drm_device *dev, void *data,
> -                           struct drm_file *filp)
> -{
> -       /* TODO: implement */
> -       DRM_ERROR("unimplemented %s\n", __func__);
> -       return -EOPNOTSUPP;
> -}
> -
>  int radeon_gem_create_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *filp)
>  {
> --
> 2.25.1
>
