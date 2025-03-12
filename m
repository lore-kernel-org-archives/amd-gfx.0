Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE6C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 14:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD9510E797;
	Wed, 12 Mar 2025 14:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MAEc0Iui";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA86B10E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 14:54:21 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2240ff0bd6eso14310365ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741791261; x=1742396061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7I6mKVtd2KaPgdLYQ54hE/LlgpO/5eUmBFgq1XkPdz8=;
 b=MAEc0Iui1epqRJJ4oqaBHHlzJy3X2rgeMsWP5l+GTfsBA3XNDp1abuiZwRbSeQ20dG
 PQ0QCx7OhCBZZXU05ZmsLXlaRuysJDCjA7H+Ef4deNF1l9N0nYsVLd85G765HqCPWqum
 JCUh83XZEB+m6RwEWmSob+TFk2E22s9mDnAlUh3XSOmDDlCdgIZ2J5Wc2tjGHr1NoS8L
 NKtZMm0eAZqtmscEYTkr0U6ggFi0YDn5RdkGWsgdOqYRJYZLZTrcSWeCdF1w0znhkUDY
 itEwZmL+mH09TwdwfM/sXZbIPoLrybltKoyF+WaENK1MhoyfORDM2syCDC/NU9KqFKHL
 HXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741791261; x=1742396061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7I6mKVtd2KaPgdLYQ54hE/LlgpO/5eUmBFgq1XkPdz8=;
 b=X2hwBhHYgXJ/HwI+4mF5Y0qEuPsSFzTqetI9D+IvunyzNYbhExj3bAVT3MrNIzI+zu
 SbaZnY1bYkt4ZDioHfHTw9SisYtdFJDsCKyJ0BVmR4EmW0kVhy1/r7SL2mpRQV1JhrKr
 zsdSYOiakd2+/8im+Q+COPIGPhgMA0W82Ow8do03b/mhPNN5liqSIh/fM1QOrbx+93RE
 ouroguGzNkit2VaChtV9Tbw9hqi+4p1HT9NgdqRfTcVkoWjt9c/8S3RPGlgLnEp+X3Xt
 L9ZjPisfdmj1YUOQ/UsBJxBpT9H0fXboxbqX2puLyxelh4GJq9zfSNY984whNCvfK0Lj
 bxEQ==
X-Gm-Message-State: AOJu0YyoPyNoZZrXX/LrAj6GU2my5u+HkTNhpDodOfbq1XhlCHJEVNyM
 7qrkfZOuROGG4P43tVcXM+UV6BXr8IVFtE/AA5SHjt03azbIKLZmTWsVrxFn9Mi+YBJqqPGO/U6
 bvPgCYaBJWVjYmGaiBq4cbYbTzhc=
X-Gm-Gg: ASbGncsDS5Ix12K4aFIY83ralOB58enakDoQM3W5sliRxP1Q4CP2/TK7heeOMXHkgQc
 VJHaWDzlYmvyiDrLgOU5WD0rqFfN4PF9ZPKA5vPEjI36nIjuFEi8w8u6sgOHkw3xNhBcJ6+uZSK
 Gi83z3Zbn2uEwXlcHS4Vh6SDvTaQ==
X-Google-Smtp-Source: AGHT+IF40XCeVkubn2NXd9TKKp1km47n2ao4XBLSvhb5fMnJzhJnLxD3aauwLnBdl7AOlbF8R+Sl7bY4VQJc4HMQMDo=
X-Received: by 2002:a17:902:f68d:b0:223:5696:44d6 with SMTP id
 d9443c01a7336-225932f3df0mr43380995ad.12.1741791261351; Wed, 12 Mar 2025
 07:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250311213833.870840-1-tomasz.pakula.oficjalny@gmail.com>
In-Reply-To: <20250311213833.870840-1-tomasz.pakula.oficjalny@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Mar 2025 10:54:08 -0400
X-Gm-Features: AQ5f1Jq-vQom4HIr7EhzFMVS8VVGQoKP2VffoNbxhgPQp2fHGmB2DTThCJ9Tf7A
Message-ID: <CADnq5_Oweha2RRpxMD4eRikSh5hsp6_syvN5kH3uc13FrOw=-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in overdrive
 for smu 14.0.2
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

+ Kenneth, Kevin

On Wed, Mar 12, 2025 at 6:18=E2=80=AFAM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> Currently, it seems like the code was carried over from RDNA3 because
> it assumes two possible values to set. RDNA4, instead of having:
> 0: min SCLK
> 1: max SCLK
> only has
> 0: SCLK offset
>
> This change makes it so it only reports current offset value instead of
> showing possible min/max values and their indices. Moreover, it now only
> accepts the offset as a value, without the indice index.
>
> Additionally, the lower bound was printed as %u by mistake.
>
> Old:
> OD_SCLK_OFFSET:
> 0: -500Mhz
> 1: 1000Mhz
> OD_MCLK:
> 0: 97Mhz
> 1: 1259MHz
> OD_VDDGFX_OFFSET:
> 0mV
> OD_RANGE:
> SCLK_OFFSET:    -500Mhz       1000Mhz
> MCLK:      97Mhz       1500Mhz
> VDDGFX_OFFSET:    -200mv          0mv
>
> New:
> OD_SCLK_OFFSET:
> 0Mhz
> OD_MCLK:
> 0: 97Mhz
> 1: 1259MHz
> OD_VDDGFX_OFFSET:
> 0mV
> OD_RANGE:
> SCLK_OFFSET:    -500Mhz       1000Mhz
> MCLK:      97Mhz       1500Mhz
> VDDGFX_OFFSET:    -200mv          0mv
>
> Setting this offset:
> Old: "s 1 <offset>"
> New: "s <offset>"
>
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 59 ++++++-------------
>  1 file changed, 18 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 5cad09c5f2ff..62bd9647541a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1193,16 +1193,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu=
_context *smu,
>                                                          PP_OD_FEATURE_GF=
XCLK_BIT))
>                         break;
>
> -               PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -               const OverDriveLimits_t * const overdrive_upperlimits =3D
> -                                       &pptable->SkuTable.OverDriveLimit=
sBasicMax;
> -               const OverDriveLimits_t * const overdrive_lowerlimits =3D
> -                                       &pptable->SkuTable.OverDriveLimit=
sBasicMin;
> -
>                 size +=3D sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
> -               size +=3D sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n"=
,
> -                                       overdrive_lowerlimits->GfxclkFoff=
set,
> -                                       overdrive_upperlimits->GfxclkFoff=
set);
> +               size +=3D sysfs_emit_at(buf, size, "%dMhz\n",
> +                                       od_table->OverDriveTable.GfxclkFo=
ffset);
>                 break;
>
>         case SMU_OD_MCLK:
> @@ -1336,13 +1329,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu=
_context *smu,
>                 size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>
>                 if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATUR=
E_GFXCLK_BIT)) {
> -                       smu_v14_0_2_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FXCLK_FMIN,
> -                                                         &min_value,
> -                                                         NULL);
>                         smu_v14_0_2_get_od_setting_limits(smu,
>                                                           PP_OD_FEATURE_G=
FXCLK_FMAX,
> -                                                         NULL,
> +                                                         &min_value,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "SCLK_OFFSET: =
%7dMhz %10uMhz\n",
>                                               min_value, max_value);
> @@ -2417,36 +2406,24 @@ static int smu_v14_0_2_od_edit_dpm_table(struct s=
mu_context *smu,
>                         return -ENOTSUPP;
>                 }
>
> -               for (i =3D 0; i < size; i +=3D 2) {
> -                       if (i + 2 > size) {
> -                               dev_info(adev->dev, "invalid number of in=
put parameters %d\n", size);
> -                               return -EINVAL;
> -                       }
> -
> -                       switch (input[i]) {
> -                       case 1:
> -                               smu_v14_0_2_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_GFXCLK_FMAX,
> -                                                                 &minimu=
m,
> -                                                                 &maximu=
m);
> -                               if (input[i + 1] < minimum ||
> -                                   input[i + 1] > maximum) {
> -                                       dev_info(adev->dev, "GfxclkFmax (=
%ld) must be within [%u, %u]!\n",
> -                                               input[i + 1], minimum, ma=
ximum);
> -                                       return -EINVAL;
> -                               }
> -
> -                               od_table->OverDriveTable.GfxclkFoffset =
=3D input[i + 1];
> -                               od_table->OverDriveTable.FeatureCtrlMask =
|=3D 1U << PP_OD_FEATURE_GFXCLK_BIT;
> -                               break;
> +               if (size !=3D 1) {
> +                       dev_info(adev->dev, "invalid number of input para=
meters %d\n", size);
> +                       return -EINVAL;
> +               }
>
> -                       default:
> -                               dev_info(adev->dev, "Invalid SCLK_VDDC_TA=
BLE index: %ld\n", input[i]);
> -                               dev_info(adev->dev, "Supported indices: [=
0:min,1:max]\n");
> -                               return -EINVAL;
> -                       }
> +               smu_v14_0_2_get_od_setting_limits(smu,
> +                                                 PP_OD_FEATURE_GFXCLK_FM=
AX,
> +                                                 &minimum,
> +                                                 &maximum);
> +               if (input[0] < minimum ||
> +                   input[0] > maximum) {
> +                       dev_info(adev->dev, "GfxclkFoffset must be within=
 [%d, %u]!\n",
> +                                minimum, maximum);
> +                       return -EINVAL;
>                 }
>
> +               od_table->OverDriveTable.GfxclkFoffset =3D input[0];
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD=
_FEATURE_GFXCLK_BIT;
>                 break;
>
>         case PP_OD_EDIT_MCLK_VDDC_TABLE:
> --
> 2.48.1
>
