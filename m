Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA685D597C7
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 02:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566FC10E328;
	Wed, 13 Nov 2024 02:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FdAIh3LP";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C8310E328
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 02:32:36 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-7eb0448693eso210084a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 18:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731465155; x=1732069955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWhc1+qtcj4e3JK0fUx5akDJRJSAQ1a577f/6OKOofg=;
 b=FdAIh3LPn90LE7/Q2GhDhr/VtsEWX0ROErLa0i/Zpp9FLCPUPC9AXmt8Kh3hUfTpFJ
 6Mf9U0CN3mEN9UPNYD+RydyDdk35Pn9YpajD33OJ2xIS62lEyb6jxfpTpGcnkjgI2j/C
 E+z0Qs6S2WTuCDm0PXED2pEzeduVPjwTcUg4o/6ugOLUM/w8hiz0rHznn/5WA1UxNia9
 GB/KsuCr2jcrqDpt5XsvJxs6k58h99AGvkUNMKTAm9Tb7Z56qeG+r2YYYzjQTXzGWZN0
 HeRsg1m1ryHdpmqnzp2T6xYVnIIknRVxlqiKUU6+HDoUbCF2NfDU5w8lj7QqX6OL/usp
 HJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731465155; x=1732069955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWhc1+qtcj4e3JK0fUx5akDJRJSAQ1a577f/6OKOofg=;
 b=ndjbR1p87jDPQUtntaR0YZANPGBuxniLhLBXe7zlpHmsrBzp+nyprZffQJJSDkGOVW
 pPAryD60ecWUxEpf7g8WNp4WWC9AID1P6eusqfJ+VnBgbm+IPlvOdH8/TNMu+UuNTYV7
 U4GRdrpmwEZD37zhEj7hL6xLwDv1gsyBbnUYOEhRQr0fIuIOs1fG18qCbGEDS2OnZaTy
 GdibRaV7My+SsFJY3rhB476KRppVJRKZGL105+wdrdLiI8MzzKD59bvy+YwG6Hv3gu2c
 AH3uJL83zf0JuuKfZOn/D7mpfufoXeWYGSpYiuWMnhxtG7dYExtGLxd8Tqeu8CJLpX0x
 CZQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCMw/EhuVZe+TG4gfrmMGobk/m3idrW+R7gpptxypi/qeCO2/fP/nuLr5lsq3MpqgsjvSrMgVI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDue1q2GoFlO12s4D27PhFrA+m4eJL7qKH72OZceqQdm3XGHrr
 QrhZgH9JCWK09qRAH5JzrevJz50BHFRoY0QlQQ/DVRVfsorGIXtN9pk4+TIFiWYHqNIhb4PBM8s
 RHRAI9PI1rP/Z/zmC4X7yEAPgyIycsA==
X-Google-Smtp-Source: AGHT+IHOQvxkOkkonUowR3TJHO27M2jGq4AitpQsGq03WtcjHqra6jNRC8sZRQDleYirZ/31pafIpXnrFuF6P6gO3Lw=
X-Received: by 2002:a17:90b:3ec4:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e9b14c7c8amr10298888a91.1.1731465155230; Tue, 12 Nov 2024
 18:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20241109053148.13617-1-alexander.deucher@amd.com>
 <DM4PR12MB516517D96A1EE5E39D96DB4E8E592@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CADnq5_NzYcvDQyBOBvNV14vXsiqnwZL=L-BO09mO0bLA1Ui9ZA@mail.gmail.com>
 <DM4PR12MB5165A0369DCF040CF251F3278E5A2@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165A0369DCF040CF251F3278E5A2@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Nov 2024 21:32:22 -0500
Message-ID: <CADnq5_NSFWWmg=fKUpmtGZbE7ma9-ZKKSuS6AHxFur5-6R4X-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
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

On Tue, Nov 12, 2024 at 8:01=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi Alex,
>
> Comments inline.
>
> Thanks.
>
>
>
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, November 12, 2024 10:23 PM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
>
>
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
>
>
>
>
>
> On Tue, Nov 12, 2024 at 12:44=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.=
com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> If I understand this patch correctly, the sysfs end user will only see hi=
s/her settings to the power profile since the smu->power_profile_mode is re=
flecting the end user's settings.
> Then if the other components set the workload mask then smu->power_profil=
e_mode can't reflect the real prioritized workload. If the end user doesn't=
 need to know this information,
> then it's ok. In addition, there might be one problem, please see comment=
s inline.
>
>
>
> The problem is that when users play videos and games at the same time or =
run ROCm apps and games at the same time, sysfs reflects the last selected =
workload profile.  This is confusing for users and it does not align with h=
ow the firmware works.  We already have bugs filed because playing back a v=
ideo while gaming shows the profile as VIDEO which users assume will be wro=
ng and impact their gaming experience.  The workload hint is a bit mask and=
 all of the currently active workloads should be set when they are active o=
therwise mixing workloads could have a negative effect on performance.  E.g=
., if you video playback and gaming you should get both the FS3D and VIDEO =
workload bits set and the PMFW will arbitrate between them.
>
>
>
> [Kenneth Feng]
>
> [Before this patch, sysfs reflects the highest priority workload actually=
. In the case of FS3D + VIDEO, both FS3D and VIDEO workloads are passed dow=
n to PMFW. But PMFW will ONLY take VIDEO workload policy in effect because =
VIDEO priority > FS3D priority.]
>
>

That's a good point.  I had missed that originally.  I think it's
still confusing to users however since it doesn't reflect what they
think it should be or what they selected.  Also, the workload bits are
not consistent across IP versions so we'd need to fix that up if we
stay with this approach.

Alex

>
>
>
>
>
> Thanks.
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Saturday, November 9, 2024 1:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kennet=
h.Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amd/pm: fix and simplify workload handling
>
> smu->workload_mask is IP specific and should not be messed with in
> the common code. The mask bits vary across SMU versions.
>
> Move all handling of smu->workload_mask in to the backends and simplify t=
he code.  Store the user's preference in smu->power_profile_mode which will=
 be reflected in sysfs.  For internal driver profile switches for KFD or VC=
N, just update the workload mask so that the user's preference is retained.=
  Remove all of the extra now unused workload related elements in the smu s=
tructure.
>
> Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 ++++++------------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-  .../gpu/drm/amd/=
pm/swsmu/smu11/arcturus_ppt.c |  20 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---  .../drm/amd/=
pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--  .../drm/amd/pm/swsmu/smu14/sm=
u_v14_0_2_ppt.c  |  24 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
>  12 files changed, 132 insertions(+), 170 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index c3a6b6f20455..162a3289855c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_b=
lock)
>         INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>         atomic64_set(&smu->throttle_int_counter, 0);
>         smu->watermarks_bitmap =3D 0;
> -       smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -       smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> -       smu->user_dpm_profile.user_workload_mask =3D 0;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
>                 atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1); @=
@ -1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_bl=
ock)
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
> -           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_=
FULLSCREEN3D)) {
> -               smu->driver_workload_mask =3D
> -                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_=
BOOTUP_DEFAULT];
> -       } else {
> -               smu->driver_workload_mask =3D
> -                       1 << smu->workload_priority[PP_SMC_POWER_PROFILE_=
FULLSCREEN3D];
> -               smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_=
FULLSCREEN3D;
> -       }
> -
> -       smu->workload_mask =3D smu->driver_workload_mask |
> -                                                       smu->user_dpm_pro=
file.user_workload_mask;
> -       smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -       smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -       smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
> -       smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
> -       smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
> -       smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
> -       smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
> +           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_=
FULLSCREEN3D))
> +               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> +       else
> +               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCRE=
EN3D;
> +
>         smu->display_config =3D &adev->pm.pm_display_cfg;
>
>         smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO; @@ -2252,24=
 +2228,23 @@ static int smu_enable_umd_pstate(void *handle,  }
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
, param_size);
> +               ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
, param_size,
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
> @@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struct =
smu_context *smu,
>         }
>
>         if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> -               smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DET=
ERMINISM) {
> -               index =3D fls(smu->workload_mask);
> -               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> -               workload[0] =3D smu->workload_setting[index];
> +           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM) {
> +               workload[0] =3D smu->power_profile_mode;
>
> -               if (init || smu->power_profile_mode !=3D workload[0])
> -                       smu_bump_power_profile_mode(smu, workload, 0);
> +               smu_bump_power_profile_mode(smu, workload, 0, true);
>         }
> #[Kenneth Feng]
> #After some OD settings, the workload will go back to the user's setting =
due to wokload[0] =3D smu->power_profile_mode.
> #is there a scenario that the compute workload is set by kfd before the O=
D setting, then the compute workload setting is missing
> #after the OD setting?
>
>
>
>
>
> I see what you mean.  I think we need to refcount the selected workload t=
ypes and keep them set until the ref count goes to 0.
>
>
>
> Alex
>
>
>
>
>         return ret;
> @@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context *sm=
u,
>                 ret =3D smu_pre_display_config_changed(smu);
>                 if (ret)
>                         return ret;
> -               ret =3D smu_adjust_power_state_dynamic(smu, level, false,=
 false);
> +               ret =3D smu_adjust_power_state_dynamic(smu, level, false)=
;
>                 break;
>         case AMD_PP_TASK_COMPLETE_INIT:
> -               ret =3D smu_adjust_power_state_dynamic(smu, level, true, =
true);
> +               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
>                 break;
>         case AMD_PP_TASK_READJUST_POWER_STATE:
> -               ret =3D smu_adjust_power_state_dynamic(smu, level, true, =
false);
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
> -               smu->driver_workload_mask &=3D ~(1 << smu->workload_prior=
ity[type]);
> -               index =3D fls(smu->workload_mask);
> -               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> -               workload[0] =3D smu->workload_setting[index];
> -       } else {
> -               smu->driver_workload_mask |=3D (1 << smu->workload_priori=
ty[type]);
> -               index =3D fls(smu->workload_mask);
> -               index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -               workload[0] =3D smu->workload_setting[index];
> -       }
> +       /* don't disable the user's preference */
> +       if (!enable && type =3D=3D smu->power_profile_mode)
> +               return 0;
>
> -       smu->workload_mask =3D smu->driver_workload_mask |
> -                                                smu->user_dpm_profile.us=
er_workload_mask;
> +       workload[0] =3D type;
>
>         if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> -               smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DET=
ERMINISM)
> -               smu_bump_power_profile_mode(smu, workload, 0);
> +           smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM)
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
e, true);
> +               if (!ret)
> +                       /* store the user's preference */
> +                       smu->power_profile_mode =3D param[param_size];
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
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
> -       int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t, uint32_t size);
> +       int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t,
> +                                     uint32_t size, bool enable);
>
>         /**
>          * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power d=
iff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4b36c230e43a..1e44cf6fec4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct s=
mu_context *smu,
>
>  static int arcturus_set_power_profile_mode(struct smu_context *smu,
>                                            long *input,
> -                                          uint32_t size)
> +                                          uint32_t size,
> +                                          bool enable)
>  {
>         DpmActivityMonitorCoeffInt_t activity_monitor;
>         int workload_type =3D 0;
> @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct s=
mu_context *smu,
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
> @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct=
 smu_context *smu,
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
>                 dev_err(smu->adev->dev, "Fail to set workload type %d\n",=
 workload_type);
> -               return ret;
> -       }
> -
> -       smu_cmn_assign_power_profile(smu);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int arcturus_set_performance_level(struct smu_context *smu, diff =
--git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu11/navi10_ppt.c
> index 211635dabed8..d944a9f954d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct s=
mu_context *smu, char *buf)
>         return size;
>  }
>
> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *=
input, uint32_t size)
> +static int navi10_set_power_profile_mode(struct smu_context *smu, long *=
input,
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
, smu->power_profile_mode);
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
> @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct s=
mu_context *smu, long *input, u
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>                                                        CMN2ASIC_MAPPING_W=
ORKLOAD,
> -                                                      smu->power_profile=
_mode);
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
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> -       else
> -               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 844532a9b641..4967e087088b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(=
struct smu_context *smu, char *
>         return size;
>  }
>
> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu=
, long *input, uint32_t size)
> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu=
,
> +                                                long *input, uint32_t si=
ze,
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
, smu->power_profile_mode);
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
> @@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(=
struct smu_context *smu, long *
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>                                                        CMN2ASIC_MAPPING_W=
ORKLOAD,
> -                                                      smu->power_profile=
_mode);
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
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> -       else
> -               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f89c487dce72..b5dba4826f81 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct sm=
u_context *smu,
>         return size;
>  }
>
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long =
*input, uint32_t size)
> +static int vangogh_set_power_profile_mode(struct smu_context *smu, long =
*input,
> +                                         uint32_t size, bool enable)
>  {
>         int workload_type, ret;
>         uint32_t profile_mode =3D input[size];
> @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct sm=
u_context *smu, long *input,
>         }
>
>         if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> +           profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
>                 return 0;
>
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@ -1080=
,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struct smu_contex=
t *smu, long *input,
>                 return -EINVAL;
>         }
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
>                                     smu->workload_mask,
>                                     NULL);
> -       if (ret) {
> +       if (ret)
>                 dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n",
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
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu, =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 75a9ea87f419..2d1eae79ab9d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context=
 *smu,
>         return ret;
>  }
>
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *=
input, uint32_t size)
> +static int renoir_set_power_profile_mode(struct smu_context *smu, long *=
input,
> +                                        uint32_t size, bool enable)
>  {
>         int workload_type, ret;
>         uint32_t profile_mode =3D input[size];
> @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_c=
ontext *smu, long *input, u
>         }
>
>         if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -                       profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> +           profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
>                 return 0;
>
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */ @@ -891,=
17 +892,17 @@ static int renoir_set_power_profile_mode(struct smu_context *=
smu, long *input, u
>                 return -EINVAL;
>         }
>
> +       if (enable)
> +               smu->workload_mask |=3D (1 << workload_type);
> +       else
> +               smu->workload_mask &=3D ~(1 << workload_type);
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
>                                     smu->workload_mask,
>                                     NULL);
> -       if (ret) {
> +       if (ret)
>                 dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n", workload_type);
> -               return ret;
> -       }
>
> -       smu_cmn_assign_power_profile(smu);
> -
> -       return 0;
> +       return ret;
>  }
>
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu) diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 80c6b1e523aa..3cc734331891 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(str=
uct smu_context *smu,
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
, smu->power_profile_mode);
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
> @@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(str=
uct smu_context *smu,
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>                                                        CMN2ASIC_MAPPING_W=
ORKLOAD,
> -                                                      smu->power_profile=
_mode);
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
>         /* Add optimizations for SMU13.0.0/10.  Reuse the power saving pr=
ofile */
>         if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13, 0, 0) &&
>              ((smu->adev->pm.fw_version =3D=3D 0x004e6601) || @@ -2658,25=
 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_conte=
xt *smu,
>                                                                CMN2ASIC_M=
APPING_WORKLOAD,
>                                                                PP_SMC_POW=
ER_PROFILE_POWERSAVING);
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
> -               if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_P=
OWERSAVING) {
> -                       workload_type =3D smu_cmn_to_asic_specific_index(=
smu,
> -                                                              CMN2ASIC_M=
APPING_WORKLOAD,
> -                                                              PP_SMC_POW=
ER_PROFILE_FULLSCREEN3D);
> -                       smu->power_profile_mode =3D smu->workload_mask & =
(1 << workload_type)
> -                                                                        =
       ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> -                                                                        =
       : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -               }
> -       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c5d3e25cc967..1aafd23857f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2528,22 +2528,23 @@ do {                                             =
                                                       \
>         return result;
>  }
>
> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, l=
ong *input, uint32_t size)
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
, smu->power_profile_mode);
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
> @@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(str=
uct smu_context *smu, long *inp
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>                                                        CMN2ASIC_MAPPING_W=
ORKLOAD,
> -                                                      smu->power_profile=
_mode);
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
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> -       else
> -               smu_cmn_assign_power_profile(smu);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..695480833603 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1719,21 +1719,22 @@ static int smu_v14_0_2_get_power_profile_mode(str=
uct smu_context *smu,
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
, smu->power_profile_mode);
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
t smu_context *smu,
>                 }
>         }
>
> -       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> +       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
>                 smu_v14_0_deep_sleep_control(smu, false);
>         else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
>                 smu_v14_0_deep_sleep_control(smu, true); @@ -1791,15 +179=
2,16 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *s=
mu,
>         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>         workload_type =3D smu_cmn_to_asic_specific_index(smu,
>                                                        CMN2ASIC_MAPPING_W=
ORKLOAD,
> -                                                      smu->power_profile=
_mode);
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
> -                                                                        =
         smu->workload_mask, NULL);
> -
> -       if (!ret)
> -               smu_cmn_assign_power_profile(smu);
> +                                             smu->workload_mask, NULL);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
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
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.h
> index 8a801e389659..1de685defe85 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8=
_t frev, uint8_t crev);  int smu_cmn_set_mp1_state(struct smu_context *smu,
>                           enum pp_mp1_state mp1_state);
>
> -void smu_cmn_assign_power_profile(struct smu_context *smu);
> -
>  /*
>   * Helper function to make sysfs_emit_at() happy. Align buf to
>   * the current page boundary and record the offset.
> --
> 2.47.0
