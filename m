Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4FEC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFA510E9F9;
	Fri, 14 Mar 2025 14:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ebxPv+Mk";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9631610E306
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:09:25 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2241c95619eso5536505ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741961365; x=1742566165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1S1XxGGyejfzrFvbVlq6Js3hF/PDUuGivB49gF13+M=;
 b=ebxPv+Mk/5pf35EOWIjTIOruqJ80IHOyA2ZE30lwHi7QvLuy1uO83hcbOnh0fuOKKy
 qNt2MVHco1OZrz9VrgZphn2qxapqqpa4KfHNiYG5wMTp3Dpv/gsj6/GYG9QocrapcqiL
 klRX4ucQwZhLb31SR6Lnyd/jJvAbPHX8SVhXj/cxtZi6B7doH+dlFE3KR25FyMjt3dW4
 SJhHUHMRSaunKSQf8nYO+TjpCFsqbBnrrdUC0SmRl8FLzYqxkK4vkmJ+tG/GabD09jUK
 yNqaQ8dM+739KmtI7Zhaw0Gg12wDV1Cc0JpfW4PaSC27gm8myCp9Wwjyhe7QQcMT259a
 pvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741961365; x=1742566165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1S1XxGGyejfzrFvbVlq6Js3hF/PDUuGivB49gF13+M=;
 b=UCxtpOwkGnhOZTC+2H3o/L76qJnmAGVlRhuFmu0YTQIS8rO0zQ1P26jq+MxZzHSEGI
 qFbQbJiVQ34hiniqRwnG6IWlOq8csPwoN5LolZWqbS00jV68MdnN1mmBabJqCDlgWWWL
 FN1z5keAGFbab8A6OOCnwWO4PHxhF1y6dHAyX/8+JRNrGtp34KQKBT5cgUgwNQyT3BJW
 QxEc7eBB0ASyIx8gCxdoUURbYByqFJBKZpn6JFjZnAPcdgcvSc9h051K8cGr5L3dApRT
 4ypEP57npZLinSDHViXnnDXpo/WF2eAE5xbBiDCNh7wWhUWINJvvNbFVUhHZdJ3ef1Ka
 qK3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiKJyuY9g4Wvl0wmlvtNnHQBuXMsiVCjwA42Z2vpdQRq9msFHrzZFDmg4Dw7IAkidbarpX/huW@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy62htil5gfqWS78NGRbfXipq2qgL4BP0Hz13HpbHiHPrnUAfHM
 6TskPPj9BEaJUq0Hnjr5o3Xt3TOxIjfEtXqxD4t2hVPrPPJ9cKtLMMzNvLNiHV+E7LyfcOwBQ7g
 mmmlm3U0Y/q5en+V9JhCOjcPmpD0=
X-Gm-Gg: ASbGnctJVY/bSb/3JIKZP77C2vDJ6ZlYbXTDLqhFk5jeWvq7UnhQ6kPIoQaxxPSQ3Ow
 Bs8yVnMhqYfkxZO02CWq4LNRBW2RDVBiZL3CkOmF0dZzfV/UK2ur8V/bDjA0P6fZaNcV6mZqgyW
 SUE7leKoALUy06kJ4mcfvQVGS2N6PKvcFaFCqs
X-Google-Smtp-Source: AGHT+IE5QVNSZn/zfkiCWSlM1q1LJWdLtgCT6pq/mHa+ZJ6RJs6UggCYvEabAJlg0tq2W5In0+AgZqqfuF3TMrcHu2M=
X-Received: by 2002:a17:902:f706:b0:221:751f:dab9 with SMTP id
 d9443c01a7336-225e0afb3a1mr12712295ad.14.1741961364479; Fri, 14 Mar 2025
 07:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250311213833.870840-1-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB6012C779AB93D388BB935AC082D32@DM4PR12MB6012.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB6012C779AB93D388BB935AC082D32@DM4PR12MB6012.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Mar 2025 10:09:12 -0400
X-Gm-Features: AQ5f1JqHPKhpOLmDPEam3TfbIOfcz_86aaewA39AlwmhwwfPQvKt704uVZxVwvQ
Message-ID: <CADnq5_Ne+0PtwNEAKtdx7iGw6A7bbujwO8VLE03VgKxNK-hX7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in overdrive
 for smu 14.0.2
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

Applied.  Thanks!

On Wed, Mar 12, 2025 at 11:28=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> It looks good to me.
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tomasz=
 Pakula
> Sent: Wednesday, March 12, 2025 05:39
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in overdrive=
 for smu 14.0.2
>
> Currently, it seems like the code was carried over from RDNA3 because it =
assumes two possible values to set. RDNA4, instead of having:
> 0: min SCLK
> 1: max SCLK
> only has
> 0: SCLK offset
>
> This change makes it so it only reports current offset value instead of s=
howing possible min/max values and their indices. Moreover, it now only acc=
epts the offset as a value, without the indice index.
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
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U <<
> +PP_OD_FEATURE_GFXCLK_BIT;
>                 break;
>
>         case PP_OD_EDIT_MCLK_VDDC_TABLE:
> --
> 2.48.1
>
