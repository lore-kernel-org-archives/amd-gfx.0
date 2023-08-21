Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7883EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 20:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC9C10E2AF;
	Mon, 21 Aug 2023 20:51:05 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D75610E2AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 20:51:04 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a85c5854deso906760b6e.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692651063; x=1693255863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMF1YkNUeHtCUI68GwXmZFQQ6m/SYydmSzZgbjWKJiA=;
 b=h2aK6dM1Z6O3NHWNbiDLvm/jWFWtIFyIlRfCdj0wJM26lt7+xLa8BSyQNQhQp7puSG
 iSu4/i92NhsyG8X0e78nmVp8CMc+Ef38cz3JAalkm6pG3+NaHaewyIuYJbBOSxiGVS9X
 pdy4eix4W2p8fnmr675MMxempUsECoEB9NdivyJOla/seKbeyILIfuloIKAw3fKbDeB9
 A/+howJDJbO8B+GdlzTtZOIu+0i/c1i5K4MmIe5QUX1nOxGI/zcaxZ8m19thHjO/M4UQ
 y3wfzwELWYGQzylNTwgm0oCjmRvyKCmkv52E2rpBWSYURgJg4+yV2739jxUxoQV3bw71
 p2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692651063; x=1693255863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMF1YkNUeHtCUI68GwXmZFQQ6m/SYydmSzZgbjWKJiA=;
 b=kzoumle7lMdedFIUcqf30P0NXTmuGn/wAgIUVhX4Rfml3OFTybULzxt7VrT2sEi80x
 G2KYXtqW09cG31ItYSnrbBKViO1jixXmCV709osDlaL0AAzozzgOXVYyv8EoYqKC3dnd
 9IU8ABxQg9Kpqpul7sJg9z3BFwSRQeP7tTOzG5+NknSyDdYKWIi9EJYGorWItKmbOZRP
 b4gLvN5VGgMETSUvf9bAnSTnDyP+NCDLyuDDKLRTsMqwH9UOt4+j1U5xWYTAhKmcN9Ml
 PV/GXZ6i2e0WGQwYoCMRAWJAXlA8eYHPbnzF14roLpdn+yPTfU0vdLfKwJSUYea+/bPV
 Yc7Q==
X-Gm-Message-State: AOJu0Yx2RN5mgzFDl7o70KYAIXjjYvOjzvJSMEuo1K08NuVP7NRnrvAT
 BdOQgpeZHutemNRVEo7Xsqf1IBVCXyrUoDZI/TvdCRX+
X-Google-Smtp-Source: AGHT+IEFaa0m/jzwj1fl1oPDgITBteg6Rg1/p5KR8AG99EGA4zGs5Yma+wqqc4gqT+mrkW96f0oPeZlQ6cyIUioYQDs=
X-Received: by 2002:aca:1211:0:b0:3a7:3ea1:b5a0 with SMTP id
 17-20020aca1211000000b003a73ea1b5a0mr8265503ois.47.1692651063159; Mon, 21 Aug
 2023 13:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230821063111.628622-1-evan.quan@amd.com>
In-Reply-To: <20230821063111.628622-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Aug 2023 16:50:52 -0400
Message-ID: <CADnq5_NVS+Qh1nQ_yhA1jXXX3v8LZ7tS33TVH9YFkff8g1m1TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct SMU13 gfx voltage related OD settings
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Aug 21, 2023 at 2:50=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
:
>
> The voltage offset setting will be applied to the whole v/f curve line
> instead of per anchor point base.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 45 +++++++------------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 ++++++-------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 31 ++++++-------
>  3 files changed, 43 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index f03647fa3df6..97d550ac6942 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -643,18 +643,14 @@ static ssize_t amdgpu_set_pp_table(struct device *d=
ev,
>   *   They can be used to calibrate the sclk voltage curve. This is
>   *   available for Vega20 and NV1X.
>   *
> - * - voltage offset for the six anchor points of the v/f curve labeled
> - *   OD_VDDC_CURVE. They can be used to calibrate the v/f curve. This
> - *   is only availabe for some SMU13 ASICs.
> - *
>   * - voltage offset(in mV) applied on target voltage calculation.
> - *   This is available for Sienna Cichlid, Navy Flounder and Dimgrey
> - *   Cavefish. For these ASICs, the target voltage calculation can be
> - *   illustrated by "voltage =3D voltage calculated from v/f curve +
> - *   overdrive vddgfx offset"
> + *   This is available for Sienna Cichlid, Navy Flounder, Dimgrey
> + *   Cavefish and some later SMU13 ASICs. For these ASICs, the target
> + *   voltage calculation can be illustrated by "voltage =3D voltage
> + *   calculated from v/f curve + overdrive vddgfx offset"
>   *
> - * - a list of valid ranges for sclk, mclk, and voltage curve points
> - *   labeled OD_RANGE
> + * - a list of valid ranges for sclk, mclk, voltage curve points
> + *   or voltage offset labeled OD_RANGE
>   *
>   * < For APUs >
>   *
> @@ -686,24 +682,17 @@ static ssize_t amdgpu_set_pp_table(struct device *d=
ev,
>   *   E.g., "p 2 0 800" would set the minimum core clock on core
>   *   2 to 800Mhz.
>   *
> - *   For sclk voltage curve,
> - *     - For NV1X, enter the new values by writing a string that
> - *       contains "vc point clock voltage" to the file. The points
> - *       are indexed by 0, 1 and 2. E.g., "vc 0 300 600" will update
> - *       point1 with clock set as 300Mhz and voltage as 600mV. "vc 2
> - *       1000 1000" will update point3 with clock set as 1000Mhz and
> - *       voltage 1000mV.
> - *     - For SMU13 ASICs, enter the new values by writing a string that
> - *       contains "vc anchor_point_index voltage_offset" to the file.
> - *       There are total six anchor points defined on the v/f curve with
> - *       index as 0 - 5.
> - *       - "vc 0 10" will update the voltage offset for point1 as 10mv.
> - *       - "vc 5 -10" will update the voltage offset for point6 as -10mv=
.
> - *
> - *   To update the voltage offset applied for gfxclk/voltage calculation=
,
> - *   enter the new value by writing a string that contains "vo offset".
> - *   This is supported by Sienna Cichlid, Navy Flounder and Dimgrey Cave=
fish.
> - *   And the offset can be a positive or negative value.
> + *   For sclk voltage curve supported by Vega20 and NV1X, enter the new
> + *   values by writing a string that contains "vc point clock voltage"
> + *   to the file. The points are indexed by 0, 1 and 2. E.g., "vc 0 300
> + *   600" will update point1 with clock set as 300Mhz and voltage as 600=
mV.
> + *   "vc 2 1000 1000" will update point3 with clock set as 1000Mhz and
> + *   voltage 1000mV.
> + *
> + *   For voltage offset supported by Sienna Cichlid, Navy Flounder, Dimg=
rey
> + *   Cavefish and some later SMU13 ASICs, enter the new value by writing=
 a
> + *   string that contains "vo offset". E.g., "vo -10" will update the ex=
tra
> + *   voltage offset applied to the whole v/f curve line as -10mv.
>   *
>   * - When you have edited all of the states as needed, write "c" (commit=
)
>   *   to the file to commit your changes
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3903a47669e4..bd0d5f027cac 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1304,16 +1304,14 @@ static int smu_v13_0_0_print_clk_levels(struct sm=
u_context *smu,
>                                         od_table->OverDriveTable.UclkFmax=
);
>                 break;
>
> -       case SMU_OD_VDDC_CURVE:
> +       case SMU_OD_VDDGFX_OFFSET:
>                 if (!smu_v13_0_0_is_od_feature_supported(smu,
>                                                          PP_OD_FEATURE_GF=
X_VF_CURVE_BIT))
>                         break;
>
> -               size +=3D sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
> -               for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
> -                       size +=3D sysfs_emit_at(buf, size, "%d: %dmv\n",
> -                                               i,
> -                                               od_table->OverDriveTable.=
VoltageOffsetPerZoneBoundary[i]);
> +               size +=3D sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n")=
;
> +               size +=3D sysfs_emit_at(buf, size, "%dmV\n",
> +                                     od_table->OverDriveTable.VoltageOff=
setPerZoneBoundary[0]);
>                 break;
>
>         case SMU_OD_RANGE:
> @@ -1355,7 +1353,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_=
context *smu,
>                                                           PP_OD_FEATURE_G=
FX_VF_CURVE,
>                                                           &min_value,
>                                                           &max_value);
> -                       size +=3D sysfs_emit_at(buf, size, "VDDC_CURVE: %=
7dmv %10dmv\n",
> +                       size +=3D sysfs_emit_at(buf, size, "VDDGFX_OFFSET=
: %7dmv %10dmv\n",
>                                               min_value, max_value);
>                 }
>                 break;
> @@ -1504,29 +1502,26 @@ static int smu_v13_0_0_od_edit_dpm_table(struct s=
mu_context *smu,
>                 }
>                 break;
>
> -       case PP_OD_EDIT_VDDC_CURVE:
> +       case PP_OD_EDIT_VDDGFX_OFFSET:
>                 if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFX_VF_CURVE_BIT)) {
> -                       dev_warn(adev->dev, "VF curve setting not support=
ed!\n");
> +                       dev_warn(adev->dev, "Gfx offset setting not suppo=
rted!\n");
>                         return -ENOTSUPP;
>                 }
>
> -               if (input[0] >=3D PP_NUM_OD_VF_CURVE_POINTS ||
> -                   input[0] < 0)
> -                       return -EINVAL;
> -
>                 smu_v13_0_0_get_od_setting_limits(smu,
>                                                   PP_OD_FEATURE_GFX_VF_CU=
RVE,
>                                                   &minimum,
>                                                   &maximum);
> -               if (input[1] < minimum ||
> -                   input[1] > maximum) {
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
>                         dev_info(adev->dev, "Voltage offset (%ld) must be=
 within [%d, %d]!\n",
> -                                input[1], minimum, maximum);
> +                                input[0], minimum, maximum);
>                         return -EINVAL;
>                 }
>
> -               od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[inp=
ut[0]] =3D input[1];
> -               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD=
_FEATURE_GFX_VF_CURVE_BIT;
> +               for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
> +                       od_table->OverDriveTable.VoltageOffsetPerZoneBoun=
dary[i] =3D input[0];
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_GFX_VF_CURVE_BIT);
>                 break;
>
>         case PP_OD_RESTORE_DEFAULT_TABLE:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 94ef5b4d116d..e54a6efc4fb5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1284,16 +1284,14 @@ static int smu_v13_0_7_print_clk_levels(struct sm=
u_context *smu,
>                                         od_table->OverDriveTable.UclkFmax=
);
>                 break;
>
> -       case SMU_OD_VDDC_CURVE:
> +       case SMU_OD_VDDGFX_OFFSET:
>                 if (!smu_v13_0_7_is_od_feature_supported(smu,
>                                                          PP_OD_FEATURE_GF=
X_VF_CURVE_BIT))
>                         break;
>
> -               size +=3D sysfs_emit_at(buf, size, "OD_VDDC_CURVE:\n");
> -               for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
> -                       size +=3D sysfs_emit_at(buf, size, "%d: %dmv\n",
> -                                               i,
> -                                               od_table->OverDriveTable.=
VoltageOffsetPerZoneBoundary[i]);
> +               size +=3D sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n")=
;
> +               size +=3D sysfs_emit_at(buf, size, "%dmV\n",
> +                                     od_table->OverDriveTable.VoltageOff=
setPerZoneBoundary[0]);
>                 break;
>
>         case SMU_OD_RANGE:
> @@ -1335,7 +1333,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_=
context *smu,
>                                                           PP_OD_FEATURE_G=
FX_VF_CURVE,
>                                                           &min_value,
>                                                           &max_value);
> -                       size +=3D sysfs_emit_at(buf, size, "VDDC_CURVE: %=
7dmv %10dmv\n",
> +                       size +=3D sysfs_emit_at(buf, size, "VDDGFX_OFFSET=
: %7dmv %10dmv\n",
>                                               min_value, max_value);
>                 }
>                 break;
> @@ -1484,29 +1482,26 @@ static int smu_v13_0_7_od_edit_dpm_table(struct s=
mu_context *smu,
>                 }
>                 break;
>
> -       case PP_OD_EDIT_VDDC_CURVE:
> +       case PP_OD_EDIT_VDDGFX_OFFSET:
>                 if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATU=
RE_GFX_VF_CURVE_BIT)) {
> -                       dev_warn(adev->dev, "VF curve setting not support=
ed!\n");
> +                       dev_warn(adev->dev, "Gfx offset setting not suppo=
rted!\n");
>                         return -ENOTSUPP;
>                 }
>
> -               if (input[0] >=3D PP_NUM_OD_VF_CURVE_POINTS ||
> -                   input[0] < 0)
> -                       return -EINVAL;
> -
>                 smu_v13_0_7_get_od_setting_limits(smu,
>                                                   PP_OD_FEATURE_GFX_VF_CU=
RVE,
>                                                   &minimum,
>                                                   &maximum);
> -               if (input[1] < minimum ||
> -                   input[1] > maximum) {
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
>                         dev_info(adev->dev, "Voltage offset (%ld) must be=
 within [%d, %d]!\n",
> -                                input[1], minimum, maximum);
> +                                input[0],minimum, maximum);
>                         return -EINVAL;
>                 }
>
> -               od_table->OverDriveTable.VoltageOffsetPerZoneBoundary[inp=
ut[0]] =3D input[1];
> -               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD=
_FEATURE_GFX_VF_CURVE_BIT;
> +               for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
> +                       od_table->OverDriveTable.VoltageOffsetPerZoneBoun=
dary[i] =3D input[0];
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D BIT(PP_OD_F=
EATURE_GFX_VF_CURVE_BIT);
>                 break;
>
>         case PP_OD_RESTORE_DEFAULT_TABLE:
> --
> 2.34.1
>
