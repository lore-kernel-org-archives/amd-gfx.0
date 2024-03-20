Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174E9C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 13:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942C810F96E;
	Wed, 20 Mar 2024 13:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HssfirkL";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E11D10F96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 13:24:41 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-29c75e348afso5013273a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710941080; x=1711545880; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4BSprb4/hzIBMkHGDAHdsROz3us6m/u2E9qxiPHDBU=;
 b=HssfirkLzsChlBIgiQhPtaSdEBsvqir4ja2oPd+mDfFRkHxEyUZAPHe4ewDXrISEqE
 q74hZu4p4qQSuzCf/Cqz1FQBfYtKbf6QmqoNlQs85PUGCGLXaPdxYcYs3CvGGY3UcN54
 Cw1ruPw5yRgbu0qcKmSR3hUzINcNm+p10qgx3s69gC7Dvj2XAjB+LcNNjC69mtnbVdC8
 4LWjXvqp9fkvM9GjwsaEhm0D91cuvf8JR8B6XfkXYTImGr3QgxrRnRPu29mILv/kJjEI
 xQReykEgJN0kd2xNkLqyYAL+t75BWFdqKqHb5UTfWntIB9xouySuHx1eX1Kh0jXDzG5c
 0XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941080; x=1711545880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4BSprb4/hzIBMkHGDAHdsROz3us6m/u2E9qxiPHDBU=;
 b=pVc1GxT9U3L7KztjAjeal6cHtEeVA7rErIGJ/V1fTKbgEdMZR/L0LAk42p2WSE/3m0
 U7PIA5ywdhTnUdlmSt9M2hUDSD2iiropSKkQPbjOQoBm1JllAnDPUkYNKBEJDL7g4jtS
 cAjFozeowXmuSax+hCfq7yRlT74/WK9uUHpJkr0YV6Yr27l43ulSuGHKsj6xAg3cRNsj
 PTOFbVnP5omHQcJQZmtd6esYgBAHBCXUvyCiiZeEQYDMC+zfjaZUZcqV/p+njbm9xgaT
 2Qc12fRtPFPCzmR9aEpxPCf85c/++IdP2j9Y5VsuaTWPqO2/lIAUyGclaQphWyEdXGMm
 q65A==
X-Gm-Message-State: AOJu0YxFv3CygQW3gOSgTdBHewOur2CzL5XJhpE6H6hY/X56XBVMXEP+
 8RrcHxJyG6RBNqX06j6ayqvHFkrUGAQzOYBsfEoB1dteLXC6ETzV4GAge2LVNjUllN4SsN+xFEo
 M3jqHrgmidTYxIePamHaQwXp8p3hrhLSkVEo=
X-Google-Smtp-Source: AGHT+IE2geoflHSf/78vEcp2eq79IC7ua802y7jqbRJn8PfLUKCLIV3L/+Y/047khZadFadjMPdBxvynK61Q0Cte6sQ=
X-Received: by 2002:a17:90a:b108:b0:29f:e443:204f with SMTP id
 z8-20020a17090ab10800b0029fe443204fmr1984097pjq.18.1710941075431; Wed, 20 Mar
 2024 06:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240320100926.2614497-1-Jun.Ma2@amd.com>
In-Reply-To: <20240320100926.2614497-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Mar 2024 09:24:23 -0400
Message-ID: <CADnq5_MvSrn6YOgJHrY3rFqZ=ErPKnHm70Sg_n_QWBSLs4Jc_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the runtime pm mode error
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Alexander.Deucher@amd.com
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

On Wed, Mar 20, 2024 at 6:17=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Because of the logic error, Arcturus and vega20 currently
> use the AMDGPU_RUNPM_NONE for runtime pm even though they
> support BACO. So, the code is optimized to fix this error.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 56 ++++++++++++-------------
>  1 file changed, 27 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 1f92fb1e7421..70cf2d0c7683 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -150,42 +150,40 @@ int amdgpu_driver_load_kms(struct amdgpu_device *ad=
ev, unsigned long flags)
>         }
>
>         adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
> -       if (amdgpu_device_supports_px(dev) &&
> -           (amdgpu_runtime_pm !=3D 0)) { /* enable PX as runtime mode */
> -               adev->pm.rpm_mode =3D AMDGPU_RUNPM_PX;
> -               dev_info(adev->dev, "Using ATPX for runtime pm\n");
> -       } else if (amdgpu_device_supports_boco(dev) &&
> -                  (amdgpu_runtime_pm !=3D 0)) { /* enable boco as runtim=
e mode */
> -               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BOCO;
> -               dev_info(adev->dev, "Using BOCO for runtime pm\n");
> -       } else if (amdgpu_device_supports_baco(dev) &&
> -                  (amdgpu_runtime_pm !=3D 0)) {
> -               switch (adev->asic_type) {
> -               case CHIP_VEGA20:
> -               case CHIP_ARCTURUS:
> -                       /* enable BACO as runpm mode if runpm=3D1 */
> -                       if (amdgpu_runtime_pm > 0)
> -                               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> -                       break;
> -               case CHIP_VEGA10:
> -                       /* enable BACO as runpm mode if noretry=3D0 */
> -                       if (!adev->gmc.noretry)
> +       if (amdgpu_runtime_pm > 0) {
> +               adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> +               dev_info(adev->dev, "Forcing BACO for runtime pm\n");

Does this need special handling for BAMACO?  Setting
amdgpu_runtime_pm=3D2 is supposed to set BAMACO and 1 is supposed to
force BACO.

Alex

> +       } else if (amdgpu_runtime_pm !=3D 0) {
> +               if (amdgpu_device_supports_px(dev)) { /* enable PX as run=
time mode */
> +                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_PX;
> +                       dev_info(adev->dev, "Using ATPX for runtime pm\n"=
);
> +               } else if (amdgpu_device_supports_boco(dev)) { /* enable =
boco as runtime mode */
> +                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_BOCO;
> +                       dev_info(adev->dev, "Using BOCO for runtime pm\n"=
);
> +               } else if (amdgpu_device_supports_baco(dev)) {
> +                       switch (adev->asic_type) {
> +                       case CHIP_VEGA10:
> +                               /* enable BACO as runpm mode if noretry=
=3D0 */
> +                               if (!adev->gmc.noretry)
> +                                       adev->pm.rpm_mode =3D AMDGPU_RUNP=
M_BACO;
> +                               break;
> +                       default:
> +                               /* enable BACO as runpm mode on CI+ */
>                                 adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> -                       break;
> -               default:
> -                       /* enable BACO as runpm mode on CI+ */
> -                       adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
> -                       break;
> -               }
> +                               break;
> +                       }
>
> -               if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO)
> -                       dev_info(adev->dev, "Using BACO for runtime pm\n"=
);
> +                       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO)
> +                               dev_info(adev->dev, "Using BACO for runti=
me pm\n");
> +               }
>         }
>
> +       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
> +               dev_info(adev->dev, "No PM mode for runtime pm\n");
> +
>         /* Call ACPI methods: require modeset init
>          * but failure is not fatal
>          */
> -
>         acpi_status =3D amdgpu_acpi_init(adev);
>         if (acpi_status)
>                 dev_dbg(dev->dev, "Error during ACPI methods call\n");
> --
> 2.34.1
>
