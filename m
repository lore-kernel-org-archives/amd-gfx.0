Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D09C369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 20:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C28810E288;
	Thu,  1 May 2025 20:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nKmBJTHM";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2009310E288
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 20:02:46 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-224172f32b3so3273445ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 May 2025 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746129765; x=1746734565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8Y06EYsDi2hG571lX7aspVyQvVB7dlvmpKGeE6ejFg=;
 b=nKmBJTHMb/3o7uQ5XuZ/52vji7bi+3qfTwGAjg1rTne0l9HjGBislrLm2PTEtOn/Mp
 RenXNzCbQiXHoyk3aKs8+TDMUm9i0msDoU04R6iuipYZuIKr+1+gLIJN3I+yTeG4D8ru
 P/Jb9ntBGLwAK0akkzG0GXJDN8lc88w6hRs/ddfWOmf3B6Gl5W6N3vOHFXIcDqh1pgyL
 gJEsyULnuQBWGKmQqrBmXELFnJFkRlT8RMM1bpYuyPtq7kIC8wBfNkGKmBaoD8aK6Q4W
 ajBprzPq1UUK5uGR5kIq1Gq9o6NUHnOpBDo8EQo20NWD6XoHRCaoMLgjOHg0F4WixL2C
 0K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746129765; x=1746734565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8Y06EYsDi2hG571lX7aspVyQvVB7dlvmpKGeE6ejFg=;
 b=YCjrV/vLJ1gcR68Y39np/CpAMIuQbNcnmD/G+5KHyZDjXgR8bSLcb5cAKp9eMbbmfG
 VmWWhsXVWwEdprdvcD16xKN0QX5o8/hZoksTf0h8DC86fQhV42VNSInCZCCxGbGNeTlX
 JWVETg/6xm3BG02O5z3QASdJnIhrG8gJ+jcR5IJbWCUBlN3GZbrzlWs5/LCeX6HICBBJ
 15xkgN8+O/Ic3WCGxQ5Fnlb3D1HwVtFoDor/OW6y5W1TUVS/YwULg8jNy1OvNL4lBk1p
 6oP3f2pHyGlDvPQLgrb+ffj0dZHQ/6cSOtyPFGm8kM1VooHEcPN0Qrf4CRjgrWlFoESA
 hnEw==
X-Gm-Message-State: AOJu0YwkwB/M8Y+Zx6rms8apiiMsyGCIoBo9Q+EaAteK7H9W4Uj/YS/Y
 GnhJv7EryXYK8zVwG1T59+Ohr7XD74b1ladzLslYdpxR8pimK4P6/7aDaGx33/rf+LXY1NRnp5q
 RKMNz4JGOMP4CDVPjJJDW0UbPx1M=
X-Gm-Gg: ASbGncst9kmnNmQje9UM7Y43E3Pqs1Zbc13suexx5ZWCZwEmdrWoazhB9wbz1Muve5c
 J+mEQ3IRhy5zOVJ3AY9ML+1C8Ew2JZs7H7PFudu+RqtRCjblDs+ZVxLvSNikh4/HjQnbCJrFYRo
 Jb07XBi11VGQSIepY2zsPGiQ==
X-Google-Smtp-Source: AGHT+IFYHjmxEhyfzr9W0vua9cLiMS23xyt9absVgIRipyXkbZJVwJ0Xp6DOiCOell9/+0wmkRnMETah9PiV5F4gcXw=
X-Received: by 2002:a17:902:f68f:b0:212:48f0:5b6f with SMTP id
 d9443c01a7336-22e10327483mr1784505ad.9.1746129765424; Thu, 01 May 2025
 13:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250501183457.4123584-1-alexander.deucher@amd.com>
 <20250501183457.4123584-2-alexander.deucher@amd.com>
In-Reply-To: <20250501183457.4123584-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 May 2025 16:02:34 -0400
X-Gm-Features: ATxdqUFduug5jWIqH3URiYXZt8GfPFksIeXywtddXgSUs-zrQ-yKk4lDty8SDQE
Message-ID: <CADnq5_NWE4gCJtZLRd90Qhd1jmiB4chONmz8MwQ_D+TBGczapg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: stop evicting resources on APUs on suspend
To: Alex Deucher <alexander.deucher@amd.com>
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

On Thu, May 1, 2025 at 2:53=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Set the s3/s0ix and s4 in the pm notifier so that we can skip
> the resource evictions in the pm notifier and pm prepare
> functions, then reset them in pm prepare so that they
> can be set properly in the suspend and freeze callbacks.

Actually, this won't work reliably.  If the notifier chain fails,
we'll end up with these flags being set.  will respin.

Alex


Alex

>
> v2: always reset flags in pm prepare
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 14 +++++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5ac7bd5942d01..a3e9f289e37c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4919,8 +4919,20 @@ static int amdgpu_device_pm_notifier(struct notifi=
er_block *nb, unsigned long mo
>         switch (mode) {
>         case PM_HIBERNATION_PREPARE:
>                 adev->in_s4 =3D true;
> -               fallthrough;
> +               r =3D amdgpu_device_evict_resources(adev);
> +               /*
> +                * This is considered non-fatal at this time because
> +                * amdgpu_device_prepare() will also fatally evict resour=
ces.
> +                * See https://gitlab.freedesktop.org/drm/amd/-/issues/37=
81
> +                */
> +               if (r)
> +                       drm_warn(adev_to_drm(adev), "Failed to evict reso=
urces, freeze active processes if problems occur: %d\n", r);
> +               break;
>         case PM_SUSPEND_PREPARE:
> +               if (amdgpu_acpi_is_s0ix_active(adev))
> +                       adev->in_s0ix =3D true;
> +               else if (amdgpu_acpi_is_s3_active(adev))
> +                       adev->in_s3 =3D true;
>                 r =3D amdgpu_device_evict_resources(adev);
>                 /*
>                  * This is considered non-fatal at this time because
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 24ee4710f807f..60c032f124149 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2516,22 +2516,29 @@ static int amdgpu_pmops_prepare(struct device *de=
v)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       int r;
>
>         /* Return a positive number here so
>          * DPM_FLAG_SMART_SUSPEND works properly
>          */
>         if (amdgpu_device_supports_boco(drm_dev) &&
> -           pm_runtime_suspended(dev))
> +           pm_runtime_suspended(dev)) {
> +               adev->in_s0ix =3D adev->in_s3 =3D adev->in_s4 =3D false;
>                 return 1;
> +       }
>
>         /* if we will not support s3 or s2i for the device
>          *  then skip suspend
>          */
>         if (!amdgpu_acpi_is_s0ix_active(adev) &&
> -           !amdgpu_acpi_is_s3_active(adev))
> +           !amdgpu_acpi_is_s3_active(adev)) {
> +               adev->in_s0ix =3D adev->in_s3 =3D adev->in_s4 =3D false;
>                 return 1;
> +       }
>
> -       return amdgpu_device_prepare(drm_dev);
> +       r =3D amdgpu_device_prepare(drm_dev);
> +       adev->in_s0ix =3D adev->in_s3 =3D adev->in_s4 =3D false;
> +       return r;
>  }
>
>  static void amdgpu_pmops_complete(struct device *dev)
> @@ -2603,6 +2610,7 @@ static int amdgpu_pmops_freeze(struct device *dev)
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>         int r;
>
> +       adev->in_s4 =3D true;
>         r =3D amdgpu_device_suspend(drm_dev, true);
>         if (r)
>                 return r;
> --
> 2.49.0
>
