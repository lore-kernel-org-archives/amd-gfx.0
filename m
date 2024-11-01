Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12217E6B278
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 14:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D29510E9DB;
	Fri,  1 Nov 2024 14:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lYyi1tRb";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585A610E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 14:04:00 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2e2c2a17aa4so257641a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Nov 2024 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730469840; x=1731074640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqaufLXFbiJBNu8ikdpOv6EjlsonXq/V2oMRy/wQYTc=;
 b=lYyi1tRbIR00SNMH5Pees7H9LRoSv14P4GOs92fcgdEU28BmzZJlaAiDV63u9tJZrb
 dRn7HNdrN1+ODdB6TYmrjANMB93MjDnqycWEZgACMBhdeG1HAkKu3ZCYZwwWNHXn04ur
 gMle7g3OJ1llPwcoDeFFqUrqcfa8i+yoXRUYZoHepIu9XTXAch3r9LN7/TLXkvsx8jfp
 SfJ8nO2zl5iODASKOFK+L5/7M1YeK6KdlabSy6qq2fW/XQ+bfy0E+cmRhm4b/kcJxNHu
 vKql7VqixVMXEQHtU8iM+kGZZazvxlI+YeWoYAYg7EEMxTJfBBj1r+83SbZaUtM53AeM
 odAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730469840; x=1731074640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqaufLXFbiJBNu8ikdpOv6EjlsonXq/V2oMRy/wQYTc=;
 b=RC52xwiGob4aBwprgLYzZAqhQwUqyehHymLVMJXs2wqH+RnpdhyW4VC1kPcz1b4Zzy
 20MaCjyNAsqjR7g8ziyv4ZoWkM6yEZO8/n60uW5AO9MLkxlAE0w4raAa98fNnSybDnhb
 GAfwcGc+w7AUe+Mm4DzlMDBCZsLFjv7fvYRmT5o+jPim+84Z/uiBQUBJ0N76WLjpbO5L
 fQyHg1LGXtvPMJg9koQC/flqB/evRxOCVYo03z2joU4bFL5nFCoyrNI24S3BGZXfG+JN
 /rVJMeSLfDF+7v/yDfwuwZRa+RUhpptFatvM1G7W40mw0f3AlHC2dWqZrQYqo3s2FwDj
 GNig==
X-Gm-Message-State: AOJu0YxOOgQwBvzJkxKzcz/O5kx8IcLnz9hzlW4o3nfDyPCF2W3GFsS6
 B004yd6KaJmWbNnG0HvFGANuGgR0DL+5473Q+8wiqL0IvdxzL2E4dh8gN/5AJmQX8s2biFHhUd+
 DRkjNCkCauV8/136L5nXu614MQ4h/3A==
X-Google-Smtp-Source: AGHT+IHzxLXxbU+BoObzAqV8f8fmba0EVoiOl4xgHphtNq5BeZncQtWQ/jHDc8U3M3SexrMz5M4sF0PAC0/MgwAYU9o=
X-Received: by 2002:a17:90a:c90b:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e8f10a42e7mr11040512a91.4.1730469839376; Fri, 01 Nov 2024
 07:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241031011739.80881-1-kenneth.feng@amd.com>
In-Reply-To: <20241031011739.80881-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Nov 2024 10:03:46 -0400
Message-ID: <CADnq5_M200bqNxa72vrd5ZbLsQNLBbA5KJEq0nK9CX-08ye=iA@mail.gmail.com>
Subject: Re: [PATCH v5] drm/amd/pm: correct the workload setting
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, 
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

On Wed, Oct 30, 2024 at 9:17=E2=80=AFPM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> Correct the workload setting in order not to mix the setting
> with the end user. Update the workload mask accordingly.
>
> v2: changes as below:
> 1. the end user can not erase the workload from driver except default wor=
kload.
> 2. always shows the real highest priority workoad to the end user.
> 3. the real workload mask is combined with driver workload mask and end u=
ser workload mask.
>
> v3: apply this to the other ASICs as well.
> v4: simplify the code
> v5: refine the code based on the review comments.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 49 +++++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 ++++++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  5 +-
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  9 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  8 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
>  12 files changed, 84 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 8d4aee4e2287..2e6c2f8dd065 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1261,26 +1261,33 @@ static int smu_sw_init(struct amdgpu_ip_block *ip=
_block)
>         smu->watermarks_bitmap =3D 0;
>         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> +       smu->user_dpm_profile.user_workload_mask =3D 0;
>
>         atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0;
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> -       smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0=
;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> +       smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
>
>         if (smu->is_apu ||
> -           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_=
FULLSCREEN3D))
> -               smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_=
POWER_PROFILE_BOOTUP_DEFAULT];
> -       else
> -               smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_=
POWER_PROFILE_FULLSCREEN3D];
> +           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_=
FULLSCREEN3D)) {
> +               smu->driver_workload_mask =3D
> +                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_=
BOOTUP_DEFAULT];
> +       } else {
> +               smu->driver_workload_mask =3D
> +                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_=
FULLSCREEN3D];
> +               smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_=
FULLSCREEN3D;
> +       }
>
> +       smu->workload_mask =3D smu->driver_workload_mask |
> +                                                       smu->user_dpm_pro=
file.user_workload_mask;
>         smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>         smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
> @@ -2354,17 +2361,20 @@ static int smu_switch_power_profile(void *handle,
>                 return -EINVAL;
>
>         if (!en) {
> -               smu->workload_mask &=3D ~(1 << smu->workload_prority[type=
]);
> +               smu->driver_workload_mask &=3D ~(1 << smu->workload_prior=
ity[type]);
>                 index =3D fls(smu->workload_mask);
>                 index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
>                 workload[0] =3D smu->workload_setting[index];
>         } else {
> -               smu->workload_mask |=3D (1 << smu->workload_prority[type]=
);
> +               smu->driver_workload_mask |=3D (1 << smu->workload_priori=
ty[type]);
>                 index =3D fls(smu->workload_mask);
>                 index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
>                 workload[0] =3D smu->workload_setting[index];
>         }
>
> +       smu->workload_mask =3D smu->driver_workload_mask |
> +                                                smu->user_dpm_profile.us=
er_workload_mask;
> +
>         if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM)
>                 smu_bump_power_profile_mode(smu, workload, 0);
>
> @@ -3054,12 +3064,23 @@ static int smu_set_power_profile_mode(void *handl=
e,
>                                       uint32_t param_size)
>  {
>         struct smu_context *smu =3D handle;
> +       int ret;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>             !smu->ppt_funcs->set_power_profile_mode)
>                 return -EOPNOTSUPP;
>
> -       return smu_bump_power_profile_mode(smu, param, param_size);
> +       if (smu->user_dpm_profile.user_workload_mask &
> +          (1 << smu->workload_priority[param[param_size]]))
> +          return 0;
> +
> +       smu->user_dpm_profile.user_workload_mask =3D
> +               (1 << smu->workload_priority[param[param_size]]);
> +       smu->workload_mask =3D smu->user_dpm_profile.user_workload_mask |
> +               smu->driver_workload_mask;
> +       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> +
> +       return ret;
>  }
>
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..4ffed49ebb4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,6 +240,7 @@ struct smu_user_dpm_profile {
>         /* user clock state information */
>         uint32_t clk_mask[SMU_CLK_COUNT];
>         uint32_t clk_dependency;
> +       uint32_t user_workload_mask;
>  };
>
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
> @@ -557,7 +558,8 @@ struct smu_context {
>         bool disable_uclk_switch;
>
>         uint32_t workload_mask;
> -       uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> +       uint32_t driver_workload_mask;
> +       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>         uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>         uint32_t power_profile_mode;
>         uint32_t default_power_profile_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 5ad09323a29d..a20d08821a50 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1455,7 +1455,6 @@ static int arcturus_set_power_profile_mode(struct s=
mu_context *smu,
>                 return -EINVAL;
>         }
>
> -
>         if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
>              (smu->smc_fw_version >=3D 0x360d00)) {
>                 if (size !=3D 10)
> @@ -1523,14 +1522,14 @@ static int arcturus_set_power_profile_mode(struct=
 smu_context *smu,
>
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                           SMU_MSG_SetWorkloadMask,
> -                                         1 << workload_type,
> +                                         smu->workload_mask,
>                                           NULL);
>         if (ret) {
>                 dev_err(smu->adev->dev, "Fail to set workload type %d\n",=
 workload_type);
>                 return ret;
>         }
>
> -       smu->power_profile_mode =3D profile_mode;
> +       smu_cmn_assign_power_profile(smu);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 9fa305ba6422..190ea240deae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2081,10 +2081,13 @@ static int navi10_set_power_profile_mode(struct s=
mu_context *smu, long *input, u
>                                                        smu->power_profile=
_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
> +
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> -                                   1 << workload_type, NULL);
> +                                   smu->workload_mask, NULL);
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> +       else
> +               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 77e58eb46328..0c7deb62b141 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1786,10 +1786,13 @@ static int sienna_cichlid_set_power_profile_mode(=
struct smu_context *smu, long *
>                                                        smu->power_profile=
_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
> +
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> -                                   1 << workload_type, NULL);
> +                                   smu->workload_mask, NULL);
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> +       else
> +               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 6c43724c01dd..26e0b4ee1fa5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1079,7 +1079,7 @@ static int vangogh_set_power_profile_mode(struct sm=
u_context *smu, long *input,
>         }
>
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
> -                                   1 << workload_type,
> +                                   smu->workload_mask,
>                                     NULL);
>         if (ret) {
>                 dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n",
> @@ -1087,7 +1087,7 @@ static int vangogh_set_power_profile_mode(struct sm=
u_context *smu, long *input,
>                 return ret;
>         }
>
> -       smu->power_profile_mode =3D profile_mode;
> +       smu_cmn_assign_power_profile(smu);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 0b210b1f2628..12d40c43ad40 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -890,14 +890,14 @@ static int renoir_set_power_profile_mode(struct smu=
_context *smu, long *input, u
>         }
>
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
> -                                   1 << workload_type,
> +                                   smu->workload_mask,
>                                     NULL);
>         if (ret) {
>                 dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n", workload_type);
>                 return ret;
>         }
>
> -       smu->power_profile_mode =3D profile_mode;
> +       smu_cmn_assign_power_profile(smu);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 8d25cc1f218f..1d29e99d7955 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2473,7 +2473,7 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> -       u32 workload_mask, selected_workload_mask;
> +       u32 workload_mask;
>
>         smu->power_profile_mode =3D input[size];
>
> @@ -2540,7 +2540,7 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> -       selected_workload_mask =3D workload_mask =3D 1 << workload_type;
> +       workload_mask =3D 1 << workload_type;
>
>         /* Add optimizations for SMU13.0.0/10.  Reuse the power saving pr=
ofile */
>         if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13, 0, 0) &&
> @@ -2555,12 +2555,22 @@ static int smu_v13_0_0_set_power_profile_mode(str=
uct smu_context *smu,
>                         workload_mask |=3D 1 << workload_type;
>         }
>
> +       smu->workload_mask |=3D workload_mask;
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
> -                                              workload_mask,
> +                                              smu->workload_mask,
>                                                NULL);
> -       if (!ret)
> -               smu->workload_mask =3D selected_workload_mask;
> +       if (!ret) {
> +               smu_cmn_assign_power_profile(smu);
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
> index 23f13388455f..12d622d4aceb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2487,13 +2487,14 @@ static int smu_v13_0_7_set_power_profile_mode(str=
uct smu_context *smu, long *inp
>                                                        smu->power_profile=
_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
> +
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> -                                   1 << workload_type, NULL);
> +                                   smu->workload_mask, NULL);
>
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
>         else
> -               smu->workload_mask =3D (1 << workload_type);
> +               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index cefe10b95d8e..e8ef6aa1d664 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1857,12 +1857,11 @@ static int smu_v14_0_2_set_power_profile_mode(str=
uct smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                              SMU_MSG_SetWorkloadMask,
> -                                              1 << workload_type,
> -                                              NULL);
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> +                                                                        =
         smu->workload_mask, NULL);
> +
>         if (!ret)
> -               smu->workload_mask =3D 1 << workload_type;
> +               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index 63c4f75fa118..fd2aa949538e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1141,6 +1141,14 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>         return ret;
>  }
>
> +void smu_cmn_assign_power_profile(struct smu_context *smu)
> +{
> +       uint32_t index;
> +       index =3D fls(smu->workload_mask);
> +       index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? index - 1=
 : 0;
> +       smu->power_profile_mode =3D smu->workload_setting[index];
> +}
> +
>  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>  {
>         struct pci_dev *p =3D NULL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.h
> index 1de685defe85..8a801e389659 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -130,6 +130,8 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8=
_t frev, uint8_t crev);
>  int smu_cmn_set_mp1_state(struct smu_context *smu,
>                           enum pp_mp1_state mp1_state);
>
> +void smu_cmn_assign_power_profile(struct smu_context *smu);
> +
>  /*
>   * Helper function to make sysfs_emit_at() happy. Align buf to
>   * the current page boundary and record the offset.
> --
> 2.34.1
>
