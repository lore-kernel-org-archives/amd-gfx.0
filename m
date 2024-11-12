Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9718CD42B88
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 14:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC3210E101;
	Tue, 12 Nov 2024 14:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jq5EUDKJ";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D439110E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 14:23:31 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2e9ed2dbfc8so35210a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731421411; x=1732026211; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nPmYiaE8Cbi1LclTKb92pZF0xL7U51EOSBmzjf1sYOc=;
 b=Jq5EUDKJfrUPcaMe4O70fsiVJw8gJmeK+vgg1QyMUTuYVLX+ThwtFcuusgV0qPgnsO
 0tayQXUnScU2gLZhqMVwpnhZE5608C9fVANo7g4Wq0JFHJQ0/lY4F4DgF1jsxEkMKeGs
 9MIoFirOi8GjMjURpRnuetU/QkVLH40JbjpHewIaj77sBeCEAZoJRXcjIF0XRKioVD4j
 5GEPW0pxwQCh6MWBTQoNTMX/fSNWAhyZNaXqQwHN9XuH+wLmTeVuTf/hWclAUZqjRnU6
 3mSjHRe7P0kdLZlQDOhe/Gl/aP27c1Aq8QQBUv3wxQukvdzg9+Wvmj32Jp/i6QhV24xy
 eTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731421411; x=1732026211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nPmYiaE8Cbi1LclTKb92pZF0xL7U51EOSBmzjf1sYOc=;
 b=Ufby0QlFugyfgkJonGUBlh/g2P6BNZ57IEjN4POPyTWBXdkWmbwqvmk7dI3BTPOQrh
 d3G0SamgyaiN0YCQ5IXRO3bRbTL4iJ8VMB07FjeBnzGEKuMW/1vpgPKv1BuJILqsAi9L
 4yg1hyH+QMUKQ5DE5a0K0KLYTA1Xi9Ed3xUmLQnNX8whtLK7O+drmHXisvt3au2B2Pq5
 F9DalW4tWQ8Z63IEHyK8lGxhh9d/L0ns8mZnXUXF12/PiMdv55aUd/vZVG5ZuRIptK7Y
 OoZlzliREkaRMJG02GKWHe6xuwezjwI/aMifQmNwDRm2Rs2qItdfFk5iRyt/cIj5Y2hw
 HeyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNyXubH8CExaj7VUj+vay1tpMK7LdELW75m8oNd+m842wSuD9YQttwb7YWHa/yhLgKqJDpXPRI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhUSX3VVgOdlZsXROElsWzfqAlzUPPBiATgCl5mo4V23/CPIO5
 WYMNmhoDXY2eQ8S1msJxzVH2s9ccugEHL95B3KzKLzA3MvW3gbnpfGD3+nuOevyiuiwAn8P5IrS
 Esariu+nqN4w7EaRqogo/EWlAwJ8oVw==
X-Google-Smtp-Source: AGHT+IFDaVB/qyBcosQeqzdPxiaPIDDzFA7SCORpmIuHbzNcf6WVOjsRQk3Noafonb91BLtF+/6kfMe5LkEfOMvA26g=
X-Received: by 2002:a17:90b:1a92:b0:2e2:8f10:45e6 with SMTP id
 98e67ed59e1d1-2e9b1404931mr9219637a91.0.1731421411058; Tue, 12 Nov 2024
 06:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20241109053148.13617-1-alexander.deucher@amd.com>
 <DM4PR12MB516517D96A1EE5E39D96DB4E8E592@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB516517D96A1EE5E39D96DB4E8E592@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Nov 2024 09:23:18 -0500
Message-ID: <CADnq5_NzYcvDQyBOBvNV14vXsiqnwZL=L-BO09mO0bLA1Ui9ZA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Content-Type: multipart/alternative; boundary="00000000000029bc390626b7f6a4"
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

--00000000000029bc390626b7f6a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:44=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.co=
m> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> If I understand this patch correctly, the sysfs end user will only see
> his/her settings to the power profile since the smu->power_profile_mode i=
s
> reflecting the end user's settings.
> Then if the other components set the workload mask then
> smu->power_profile_mode can't reflect the real prioritized workload. If t=
he
> end user doesn't need to know this information,
> then it's ok. In addition, there might be one problem, please see comment=
s
> inline.
>

The problem is that when users play videos and games at the same time or
run ROCm apps and games at the same time, sysfs reflects the last selected
workload profile.  This is confusing for users and it does not align with
how the firmware works.  We already have bugs filed because playing back a
video while gaming shows the profile as VIDEO which users assume will be
wrong and impact their gaming experience.  The workload hint is a bit mask
and all of the currently active workloads should be set when they are
active otherwise mixing workloads could have a negative effect on
performance.  E.g., if you video playback and gaming you should get both
the FS3D and VIDEO workload bits set and the PMFW will arbitrate between
them.



> Thanks.
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Saturday, November 9, 2024 1:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <
> Kenneth.Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amd/pm: fix and simplify workload handling
>
> smu->workload_mask is IP specific and should not be messed with in
> the common code. The mask bits vary across SMU versions.
>
> Move all handling of smu->workload_mask in to the backends and simplify
> the code.  Store the user's preference in smu->power_profile_mode which
> will be reflected in sysfs.  For internal driver profile switches for KFD
> or VCN, just update the workload mask so that the user's preference is
> retained.  Remove all of the extra now unused workload related elements i=
n
> the smu structure.
>
> Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 ++++++------------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-
> .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---
> .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--
> .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  24 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
>  12 files changed, 132 insertions(+), 170 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c3a6b6f20455..162a3289855c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block
> *ip_block)
>         INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>         atomic64_set(&smu->throttle_int_counter, 0);
>         smu->watermarks_bitmap =3D 0;
> -       smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -       smu->default_power_profile_mode =3D
> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -       smu->user_dpm_profile.user_workload_mask =3D 0;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
>                 atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1); @=
@
> -1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block
> *ip_block)
>         atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>         atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0=
;
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> -       smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
> -
>         if (smu->is_apu ||
> -           !smu_is_workload_profile_available(smu,
> PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> -               smu->driver_workload_mask =3D
> -                       1 <<
> smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -       } else {
> -               smu->driver_workload_mask =3D
> -                       1 <<
> smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> -               smu->default_power_profile_mode =3D
> PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -       }
> -
> -       smu->workload_mask =3D smu->driver_workload_mask |
> -
>  smu->user_dpm_profile.user_workload_mask;
> -       smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -       smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -       smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
> -       smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
> -       smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
> -       smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
> -       smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
> +           !smu_is_workload_profile_available(smu,
> PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> +               smu->power_profile_mode =3D
> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +       else
> +               smu->power_profile_mode =3D
> PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +
>         smu->display_config =3D &adev->pm.pm_display_cfg;
>
>         smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO; @@ -2252,24
> +2228,23 @@ static int smu_enable_umd_pstate(void *handle,  }
>
>  static int smu_bump_power_profile_mode(struct smu_context *smu,
> -                                          long *param,
> -                                          uint32_t param_size)
> +                                      long *param,
> +                                      uint32_t param_size,
> +                                      bool enable)
>  {
>         int ret =3D 0;
>
>         if (smu->ppt_funcs->set_power_profile_mode)
> -               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
,
> param_size);
> +               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
,
> param_size,
> +enable);
>
>         return ret;
>  }
>
>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>                                           enum amd_dpm_forced_level level=
,
> -                                         bool skip_display_settings,
> -                                         bool init)
> +                                         bool skip_display_settings)
>  {
>         int ret =3D 0;
> -       int index =3D 0;
>         long workload[1];
>         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
>
> @@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struct
> smu_context *smu,
>         }
>
>         if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> -               smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> -               index =3D fls(smu->workload_mask);
> -               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex
> - 1 : 0;
> -               workload[0] =3D smu->workload_setting[index];
> +           smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> +               workload[0] =3D smu->power_profile_mode;
>
> -               if (init || smu->power_profile_mode !=3D workload[0])
> -                       smu_bump_power_profile_mode(smu, workload, 0);
> +               smu_bump_power_profile_mode(smu, workload, 0, true);
>         }
> #[Kenneth Feng]
> #After some OD settings, the workload will go back to the user's setting
> due to wokload[0] =3D smu->power_profile_mode.
> #is there a scenario that the compute workload is set by kfd before the O=
D
> setting, then the compute workload setting is missing
> #after the OD setting?
>


I see what you mean.  I think we need to refcount the selected workload
types and keep them set until the ref count goes to 0.

Alex


>
>         return ret;
> @@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context *sm=
u,
>                 ret =3D smu_pre_display_config_changed(smu);
>                 if (ret)
>                         return ret;
> -               ret =3D smu_adjust_power_state_dynamic(smu, level, false,
> false);
> +               ret =3D smu_adjust_power_state_dynamic(smu, level, false)=
;
>                 break;
>         case AMD_PP_TASK_COMPLETE_INIT:
> -               ret =3D smu_adjust_power_state_dynamic(smu, level, true,
> true);
> +               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
>                 break;
>         case AMD_PP_TASK_READJUST_POWER_STATE:
> -               ret =3D smu_adjust_power_state_dynamic(smu, level, true,
> false);
> +               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
>                 break;
>         default:
>                 break;
> @@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,
>
>  static int smu_switch_power_profile(void *handle,
>                                     enum PP_SMC_POWER_PROFILE type,
> -                                   bool en)
> +                                   bool enable)
>  {
>         struct smu_context *smu =3D handle;
>         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
>         long workload[1];
> -       uint32_t index;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
> @@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *handle,
>         if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>                 return -EINVAL;
>
> -       if (!en) {
> -               smu->driver_workload_mask &=3D ~(1 <<
> smu->workload_priority[type]);
> -               index =3D fls(smu->workload_mask);
> -               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex
> - 1 : 0;
> -               workload[0] =3D smu->workload_setting[index];
> -       } else {
> -               smu->driver_workload_mask |=3D (1 <<
> smu->workload_priority[type]);
> -               index =3D fls(smu->workload_mask);
> -               index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -               workload[0] =3D smu->workload_setting[index];
> -       }
> +       /* don't disable the user's preference */
> +       if (!enable && type =3D=3D smu->power_profile_mode)
> +               return 0;
>
> -       smu->workload_mask =3D smu->driver_workload_mask |
> -
> smu->user_dpm_profile.user_workload_mask;
> +       workload[0] =3D type;
>
>         if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> -               smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> -               smu_bump_power_profile_mode(smu, workload, 0);
> +           smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> +               smu_bump_power_profile_mode(smu, workload, 0, enable);
>
>         return 0;
>  }
> @@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void *handl=
e,
>                                       uint32_t param_size)
>  {
>         struct smu_context *smu =3D handle;
> -       int ret;
> +       long workload[1];
> +       int ret =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>             !smu->ppt_funcs->set_power_profile_mode)
>                 return -EOPNOTSUPP;
>
> -       if (smu->user_dpm_profile.user_workload_mask &
> -          (1 << smu->workload_priority[param[param_size]]))
> -          return 0;
> -
> -       smu->user_dpm_profile.user_workload_mask =3D
> -               (1 << smu->workload_priority[param[param_size]]);
> -       smu->workload_mask =3D smu->user_dpm_profile.user_workload_mask |
> -               smu->driver_workload_mask;
> -       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> +       if (param[param_size] !=3D smu->power_profile_mode) {
> +               /* clear the old user preference */
> +               workload[0] =3D smu->power_profile_mode;
> +               ret =3D smu_bump_power_profile_mode(smu, workload, 0, fal=
se);
> +               if (ret)
> +                       return ret;
> +               /* set the new user preference */
> +               ret =3D smu_bump_power_profile_mode(smu, param, param_siz=
e,
> true);
> +               if (!ret)
> +                       /* store the user's preference */
> +                       smu->power_profile_mode =3D param[param_size];
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fa93a8879113..cd2db06d752b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
>         /* user clock state information */
>         uint32_t clk_mask[SMU_CLK_COUNT];
>         uint32_t clk_dependency;
> -       uint32_t user_workload_mask;
>  };
>
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
> @@ -557,12 +556,10 @@ struct smu_context {
>         uint32_t hard_min_uclk_req_from_dal;
>         bool disable_uclk_switch;
>
> +       /* backend specific workload mask */
>         uint32_t workload_mask;
> -       uint32_t driver_workload_mask;
> -       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> -       uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> +       /* default/user workload preference */
>         uint32_t power_profile_mode;
> -       uint32_t default_power_profile_mode;
>         bool pm_enabled;
>         bool is_apu;
>
> @@ -734,8 +731,10 @@ struct pptable_funcs {
>          *                          create/set custom power profile modes=
.
>          * &input: Power profile mode parameters.
>          * &size: Size of &input.
> +        * &enable: enable/disable the profile
>          */
> -       int (*set_power_profile_mode)(struct smu_context *smu, long
> *input, uint32_t size);
> +       int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t,
> +                                     uint32_t size, bool enable);
>
>         /**
>          * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4b36c230e43a..1e44cf6fec4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct
> smu_context *smu,
>
>  static int arcturus_set_power_profile_mode(struct smu_context *smu,
>                                            long *input,
> -                                          uint32_t size)
> +                                          uint32_t size,
> +                                          bool enable)
>  {
>         DpmActivityMonitorCoeffInt_t activity_monitor;
>         int workload_type =3D 0;
> @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct
> smu_context *smu,
>                 return -EINVAL;
>         }
>
> -       if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> -            (smu->smc_fw_version >=3D 0x360d00)) {
> +       if (enable &&
> +           (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> +           (smu->smc_fw_version >=3D 0x360d00)) {
>                 if (size !=3D 10)
>                         return -EINVAL;
>
> @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct
> smu_context *smu,
>                 return -EINVAL;
>         }
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                           SMU_MSG_SetWorkloadMask,
>                                           smu->workload_mask,
>                                           NULL);
> -       if (ret) {
> +       if (ret)
>                 dev_err(smu->adev->dev, "Fail to set workload type %d\n",
> workload_type);
> -               return ret;
> -       }
> -
> -       smu_cmn_assign_power_profile(smu);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int arcturus_set_performance_level(struct smu_context *smu, diff
> --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 211635dabed8..d944a9f954d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct
> smu_context *smu, char *buf)
>         return size;
>  }
>
> -static int navi10_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size)
> +static int navi10_set_power_profile_mode(struct smu_context *smu, long
> *input,
> +                                        uint32_t size, bool enable)
>  {
>         DpmActivityMonitorCoeffInt_t activity_monitor;
>         int workload_type, ret =3D 0;
> +       uint32_t profile_mode =3D input[size];
>
> -       smu->power_profile_mode =3D input[size];
> -
> -       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> smu->power_profile_mode);
> +       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> +               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> +profile_mode);
>                 return -EINVAL;
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> +       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
>                 if (size !=3D 10)
>                         return -EINVAL;
>
> @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct
> smu_context *smu, long *input, u
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>
>  CMN2ASIC_MAPPING_WORKLOAD,
> -
> smu->power_profile_mode);
> +                                                      profile_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
>                                     smu->workload_mask, NULL);
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load
> mask!", __func__);
> -       else
> -               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 844532a9b641..4967e087088b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1704,22 +1704,23 @@ static int
> sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>         return size;
>  }
>
> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu=
,
> long *input, uint32_t size)
> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu=
,
> +                                                long *input, uint32_t
> size,
> +                                                bool enable)
>  {
>
>         DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +       uint32_t profile_mode =3D input[size];
>         int workload_type, ret =3D 0;
>
> -       smu->power_profile_mode =3D input[size];
> -
> -       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> smu->power_profile_mode);
> +       if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> +               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> +profile_mode);
>                 return -EINVAL;
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> +       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
>                 if (size !=3D 10)
>                         return -EINVAL;
>
> @@ -1781,16 +1782,18 @@ static int
> sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>
>  CMN2ASIC_MAPPING_WORKLOAD,
> -
> smu->power_profile_mode);
> +                                                      profile_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
>                                     smu->workload_mask, NULL);
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load
> mask!", __func__);
> -       else
> -               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f89c487dce72..b5dba4826f81 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct
> smu_context *smu,
>         return size;
>  }
>
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size)
> +static int vangogh_set_power_profile_mode(struct smu_context *smu, long
> *input,
> +                                         uint32_t size, bool enable)
>  {
>         int workload_type, ret;
>         uint32_t profile_mode =3D input[size];
> @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct
> smu_context *smu, long *input,
>         }
>
>         if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> +           profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
>                 return 0;
>
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@
> -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struct
> smu_context *smu, long *input,
>                 return -EINVAL;
>         }
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
>                                     smu->workload_mask,
>                                     NULL);
> -       if (ret) {
> +       if (ret)
>                 dev_err_once(smu->adev->dev, "Fail to set workload type
> %d\n",
>                                         workload_type);
> -               return ret;
> -       }
> -
> -       smu_cmn_assign_power_profile(smu);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 75a9ea87f419..2d1eae79ab9d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context
> *smu,
>         return ret;
>  }
>
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size)
> +static int renoir_set_power_profile_mode(struct smu_context *smu, long
> *input,
> +                                        uint32_t size, bool enable)
>  {
>         int workload_type, ret;
>         uint32_t profile_mode =3D input[size];
> @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct
> smu_context *smu, long *input, u
>         }
>
>         if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> +           profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
>                 return 0;
>
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@
> -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct
> smu_context *smu, long *input, u
>                 return -EINVAL;
>         }
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
>                                     smu->workload_mask,
>                                     NULL);
> -       if (ret) {
> +       if (ret)
>                 dev_err_once(smu->adev->dev, "Fail to set workload type
> %d\n", workload_type);
> -               return ret;
> -       }
>
> -       smu_cmn_assign_power_profile(smu);
> -
> -       return 0;
> +       return ret;
>  }
>
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu) diff
> --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 80c6b1e523aa..3cc734331891 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2573,22 +2573,22 @@ static int
> smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>
>  static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>                                               long *input,
> -                                             uint32_t size)
> +                                             uint32_t size,
> +                                             bool enable)
>  {
>         DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +       uint32_t profile_mode =3D input[size];
>         int workload_type, ret =3D 0;
>         u32 workload_mask;
>
> -       smu->power_profile_mode =3D input[size];
> -
> -       if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> smu->power_profile_mode);
> +       if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> +               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> +profile_mode);
>                 return -EINVAL;
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> +       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
>                 if (size !=3D 9)
>                         return -EINVAL;
>
> @@ -2641,13 +2641,18 @@ static int
> smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>
>  CMN2ASIC_MAPPING_WORKLOAD,
> -
> smu->power_profile_mode);
> +                                                      profile_mode);
>
>         if (workload_type < 0)
>                 return -EINVAL;
>
>         workload_mask =3D 1 << workload_type;
>
> +       if (enable)
> +               smu->workload_mask |=3D workload_mask;
> +       else
> +               smu->workload_mask &=3D ~workload_mask;
> +
>         /* Add optimizations for SMU13.0.0/10.  Reuse the power saving
> profile */
>         if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13,
> 0, 0) &&
>              ((smu->adev->pm.fw_version =3D=3D 0x004e6601) || @@ -2658,25
> +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct
> smu_context *smu,
>
>  CMN2ASIC_MAPPING_WORKLOAD,
>
>  PP_SMC_POWER_PROFILE_POWERSAVING);
>                 if (workload_type >=3D 0)
> -                       workload_mask |=3D 1 << workload_type;
> +                       smu->workload_mask |=3D 1 << workload_type;
>         }
>
> -       smu->workload_mask |=3D workload_mask;
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
>                                                smu->workload_mask,
>                                                NULL);
> -       if (!ret) {
> -               smu_cmn_assign_power_profile(smu);
> -               if (smu->power_profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_POWERSAVING) {
> -                       workload_type =3D smu_cmn_to_asic_specific_index(=
smu,
> -
> CMN2ASIC_MAPPING_WORKLOAD,
> -
> PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> -                       smu->power_profile_mode =3D smu->workload_mask & =
(1
> << workload_type)
> -
>      ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> -
>      : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -               }
> -       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c5d3e25cc967..1aafd23857f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2528,22 +2528,23 @@ do {
>                                                       \
>         return result;
>  }
>
> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> long *input, uint32_t size)
> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> +                                             long *input, uint32_t size,
> +                                             bool enable)
>  {
>
>         DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +       uint32_t profile_mode =3D input[size];
>         int workload_type, ret =3D 0;
>
> -       smu->power_profile_mode =3D input[size];
> -
> -       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> smu->power_profile_mode);
> +       if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> +               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> +profile_mode);
>                 return -EINVAL;
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> +       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
>                 if (size !=3D 8)
>                         return -EINVAL;
>
> @@ -2590,17 +2591,19 @@ static int
> smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>
>  CMN2ASIC_MAPPING_WORKLOAD,
> -
> smu->power_profile_mode);
> +                                                      profile_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
>                                     smu->workload_mask, NULL);
>
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load
> mask!", __func__);
> -       else
> -               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..695480833603 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1719,21 +1719,22 @@ static int
> smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>
>  static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>                                               long *input,
> -                                             uint32_t size)
> +                                             uint32_t size,
> +                                             bool enable)
>  {
>         DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +       uint32_t profile_mode =3D input[size];
>         int workload_type, ret =3D 0;
>         uint32_t current_profile_mode =3D smu->power_profile_mode;
> -       smu->power_profile_mode =3D input[size];
>
> -       if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> -               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> smu->power_profile_mode);
> +       if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> +               dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> +profile_mode);
>                 return -EINVAL;
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> +       if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
>                 if (size !=3D 9)
>                         return -EINVAL;
>
> @@ -1783,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struc=
t
> smu_context *smu,
>                 }
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> +       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
>                 smu_v14_0_deep_sleep_control(smu, false);
>         else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
>                 smu_v14_0_deep_sleep_control(smu, true); @@ -1791,15
> +1792,16 @@ static int smu_v14_0_2_set_power_profile_mode(struct
> smu_context *smu,
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>
>  CMN2ASIC_MAPPING_WORKLOAD,
> -
> smu->power_profile_mode);
> +                                                      profile_mode);
>         if (workload_type < 0)
>                 return -EINVAL;
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> -
>        smu->workload_mask, NULL);
> -
> -       if (!ret)
> -               smu_cmn_assign_power_profile(smu);
> +                                             smu->workload_mask, NULL);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index fd2aa949538e..63c4f75fa118 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>         return ret;
>  }
>
> -void smu_cmn_assign_power_profile(struct smu_context *smu) -{
> -       uint32_t index;
> -       index =3D fls(smu->workload_mask);
> -       index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? index - 1=
 : 0;
> -       smu->power_profile_mode =3D smu->workload_setting[index];
> -}
> -
>  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)  {
>         struct pci_dev *p =3D NULL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 8a801e389659..1de685defe85 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table,
> uint8_t frev, uint8_t crev);  int smu_cmn_set_mp1_state(struct smu_contex=
t
> *smu,
>                           enum pp_mp1_state mp1_state);
>
> -void smu_cmn_assign_power_profile(struct smu_context *smu);
> -
>  /*
>   * Helper function to make sysfs_emit_at() happy. Align buf to
>   * the current page boundary and record the offset.
> --
> 2.47.0
>
>

--00000000000029bc390626b7f6a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 12, 2024 at 12:44=E2=80=
=AFAM Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com">Kenneth.Fen=
g@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">[AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Hi Alex,<br>
If I understand this patch correctly, the sysfs end user will only see his/=
her settings to the power profile since the smu-&gt;power_profile_mode is r=
eflecting the end user&#39;s settings.<br>
Then if the other components set the workload mask then smu-&gt;power_profi=
le_mode can&#39;t reflect the real prioritized workload. If the end user do=
esn&#39;t need to know this information,<br>
then it&#39;s ok. In addition, there might be one problem, please see comme=
nts inline.<br></blockquote><div><br></div><div>The problem is that when us=
ers play videos and games at the same time or run ROCm apps and games at th=
e same time, sysfs reflects the last selected workload profile.=C2=A0 This =
is confusing for users and it does not align with how the firmware works.=
=C2=A0 We already have bugs filed because playing back a video while gaming=
 shows the profile as VIDEO which users assume will be wrong and impact the=
ir gaming experience.=C2=A0 The workload hint is a bit mask and all of the =
currently active workloads should be set when they are active otherwise mix=
ing workloads could have a negative effect on performance.=C2=A0 E.g., if y=
ou video playback and gaming you should get both the FS3D and VIDEO workloa=
d bits set and the PMFW will arbitrate between them. <br></div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks.<br>
<br>
-----Original Message-----<br>
From: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" t=
arget=3D"_blank">Alexander.Deucher@amd.com</a>&gt;<br>
Sent: Saturday, November 9, 2024 1:32 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-=
gfx@lists.freedesktop.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" tar=
get=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Feng, Kenneth &lt;<a href=
=3D"mailto:Kenneth.Feng@amd.com" target=3D"_blank">Kenneth.Feng@amd.com</a>=
&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" target=3D"_blan=
k">Lijo.Lazar@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amd/pm: fix and simplify workload handling<br>
<br>
smu-&gt;workload_mask is IP specific and should not be messed with in<br>
the common code. The mask bits vary across SMU versions.<br>
<br>
Move all handling of smu-&gt;workload_mask in to the backends and simplify =
the code.=C2=A0 Store the user&#39;s preference in smu-&gt;power_profile_mo=
de which will be reflected in sysfs.=C2=A0 For internal driver profile swit=
ches for KFD or VCN, just update the workload mask so that the user&#39;s p=
reference is retained.=C2=A0 Remove all of the extra now unused workload re=
lated elements in the smu structure.<br>
<br>
Fixes: 8cc438be5d49 (&quot;drm/amd/pm: correct the workload setting&quot;)<=
br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
Cc: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com" target=3D"_bla=
nk">kenneth.feng@amd.com</a>&gt;<br>
Cc: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com" target=3D"_blank">=
lijo.lazar@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c=C2=A0 =C2=A0 =C2=A0| 108 ++=
++++------------<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |=C2=A0 11 +-=C2=A0 ...=
/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |=C2=A0 20 ++--<br>
=C2=A0.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c=C2=A0 =C2=A0|=C2=A0 20 ++=
--<br>
=C2=A0.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c=C2=A0 =C2=A0|=C2=A0 21 ++=
--<br>
=C2=A0.../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c=C2=A0 |=C2=A0 17 +--<br>
=C2=A0.../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c=C2=A0 =C2=A0|=C2=A0 17 +-=
-<br>
=C2=A0.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c=C2=A0 |=C2=A0 33 +++---=
=C2=A0 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c=C2=A0 |=C2=A0 21 ++--=
=C2=A0 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c=C2=A0 |=C2=A0 24 ++--<b=
r>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A08 --<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 -<br>
=C2=A012 files changed, 132 insertions(+), 170 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index c3a6b6f20455..162a3289855c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&amp;smu-&gt;interrupt_work, smu_inte=
rrupt_work_fn);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic64_set(&amp;smu-&gt;throttle_int_counter,=
 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;watermarks_bitmap =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D PP_SMC_POWER_PRO=
FILE_BOOTUP_DEFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;default_power_profile_mode =3D PP_SMC_P=
OWER_PROFILE_BOOTUP_DEFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;user_dpm_profile.user_workload_mask =3D=
 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;vcn.num_vcn_inst;=
 i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_set(&amp;smu=
-&gt;smu_power.power_gate.vcn_gated[i], 1); @@ -1278,33 +1275,12 @@ static =
int smu_sw_init(struct amdgpu_ip_block *ip_block)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_set(&amp;smu-&gt;smu_power.power_gate.vp=
e_gated, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_set(&amp;smu-&gt;smu_power.power_gate.um=
sch_mm_gated, 1);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
BOOTUP_DEFAULT] =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
FULLSCREEN3D] =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
POWERSAVING] =3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
VIDEO] =3D 3;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
VR] =3D 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
COMPUTE] =3D 5;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_=
CUSTOM] =3D 6;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu-&gt;is_apu ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!smu_is_workload_profile_availabl=
e(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_work=
load_mask =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 &lt;&lt; smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_=
DEFAULT];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_work=
load_mask =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 &lt;&lt; smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_FULLSCR=
EEN3D];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;default_pow=
er_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask =3D smu-&gt;driver_worklo=
ad_mask |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;user_dpm_profile.us=
er_workload_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[0] =3D PP_SMC_POWER_PR=
OFILE_BOOTUP_DEFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[1] =3D PP_SMC_POWER_PR=
OFILE_FULLSCREEN3D;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[2] =3D PP_SMC_POWER_PR=
OFILE_POWERSAVING;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[3] =3D PP_SMC_POWER_PR=
OFILE_VIDEO;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[4] =3D PP_SMC_POWER_PR=
OFILE_VR;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[5] =3D PP_SMC_POWER_PR=
OFILE_COMPUTE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[6] =3D PP_SMC_POWER_PR=
OFILE_CUSTOM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!smu_is_workload_profile_availabl=
e(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profi=
le_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profi=
le_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;display_config =3D &amp;adev-&gt;pm.pm_=
display_cfg;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;smu_dpm.dpm_level =3D AMD_DPM_FORCED_LE=
VEL_AUTO; @@ -2252,24 +2228,23 @@ static int smu_enable_umd_pstate(void *ha=
ndle,=C2=A0 }<br>
<br>
=C2=A0static int smu_bump_power_profile_mode(struct smu_context *smu,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l=
ong *param,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
int32_t param_size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long *param,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t param_=
size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool enable)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu-&gt;ppt_funcs-&gt;set_power_profile_mod=
e)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu-&gt;ppt=
_funcs-&gt;set_power_profile_mode(smu, param, param_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu-&gt;ppt=
_funcs-&gt;set_power_profile_mode(smu, param, param_size,<br>
+enable);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static int smu_adjust_power_state_dynamic(struct smu_context *smu,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
num amd_dpm_forced_level level,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol skip_display_settings,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol init)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
ol skip_display_settings)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int index =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long workload[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct smu_dpm_context *smu_dpm_ctx =3D &amp;(s=
mu-&gt;smu_dpm);<br>
<br>
@@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struct sm=
u_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu_dpm_ctx-&gt;dpm_level !=3D AMD_DPM_FORC=
ED_LEVEL_MANUAL &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm=
_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&=
gt;workload_mask);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &gt=
; 0 &amp;&amp; index &lt;=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu=
-&gt;workload_setting[index];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm_level !=3D AM=
D_DPM_FORCED_LEVEL_PERF_DETERMINISM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu=
-&gt;power_profile_mode;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (init || smu-&gt=
;power_profile_mode !=3D workload[0])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu_bump_power_profile_mode(smu, workload, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_bump_power_prof=
ile_mode(smu, workload, 0, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
#[Kenneth Feng]<br>
#After some OD settings, the workload will go back to the user&#39;s settin=
g due to wokload[0] =3D smu-&gt;power_profile_mode.<br>
#is there a scenario that the compute workload is set by kfd before the OD =
setting, then the compute workload setting is missing<br>
#after the OD setting?<br></blockquote><div><br></div><div><br></div><div>I=
 see what you mean.=C2=A0 I think we need to refcount the selected workload=
 types and keep them set until the ref count goes to 0.</div><div><br></div=
><div>Alex<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
@@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context *smu,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_pre_dis=
play_config_changed(smu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_=
power_state_dynamic(smu, level, false, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_=
power_state_dynamic(smu, level, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_PP_TASK_COMPLETE_INIT:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_=
power_state_dynamic(smu, level, true, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_=
power_state_dynamic(smu, level, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_PP_TASK_READJUST_POWER_STATE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_=
power_state_dynamic(smu, level, true, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_=
power_state_dynamic(smu, level, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
@@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,<br>
<br>
=C2=A0static int smu_switch_power_profile(void *handle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum PP_SMC_POWER_PROF=
ILE type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool en)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct smu_context *smu =3D handle;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct smu_dpm_context *smu_dpm_ctx =3D &amp;(s=
mu-&gt;smu_dpm);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long workload[1];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t index;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt;pm=
.dpm_enabled)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;=
<br>
@@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *handle,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(type &lt; PP_SMC_POWER_PROFILE_CUSTOM))<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!en) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_work=
load_mask &amp;=3D ~(1 &lt;&lt; smu-&gt;workload_priority[type]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&=
gt;workload_mask);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &gt=
; 0 &amp;&amp; index &lt;=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu=
-&gt;workload_setting[index];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_work=
load_mask |=3D (1 &lt;&lt; smu-&gt;workload_priority[type]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&=
gt;workload_mask);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &lt=
;=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu=
-&gt;workload_setting[index];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* don&#39;t disable the user&#39;s preference =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!enable &amp;&amp; type =3D=3D smu-&gt;powe=
r_profile_mode)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask =3D smu-&gt;driver_worklo=
ad_mask |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 smu-&gt;user_dpm_profile.user_workload_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D type;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu_dpm_ctx-&gt;dpm_level !=3D AMD_DPM_FORC=
ED_LEVEL_MANUAL &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm=
_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_bump_power_prof=
ile_mode(smu, workload, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm_level !=3D AM=
D_DPM_FORCED_LEVEL_PERF_DETERMINISM)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_bump_power_prof=
ile_mode(smu, workload, 0, enable);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void *handle,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t param_=
size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct smu_context *smu =3D handle;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long workload[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt;pm=
.dpm_enabled ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !smu-&gt;ppt_funcs-&gt;set_power_=
profile_mode)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;user_dpm_profile.user_workload_mask=
 &amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; smu-&gt;workload_priority[p=
aram[param_size]]))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;user_dpm_profile.user_workload_mask =3D=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; smu-&gt=
;workload_priority[param[param_size]]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask =3D smu-&gt;user_dpm_prof=
ile.user_workload_mask |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_work=
load_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_bump_power_profile_mode(smu, param,=
 param_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (param[param_size] !=3D smu-&gt;power_profil=
e_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear the old us=
er preference */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu=
-&gt;power_profile_mode;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_bump_po=
wer_profile_mode(smu, workload, 0, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set the new user=
 preference */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_bump_po=
wer_profile_mode(smu, param, param_size, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* store the user&#39;s preference */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu-&gt;power_profile_mode =3D param[param_size];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h<br>
index fa93a8879113..cd2db06d752b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* user clock state information */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t clk_mask[SMU_CLK_COUNT];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t clk_dependency;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t user_workload_mask;<br>
=C2=A0};<br>
<br>
=C2=A0#define SMU_TABLE_INIT(tables, table_id, s, a, d)=C2=A0 =C2=A0 =C2=A0=
 \<br>
@@ -557,12 +556,10 @@ struct smu_context {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t hard_min_uclk_req_from_dal;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool disable_uclk_switch;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* backend specific workload mask */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t workload_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t driver_workload_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t workload_priority[WORKLOAD_POLICY_MAX]=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t workload_setting[WORKLOAD_POLICY_MAX];=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* default/user workload preference */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t power_profile_mode;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t default_power_profile_mode;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool pm_enabled;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_apu;<br>
<br>
@@ -734,8 +731,10 @@ struct pptable_funcs {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create/set custom powe=
r profile modes.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &amp;input: Power profile mode paramete=
rs.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &amp;size: Size of &amp;input.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * &amp;enable: enable/disable the profile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*set_power_profile_mode)(struct smu_contex=
t *smu, long *input, uint32_t size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int (*set_power_profile_mode)(struct smu_contex=
t *smu, long *input,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t size, b=
ool enable);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* @dpm_set_vcn_enable: Enable/disable VCN=
 engine dynamic power diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arctu=
rus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
index 4b36c230e43a..1e44cf6fec4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
@@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct smu=
_context *smu,<br>
<br>
=C2=A0static int arcturus_set_power_profile_mode(struct smu_context *smu,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0long *input,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
int32_t size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
int32_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
ool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffInt_t activity_monitor;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type =3D 0;<br>
@@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct smu=
_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_C=
USTOM) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (smu-&gt;smc_fw_version &gt;=3D =
0x360d00)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(profile_mode =3D=3D PP_SMC_POWER=
_PROFILE_CUSTOM) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(smu-&gt;smc_fw_version &gt;=3D 0=
x360d00)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D 10)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
@@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct s=
mu_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S=
MU_MSG_SetWorkloadMask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
mu-&gt;workload_mask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 N=
ULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Fail to set workload type %d\n&quot;, workload_type);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_profile(smu);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static int arcturus_set_performance_level(struct smu_context *smu, di=
ff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/dr=
m/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 211635dabed8..d944a9f954d0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct smu=
_context *smu, char *buf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return size;<br>
=C2=A0}<br>
<br>
-static int navi10_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)<br>
+static int navi10_set_power_profile_mode(struct smu_context *smu, long *in=
put,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 size, bool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffInt_t activity_monitor;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt; PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profi=
le_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode &gt; PP_SMC_POWER_PROFILE_CUST=
OM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;,<br>
+profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_PO=
WER_PROFILE_CUSTOM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SM=
C_POWER_PROFILE_CUSTOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D 10)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
@@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct smu=
_context *smu, long *input, u<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workload_type =3D smu_cmn_to_asic_specific_inde=
x(smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMN2ASIC_MAPPING_WORKLOAD,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (workload_type &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetWorkloadMask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;workload_mask,=
 NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(smu-&gt;ade=
v-&gt;dev, &quot;[%s] Failed to set work load mask!&quot;, __func__);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_powe=
r_profile(smu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 844532a9b641..4967e087088b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(st=
ruct smu_context *smu, char *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return size;<br>
=C2=A0}<br>
<br>
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, =
long *input, uint32_t size)<br>
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 long *input, uint32_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bool enable)<br>
=C2=A0{<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffIntExternal_t activity_m=
onitor_external;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffInt_t *activity_monitor =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;(activity_moni=
tor_external.DpmActivityMonitorCoeffInt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt; PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profi=
le_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode &gt; PP_SMC_POWER_PROFILE_CUST=
OM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;,<br>
+profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_PO=
WER_PROFILE_CUSTOM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SM=
C_POWER_PROFILE_CUSTOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D 10)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
@@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(st=
ruct smu_context *smu, long *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workload_type =3D smu_cmn_to_asic_specific_inde=
x(smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMN2ASIC_MAPPING_WORKLOAD,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (workload_type &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetWorkloadMask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;workload_mask,=
 NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(smu-&gt;ade=
v-&gt;dev, &quot;[%s] Failed to set work load mask!&quot;, __func__);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_powe=
r_profile(smu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
index f89c487dce72..b5dba4826f81 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
@@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct smu_=
context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return size;<br>
=C2=A0}<br>
<br>
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *i=
nput, uint32_t size)<br>
+static int vangogh_set_power_profile_mode(struct smu_context *smu, long *i=
nput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t size, bool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t profile_mode =3D input[size];<br>
@@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_=
context *smu, long *input,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0profile_mode =3D=3D PP_SMC_POWER_=
PROFILE_POWERSAVING)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */ @@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode=
(struct smu_context *smu, long *input,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_ActiveProcessNotify,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;workload_mask,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err_once(smu-&g=
t;adev-&gt;dev, &quot;Fail to set workload type %d\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 workload=
_type);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_profile(smu);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static int vangogh_set_soft_freq_limited_range(struct smu_context *sm=
u, diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index 75a9ea87f419..2d1eae79ab9d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context *=
smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)<br>
+static int renoir_set_power_profile_mode(struct smu_context *smu, long *in=
put,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 size, bool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t profile_mode =3D input[size];<br>
@@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_con=
text *smu, long *input, u<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0profile_mode =3D=3D PP_SMC_POWER_=
PROFILE_POWERSAVING)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */ @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(st=
ruct smu_context *smu, long *input, u<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_ActiveProcessNotify,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;workload_mask,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err_once(smu-&g=
t;adev-&gt;dev, &quot;Fail to set workload type %d\n&quot;, workload_type);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_profile(smu);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static int renoir_set_peak_clock_by_device(struct smu_context *smu) d=
iff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 80c6b1e523aa..3cc734331891 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(struc=
t smu_context *smu,<br>
<br>
=C2=A0static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 long *input,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffIntExternal_t activity_m=
onitor_external;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffInt_t *activity_monitor =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;(activity_moni=
tor_external.DpmActivityMonitorCoeffInt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 workload_mask;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt;=3D PP_SMC_P=
OWER_PROFILE_COUNT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profi=
le_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode &gt;=3D PP_SMC_POWER_PROFILE_C=
OUNT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;,<br>
+profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_PO=
WER_PROFILE_CUSTOM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SM=
C_POWER_PROFILE_CUSTOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D 9)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
@@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workload_type =3D smu_cmn_to_asic_specific_inde=
x(smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMN2ASIC_MAPPING_WORKLOAD,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (workload_type &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workload_mask =3D 1 &lt;&lt; workload_type;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D workload_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~workload_mask;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add optimizations for SMU13.0.0/10.=C2=A0 Re=
use the power saving profile */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((amdgpu_ip_version(smu-&gt;adev, MP1_HWIP, =
0) =3D=3D IP_VERSION(13, 0, 0) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((smu-&gt;adev-&gt;pm.fw_ve=
rsion =3D=3D 0x004e6601) || @@ -2658,25 +2663,13 @@ static int smu_v13_0_0_=
set_power_profile_mode(struct smu_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0CMN2ASIC_MAPPING_WORKLOAD,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0PP_SMC_POWER_PROFILE_POWERSAVING);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (workload_type &=
gt;=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0workload_mask |=3D 1 &lt;&lt; workload_type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu-&gt;workload_mask |=3D 1 &lt;&lt; workload_type;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask |=3D workload_mask;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0SMU_MSG_SetWorkloadMask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_powe=
r_profile(smu);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_p=
rofile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0workload_type =3D smu_cmn_to_asic_specific_index(smu,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2A=
SIC_MAPPING_WORKLOAD,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PP_SM=
C_POWER_PROFILE_FULLSCREEN3D);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu-&gt;power_profile_mode =3D smu-&gt;workload_mask &amp; (1 &lt=
;&lt; workload_type)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? PP_SMC_POWER_P=
ROFILE_FULLSCREEN3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: PP_SMC_POWER_P=
ROFILE_BOOTUP_DEFAULT;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index c5d3e25cc967..1aafd23857f0 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -2528,22 +2528,23 @@ do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;<br>
=C2=A0}<br>
<br>
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)<br>
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0long *input, uint32_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool enable)<br>
=C2=A0{<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffIntExternal_t activity_m=
onitor_external;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffInt_t *activity_monitor =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;(activity_moni=
tor_external.DpmActivityMonitorCoeffInt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt; PP_SMC_POWE=
R_PROFILE_WINDOW3D) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profi=
le_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode &gt; PP_SMC_POWER_PROFILE_WIND=
OW3D) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;,<br>
+profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_PO=
WER_PROFILE_CUSTOM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SM=
C_POWER_PROFILE_CUSTOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D 8)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
@@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(struc=
t smu_context *smu, long *inp<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workload_type =3D smu_cmn_to_asic_specific_inde=
x(smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMN2ASIC_MAPPING_WORKLOAD,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (workload_type &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetWorkloadMask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;workload_mask,=
 NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(smu-&gt;ade=
v-&gt;dev, &quot;[%s] Failed to set work load mask!&quot;, __func__);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_powe=
r_profile(smu);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
index 59b369eff30f..695480833603 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
@@ -1719,21 +1719,22 @@ static int smu_v14_0_2_get_power_profile_mode(struc=
t smu_context *smu,<br>
<br>
=C2=A0static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 long *input,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t size)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool enable)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffIntExternal_t activity_m=
onitor_external;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DpmActivityMonitorCoeffInt_t *activity_monitor =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;(activity_moni=
tor_external.DpmActivityMonitorCoeffInt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int workload_type, ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t current_profile_mode =3D smu-&gt;power=
_profile_mode;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt;=3D PP_SMC_P=
OWER_PROFILE_COUNT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profi=
le_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode &gt;=3D PP_SMC_POWER_PROFILE_C=
OUNT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;ade=
v-&gt;dev, &quot;Invalid power profile mode %d\n&quot;,<br>
+profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_PO=
WER_PROFILE_CUSTOM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SM=
C_POWER_PROFILE_CUSTOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size !=3D 9)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
@@ -1783,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct =
smu_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_PO=
WER_PROFILE_COMPUTE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CO=
MPUTE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu_v14_0_deep_slee=
p_control(smu, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (current_profile_mode =3D=3D PP_SMC_POW=
ER_PROFILE_COMPUTE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu_v14_0_deep_slee=
p_control(smu, true); @@ -1791,15 +1792,16 @@ static int smu_v14_0_2_set_po=
wer_profile_mode(struct smu_context *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB=
_*_BIT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 workload_type =3D smu_cmn_to_asic_specific_inde=
x(smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CMN2ASIC_MAPPING_WORKLOAD,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (workload_type &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk |=3D (1 &lt;&lt; workload_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_ma=
sk &amp;=3D ~(1 &lt;&lt; workload_type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_cmn_send_smc_msg_with_param(smu, SM=
U_MSG_SetWorkloadMask,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;w=
orkload_mask, NULL);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_powe=
r_profile(smu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0smu-&gt;workload_mask, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index fd2aa949538e..63c4f75fa118 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
-void smu_cmn_assign_power_profile(struct smu_context *smu) -{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t index;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&gt;workload_mask);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &gt; 0 &amp;&amp; index &lt;=3D=
 WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D smu-&gt;workload=
_setting[index];<br>
-}<br>
-<br>
=C2=A0bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)=C2=A0 =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *p =3D NULL;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index 8a801e389659..1de685defe85 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t=
 frev, uint8_t crev);=C2=A0 int smu_cmn_set_mp1_state(struct smu_context *s=
mu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 enum pp_mp1_state mp1_state);<br>
<br>
-void smu_cmn_assign_power_profile(struct smu_context *smu);<br>
-<br>
=C2=A0/*<br>
=C2=A0 * Helper function to make sysfs_emit_at() happy. Align buf to<br>
=C2=A0 * the current page boundary and record the offset.<br>
--<br>
2.47.0<br>
<br>
</blockquote></div></div>

--00000000000029bc390626b7f6a4--
