Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA8DC47DA2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 14:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7871810E6AE;
	Wed, 17 Jan 2024 14:15:14 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18D610E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 14:15:10 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-210aaf2af35so193076fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 06:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500849; x=1706105649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQj2SR0tQ9b33YQSAypj8qp5bSuca1UhDyIbQ1YeOQY=;
 b=PBVYvxBGqqvtgnkAtRqETHdoxzo8Uq+Ze3/4Q/s6FxjK9yDht741U5pDngTukJK2Iq
 Arq0j8Xh+a6DdsrIacQ+OtRzeKvPutZDf4i2ej+bgbmBnEBaon1+p5SqG+Kw25jH4ZEf
 JKIj0UGQSY0ZPxRg315QS01xMwfoPzWprVIqpt+SCOe5Zo+nwJ/GR/2xB3UK6jpoYcUU
 xqWZMr8Gd784HiYeRyetsuS3akqyOdJhw6J3NpTZ4eLgfJpJy4TYiIyIs4l+tMJ99v/w
 9PWCMg6WeVjIdd7PXPYzUfmJnCtABDIUTtPYmpRHOjn487/e/XK6C53uHq4A9niG4SEs
 3FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500849; x=1706105649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQj2SR0tQ9b33YQSAypj8qp5bSuca1UhDyIbQ1YeOQY=;
 b=eVKg5dy1Azzbd5yLPfTnCiSBOzvdlQPoay3bPq6/iQrPXPfUWFEfyJ6UbS+K/MBzOv
 EqxiWX25rDqVmFvpSzjNg0iH13xgVOhLDK5calf/gD19+KKfaElajXl94irFJaS/YIeh
 n5lBgekGLb/uKjuQx1JTU0dQvMXConKuKf+KocQTAimE9REyKwwaTv0iIYItXhbnugLR
 4KCvUjlTx3Vaz/cr6JtJwAORUFZ2LldioD16peXNLJ6c+07ANTWyGSE0ltuUTP/nphkG
 IXh+1oCz/3AOxcSbOdrhr4K/PDp6cpcULQPjPXx9M4JPBtdv3XO9/xNJ7KzKDEQ2Kxp9
 XaqA==
X-Gm-Message-State: AOJu0YwphzZUj3/5Hy8DPeXvfTCUDVVRGK2246XlfQQkPPH1Y5+v7F+F
 nE7egikeyFzGKUW3ei3eUagmyhcQkvLJjm1X1hU=
X-Google-Smtp-Source: AGHT+IE/SLbYO5ZDm8bL3G59nwauObwFxAPVe/Ci3RXxCuUiRVcY2R7PK8ly7Pcm5NUytrY+Yk7vdFsw8xFwi9lyCoI=
X-Received: by 2002:a05:6871:878d:b0:210:a45b:5ec0 with SMTP id
 td13-20020a056871878d00b00210a45b5ec0mr724212oab.37.1705500849555; Wed, 17
 Jan 2024 06:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20240117085229.981555-1-Jun.Ma2@amd.com>
In-Reply-To: <20240117085229.981555-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jan 2024 09:13:57 -0500
Message-ID: <CADnq5_NUFJYOdNa2sm4y_KU108EUvwpR7MxTQySwdK+S=1G1hA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power source flag error
To: Ma Jun <Jun.Ma2@amd.com>
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 17, 2024 at 4:01=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> The power source flag should be updated when
> [1] System receives an interrupt indicating that the power source
> has changed.
> [2] System resumes from suspend or runtime suspend
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
>  3 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index c16703868e5c..e16d22e30a8a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -24,6 +24,7 @@
>
>  #include <linux/firmware.h>
>  #include <linux/pci.h>
> +#include <linux/power_supply.h>
>  #include <linux/reboot.h>
>
>  #include "amdgpu.h"
> @@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(s=
truct smu_context *smu)
>         return smu_set_config_table(smu, &adev->pm.config_table);
>  }
>
> +static void smu_update_power_source(struct amdgpu_device *adev)
> +{
> +       if (power_supply_is_system_supplied() > 0)
> +               adev->pm.ac_power =3D true;
> +       else
> +               adev->pm.ac_power =3D false;
> +
> +       if (is_support_sw_smu(adev))

Do we need this check here?  This is the sw_smu code.

> +               smu_set_ac_dc(adev->powerplay.pp_handle);
> +}
> +
>  static int smu_late_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
>          * handle the switch automatically. Driver involvement
>          * is unnecessary.
>          */
> -       if (!smu->dc_controlled_by_gpio) {
> -               ret =3D smu_set_power_source(smu,
> -                                          adev->pm.ac_power ? SMU_POWER_=
SOURCE_AC :
> -                                          SMU_POWER_SOURCE_DC);
> -               if (ret) {
> -                       dev_err(adev->dev, "Failed to switch to %s mode!\=
n",
> -                               adev->pm.ac_power ? "AC" : "DC");
> -                       return ret;
> -               }
> -       }
> +       if (!smu->dc_controlled_by_gpio)
> +               smu_update_power_source(adev);
>
>         if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0=
, 1)) ||
>             (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0=
, 3)))
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 2e7f8d5cfc28..8047150fddd4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_de=
vice *adev,
>                         case 0x3:
>                                 dev_dbg(adev->dev, "Switched to AC mode!\=
n");
>                                 schedule_work(&smu->interrupt_work);
> +                               adev->pm.ac_power =3D true;
>                                 break;
>                         case 0x4:
>                                 dev_dbg(adev->dev, "Switched to DC mode!\=
n");
>                                 schedule_work(&smu->interrupt_work);
> +                               adev->pm.ac_power =3D false;
>                                 break;
>                         case 0x7:
>                                 /*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 771a3d457c33..c486182ff275 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_de=
vice *adev,
>                         case 0x3:
>                                 dev_dbg(adev->dev, "Switched to AC mode!\=
n");
>                                 smu_v13_0_ack_ac_dc_interrupt(smu);
> +                               adev->pm.ac_power =3D true;
>                                 break;
>                         case 0x4:
>                                 dev_dbg(adev->dev, "Switched to DC mode!\=
n");
>                                 smu_v13_0_ack_ac_dc_interrupt(smu);
> +                               adev->pm.ac_power =3D false;
>                                 break;
>                         case 0x7:
>                                 /*
> --
> 2.34.1
>
