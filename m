Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE23C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 13:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4154B10EF1F;
	Wed, 13 Mar 2024 13:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hb2LSbmU";
	dkim-atps=neutral
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C35D10EF1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 13:21:55 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-7dadba3284cso401831241.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710336114; x=1710940914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdTmrLicne0xcyPbGXZU6GlpHzRsoMYU6PsfeUaLd0k=;
 b=hb2LSbmU/7o3lnKupfCnJnh29Xvqwf+a0fJHV36wr1tAqxVrxyo7ZbUvPN09BKuH07
 gwsmmBsnfW2E6typc1Vd5RmZR9jmhy5u8kNaG2IQn2Ctsss0v36lBIVT03FHIkTQ6FAF
 dwTWmUju7HOp3Dn+ahCjRf7RgOX15ENR/5m8v2xAZkI0wz7VW09rFkqxo3JS/QlXTmoX
 +nO5qU9JwsZL9IQvJYxJbo0BSE6Pwtl0TpqhCwaWtkuEXrLpmu1/7oB/FEXrypR65Nxk
 jxxDUuJal1E6Ak3seprA1yc63ZOP+rPpCI01nysMte52NS3QDqr93IXvN1ILvF5u7CtG
 rvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710336114; x=1710940914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdTmrLicne0xcyPbGXZU6GlpHzRsoMYU6PsfeUaLd0k=;
 b=e3Wedz+KFnmUqbSGGu11922WQPMs8aDfpupJpXU49WpXDrJt5SUqZGwb5rnaB7e3HL
 X5rDsOlRh+ha+0WCEv/QzLIvFbRuttmLYk2vbWL9t1nH34J/3x+Ukp2XLCzFWXNSA2x8
 7HFoEM0hifVJgzF8tBQqy+q4H0mJxBIZAhP/NqRGcvO1dIY7Zr+KefZm4ivScxoXXT4a
 9xS3yPsDoLVq6024aQ9Yu7XZTRk1S8hXhOkL7+2i7mXkKb05W+fcyB/AlX9ck9qWSsoh
 JE3EcH4LuJvvpEqZDbZdAX+WSPM93171vkRtwpT+xJDUtt7y4JzkQ6aD3/tjKN2YA9Ei
 UDLA==
X-Gm-Message-State: AOJu0Yx9vC2L5+bHUZ90yHYhgV9UTKexU6kr++Z0Q3e6y6yKyw0Kx/il
 eEdQP4mHauGpmjHczhHhmXy0q4dhwWdV/GOsUHT0UkAWp/HNO1+6S/7V9vSqmHiFbLkvA9QkA0k
 dg8CU5KcFUqHsA0BIO/wIKiWI2Uk=
X-Google-Smtp-Source: AGHT+IGC/k1XvuTXmfw6IfKzYNe3W3t1lMdLqc2KXCoNclAqMwoJHN5i4x2i/ApXnS7ufb2DlK+NGvURWjYMQp53rw0=
X-Received: by 2002:a67:b305:0:b0:474:c377:19f0 with SMTP id
 a5-20020a67b305000000b00474c37719f0mr3712231vsm.14.1710336113685; Wed, 13 Mar
 2024 06:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240313105934.2362429-1-Jun.Ma2@amd.com>
In-Reply-To: <20240313105934.2362429-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Mar 2024 09:21:41 -0400
Message-ID: <CADnq5_MJi3Fua00wOgAhHsQp=_rYg954PighWQJ1uqkDht99rw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/pm: Fix NULL pointer dereference when get
 power limit
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com, 
 Alexander.Deucher@amd.com, kevinyang.wang@amd.com, 
 Yin Zhenguo <zhenguo.yin@amd.com>, Lazar Lijo <lijo.lazar@amd.com>
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

On Wed, Mar 13, 2024 at 7:07=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Because powerplay_table initialization is skipped under
> sriov case, We check and set default lower and upper OD
> value if powerplay_table is NULL.
>
> Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
> Suggested-by: Lazar Lijo <lijo.lazar@amd.com>
> Suggested-by: Alex Deucher <Alexander.Deucher@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 14 ++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 16 +++++++++-------
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 14 ++++++++------
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 14 ++++++++------
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 14 ++++++++------
>  5 files changed, 41 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 1d96eb274d72..a406372e79d8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1286,7 +1286,7 @@ static int arcturus_get_power_limit(struct smu_cont=
ext *smu,
>         struct smu_11_0_powerplay_table *powerplay_table =3D
>                 (struct smu_11_0_powerplay_table *)smu->smu_table.power_p=
lay_table;
>         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -       uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
>
>         if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>                 /* the last hope to figure out the ppt limit */
> @@ -1303,12 +1303,14 @@ static int arcturus_get_power_limit(struct smu_co=
ntext *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled)
> -               od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -       else
> -               od_percent_upper =3D 0;
> +       if (powerplay_table) {
> +               if (smu->od_enabled)
> +                       od_percent_upper =3D le32_to_cpu(powerplay_table-=
>overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +               else
> +                       od_percent_upper =3D 0;
>
> -       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +       }
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                                         od_percent_upper,=
 od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ed189a3878eb..65bba5fc2335 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2339,7 +2339,7 @@ static int navi10_get_power_limit(struct smu_contex=
t *smu,
>                 (struct smu_11_0_powerplay_table *)smu->smu_table.power_p=
lay_table;
>         struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings=
;
>         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -       uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
>
>         if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>                 /* the last hope to figure out the ppt limit */
> @@ -2356,13 +2356,15 @@ static int navi10_get_power_limit(struct smu_cont=
ext *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled &&
> -                   navi10_od_feature_is_supported(od_settings, SMU_11_0_=
ODCAP_POWER_LIMIT))
> -               od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -       else
> -               od_percent_upper =3D 0;
> +       if (powerplay_table) {
> +               if (smu->od_enabled &&
> +                           navi10_od_feature_is_supported(od_settings, S=
MU_11_0_ODCAP_POWER_LIMIT))
> +                       od_percent_upper =3D le32_to_cpu(powerplay_table-=
>overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +               else
> +                       od_percent_upper =3D 0;
>
> -       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +       }
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index a405424dd699..9371e6e79c56 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -625,7 +625,7 @@ static int sienna_cichlid_get_power_limit(struct smu_=
context *smu,
>  {
>         struct smu_11_0_7_powerplay_table *powerplay_table =3D
>                 (struct smu_11_0_7_powerplay_table *)smu->smu_table.power=
_play_table;
> -       uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
>         uint16_t *table_member;
>
>         GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
> @@ -640,12 +640,14 @@ static int sienna_cichlid_get_power_limit(struct sm=
u_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled)
> -               od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -       else
> -               od_percent_upper =3D 0;
> +       if (powerplay_table) {
> +               if (smu->od_enabled)
> +                       od_percent_upper =3D le32_to_cpu(powerplay_table-=
>overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +               else
> +                       od_percent_upper =3D 0;
>
> -       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +       }
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 6a501d2661f5..f1e388c2863a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2356,7 +2356,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
>                 (struct smu_13_0_0_powerplay_table *)table_context->power=
_play_table;
>         PPTable_t *pptable =3D table_context->driver_pptable;
>         SkuTable_t *skutable =3D &pptable->SkuTable;
> -       uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
>         uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PP=
T0][POWER_SOURCE_AC];
>
>         if (smu_v13_0_get_current_power_limit(smu, &power_limit))
> @@ -2369,12 +2369,14 @@ static int smu_v13_0_0_get_power_limit(struct smu=
_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled)
> -               od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -       else
> -               od_percent_upper =3D 0;
> +       if (powerplay_table) {
> +               if (smu->od_enabled)
> +                       od_percent_upper =3D le32_to_cpu(powerplay_table-=
>overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +               else
> +                       od_percent_upper =3D 0;
>
> -       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +       }
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 3dc7b60cb075..8abf0a772e6b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2320,7 +2320,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
>                 (struct smu_13_0_7_powerplay_table *)table_context->power=
_play_table;
>         PPTable_t *pptable =3D table_context->driver_pptable;
>         SkuTable_t *skutable =3D &pptable->SkuTable;
> -       uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
>         uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PP=
T0][POWER_SOURCE_AC];
>
>         if (smu_v13_0_get_current_power_limit(smu, &power_limit))
> @@ -2333,12 +2333,14 @@ static int smu_v13_0_7_get_power_limit(struct smu=
_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled)
> -               od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -       else
> -               od_percent_upper =3D 0;
> +       if (powerplay_table) {
> +               if (smu->od_enabled)
> +                       od_percent_upper =3D le32_to_cpu(powerplay_table-=
>overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +               else
> +                       od_percent_upper =3D 0;
>
> -       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +       }
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> --
> 2.34.1
>
