Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E26D339AF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 18:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F188710E17F;
	Mon, 28 Oct 2024 18:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dDGAXJcN";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BA210E17F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 18:12:15 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-7ea535890e0so513646a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730139135; x=1730743935; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGt/RpWil1yDUvVN47Qq5DjCJZgOpcnT3mUt5G1nfs4=;
 b=dDGAXJcNE2uYrYaK7Ac6AbBbqabQ8IAm795aZt/CS30Pb5aT/STrFTemiAljRI76+O
 aPKhCG1tNjjoZBK/C62Iq4gK9aU/QZwFAVP0PeF9IeaS85857aNz0uLbNAIJLpC1/y5v
 1CJ7Oh9D2jUKS8pucjX5ScrLWR7FNGW01QAsRoNVbFFyL9MZFn49vlvcMeK4eY6wupwT
 d8oROddISiu6pDIMmiNN0+TDVs4Z7bKNZmGiRzXkIPscpzgq8Ga//wZfd7if+HiTRytp
 lLfa5yNgfgcyGXEfiA62/rXEpxjgLwmgAB7Fuv04oUO5W3axAJKNRETxlFpJl0Q/Eovd
 EH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730139135; x=1730743935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGt/RpWil1yDUvVN47Qq5DjCJZgOpcnT3mUt5G1nfs4=;
 b=gUOiLcgD9EDrD+vPfBsN3mNcfUmai0ze53kRMrGY3NeDFMvDystE7MLUNOpM404MQu
 DjkjIhMaH4oJ8AV/TbH8I64sozySpcQEQxzKD3dv0cZZXh1jao485c4s0Bj9d9PQrZy7
 phRQJWljfIDS9ImIPELUafAD9DxMqFDEWeJX54alPcEPRDoX8TTKo7baqr9sUCN7oA6J
 fbAhygIoGPHuokR4FSGNEovjCJxgiIQN455M4qYHOrzlvnNcA5Qw1goDOg+iYB2tAc8E
 MNPFyLxH+Ld2xVyqM6xlbhuR8CdJ0WyLCLPOTJLP1XGrS4AGvE6rvSpuH9qowFl+G8PR
 ghKA==
X-Gm-Message-State: AOJu0YyZ2PLAuc/79tW0YmCBo5wP9YBEkjIuluiUytRbqUPLEn/JnxQ8
 wxERHlXHkpgCfmnVd8Q4EZKHL7bpAsKJu3izVki6Oc9Q4phYEUxecQLKDPDYh83e3d2StM66dE2
 S97uuYBa5hPD33QWtA5GckxsR9g4GuGPa
X-Google-Smtp-Source: AGHT+IHkbHBy33wINv3+a0lT1tT1SGy76PEuCIyKj2/tWAk++TkET2uL2WPcNXtERdgQBBc1xlbOyC1JmZV0ooDre0k=
X-Received: by 2002:a05:6a20:2444:b0:1d9:ddf:b087 with SMTP id
 adf61e73a8af0-1d9a84d970amr5655972637.8.1730139133133; Mon, 28 Oct 2024
 11:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241024085926.25349-1-kenneth.feng@amd.com>
In-Reply-To: <20241024085926.25349-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 14:12:01 -0400
Message-ID: <CADnq5_PYPN_B5pk3MrsYf6Q0A5GHNKZXkNjzZRrW_JVqvbxd5g@mail.gmail.com>
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

I think this can be simplified.  We just need to store the user
workload profile and the mask of all of the currently active workload
profiles (the user selected profile and the any transient ones like
COMPUTE for KFD, VIDEO for VCN, and POWERSAVE for SMU13, etc.).  At
init time, the driver sets the user workload profile to FS3D or
DEFAULT per the current logic.  Add a new parameter to
ppt_funcs->set_power_profile_mode(), bool
update_user_workload_profile, which we set to true in
smu_set_power_profile_mode() which is used by the sysfs code to set
the user workload profile, and set to false in
smu_switch_power_profile() which is used internally for KFD and VCN.
Then the user workload profile would only get changed when the user
changes it via sysfs.  Meanwhile KFD and VCN can add their workload
types dynamically at runtime.

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 44 +++++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---
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

This is repeated in several places and could be split out into a
helper function.

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
