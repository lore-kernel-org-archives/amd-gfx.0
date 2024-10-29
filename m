Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063F2D2AB3C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 13:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E564C10E250;
	Tue, 29 Oct 2024 13:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bkh4PQYC";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F96F10E250
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 13:20:28 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-7eadb7f77e8so795326a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730208028; x=1730812828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66+aYEA3SIRYUFhvXi77ic4EpB7OVnkXnqCyE5IcIR0=;
 b=bkh4PQYC775xcctP9D37Q5T5AMU9tbx8/bULhcL38rZt7UUmAKs88raeddydjl2fTb
 OIbeuXtczXIqqrWdC9UdgUdBqgd9QhGtNx42WY16knAlq4M5CE1QOV9xpzZvXyMpGkXW
 zj56fK8ZChnoxRSDNJhgR0Wb1MME5kZiiEFYX3JzRQ+X/C7tJ6o8XDb9DY1qyEEars9W
 buMkxxR1LKXeZTdU3w21oZSGvKC2KuhLS/2ekXp5oXn2fHSgEaqqYpLfXRwSLLnhvxk4
 4+wAs1ebDGyKdlmCi814HMo1FA6XMTCMoSZpHjFMPHb1mPvSXurybm57DgZz/Ewm8FHh
 ENTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730208028; x=1730812828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66+aYEA3SIRYUFhvXi77ic4EpB7OVnkXnqCyE5IcIR0=;
 b=pohUMPxj3cdbaQQ43LVNJPHjormMYDpUOqlWG8mjWvfDxBzi5r0Z/krLm3JJ/3mRNm
 n6pfymoek4AiQzTstPBA2FVc5VGMYj/8ZRK5AijUnlQgXr+LS8PY5EE1uC8Zexh5ke7h
 XKjtVs3X0Jfgphm0wvgItpC66Mn26qTb/yUYFCou0VajcGSCUPe5WdIe7u048QLRv9Yh
 XeH9gSNhglN25mPKxmFvx+c+fdvYZNo3IcchlhrZK7z/m5c/EDv2CqXB38CNk13ifFUW
 0kzxquPlsGgdPQlUpn9wfAfa8rvQIMRZjUElD1EDUVKnRlsjjzNkyqepaTZKFEXj2y5I
 IDMw==
X-Gm-Message-State: AOJu0YyEzMY78MHNGBEMewo2UedaauPWVfnH5XrDjb7xdDwp7g+uzmOm
 wgcX1mQ544d6A9R60TxAURq2qUdrG/rByFroHKW/3KT7TmntlNtoA8nSPbCcJAbyrzesbSLyy9I
 YHyS32XxrOZTNOpsfFyvyLDCfExkzxCQa
X-Google-Smtp-Source: AGHT+IH9Up+FltOZGv271vtj2YQhOgRz3iLpemwN29bPCcR6J/zyNuN+Hn16As053K6U4qPKyBS48OUQF6/1PT1JBlw=
X-Received: by 2002:a05:6a21:6d94:b0:1cf:46ff:973d with SMTP id
 adf61e73a8af0-1d9a84d99edmr7678252637.9.1730208028235; Tue, 29 Oct 2024
 06:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241024085926.25349-1-kenneth.feng@amd.com>
In-Reply-To: <20241024085926.25349-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:20:16 -0400
Message-ID: <CADnq5_N-hpJiOfeMGc+dAO53Tg3o-RF0hjBsBu_ya017sXjtsg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: correct the workload setting
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

On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
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
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 44 +++++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---

What about renoir_ppt.c, vangogh_ppt.c, navi10_ppt.c, and sienna_cichlid_pp=
t.c?

>  5 files changed, 106 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 8d4aee4e2287..1de576461a70 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1261,25 +1261,31 @@ static int smu_sw_init(struct amdgpu_ip_block *ip=
_block)
>         smu->watermarks_bitmap =3D 0;
>         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> +       smu->user_dpm_profile.user_workload_mask =3D 0;
> +       smu->user_dpm_profile.prev_user_workload_mask =3D 0;
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
> +               smu->workload_mask =3D 1 << smu->workload_priority[PP_SMC=
_POWER_PROFILE_BOOTUP_DEFAULT];
> +       } else {
> +               smu->workload_mask =3D 1 << smu->workload_priority[PP_SMC=
_POWER_PROFILE_FULLSCREEN3D];
> +               smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_=
FULLSCREEN3D;
> +       }
> +
> +       smu->driver_workload_mask =3D smu->workload_mask;
>
>         smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>         smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> @@ -2354,12 +2360,14 @@ static int smu_switch_power_profile(void *handle,
>                 return -EINVAL;
>
>         if (!en) {
> -               smu->workload_mask &=3D ~(1 << smu->workload_prority[type=
]);
> +               smu->workload_mask &=3D ~(1 << smu->workload_priority[typ=
e]);
> +               smu->driver_workload_mask &=3D ~(1 << smu->workload_prior=
ity[type]);
>                 index =3D fls(smu->workload_mask);
>                 index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
>                 workload[0] =3D smu->workload_setting[index];
>         } else {
> -               smu->workload_mask |=3D (1 << smu->workload_prority[type]=
);
> +               smu->workload_mask |=3D (1 << smu->workload_priority[type=
]);
> +               smu->driver_workload_mask |=3D (1 << smu->workload_priori=
ty[type]);
>                 index =3D fls(smu->workload_mask);
>                 index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
>                 workload[0] =3D smu->workload_setting[index];
> @@ -3054,12 +3062,20 @@ static int smu_set_power_profile_mode(void *handl=
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
> +       smu->user_dpm_profile.prev_user_workload_mask =3D
> +                       smu->user_dpm_profile.user_workload_mask;
> +       smu->user_dpm_profile.user_workload_mask =3D (1 << smu->workload_=
priority[param[param_size]]);
> +       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> +       smu->user_dpm_profile.prev_user_workload_mask =3D
> +                       smu->user_dpm_profile.user_workload_mask;
> +
> +       return ret;
>  }
>
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..88294d986b36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,6 +240,8 @@ struct smu_user_dpm_profile {
>         /* user clock state information */
>         uint32_t clk_mask[SMU_CLK_COUNT];
>         uint32_t clk_dependency;
> +       uint32_t user_workload_mask;
> +       uint32_t prev_user_workload_mask;
>  };
>
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
> @@ -557,7 +559,8 @@ struct smu_context {
>         bool disable_uclk_switch;
>
>         uint32_t workload_mask;
> -       uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> +       uint32_t driver_workload_mask;
> +       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>         uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>         uint32_t power_profile_mode;
>         uint32_t default_power_profile_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3e2277abc754..0733fd3efd8b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2474,9 +2474,22 @@ static int smu_v13_0_0_set_power_profile_mode(stru=
ct smu_context *smu,
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
>         u32 workload_mask;
> +       uint32_t index;
>
>         smu->power_profile_mode =3D input[size];
>
> +       if (smu->user_dpm_profile.prev_user_workload_mask !=3D
> +               smu->user_dpm_profile.user_workload_mask) {
> +               if (smu->workload_mask & smu->user_dpm_profile.prev_user_=
workload_mask &&
> +                       !(smu->driver_workload_mask & smu->user_dpm_profi=
le.prev_user_workload_mask))
> +                       smu->workload_mask &=3D ~smu->user_dpm_profile.pr=
ev_user_workload_mask;
> +
> +               if (input[size] !=3D smu->default_power_profile_mode) {
> +                       smu->workload_mask &=3D ~(1 << smu->workload_prio=
rity[smu->default_power_profile_mode]);
> +                       smu->driver_workload_mask &=3D ~(1 << smu->worklo=
ad_priority[smu->default_power_profile_mode]);
> +               }
> +       }

This can be split into a helper function.

> +
>         if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
>                 return -EINVAL;
> @@ -2555,12 +2568,24 @@ static int smu_v13_0_0_set_power_profile_mode(str=
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
> index 23f13388455f..2323c74ee50b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2429,9 +2429,22 @@ static int smu_v13_0_7_set_power_profile_mode(stru=
ct smu_context *smu, long *inp
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> +       uint32_t index;
>
>         smu->power_profile_mode =3D input[size];
>
> +       if (smu->user_dpm_profile.prev_user_workload_mask !=3D
> +               smu->user_dpm_profile.user_workload_mask) {
> +               if (smu->workload_mask & smu->user_dpm_profile.prev_user_=
workload_mask &&
> +                       !(smu->driver_workload_mask & smu->user_dpm_profi=
le.prev_user_workload_mask))
> +                       smu->workload_mask &=3D ~smu->user_dpm_profile.pr=
ev_user_workload_mask;
> +
> +               if (input[size] !=3D smu->default_power_profile_mode) {
> +                       smu->workload_mask &=3D ~(1 << smu->workload_prio=
rity[smu->default_power_profile_mode]);
> +                       smu->driver_workload_mask &=3D ~(1 << smu->worklo=
ad_priority[smu->default_power_profile_mode]);
> +               }
> +       }
> +
>         if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
>                 return -EINVAL;
> @@ -2487,13 +2500,19 @@ static int smu_v13_0_7_set_power_profile_mode(str=
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
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> -       else
> -               smu->workload_mask =3D (1 << workload_type);
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
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index cefe10b95d8e..c2fd47f04e2d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1787,9 +1787,22 @@ static int smu_v14_0_2_set_power_profile_mode(stru=
ct smu_context *smu,
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> +       uint32_t index;
>         uint32_t current_profile_mode =3D smu->power_profile_mode;
>         smu->power_profile_mode =3D input[size];
>
> +       if (smu->user_dpm_profile.prev_user_workload_mask !=3D
> +               smu->user_dpm_profile.user_workload_mask) {
> +               if (smu->workload_mask & smu->user_dpm_profile.prev_user_=
workload_mask &&
> +                       !(smu->driver_workload_mask & smu->user_dpm_profi=
le.prev_user_workload_mask))
> +                       smu->workload_mask &=3D ~smu->user_dpm_profile.pr=
ev_user_workload_mask;
> +
> +               if (input[size] !=3D smu->default_power_profile_mode) {
> +                       smu->workload_mask &=3D ~(1 << smu->workload_prio=
rity[smu->default_power_profile_mode]);
> +                       smu->driver_workload_mask &=3D ~(1 << smu->worklo=
ad_priority[smu->default_power_profile_mode]);
> +               }
> +       }
> +
>         if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
>                 return -EINVAL;
> @@ -1857,12 +1870,15 @@ static int smu_v14_0_2_set_power_profile_mode(str=
uct smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                              SMU_MSG_SetWorkloadMask,
> -                                              1 << workload_type,
> -                                              NULL);
> -       if (!ret)
> -               smu->workload_mask =3D 1 << workload_type;
> +       smu->workload_mask |=3D (1 << workload_type);
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> +                                                                        =
         smu->workload_mask, NULL);
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
