Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE6CC47DAF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 14:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BB710EA14;
	Fri, 19 Jan 2024 14:45:01 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F7410EA14
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 14:44:59 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-20503dc09adso500946fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 06:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705675438; x=1706280238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DHCeuz+kAepITfOqbplVWmxx9Im/69pJy6hyS+3Ok0=;
 b=j8dJaShgsPeStIg+64l9SgXQeS31gfgtNj+Bbji+SskqsHq3h5VqDaZ3SkXaEfJH30
 t3RTcixsjrer3JE1jtJ1fz1UIG408Ik2WjieVs1MAPdeRYSPXD8BFmZyOkOU4IPENSHJ
 6Mee3c6aewUzzuRQ0mQYgdWqBW5vclv2b90DKB5sdR5PxUZHbf/t6nWiFUUTIfYSQ9ah
 ieJfk9kxm+rc6g8fvBG/AHMvtx6YUlVkDpGhPBjq70RncDQt1Jnzk2zYFAop6rAWKnY6
 jy6UgKT3R9bttNDiajhGBXJfKZt9j47PtilH+X6tKsndLFhcxtY1bSGt396fpZ4oFXen
 tXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705675438; x=1706280238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DHCeuz+kAepITfOqbplVWmxx9Im/69pJy6hyS+3Ok0=;
 b=u1lKTSVJqck9QCf3cqT5G5kDChkmqp8ARLS3Lsd0ADTbZTm+AoAAAzsAAqTqUG1MGH
 boKWRAe3BSQluaLeCy7/Zz/HrGWrxSHkCAWMNknmY4FzxQf/c/igIsNlsTDoB6ta+2hV
 v4gf7bxpwF0J5ffKZ0Des9SdS9Bqr/9uCOFIa8N4ZlLpWPweBtN89Q+4h4gTMAJPsxxz
 MOEGGOMDdkI6h+SPpVMOlkxJWZp2HdTOdPqQAysuoaR6oLB20AQj1Wx8YN6l9MjO6EH6
 SzzKT91SOlYzLJt57czQu3JP1t248xLtqv1anmW0q7k/xaJv8nZvP52AKvOSy2KZIYpQ
 Re1A==
X-Gm-Message-State: AOJu0YxhpAxPu/ePfT0y7YTgWFyuePYsz/likAzcG4+QqyMAXt0vSr/e
 hg1ptDnddSHZf6nhPiE1Q4DDhRwHXjxS+Rw237cFIvqwjKrzLHqqkIuz5Akq4uWetejj/+c6wEk
 lkeSOF9eX+8xlWJRGPS9K/AhNclc=
X-Google-Smtp-Source: AGHT+IF3Lyu3Ks8AdhGzwJdV6lHBtR4a9raT+1raVhWEfc0sxnIfTvaL1V0jYV46Oh2MI+zePH2YsV6ZMk+TbeUrKXk=
X-Received: by 2002:a05:6870:4799:b0:210:847f:540b with SMTP id
 c25-20020a056870479900b00210847f540bmr2545222oaq.117.1705675438631; Fri, 19
 Jan 2024 06:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20240119082013.2953172-1-kenneth.feng@amd.com>
In-Reply-To: <20240119082013.2953172-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jan 2024 09:43:47 -0500
Message-ID: <CADnq5_O8iCe0M59fykor5M26=P2djavZzvMcSyVFD1O+WqScUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: update the power cap setting
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 19, 2024 at 3:47=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> update the power cap setting for smu_v13.0.0/smu_v13.0.7
>

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2356

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 54 ++++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 54 ++++++++++++++++++-
>  2 files changed, 104 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 231122622a9c..e769adb8da2c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2357,6 +2357,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
>         PPTable_t *pptable =3D table_context->driver_pptable;
>         SkuTable_t *skutable =3D &pptable->SkuTable;
>         uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PP=
T0][POWER_SOURCE_AC];
>
>         if (smu_v13_0_get_current_power_limit(smu, &power_limit))
>                 power_limit =3D smu->adev->pm.ac_power ?
> @@ -2380,7 +2381,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
>
>         if (max_power_limit) {
> -               *max_power_limit =3D power_limit * (100 + od_percent_uppe=
r);
> +               *max_power_limit =3D msg_limit * (100 + od_percent_upper)=
;
>                 *max_power_limit /=3D 100;
>         }
>
> @@ -2960,6 +2961,55 @@ static bool smu_v13_0_0_wbrf_support_check(struct =
smu_context *smu)
>         }
>  }
>
> +static int smu_v13_0_0_set_power_limit(struct smu_context *smu,
> +                                      enum smu_ppt_limit_type limit_type=
,
> +                                      uint32_t limit)
> +{
> +       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> +       SkuTable_t *skutable =3D &pptable->SkuTable;
> +       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PP=
T0][POWER_SOURCE_AC];
> +       struct smu_table_context *table_context =3D &smu->smu_table;
> +       OverDriveTableExternal_t *od_table =3D
> +               (OverDriveTableExternal_t *)table_context->overdrive_tabl=
e;
> +       int ret =3D 0;
> +
> +       if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
> +               return -EINVAL;
> +
> +       if (limit <=3D msg_limit) {
> +               if (smu->current_power_limit > msg_limit) {
> +                       od_table->OverDriveTable.Ppt =3D 0;
> +                       od_table->OverDriveTable.FeatureCtrlMask |=3D 1U =
<< PP_OD_FEATURE_PPT_BIT;
> +
> +                       ret =3D smu_v13_0_0_upload_overdrive_table(smu, o=
d_table);
> +                       if (ret) {
> +                               dev_err(smu->adev->dev, "Failed to upload=
 overdrive table!\n");
> +                               return ret;
> +                       }
> +               }
> +               return smu_v13_0_set_power_limit(smu, limit_type, limit);
> +       } else if (smu->od_enabled) {
> +               ret =3D smu_v13_0_set_power_limit(smu, limit_type, msg_li=
mit);
> +               if (ret)
> +                       return ret;
> +
> +               od_table->OverDriveTable.Ppt =3D (limit * 100) / msg_limi=
t - 100;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD=
_FEATURE_PPT_BIT;
> +
> +               ret =3D smu_v13_0_0_upload_overdrive_table(smu, od_table)=
;
> +               if (ret) {
> +                 dev_err(smu->adev->dev, "Failed to upload overdrive tab=
le!\n");
> +                 return ret;
> +               }
> +
> +               smu->current_power_limit =3D limit;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
>         .get_allowed_feature_mask =3D smu_v13_0_0_get_allowed_feature_mas=
k,
>         .set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
> @@ -3014,7 +3064,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_f=
uncs =3D {
>         .set_fan_control_mode =3D smu_v13_0_set_fan_control_mode,
>         .enable_mgpu_fan_boost =3D smu_v13_0_0_enable_mgpu_fan_boost,
>         .get_power_limit =3D smu_v13_0_0_get_power_limit,
> -       .set_power_limit =3D smu_v13_0_set_power_limit,
> +       .set_power_limit =3D smu_v13_0_0_set_power_limit,
>         .set_power_source =3D smu_v13_0_set_power_source,
>         .get_power_profile_mode =3D smu_v13_0_0_get_power_profile_mode,
>         .set_power_profile_mode =3D smu_v13_0_0_set_power_profile_mode,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 59606a19e3d2..7c3e162e2d81 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2321,6 +2321,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
>         PPTable_t *pptable =3D table_context->driver_pptable;
>         SkuTable_t *skutable =3D &pptable->SkuTable;
>         uint32_t power_limit, od_percent_upper, od_percent_lower;
> +       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PP=
T0][POWER_SOURCE_AC];
>
>         if (smu_v13_0_get_current_power_limit(smu, &power_limit))
>                 power_limit =3D smu->adev->pm.ac_power ?
> @@ -2344,7 +2345,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
>
>         if (max_power_limit) {
> -               *max_power_limit =3D power_limit * (100 + od_percent_uppe=
r);
> +               *max_power_limit =3D msg_limit * (100 + od_percent_upper)=
;
>                 *max_power_limit /=3D 100;
>         }
>
> @@ -2545,6 +2546,55 @@ static bool smu_v13_0_7_wbrf_support_check(struct =
smu_context *smu)
>         return smu->smc_fw_version > 0x00524600;
>  }
>
> +static int smu_v13_0_7_set_power_limit(struct smu_context *smu,
> +                                      enum smu_ppt_limit_type limit_type=
,
> +                                      uint32_t limit)
> +{
> +       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> +       SkuTable_t *skutable =3D &pptable->SkuTable;
> +       uint32_t msg_limit =3D skutable->MsgLimits.Power[PPT_THROTTLER_PP=
T0][POWER_SOURCE_AC];
> +       struct smu_table_context *table_context =3D &smu->smu_table;
> +       OverDriveTableExternal_t *od_table =3D
> +               (OverDriveTableExternal_t *)table_context->overdrive_tabl=
e;
> +       int ret =3D 0;
> +
> +       if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
> +               return -EINVAL;
> +
> +       if (limit <=3D msg_limit) {
> +               if (smu->current_power_limit > msg_limit) {
> +                       od_table->OverDriveTable.Ppt =3D 0;
> +                       od_table->OverDriveTable.FeatureCtrlMask |=3D 1U =
<< PP_OD_FEATURE_PPT_BIT;
> +
> +                       ret =3D smu_v13_0_7_upload_overdrive_table(smu, o=
d_table);
> +                       if (ret) {
> +                               dev_err(smu->adev->dev, "Failed to upload=
 overdrive table!\n");
> +                               return ret;
> +                       }
> +               }
> +               return smu_v13_0_set_power_limit(smu, limit_type, limit);
> +       } else if (smu->od_enabled) {
> +               ret =3D smu_v13_0_set_power_limit(smu, limit_type, msg_li=
mit);
> +               if (ret)
> +                       return ret;
> +
> +               od_table->OverDriveTable.Ppt =3D (limit * 100) / msg_limi=
t - 100;
> +               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD=
_FEATURE_PPT_BIT;
> +
> +               ret =3D smu_v13_0_7_upload_overdrive_table(smu, od_table)=
;
> +               if (ret) {
> +                 dev_err(smu->adev->dev, "Failed to upload overdrive tab=
le!\n");
> +                 return ret;
> +               }
> +
> +               smu->current_power_limit =3D limit;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct pptable_funcs smu_v13_0_7_ppt_funcs =3D {
>         .get_allowed_feature_mask =3D smu_v13_0_7_get_allowed_feature_mas=
k,
>         .set_default_dpm_table =3D smu_v13_0_7_set_default_dpm_table,
> @@ -2596,7 +2646,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_f=
uncs =3D {
>         .set_fan_control_mode =3D smu_v13_0_set_fan_control_mode,
>         .enable_mgpu_fan_boost =3D smu_v13_0_7_enable_mgpu_fan_boost,
>         .get_power_limit =3D smu_v13_0_7_get_power_limit,
> -       .set_power_limit =3D smu_v13_0_set_power_limit,
> +       .set_power_limit =3D smu_v13_0_7_set_power_limit,
>         .set_power_source =3D smu_v13_0_set_power_source,
>         .get_power_profile_mode =3D smu_v13_0_7_get_power_profile_mode,
>         .set_power_profile_mode =3D smu_v13_0_7_set_power_profile_mode,
> --
> 2.34.1
>
