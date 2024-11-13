Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01935D41C03
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFE510E02A;
	Wed, 13 Nov 2024 05:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfFLLbxQ";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E3110E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:58:07 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2e2ab5bbc01so436381a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731477486; x=1732082286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNhUIXfw9tAHF4hW1oPkujNugiDwoR0aT/aO2nn6K6w=;
 b=hfFLLbxQgi8qPCmZIcFnORGi7yZYHVFgzYqPDoQH1PuuiclgE9OYA/h+7+b5Vqw3hf
 nb/tkLlMDDBHSXcYwzaLlmmIEOrLlEkkXfSAwLnb09c8PZWhTKqMvFNyrZYrO8PEbN6E
 dXHTCtUxief63rkEwSRe+ImFtXuz3Nx8mD/s9xTDyqGEKtojYf9Hc59UUb6QXip29eqa
 GwEvwJmqkZVmaBwfF2wcNAzoZhqcVcvXP8DG4wMLC8+sPKL6HkBzk4bRBSOlQs/YrYA/
 toUSDQ8lybiaSQNLK+WHYbWn38VR9A32dY3qcvabtS4VrC6iEDh1nJPfLX3gXz8JoHVq
 q8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731477486; x=1732082286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNhUIXfw9tAHF4hW1oPkujNugiDwoR0aT/aO2nn6K6w=;
 b=vE9dfwk8NFXGyqyjrGLj7Xk8qfR6Zmo9SBjT1bmx+mp1GcxhdIj6XXLn6UJyUpzCWK
 kmwaGK46mUA/+/1FbzabvFhll0WZL9bO2WWh3Fm6SWtNRnyyyj3NFPCkArqucCzXKU73
 SjJmReMSO5pIXpu3q00Js2QusGYP5swWdA+zq9skQFnjvv3hveUNZc/DcRaeuB7MEzE4
 zcWl7NgAY5b/XwALJy4vHzJaJBixlHtyRdFCX3rN4xx9f21crXIF9WbpjsEkgvZJN2tj
 r8dJpjo8rW2TPX28AKA0N/vYNYBzM9yfmoFnXITr63mLresEMNsmCKoAaaEjmNUegNcs
 uiVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfvcjk/ChfiTtk16aE6JPoj7yoUc7Xsx7ctzTR54Mq2i913YaLXuLflFAZXx4SmieOTcZ/kQD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyV8HukgvUro6hpymMX3m/ATEG0bZbwQ4Jl3RFYZCKjiYv5k3Rg
 j6ocG6gT2gw4fhLP7+KUvu5twCBRIBZdvL8umRkVhogM1F+aN/hq8Pr+eMb44dxPbyptQdKFsva
 kaSCrg6s8l3MZz+v32pyjOgygL3OgM4uB
X-Google-Smtp-Source: AGHT+IE/ujVb3EQFeih5JjQ6nWYmiJ7F+tv6BRQTBL3KgZTHaJ4mKI6b8ixKFnP9Mg6PUJXcCMeGGtXUoq2A5QJU2kE=
X-Received: by 2002:a17:90b:1806:b0:2e5:5a58:630 with SMTP id
 98e67ed59e1d1-2e9b16527efmr10717058a91.5.1731477486070; Tue, 12 Nov 2024
 21:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20241112202847.8509-1-alexander.deucher@amd.com>
 <657e02e0-3dde-4ca3-bc4c-9e3b9ace3f8f@amd.com>
In-Reply-To: <657e02e0-3dde-4ca3-bc4c-9e3b9ace3f8f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2024 00:57:54 -0500
Message-ID: <CADnq5_MA8vZCq0cjgw4ctch2YfG_nj=ceSK5H4AdVAC5QEDiNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: fix and simplify workload handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Kenneth Feng <kenneth.feng@amd.com>
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

On Tue, Nov 12, 2024 at 11:59=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 11/13/2024 1:58 AM, Alex Deucher wrote:
> > smu->workload_mask is IP specific and should not be messed with in
> > the common code. The mask bits vary across SMU versions.
> >
> > Move all handling of smu->workload_mask in to the backends and
> > simplify the code.  Store the user's preference in smu->power_profile_m=
ode
> > which will be reflected in sysfs.  For internal driver profile
> > switches for KFD or VCN, just update the workload mask so that the
> > user's preference is retained.  Remove all of the extra now unused
> > workload related elements in the smu structure.
> >
> > v2: use refcounts for workload profiles
> >
> > Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Kenneth Feng <kenneth.feng@amd.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 128 +++++++++---------
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  13 +-
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 +--
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 +--
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 +--
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
> >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 ++---
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +--
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  33 ++---
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
> >  12 files changed, 162 insertions(+), 171 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index c3a6b6f20455..41b591ecfb64 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_=
t limit);
> >  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
> >  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> >  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state=
);
> > +static void smu_power_profile_mode_get(struct smu_context *smu,
> > +                                    enum PP_SMC_POWER_PROFILE profile_=
mode);
> > +static void smu_power_profile_mode_put(struct smu_context *smu,
> > +                                    enum PP_SMC_POWER_PROFILE profile_=
mode);
> >
> >  static int smu_sys_get_pp_feature_mask(void *handle,
> >                                      char *buf)
> > @@ -765,6 +769,7 @@ static int smu_early_init(struct amdgpu_ip_block *i=
p_block)
> >       smu->user_dpm_profile.fan_mode =3D -1;
> >
> >       mutex_init(&smu->message_lock);
> > +     mutex_init(&smu->workload_lock);
> >
> >       adev->powerplay.pp_handle =3D smu;
> >       adev->powerplay.pp_funcs =3D &swsmu_pm_funcs;
> > @@ -1268,9 +1273,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip=
_block)
> >       INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
> >       atomic64_set(&smu->throttle_int_counter, 0);
> >       smu->watermarks_bitmap =3D 0;
> > -     smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -     smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> > -     smu->user_dpm_profile.user_workload_mask =3D 0;
> >
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> >               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> > @@ -1278,33 +1280,13 @@ static int smu_sw_init(struct amdgpu_ip_block *=
ip_block)
> >       atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
> >       atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
> >
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0=
;
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> > -     smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
> > -
> >       if (smu->is_apu ||
> > -         !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_=
FULLSCREEN3D)) {
> > -             smu->driver_workload_mask =3D
> > -                     1 << smu->workload_priority[PP_SMC_POWER_PROFILE_=
BOOTUP_DEFAULT];
> > -     } else {
> > -             smu->driver_workload_mask =3D
> > -                     1 << smu->workload_priority[PP_SMC_POWER_PROFILE_=
FULLSCREEN3D];
> > -             smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_=
FULLSCREEN3D;
> > -     }
> > -
> > -     smu->workload_mask =3D smu->driver_workload_mask |
> > -                                                     smu->user_dpm_pro=
file.user_workload_mask;
> > -     smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -     smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > -     smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
> > -     smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
> > -     smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
> > -     smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
> > -     smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
> > +         !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_=
FULLSCREEN3D))
> > +             smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;
> > +     else
> > +             smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCRE=
EN3D;
> > +     smu_power_profile_mode_get(smu, smu->power_profile_mode);
> > +
> >       smu->display_config =3D &adev->pm.pm_display_cfg;
> >
> >       smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> > @@ -2252,24 +2234,41 @@ static int smu_enable_umd_pstate(void *handle,
> >  }
> >
> >  static int smu_bump_power_profile_mode(struct smu_context *smu,
> > -                                        long *param,
> > -                                        uint32_t param_size)
> > +                                    long *param,
> > +                                    uint32_t param_size,
> > +                                    bool enable)
> >  {
> >       int ret =3D 0;
> >
> >       if (smu->ppt_funcs->set_power_profile_mode)
> > -             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
, param_size);
> > +             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
, param_size, enable);
>
> Have a different expectation with refcount; not expecting to see
> enable/disable. I think only switch power_profile_mode is required.
>
> Workload mask is then created based on non-zero refcounts in this array
> - smu->workload_refcount[]. If it is different from the current mask,
> then it's applied.

I tried that originally, but the problem was the custom profiles.
They need a bunch of extra parameters so it seemed easier to just
leave the set_power_profile backend API as is.  Although thinking
about it more I can save them off in amdgpu_smu.c when I update the
ref count and then just pass the mask to the backend set_power_profile
API.  Additionally for resume, we need to make sure the current
profile gets sent to PMFW.  Once again, thinking about it more, I can
just clear the backend workload_mask on suspend and then on resume, it
won't match and will update.

>
> >
> >       return ret;
> >  }
> >
> > +static void smu_power_profile_mode_get(struct smu_context *smu,
> > +                                    enum PP_SMC_POWER_PROFILE profile_=
mode)
> > +{
> > +     mutex_lock(&smu->workload_lock);
>
> I think this is not needed. DPM calls are already under lock, not seeing
> a case where it could do toggle get/put at the sametime.

Will drop.

>
> > +     smu->workload_refcount[profile_mode]++;
> > +     mutex_unlock(&smu->workload_lock);
> > +}
> > +
> > +static void smu_power_profile_mode_put(struct smu_context *smu,
> > +                                    enum PP_SMC_POWER_PROFILE profile_=
mode)
> > +{
> > +     mutex_lock(&smu->workload_lock);
> > +     if (smu->workload_refcount[profile_mode])
> > +             smu->workload_refcount[profile_mode]--;
> > +     mutex_unlock(&smu->workload_lock);
> > +}
> > +
> >  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
> >                                         enum amd_dpm_forced_level level=
,
> >                                         bool skip_display_settings,
> >                                         bool init)
> >  {
> >       int ret =3D 0;
> > -     int index =3D 0;
> >       long workload[1];
> >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> >
> > @@ -2307,13 +2306,11 @@ static int smu_adjust_power_state_dynamic(struc=
t smu_context *smu,
> >       }
> >
> >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > -             smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DET=
ERMINISM) {
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > +         smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM) {
> > +             workload[0] =3D smu->power_profile_mode;
> >
> > -             if (init || smu->power_profile_mode !=3D workload[0])
> > -                     smu_bump_power_profile_mode(smu, workload, 0);
> > +             if (init)
> > +                     smu_bump_power_profile_mode(smu, workload, 0, tru=
e);
>
> Same here - not expecting to have init check here. Since workload_mask
> is 0 during init and workload_refcount is changed, it will set the right
> mask on smu_bump_power_profile_mode().

This was to cover resume so we apply the current state to PMFW on
resume.  Otherwise, the driver would skip the state update because it
thinks the state is already up to date.

>
> >       }
> >
> >       return ret;
> > @@ -2361,12 +2358,11 @@ static int smu_handle_dpm_task(void *handle,
> >
> >  static int smu_switch_power_profile(void *handle,
> >                                   enum PP_SMC_POWER_PROFILE type,
> > -                                 bool en)
> > +                                 bool enable)
> >  {
> >       struct smu_context *smu =3D handle;
> >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> >       long workload[1];
> > -     uint32_t index;
> >
> >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> >               return -EOPNOTSUPP;
> > @@ -2374,24 +2370,16 @@ static int smu_switch_power_profile(void *handl=
e,
> >       if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
> >               return -EINVAL;
> >
> > -     if (!en) {
> > -             smu->driver_workload_mask &=3D ~(1 << smu->workload_prior=
ity[type]);
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > -     } else {
> > -             smu->driver_workload_mask |=3D (1 << smu->workload_priori=
ty[type]);
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > -     }
> > -
> > -     smu->workload_mask =3D smu->driver_workload_mask |
> > -                                              smu->user_dpm_profile.us=
er_workload_mask;
> > +     workload[0] =3D type;
> >
> >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > -             smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DET=
ERMINISM)
> > -             smu_bump_power_profile_mode(smu, workload, 0);
> > +         smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM) {
> > +             if (enable)
> > +                     smu_power_profile_mode_get(smu, type);
> > +             else
> > +                     smu_power_profile_mode_put(smu, type);
> > +             smu_bump_power_profile_mode(smu, workload, 0, enable);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -3090,21 +3078,27 @@ static int smu_set_power_profile_mode(void *han=
dle,
> >                                     uint32_t param_size)
> >  {
> >       struct smu_context *smu =3D handle;
> > -     int ret;
> > +     long workload[1];
> > +     int ret =3D 0;
> >
> >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> >           !smu->ppt_funcs->set_power_profile_mode)
> >               return -EOPNOTSUPP;
> >
> > -     if (smu->user_dpm_profile.user_workload_mask &
> > -        (1 << smu->workload_priority[param[param_size]]))
> > -        return 0;
> > -
> > -     smu->user_dpm_profile.user_workload_mask =3D
> > -             (1 << smu->workload_priority[param[param_size]]);
> > -     smu->workload_mask =3D smu->user_dpm_profile.user_workload_mask |
> > -             smu->driver_workload_mask;
> > -     ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> > +     if (param[param_size] !=3D smu->power_profile_mode) {
> > +             /* clear the old user preference */
> > +             workload[0] =3D smu->power_profile_mode;
> > +             smu_power_profile_mode_put(smu, smu->power_profile_mode);
> > +             ret =3D smu_bump_power_profile_mode(smu, workload, 0, fal=
se);
> > +             if (ret)
> > +                     return ret;
>
> Here as well - no need to call twice with false/true. Put the existing
> one and get the new one. If smu_bump_power_profile_mode call fails, then
> we have to reverse the operation though - this is true for other cases al=
so.

Good catch.  Will fix.

Alex

>
> Thanks,
> Lijo
>
> > +             /* set the new user preference */
> > +             smu_power_profile_mode_get(smu, param[param_size]);
> > +             ret =3D smu_bump_power_profile_mode(smu, param, param_siz=
e, true);
> > +             if (!ret)
> > +                     /* store the user's preference */
> > +                     smu->power_profile_mode =3D param[param_size];
> > +     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gp=
u/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index fa93a8879113..da7558a65c09 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
> >       /* user clock state information */
> >       uint32_t clk_mask[SMU_CLK_COUNT];
> >       uint32_t clk_dependency;
> > -     uint32_t user_workload_mask;
> >  };
> >
> >  #define SMU_TABLE_INIT(tables, table_id, s, a, d)    \
> > @@ -557,12 +556,12 @@ struct smu_context {
> >       uint32_t hard_min_uclk_req_from_dal;
> >       bool disable_uclk_switch;
> >
> > +     /* backend specific workload mask */
> >       uint32_t workload_mask;
> > -     uint32_t driver_workload_mask;
> > -     uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> > -     uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> > +     /* default/user workload preference */
> >       uint32_t power_profile_mode;
> > -     uint32_t default_power_profile_mode;
> > +     uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> > +     struct mutex workload_lock;
> >       bool pm_enabled;
> >       bool is_apu;
> >
> > @@ -734,8 +733,10 @@ struct pptable_funcs {
> >        *                          create/set custom power profile modes=
.
> >        * &input: Power profile mode parameters.
> >        * &size: Size of &input.
> > +      * &enable: enable/disable the profile
> >        */
> > -     int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t, uint32_t size);
> > +     int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t,
> > +                                   uint32_t size, bool enable);
> >
> >       /**
> >        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index 4b36c230e43a..1e44cf6fec4b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct=
 smu_context *smu,
> >
> >  static int arcturus_set_power_profile_mode(struct smu_context *smu,
> >                                          long *input,
> > -                                        uint32_t size)
> > +                                        uint32_t size,
> > +                                        bool enable)
> >  {
> >       DpmActivityMonitorCoeffInt_t activity_monitor;
> >       int workload_type =3D 0;
> > @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct=
 smu_context *smu,
> >               return -EINVAL;
> >       }
> >
> > -     if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> > -          (smu->smc_fw_version >=3D 0x360d00)) {
> > +     if (enable &&
> > +         (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> > +         (smu->smc_fw_version >=3D 0x360d00)) {
> >               if (size !=3D 10)
> >                       return -EINVAL;
> >
> > @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(stru=
ct smu_context *smu,
> >               return -EINVAL;
> >       }
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >                                         SMU_MSG_SetWorkloadMask,
> >                                         smu->workload_mask,
> >                                         NULL);
> > -     if (ret) {
> > +     if (ret)
> >               dev_err(smu->adev->dev, "Fail to set workload type %d\n",=
 workload_type);
> > -             return ret;
> > -     }
> > -
> > -     smu_cmn_assign_power_profile(smu);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int arcturus_set_performance_level(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 211635dabed8..d944a9f954d0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct=
 smu_context *smu, char *buf)
> >       return size;
> >  }
> >
> > -static int navi10_set_power_profile_mode(struct smu_context *smu, long=
 *input, uint32_t size)
> > +static int navi10_set_power_profile_mode(struct smu_context *smu, long=
 *input,
> > +                                      uint32_t size, bool enable)
> >  {
> >       DpmActivityMonitorCoeffInt_t activity_monitor;
> >       int workload_type, ret =3D 0;
> > +     uint32_t profile_mode =3D input[size];
> >
> > -     smu->power_profile_mode =3D input[size];
> > -
> > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 10)
> >                       return -EINVAL;
> >
> > @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct=
 smu_context *smu, long *input, u
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > +                                                    profile_mode);
> >       if (workload_type < 0)
> >               return -EINVAL;
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> >                                   smu->workload_mask, NULL);
> >       if (ret)
> >               dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/=
drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 844532a9b641..4967e087088b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mod=
e(struct smu_context *smu, char *
> >       return size;
> >  }
> >
> > -static int sienna_cichlid_set_power_profile_mode(struct smu_context *s=
mu, long *input, uint32_t size)
> > +static int sienna_cichlid_set_power_profile_mode(struct smu_context *s=
mu,
> > +                                              long *input, uint32_t si=
ze,
> > +                                              bool enable)
> >  {
> >
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > +     uint32_t profile_mode =3D input[size];
> >       int workload_type, ret =3D 0;
> >
> > -     smu->power_profile_mode =3D input[size];
> > -
> > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 10)
> >                       return -EINVAL;
> >
> > @@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mod=
e(struct smu_context *smu, long *
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > +                                                    profile_mode);
> >       if (workload_type < 0)
> >               return -EINVAL;
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> >                                   smu->workload_mask, NULL);
> >       if (ret)
> >               dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index f89c487dce72..b5dba4826f81 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct =
smu_context *smu,
> >       return size;
> >  }
> >
> > -static int vangogh_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)
> > +static int vangogh_set_power_profile_mode(struct smu_context *smu, lon=
g *input,
> > +                                       uint32_t size, bool enable)
> >  {
> >       int workload_type, ret;
> >       uint32_t profile_mode =3D input[size];
> > @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct =
smu_context *smu, long *input,
> >       }
> >
> >       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> > +         profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
> >               return 0;
> >
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > @@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struc=
t smu_context *smu, long *input,
> >               return -EINVAL;
> >       }
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
> >                                   smu->workload_mask,
> >                                   NULL);
> > -     if (ret) {
> > +     if (ret)
> >               dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n",
> >                                       workload_type);
> > -             return ret;
> > -     }
> > -
> > -     smu_cmn_assign_power_profile(smu);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu=
,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > index 75a9ea87f419..2d1eae79ab9d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_conte=
xt *smu,
> >       return ret;
> >  }
> >
> > -static int renoir_set_power_profile_mode(struct smu_context *smu, long=
 *input, uint32_t size)
> > +static int renoir_set_power_profile_mode(struct smu_context *smu, long=
 *input,
> > +                                      uint32_t size, bool enable)
> >  {
> >       int workload_type, ret;
> >       uint32_t profile_mode =3D input[size];
> > @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu=
_context *smu, long *input, u
> >       }
> >
> >       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> > +         profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
> >               return 0;
> >
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct s=
mu_context *smu, long *input, u
> >               return -EINVAL;
> >       }
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
> >                                   smu->workload_mask,
> >                                   NULL);
> > -     if (ret) {
> > +     if (ret)
> >               dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n", workload_type);
> > -             return ret;
> > -     }
> >
> > -     smu_cmn_assign_power_profile(smu);
> > -
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 80c6b1e523aa..3cc734331891 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(s=
truct smu_context *smu,
> >
> >  static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> >                                             long *input,
> > -                                           uint32_t size)
> > +                                           uint32_t size,
> > +                                           bool enable)
> >  {
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > +     uint32_t profile_mode =3D input[size];
> >       int workload_type, ret =3D 0;
> >       u32 workload_mask;
> >
> > -     smu->power_profile_mode =3D input[size];
> > -
> > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 9)
> >                       return -EINVAL;
> >
> > @@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(s=
truct smu_context *smu,
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > +                                                    profile_mode);
> >
> >       if (workload_type < 0)
> >               return -EINVAL;
> >
> >       workload_mask =3D 1 << workload_type;
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D workload_mask;
> > +     else
> > +             smu->workload_mask &=3D ~workload_mask;
> > +
> >       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving pr=
ofile */
> >       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13, 0, 0) &&
> >            ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
> > @@ -2658,25 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(s=
truct smu_context *smu,
> >                                                              CMN2ASIC_M=
APPING_WORKLOAD,
> >                                                              PP_SMC_POW=
ER_PROFILE_POWERSAVING);
> >               if (workload_type >=3D 0)
> > -                     workload_mask |=3D 1 << workload_type;
> > +                     smu->workload_mask |=3D 1 << workload_type;
> >       }
> >
> > -     smu->workload_mask |=3D workload_mask;
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >                                              SMU_MSG_SetWorkloadMask,
> >                                              smu->workload_mask,
> >                                              NULL);
> > -     if (!ret) {
> > -             smu_cmn_assign_power_profile(smu);
> > -             if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_P=
OWERSAVING) {
> > -                     workload_type =3D smu_cmn_to_asic_specific_index(=
smu,
> > -                                                            CMN2ASIC_M=
APPING_WORKLOAD,
> > -                                                            PP_SMC_POW=
ER_PROFILE_FULLSCREEN3D);
> > -                     smu->power_profile_mode =3D smu->workload_mask & =
(1 << workload_type)
> > -                                                                      =
       ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> > -                                                                      =
       : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -             }
> > -     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index c5d3e25cc967..1aafd23857f0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -2528,22 +2528,23 @@ do {                                           =
                                                       \
> >       return result;
> >  }
> >
> > -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,=
 long *input, uint32_t size)
> > +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> > +                                           long *input, uint32_t size,
> > +                                           bool enable)
> >  {
> >
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > +     uint32_t profile_mode =3D input[size];
> >       int workload_type, ret =3D 0;
> >
> > -     smu->power_profile_mode =3D input[size];
> > -
> > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 8)
> >                       return -EINVAL;
> >
> > @@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(s=
truct smu_context *smu, long *inp
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > +                                                    profile_mode);
> >       if (workload_type < 0)
> >               return -EINVAL;
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> >                                   smu->workload_mask, NULL);
> >
> >       if (ret)
> >               dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > index 59b369eff30f..b64490bcfd62 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > @@ -1719,21 +1719,21 @@ static int smu_v14_0_2_get_power_profile_mode(s=
truct smu_context *smu,
> >
> >  static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> >                                             long *input,
> > -                                           uint32_t size)
> > +                                           uint32_t size,
> > +                                           bool enable)
> >  {
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > +     uint32_t profile_mode =3D input[size];
> >       int workload_type, ret =3D 0;
> > -     uint32_t current_profile_mode =3D smu->power_profile_mode;
> > -     smu->power_profile_mode =3D input[size];
> >
> > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 9)
> >                       return -EINVAL;
> >
> > @@ -1783,23 +1783,24 @@ static int smu_v14_0_2_set_power_profile_mode(s=
truct smu_context *smu,
> >               }
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> > -             smu_v14_0_deep_sleep_control(smu, false);
> > -     else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
> > -             smu_v14_0_deep_sleep_control(smu, true);
> > -
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >                                                      CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > +                                                    profile_mode);
> >       if (workload_type < 0)
> >               return -EINVAL;
> >
> > -     ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> > -                                                                      =
         smu->workload_mask, NULL);
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >
> > -     if (!ret)
> > -             smu_cmn_assign_power_profile(smu);
> > +     /* disable deep sleep if compute is enabled */
> > +     if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> > +             smu_v14_0_deep_sleep_control(smu, !enable);
> > +
> > +     ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> > +                                           smu->workload_mask, NULL);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu_cmn.c
> > index fd2aa949538e..63c4f75fa118 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *sm=
u,
> >       return ret;
> >  }
> >
> > -void smu_cmn_assign_power_profile(struct smu_context *smu)
> > -{
> > -     uint32_t index;
> > -     index =3D fls(smu->workload_mask);
> > -     index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? index - 1=
 : 0;
> > -     smu->power_profile_mode =3D smu->workload_setting[index];
> > -}
> > -
> >  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
> >  {
> >       struct pci_dev *p =3D NULL;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/a=
md/pm/swsmu/smu_cmn.h
> > index 8a801e389659..1de685defe85 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uin=
t8_t frev, uint8_t crev);
> >  int smu_cmn_set_mp1_state(struct smu_context *smu,
> >                         enum pp_mp1_state mp1_state);
> >
> > -void smu_cmn_assign_power_profile(struct smu_context *smu);
> > -
> >  /*
> >   * Helper function to make sysfs_emit_at() happy. Align buf to
> >   * the current page boundary and record the offset.
