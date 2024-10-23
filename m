Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B0BD0BB47
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 22:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733EC10E0EE;
	Wed, 23 Oct 2024 22:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ex7p3rBr";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2555210E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 22:48:01 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2e2c2a17aa4so66460a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 15:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729723680; x=1730328480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjja7ATZMPtB3MxtiR5GfifCLQJNTGWuOeCu1qqNaSY=;
 b=Ex7p3rBrsC0CzlzqaFy2dadXCGlqwMxeARSeCwI4WK8gJWxpCcuu5ZLYFyQ+RJYu/q
 jBOG8M1Uz7NVRGDvKcVduK8yfqwKov9Ej7sUlyE82p7+/08l+tVuyCjQC3LwcCNfveID
 BZy08p2H8smI1ITz9LXTKWbdML9xces1WRl5Ggg88w/QCXiQ7M0jbZXbmNqEEGHMIU/b
 KiaUjRBStegACP/MrQJtMcq/hzyoZkJI87IWXPa6yP8VULGQ8aI6DdHmMnck0/fbBqCB
 7QXuNjViy4VxThpDrMM60OWq4PEIvluRVIiZwgyKFUBX3BNGdg/3CaeNF5o0KEyqpDkG
 daYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729723680; x=1730328480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjja7ATZMPtB3MxtiR5GfifCLQJNTGWuOeCu1qqNaSY=;
 b=wS3WJNDiEgqJXC5JwAOnl03NZFNGGxe0UZGPvN4wFyvzOMAWyiPPWGkXVKu/o7G9Tj
 w//eEvnRO4DvPaO8xZqFjEHyejAJ3bIrcQiD1BhgBVbUIYc+nlNyUTzVk5h6J8jheP38
 DH/jRoALivSu7NzLj0KOIVIs22HeJdMEjPjbr6npXuphSVV1VI/3qhu+7Hal5cK+lSN3
 L60oriq3tI4DUkhZi9yJAiz77WgDPleqKxBRHLSOZySNJn+FBUJun1HagXAY6d5fVQLl
 +NHtbIHnrQKY+yA7IP5VP5tE3U6o00byLlqcp7z76I4RdiUScXVygyBxsraRJUxEhztk
 PEDw==
X-Gm-Message-State: AOJu0YxCcB93D5feppgtJtAMsEZ2nDsdAtzA+MxoDET1ElELrF+vv6gx
 B7YEg4UxcmN9Us1MwcOJY7exy1M8+IyckoGgTeKYdBZq64ZbTOvDxd3di1jgG8ud1Ups45Bej/H
 24uCL9DSAtjYQ5/+pMrriezbcjhjSOYRE
X-Google-Smtp-Source: AGHT+IGXDBrCPhC9OHPfZMZNFhmfam7JNMwqX8cbouEauyNcygtweMbv/hrmjPpyW9SB8DqcLem44c7mhVt5KOBwlJo=
X-Received: by 2002:a05:6a20:2591:b0:1cf:4dc7:e4fc with SMTP id
 adf61e73a8af0-1d978aeb5bamr2721037637.2.1729723680302; Wed, 23 Oct 2024
 15:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241023031257.14238-1-kenneth.feng@amd.com>
In-Reply-To: <20241023031257.14238-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Oct 2024 18:47:48 -0400
Message-ID: <CADnq5_MafvznREau3FfCB7QeE3G5-SgTnrqbDk6mr5UKRGRt2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct the workload setting
To: Kenneth Feng <kenneth.feng@amd.com>
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

On Tue, Oct 22, 2024 at 11:23=E2=80=AFPM Kenneth Feng <kenneth.feng@amd.com=
> wrote:
>
> Correct the workload setting in order not to mix the setting
> with the end user. Update the workload mask accordingly.

Might be better to actually treat the workload like a mask rather than
as a discrete setting since that mirrors how the firmware actually
works.  The default value set at init time or whatever the user
selects via sysfs should be what is reflected in sysfs, however, when
KFD selects COMPUTE or the VCN code selects VIDEO, rather than
clearing all of the other bits and just setting the selected profile,
we should just add or remove the additional bits to the bit mask and
store the whole bit mask in the driver.  E.g., smu->workload_mask
would be the actual mask and smu->power_profile_mode would be the
value reflected in sysfs.

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 39 +++++++++++++++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 42 ++++++++++++++++---
>  5 files changed, 115 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index accc96a03bd9..f1984736ff4a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1252,7 +1252,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
>         atomic64_set(&smu->throttle_int_counter, 0);
>         smu->watermarks_bitmap =3D 0;
>         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -       smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> +       smu->user_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +       smu->driver_workload_mask =3D 0;
>
>         atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
> @@ -1267,10 +1268,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip=
_block)
>         smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
>         smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
>
> -       if (smu->is_apu)
> +       if (smu->is_apu) {
>                 smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_=
POWER_PROFILE_BOOTUP_DEFAULT];
> -       else
> +       } else {
>                 smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_=
POWER_PROFILE_FULLSCREEN3D];
> +               smu->user_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREE=
N3D;
> +       }
>
>         smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> @@ -2346,11 +2349,13 @@ static int smu_switch_power_profile(void *handle,
>
>         if (!en) {
>                 smu->workload_mask &=3D ~(1 << smu->workload_prority[type=
]);
> +               smu->driver_workload_mask &=3D ~(1 << smu->workload_prori=
ty[type]);
>                 index =3D fls(smu->workload_mask);
>                 index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
>                 workload[0] =3D smu->workload_setting[index];
>         } else {
>                 smu->workload_mask |=3D (1 << smu->workload_prority[type]=
);
> +               smu->driver_workload_mask |=3D (1 << smu->workload_prorit=
y[type]);
>                 index =3D fls(smu->workload_mask);
>                 index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
>                 workload[0] =3D smu->workload_setting[index];
> @@ -3045,12 +3050,16 @@ static int smu_set_power_profile_mode(void *handl=
e,
>                                       uint32_t param_size)
>  {
>         struct smu_context *smu =3D handle;
> +       int ret;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>             !smu->ppt_funcs->set_power_profile_mode)
>                 return -EOPNOTSUPP;
> +       smu->user_profile_mode_setting =3D true;
> +       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> +       smu->user_profile_mode_setting =3D false;
>
> -       return smu_bump_power_profile_mode(smu, param, param_size);
> +       return ret;
>  }
>
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..e43b23dd3457 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -557,10 +557,11 @@ struct smu_context {
>         bool disable_uclk_switch;
>
>         uint32_t workload_mask;
> +       uint32_t driver_workload_mask;
>         uint32_t workload_prority[WORKLOAD_POLICY_MAX];
>         uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>         uint32_t power_profile_mode;
> -       uint32_t default_power_profile_mode;
> +       uint32_t user_profile_mode;
>         bool pm_enabled;
>         bool is_apu;
>
> @@ -572,6 +573,7 @@ struct smu_context {
>
>         bool uploading_custom_pp_table;
>         bool dc_controlled_by_gpio;
> +       bool user_profile_mode_setting;
>
>         struct work_struct throttling_logging_work;
>         atomic64_t throttle_int_counter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3e2277abc754..7250b2bad198 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2433,7 +2433,7 @@ static int smu_v13_0_0_get_power_profile_mode(struc=
t smu_context *smu,
>                 }
>
>                 size +=3D sysfs_emit_at(buf, size, "%2d %14s%s:\n",
> -                       i, amdgpu_pp_profile_name[i], (i =3D=3D smu->powe=
r_profile_mode) ? "*" : " ");
> +                       i, amdgpu_pp_profile_name[i], (i =3D=3D smu->user=
_profile_mode) ? "*" : " ");
>
>                 size +=3D sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d=
 %7d %7d %7d %7d %7d %7d\n",
>                         " ",
> @@ -2474,9 +2474,27 @@ static int smu_v13_0_0_set_power_profile_mode(stru=
ct smu_context *smu,
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
>         u32 workload_mask;
> +       uint32_t current_user_profile_mode;
> +       uint32_t index;
> +
> +       if (smu->user_profile_mode_setting && smu->user_profile_mode =3D=
=3D input[size])
> +               return 0;
>
>         smu->power_profile_mode =3D input[size];
>
> +       if (smu->user_profile_mode_setting) {
> +               current_user_profile_mode =3D smu->user_profile_mode;
> +               smu->user_profile_mode =3D input[size];
> +               workload_type =3D smu_cmn_to_asic_specific_index(smu,
> +                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> +                                                      current_user_profi=
le_mode);
> +               if (workload_type < 0)
> +                       return -EINVAL;
> +
> +               if (!(smu->driver_workload_mask & (1 << workload_type)))
> +                       smu->workload_mask &=3D ~(1 << workload_type);
> +       }
> +
>         if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
>                 return -EINVAL;
> @@ -2555,12 +2573,25 @@ static int smu_v13_0_0_set_power_profile_mode(str=
uct smu_context *smu,
>                         workload_mask |=3D 1 << workload_type;
>         }
>
> +       smu->workload_mask |=3D workload_mask;
> +
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
> -                                              workload_mask,
> +                                              smu->workload_mask,
>                                                NULL);
> -       if (!ret)
> -               smu->workload_mask =3D workload_mask;
> +       if (!ret) {
> +               index =3D fls(smu->workload_mask);
> +               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> +               smu->power_profile_mode =3D smu->workload_setting[index];
> +               if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_P=
OWERSAVING) {
> +                       workload_type =3D smu_cmn_to_asic_specific_index(=
smu,
> +                                                              CMN2ASIC_M=
APPING_WORKLOAD,
> +                                                              PP_SMC_POW=
ER_PROFILE_FULLSCREEN3D);
> +                       smu->power_profile_mode =3D smu->workload_mask & =
(1 << workload_type)
> +                                                                        =
       ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> +                                                                        =
       : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +               }
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 23f13388455f..8afd43e78ebc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2367,7 +2367,7 @@ static int smu_v13_0_7_get_power_profile_mode(struc=
t smu_context *smu, char *buf
>         size +=3D sysfs_emit_at(buf, size, "                             =
 ");
>         for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_WINDOW3D; i++)
>                 size +=3D sysfs_emit_at(buf, size, "%d %-14s%s", i, amdgp=
u_pp_profile_name[i],
> -                       (i =3D=3D smu->power_profile_mode) ? "* " : "  ")=
;
> +                       (i =3D=3D smu->user_profile_mode) ? "* " : "  ");
>
>         size +=3D sysfs_emit_at(buf, size, "\n");
>
> @@ -2429,9 +2429,27 @@ static int smu_v13_0_7_set_power_profile_mode(stru=
ct smu_context *smu, long *inp
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> +       uint32_t current_user_profile_mode;
> +       uint32_t index;
> +
> +       if (smu->user_profile_mode_setting && smu->user_profile_mode =3D=
=3D input[size])
> +               return 0;
>
>         smu->power_profile_mode =3D input[size];
>
> +       if (smu->user_profile_mode_setting) {
> +               current_user_profile_mode =3D smu->user_profile_mode;
> +               smu->user_profile_mode =3D input[size];
> +               workload_type =3D smu_cmn_to_asic_specific_index(smu,
> +                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> +                                                      current_user_profi=
le_mode);
> +               if (workload_type < 0)
> +                       return -EINVAL;
> +
> +               if (!(smu->driver_workload_mask & (1 << workload_type)))
> +                       smu->workload_mask &=3D ~(1 << workload_type);
> +       }
> +
>         if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
>                 return -EINVAL;
> @@ -2487,13 +2505,18 @@ static int smu_v13_0_7_set_power_profile_mode(str=
uct smu_context *smu, long *inp
>                                                        smu->power_profile=
_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
> +
> +       smu->workload_mask |=3D (1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> -                                   1 << workload_type, NULL);
> +                                   smu->workload_mask, NULL);
>
> -       if (ret)
> +       if (ret) {
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> -       else
> -               smu->workload_mask =3D (1 << workload_type);
> +       } else {
> +               index =3D fls(smu->workload_mask);
> +               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> +               smu->power_profile_mode =3D smu->workload_setting[index];
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index cefe10b95d8e..d88bf9bad313 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1747,7 +1747,7 @@ static int smu_v14_0_2_get_power_profile_mode(struc=
t smu_context *smu,
>                 }
>
>                 size +=3D sysfs_emit_at(buf, size, "%2d %14s%s:\n",
> -                       i, amdgpu_pp_profile_name[i], (i =3D=3D smu->powe=
r_profile_mode) ? "*" : " ");
> +                       i, amdgpu_pp_profile_name[i], (i =3D=3D smu->user=
_profile_mode) ? "*" : " ");
>
>                 size +=3D sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d=
 %7d %7d %7d %7d %7d %7d\n",
>                         " ",
> @@ -1787,9 +1787,27 @@ static int smu_v14_0_2_set_power_profile_mode(stru=
ct smu_context *smu,
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> -       uint32_t current_profile_mode =3D smu->power_profile_mode;
> +       uint32_t current_user_profile_mode;
> +       uint32_t index;
> +
> +       if (smu->user_profile_mode_setting && smu->user_profile_mode =3D=
=3D input[size])
> +               return 0;
> +
>         smu->power_profile_mode =3D input[size];
>
> +       if (smu->user_profile_mode_setting) {
> +               current_user_profile_mode =3D smu->user_profile_mode;
> +               smu->user_profile_mode =3D input[size];
> +               workload_type =3D smu_cmn_to_asic_specific_index(smu,
> +                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> +                                                      current_user_profi=
le_mode);
> +               if (workload_type < 0)
> +                       return -EINVAL;
> +
> +               if (!(smu->driver_workload_mask & (1 << workload_type)))
> +                       smu->workload_mask &=3D ~(1 << workload_type);
> +       }
> +
>         if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
>                 return -EINVAL;
> @@ -1845,9 +1863,16 @@ static int smu_v14_0_2_set_power_profile_mode(stru=
ct smu_context *smu,
>                 }
>         }
>
> +       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> +                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> +                                                      PP_SMC_POWER_PROFI=
LE_COMPUTE);
> +
> +       if (workload_type < 0)
> +               return -EINVAL;
> +
>         if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
>                 smu_v14_0_deep_sleep_control(smu, false);
> -       else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
> +       else if (smu->workload_mask & (1 << workload_type))
>                 smu_v14_0_deep_sleep_control(smu, true);
>
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> @@ -1857,12 +1882,17 @@ static int smu_v14_0_2_set_power_profile_mode(str=
uct smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> +       smu->workload_mask |=3D (1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
> -                                              1 << workload_type,
> +                                              smu->workload_mask,
>                                                NULL);
> -       if (!ret)
> -               smu->workload_mask =3D 1 << workload_type;
> +
> +       if (!ret) {
> +               index =3D fls(smu->workload_mask);
> +               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> +               smu->power_profile_mode =3D smu->workload_setting[index];
> +       }
>
>         return ret;
>  }
> --
> 2.34.1
>
