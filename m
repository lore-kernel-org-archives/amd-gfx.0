Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D28D65C7E
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 14:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE56110E0DE;
	Fri, 15 Nov 2024 14:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZCBtjcex";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D795510E0DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 14:14:25 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2e9ed2dbfc8so284984a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731680065; x=1732284865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6n2OkJe39IP74DwFIp6VT01BAHbxg8/MlfqvxrHQY4s=;
 b=ZCBtjcex73y8eUOyXma70cd0Uegl+LqBRvFGSBRdZ9MvABgMbD10qTDP/iqmyv7KZL
 r0tqSpqtd7F1Ow+sSF61SY12aAQWS4C6h0STbJl970qgzFVacUi3ahOHbCUyLR/ZzfWo
 XiKUgA/vYcQeHLxYaVmfNT1/q6EmIG9/G91+Fz/RNPeoN8mtfacEsYKTw5Xfq6e2Cg+c
 O2aHjk92qAtETeGf6jOcA8QnEiT6yGf0IlLRP+lHfXJ4oNqbWsYZk+wvMJ4H00HEbDNW
 vmptHaVgIo+UfsK6gs2UiecWSSNwjeGfbVyv/3bakwb6aCfaE6Ys6Kpgov2BBFFrbjDp
 F0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680065; x=1732284865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6n2OkJe39IP74DwFIp6VT01BAHbxg8/MlfqvxrHQY4s=;
 b=n1Mp4GPZyaLd9Bxre9bnQLDmUlNm63b4I2YzdX2aM9fFWdA7EK1c5JUp7iMCDk8p+q
 FPNMtM5I9rdab/DSnBLTOIDPewcl0CdWfst8pmGjzkabOFoPc1kTgckfo/FvcUFjxof8
 XzKcaC2W6sCNeDOZ+6eK9uNFYW35N+S821iebr12I/U13/rmibGy4St4TB1BqHvQzpwL
 5S67/AODqLXKDfssmVRo31AIOXNMldPmwLzBtC8e0455jl/4hgeQA66MDyQopMwW0dkh
 vrKiToxqDr1xB61JcVKcBibhgoph6sgHlqbrA0Tzuqa7SWrEYJcTDh7c6CV+QGlw8QQ7
 ohYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXNax/Py8Z8BLeB1Xmc4hSnt6kcoEoje/ykIiESG0myOLtkgzNFiGfAd4muPkOaoSFNuhzi5pq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgLRli+iEmkfF6CQfAjBRcpkfZeathc9Hqc73N5KZSxb5HNMPd
 SZzG1xtoXglASnY7t1ayVsoNURW5x0x6W4KxvYbvTIIiTsPsd1Y/Ig4ehJZxKsZ30mtmBSPinfK
 RrNiFr+uO5mIP/B/1nzh/bSEMvmpy235e
X-Google-Smtp-Source: AGHT+IFVhJIcNi/N96gha6ooI4kvU5uWTCz8tOLVl7JlGQLXgIbrl8OpzjdHNTIW3goYqWKI65LK1Kb/udd45Ff1QJY=
X-Received: by 2002:a17:90b:4ac6:b0:2e2:d881:5936 with SMTP id
 98e67ed59e1d1-2ea155abf11mr1416213a91.7.1731680064493; Fri, 15 Nov 2024
 06:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20241114210603.10448-1-alexander.deucher@amd.com>
 <45129aa7-31e1-4d87-9f28-84a9c2b8485a@amd.com>
In-Reply-To: <45129aa7-31e1-4d87-9f28-84a9c2b8485a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2024 09:14:12 -0500
Message-ID: <CADnq5_O9+d_og8FxrxdcjSn0KbRRtBXNCyxsxZRV7w1hYYsenw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
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

On Fri, Nov 15, 2024 at 7:14=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 11/15/2024 2:36 AM, Alex Deucher wrote:
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
> > v3: rework based on feedback from Lijo
> >
> > Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Kenneth Feng <kenneth.feng@amd.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 165 +++++++++---------
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  21 ++-
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 147 ++++++++--------
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 151 ++++++++--------
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 150 ++++++++--------
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
> >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 153 ++++++++--------
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 120 +++++++------
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 141 ++++++++-------
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  38 +++-
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   7 +-
> >  12 files changed, 614 insertions(+), 563 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index c3a6b6f20455..ab6b30a9df1a 100644
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
> > @@ -1268,9 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip=
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
> > @@ -1278,33 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *=
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
> > @@ -2140,6 +2121,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip=
_block)
> >       if (!ret)
> >               adev->gfx.gfx_off_entrycount =3D count;
> >
> > +     /* clear this on suspend so it will get reprogrammed on resume */
> > +     smu->frontend_workload_mask =3D 0;
> > +
> >       return 0;
> >  }
> >
> > @@ -2251,26 +2235,46 @@ static int smu_enable_umd_pstate(void *handle,
> >       return 0;
> >  }
> >
> > -static int smu_bump_power_profile_mode(struct smu_context *smu,
> > -                                        long *param,
> > -                                        uint32_t param_size)
> > +static int smu_bump_power_profile_mode(struct smu_context *smu)
> >  {
> > -     int ret =3D 0;
> > +     u32 workload_mask =3D 0;
> > +     int i, ret =3D 0;
> > +
> > +     for (i =3D 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
> > +             if (smu->workload_refcount[i])
> > +                     workload_mask |=3D 1 << i;
> > +     }
> > +
> > +     if (smu->frontend_workload_mask =3D=3D workload_mask)
> > +             return 0;
>
> If you notice, smu->backend_workload_mask is really not used. I think
> only a single mask is required. At any point, smu->workload_refcount[i]
> can be used to derive the mask. I think we just need to move the above
> logic to smu_cmn_get_backend_workload_mask/smu_cmn_get_workload_mask.
>
> While going for suspend, only clear smu->workload_mask. During resume
> bump_profile_mode() will be called and at that time, we will have
>
> smu_cmn_get_backend_workload_mask() !=3D smu->workload_mask

Yeah, I noticed that as well, but decided to leave it just in case.  I
can drop it.

>
> To check if custom profile is requested,this will do -
>
> if (smu->workload_refcount[PP_SMC_POWER_PROFILE_CUSTOM]).
>
> The decision for smu_cmn_get_backend_workload_mask() !=3D
> smu->workload_mask may be left to the backend.

I was trying to avoid adding duplicate logic to every backend.  Seemed
easier to put the checks into the frontend code.

>
> It's possible that the parameters for custom changed, but the mask
> remains same. The current check in bump_profile_mode() doesn't appear to
> cover that case.

I added a check handling custom updates in
smu_set_power_profile_mode() since that is the only interface to
specify custom profiles.  If the parameters change, the driver clears
the front_end_mask to force an update.

>
> // custom_param_changed =3D existing check in this patch.
>
> In backend we can check
>         if (smu->workload_refcount[PP_SMC_POWER_PROFILE_CUSTOM] &&
> custom_param_changed)
>
> Also, anytime a smu_bump_power_profile_mode() fails we need to do
>
>         smu_power_profile_mode_put(smu, type)
>
> Not able to see that in the patch, not sure if it's handled in a
> different way.

Yes, will fix.

Alex

>
> Thanks,
> Lijo
> >
> >       if (smu->ppt_funcs->set_power_profile_mode)
> > -             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
, param_size);
> > +             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, workl=
oad_mask);
> > +
> > +     if (!ret)
> > +             smu->frontend_workload_mask =3D workload_mask;
> >
> >       return ret;
> >  }
> >
> > +static void smu_power_profile_mode_get(struct smu_context *smu,
> > +                                    enum PP_SMC_POWER_PROFILE profile_=
mode)
> > +{
> > +     smu->workload_refcount[profile_mode]++;
> > +}
> > +
> > +static void smu_power_profile_mode_put(struct smu_context *smu,
> > +                                    enum PP_SMC_POWER_PROFILE profile_=
mode)
> > +{
> > +     if (smu->workload_refcount[profile_mode])
> > +             smu->workload_refcount[profile_mode]--;
> > +}
> > +
> >  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
> >                                         enum amd_dpm_forced_level level=
,
> > -                                       bool skip_display_settings,
> > -                                       bool init)
> > +                                       bool skip_display_settings)
> >  {
> >       int ret =3D 0;
> > -     int index =3D 0;
> > -     long workload[1];
> >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> >
> >       if (!skip_display_settings) {
> > @@ -2307,14 +2311,8 @@ static int smu_adjust_power_state_dynamic(struct=
 smu_context *smu,
> >       }
> >
> >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > -             smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DET=
ERMINISM) {
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > -
> > -             if (init || smu->power_profile_mode !=3D workload[0])
> > -                     smu_bump_power_profile_mode(smu, workload, 0);
> > -     }
> > +         smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMI=
NISM)
> > +             smu_bump_power_profile_mode(smu);
> >
> >       return ret;
> >  }
> > @@ -2333,13 +2331,13 @@ static int smu_handle_task(struct smu_context *=
smu,
> >               ret =3D smu_pre_display_config_changed(smu);
> >               if (ret)
> >                       return ret;
> > -             ret =3D smu_adjust_power_state_dynamic(smu, level, false,=
 false);
> > +             ret =3D smu_adjust_power_state_dynamic(smu, level, false)=
;
> >               break;
> >       case AMD_PP_TASK_COMPLETE_INIT:
> > -             ret =3D smu_adjust_power_state_dynamic(smu, level, true, =
true);
> > +             ret =3D smu_adjust_power_state_dynamic(smu, level, true);
> >               break;
> >       case AMD_PP_TASK_READJUST_POWER_STATE:
> > -             ret =3D smu_adjust_power_state_dynamic(smu, level, true, =
false);
> > +             ret =3D smu_adjust_power_state_dynamic(smu, level, true);
> >               break;
> >       default:
> >               break;
> > @@ -2361,12 +2359,10 @@ static int smu_handle_dpm_task(void *handle,
> >
> >  static int smu_switch_power_profile(void *handle,
> >                                   enum PP_SMC_POWER_PROFILE type,
> > -                                 bool en)
> > +                                 bool enable)
> >  {
> >       struct smu_context *smu =3D handle;
> >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> > -     long workload[1];
> > -     uint32_t index;
> >
> >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> >               return -EOPNOTSUPP;
> > @@ -2374,24 +2370,14 @@ static int smu_switch_power_profile(void *handl=
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
> > -
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
> > +             smu_bump_power_profile_mode(smu);
> > +     }
> >
> >       return 0;
> >  }
> > @@ -3090,21 +3076,44 @@ static int smu_set_power_profile_mode(void *han=
dle,
> >                                     uint32_t param_size)
> >  {
> >       struct smu_context *smu =3D handle;
> > -     int ret;
> > +     bool custom_changed =3D false;
> > +     int ret =3D 0, i;
> >
> >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> >           !smu->ppt_funcs->set_power_profile_mode)
> >               return -EOPNOTSUPP;
> >
> > -     if (smu->user_dpm_profile.user_workload_mask &
> > -        (1 << smu->workload_priority[param[param_size]]))
> > -        return 0;
> > +     if (param[param_size] =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +             if (param_size > SMU_BACKEND_MAX_CUSTOM_PARAMETERS)
> > +                     return -EINVAL;
> > +             /* param_size is actually a max index, not an array size =
*/
> > +             for (i =3D 0; i <=3D param_size; i++) {
> > +                     if (smu->custom_profile_input[i] !=3D param[i]) {
> > +                             custom_changed =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> >
> > -     smu->user_dpm_profile.user_workload_mask =3D
> > -             (1 << smu->workload_priority[param[param_size]]);
> > -     smu->workload_mask =3D smu->user_dpm_profile.user_workload_mask |
> > -             smu->driver_workload_mask;
> > -     ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> > +     if ((param[param_size] !=3D smu->power_profile_mode) || custom_ch=
anged) {
> > +             /* save the parameters for custom */
> > +             if (custom_changed) {
> > +                     /* param_size is actually a max index, not an arr=
ay size */
> > +                     for (i =3D 0; i <=3D param_size; i++)
> > +                             smu->custom_profile_input[i] =3D param[i]=
;
> > +                     smu->custom_profile_size =3D param_size;
> > +                     /* clear frontend mask so custom changes propogat=
e */
> > +                     smu->frontend_workload_mask =3D 0;
> > +             }
> > +             /* clear the old user preference */
> > +             smu_power_profile_mode_put(smu, smu->power_profile_mode);
> > +             /* set the new user preference */
> > +             smu_power_profile_mode_get(smu, param[param_size]);
> > +             ret =3D smu_bump_power_profile_mode(smu);
> > +             if (!ret)
> > +                     /* store the user's preference */
> > +                     smu->power_profile_mode =3D param[param_size];
> > +     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gp=
u/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index fa93a8879113..a9b88072bd05 100644
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
> > @@ -510,6 +509,8 @@ enum smu_fw_status {
> >   */
> >  #define SMU_WBRF_EVENT_HANDLING_PACE 10
> >
> > +#define SMU_BACKEND_MAX_CUSTOM_PARAMETERS    11
> > +
> >  struct smu_context {
> >       struct amdgpu_device            *adev;
> >       struct amdgpu_irq_src           irq_source;
> > @@ -557,12 +558,16 @@ struct smu_context {
> >       uint32_t hard_min_uclk_req_from_dal;
> >       bool disable_uclk_switch;
> >
> > -     uint32_t workload_mask;
> > -     uint32_t driver_workload_mask;
> > -     uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> > -     uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> > +     /* asic agnostic workload mask */
> > +     uint32_t frontend_workload_mask;
> > +     /* asic specific workload mask */
> > +     uint32_t backend_workload_mask;
> > +     /* default/user workload preference */
> >       uint32_t power_profile_mode;
> > -     uint32_t default_power_profile_mode;
> > +     uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> > +     /* backend specific custom workload settings */
> > +     long custom_profile_input[SMU_BACKEND_MAX_CUSTOM_PARAMETERS];
> > +     bool custom_profile_size;
> >       bool pm_enabled;
> >       bool is_apu;
> >
> > @@ -733,9 +738,9 @@ struct pptable_funcs {
> >        * @set_power_profile_mode: Set a power profile mode. Also used t=
o
> >        *                          create/set custom power profile modes=
.
> >        * &input: Power profile mode parameters.
> > -      * &size: Size of &input.
> > +      * &workload_mask: mask of workloads to enable
> >        */
> > -     int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t, uint32_t size);
> > +     int (*set_power_profile_mode)(struct smu_context *smu, u32 worklo=
ad_mask);
> >
> >       /**
> >        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index 4b36c230e43a..64605cd932ab 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -1441,97 +1441,98 @@ static int arcturus_get_power_profile_mode(stru=
ct smu_context *smu,
> >       return size;
> >  }
> >
> > -static int arcturus_set_power_profile_mode(struct smu_context *smu,
> > -                                        long *input,
> > -                                        uint32_t size)
> > +static int arcturus_set_power_profile_mode_coeff(struct smu_context *s=
mu,
> > +                                              long *input,
> > +                                              uint32_t size)
> >  {
> >       DpmActivityMonitorCoeffInt_t activity_monitor;
> > -     int workload_type =3D 0;
> > -     uint32_t profile_mode =3D input[size];
> > -     int ret =3D 0;
> > +     int ret;
> >
> > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> > +     if (size !=3D 10)
> >               return -EINVAL;
> > +
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor),
> > +                                false);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to get activity moni=
tor!", __func__);
> > +             return ret;
> >       }
> >
> > -     if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> > -          (smu->smc_fw_version >=3D 0x360d00)) {
> > -             if (size !=3D 10)
> > -                     return -EINVAL;
> > +     switch (input[0]) {
> > +     case 0: /* Gfxclk */
> > +             activity_monitor.Gfx_FPS =3D input[1];
> > +             activity_monitor.Gfx_UseRlcBusy =3D input[2];
> > +             activity_monitor.Gfx_MinActiveFreqType =3D input[3];
> > +             activity_monitor.Gfx_MinActiveFreq =3D input[4];
> > +             activity_monitor.Gfx_BoosterFreqType =3D input[5];
> > +             activity_monitor.Gfx_BoosterFreq =3D input[6];
> > +             activity_monitor.Gfx_PD_Data_limit_c =3D input[7];
> > +             activity_monitor.Gfx_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor.Gfx_PD_Data_error_rate_coeff =3D input[9=
];
> > +             break;
> > +     case 1: /* Uclk */
> > +             activity_monitor.Mem_FPS =3D input[1];
> > +             activity_monitor.Mem_UseRlcBusy =3D input[2];
> > +             activity_monitor.Mem_MinActiveFreqType =3D input[3];
> > +             activity_monitor.Mem_MinActiveFreq =3D input[4];
> > +             activity_monitor.Mem_BoosterFreqType =3D input[5];
> > +             activity_monitor.Mem_BoosterFreq =3D input[6];
> > +             activity_monitor.Mem_PD_Data_limit_c =3D input[7];
> > +             activity_monitor.Mem_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor.Mem_PD_Data_error_rate_coeff =3D input[9=
];
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > -                                    WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor),
> > -                                    false);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor),
> > +                                true);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to set activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -             switch (input[0]) {
> > -             case 0: /* Gfxclk */
> > -                     activity_monitor.Gfx_FPS =3D input[1];
> > -                     activity_monitor.Gfx_UseRlcBusy =3D input[2];
> > -                     activity_monitor.Gfx_MinActiveFreqType =3D input[=
3];
> > -                     activity_monitor.Gfx_MinActiveFreq =3D input[4];
> > -                     activity_monitor.Gfx_BoosterFreqType =3D input[5]=
;
> > -                     activity_monitor.Gfx_BoosterFreq =3D input[6];
> > -                     activity_monitor.Gfx_PD_Data_limit_c =3D input[7]=
;
> > -                     activity_monitor.Gfx_PD_Data_error_coeff =3D inpu=
t[8];
> > -                     activity_monitor.Gfx_PD_Data_error_rate_coeff =3D=
 input[9];
> > -                     break;
> > -             case 1: /* Uclk */
> > -                     activity_monitor.Mem_FPS =3D input[1];
> > -                     activity_monitor.Mem_UseRlcBusy =3D input[2];
> > -                     activity_monitor.Mem_MinActiveFreqType =3D input[=
3];
> > -                     activity_monitor.Mem_MinActiveFreq =3D input[4];
> > -                     activity_monitor.Mem_BoosterFreqType =3D input[5]=
;
> > -                     activity_monitor.Mem_BoosterFreq =3D input[6];
> > -                     activity_monitor.Mem_PD_Data_limit_c =3D input[7]=
;
> > -                     activity_monitor.Mem_PD_Data_error_coeff =3D inpu=
t[8];
> > -                     activity_monitor.Mem_PD_Data_error_rate_coeff =3D=
 input[9];
> > -                     break;
> > -             default:
> > -                     return -EINVAL;
> > -             }
> > +     return ret;
> > +}
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > -                                    WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor),
> > -                                    true);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to set activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > -     }
> > +static int arcturus_set_power_profile_mode(struct smu_context *smu,
> > +                                        u32 workload_mask)
> > +{
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int ret;
> >
> > -     /*
> > -      * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> > -      * Not all profile modes are supported on arcturus.
> > -      */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    profile_mode);
> > -     if (workload_type < 0) {
> > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %=
d on arcturus\n", profile_mode);
> > -             return -EINVAL;
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> > +
> > +     if (custom_enabled) {
> > +             ret =3D arcturus_set_power_profile_mode_coeff(smu,
> > +                                                         smu->custom_p=
rofile_input,
> > +                                                         smu->custom_p=
rofile_size);
> > +             if (ret)
> > +                     return ret;
> >       }
> >
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > -                                       SMU_MSG_SetWorkloadMask,
> > -                                       smu->workload_mask,
> > -                                       NULL);
> > +                                           SMU_MSG_SetWorkloadMask,
> > +                                           backend_workload_mask,
> > +                                           NULL);
> >       if (ret) {
> > -             dev_err(smu->adev->dev, "Fail to set workload type %d\n",=
 workload_type);
> > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%0=
8x\n",
> > +                     workload_mask);
> >               return ret;
> >       }
> >
> > -     smu_cmn_assign_power_profile(smu);
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int arcturus_set_performance_level(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 211635dabed8..8ed446b3458c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2006,90 +2006,101 @@ static int navi10_get_power_profile_mode(struc=
t smu_context *smu, char *buf)
> >       return size;
> >  }
> >
> > -static int navi10_set_power_profile_mode(struct smu_context *smu, long=
 *input, uint32_t size)
> > +static int navi10_set_power_profile_mode_coeff(struct smu_context *smu=
,
> > +                                            long *input,
> > +                                            uint32_t size)
> >  {
> >       DpmActivityMonitorCoeffInt_t activity_monitor;
> > -     int workload_type, ret =3D 0;
> > +     int ret;
> > +
> > +     if (size !=3D 10)
> > +             return -EINVAL;
> >
> > -     smu->power_profile_mode =3D input[size];
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORK=
LOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor), false);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to get activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     switch (input[0]) {
> > +     case 0: /* Gfxclk */
> > +             activity_monitor.Gfx_FPS =3D input[1];
> > +             activity_monitor.Gfx_MinFreqStep =3D input[2];
> > +             activity_monitor.Gfx_MinActiveFreqType =3D input[3];
> > +             activity_monitor.Gfx_MinActiveFreq =3D input[4];
> > +             activity_monitor.Gfx_BoosterFreqType =3D input[5];
> > +             activity_monitor.Gfx_BoosterFreq =3D input[6];
> > +             activity_monitor.Gfx_PD_Data_limit_c =3D input[7];
> > +             activity_monitor.Gfx_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor.Gfx_PD_Data_error_rate_coeff =3D input[9=
];
> > +             break;
> > +     case 1: /* Socclk */
> > +             activity_monitor.Soc_FPS =3D input[1];
> > +             activity_monitor.Soc_MinFreqStep =3D input[2];
> > +             activity_monitor.Soc_MinActiveFreqType =3D input[3];
> > +             activity_monitor.Soc_MinActiveFreq =3D input[4];
> > +             activity_monitor.Soc_BoosterFreqType =3D input[5];
> > +             activity_monitor.Soc_BoosterFreq =3D input[6];
> > +             activity_monitor.Soc_PD_Data_limit_c =3D input[7];
> > +             activity_monitor.Soc_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor.Soc_PD_Data_error_rate_coeff =3D input[9=
];
> > +             break;
> > +     case 2: /* Memclk */
> > +             activity_monitor.Mem_FPS =3D input[1];
> > +             activity_monitor.Mem_MinFreqStep =3D input[2];
> > +             activity_monitor.Mem_MinActiveFreqType =3D input[3];
> > +             activity_monitor.Mem_MinActiveFreq =3D input[4];
> > +             activity_monitor.Mem_BoosterFreqType =3D input[5];
> > +             activity_monitor.Mem_BoosterFreq =3D input[6];
> > +             activity_monitor.Mem_PD_Data_limit_c =3D input[7];
> > +             activity_monitor.Mem_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor.Mem_PD_Data_error_rate_coeff =3D input[9=
];
> > +             break;
> > +     default:
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             if (size !=3D 10)
> > -                     return -EINVAL;
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORK=
LOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor), true);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to set activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, =
WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor), false=
);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     return ret;
> > +}
> >
> > -             switch (input[0]) {
> > -             case 0: /* Gfxclk */
> > -                     activity_monitor.Gfx_FPS =3D input[1];
> > -                     activity_monitor.Gfx_MinFreqStep =3D input[2];
> > -                     activity_monitor.Gfx_MinActiveFreqType =3D input[=
3];
> > -                     activity_monitor.Gfx_MinActiveFreq =3D input[4];
> > -                     activity_monitor.Gfx_BoosterFreqType =3D input[5]=
;
> > -                     activity_monitor.Gfx_BoosterFreq =3D input[6];
> > -                     activity_monitor.Gfx_PD_Data_limit_c =3D input[7]=
;
> > -                     activity_monitor.Gfx_PD_Data_error_coeff =3D inpu=
t[8];
> > -                     activity_monitor.Gfx_PD_Data_error_rate_coeff =3D=
 input[9];
> > -                     break;
> > -             case 1: /* Socclk */
> > -                     activity_monitor.Soc_FPS =3D input[1];
> > -                     activity_monitor.Soc_MinFreqStep =3D input[2];
> > -                     activity_monitor.Soc_MinActiveFreqType =3D input[=
3];
> > -                     activity_monitor.Soc_MinActiveFreq =3D input[4];
> > -                     activity_monitor.Soc_BoosterFreqType =3D input[5]=
;
> > -                     activity_monitor.Soc_BoosterFreq =3D input[6];
> > -                     activity_monitor.Soc_PD_Data_limit_c =3D input[7]=
;
> > -                     activity_monitor.Soc_PD_Data_error_coeff =3D inpu=
t[8];
> > -                     activity_monitor.Soc_PD_Data_error_rate_coeff =3D=
 input[9];
> > -                     break;
> > -             case 2: /* Memclk */
> > -                     activity_monitor.Mem_FPS =3D input[1];
> > -                     activity_monitor.Mem_MinFreqStep =3D input[2];
> > -                     activity_monitor.Mem_MinActiveFreqType =3D input[=
3];
> > -                     activity_monitor.Mem_MinActiveFreq =3D input[4];
> > -                     activity_monitor.Mem_BoosterFreqType =3D input[5]=
;
> > -                     activity_monitor.Mem_BoosterFreq =3D input[6];
> > -                     activity_monitor.Mem_PD_Data_limit_c =3D input[7]=
;
> > -                     activity_monitor.Mem_PD_Data_error_coeff =3D inpu=
t[8];
> > -                     activity_monitor.Mem_PD_Data_error_rate_coeff =3D=
 input[9];
> > -                     break;
> > -             default:
> > -                     return -EINVAL;
> > -             }
> > +static int navi10_set_power_profile_mode(struct smu_context *smu,
> > +                                      u32 workload_mask)
> > +{
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int ret;
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, =
WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor), true)=
;
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to set activ=
ity monitor!", __func__);
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> > +
> > +     if (custom_enabled) {
> > +             ret =3D navi10_set_power_profile_mode_coeff(smu,
> > +                                                       smu->custom_pro=
file_input,
> > +                                                       smu->custom_pro=
file_size);
> > +             if (ret)
> >                       return ret;
> > -             }
> >       }
> >
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > -     if (workload_type < 0)
> > -             return -EINVAL;
> > -
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> > -                                 smu->workload_mask, NULL);
> > -     if (ret)
> > -             dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> > +                                           backend_workload_mask, NULL=
);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%0=
8x\n",
> > +                     workload_mask);
> > +             return ret;
> > +     }
> > +
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/=
drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 844532a9b641..bea11bbe859c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -1704,93 +1704,103 @@ static int sienna_cichlid_get_power_profile_mo=
de(struct smu_context *smu, char *
> >       return size;
> >  }
> >
> > -static int sienna_cichlid_set_power_profile_mode(struct smu_context *s=
mu, long *input, uint32_t size)
> > +static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_cont=
ext *smu,
> > +                                                    long *input, uint3=
2_t size)
> >  {
> >
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > -     int workload_type, ret =3D 0;
> > +     int ret;
> > +
> > +     if (size !=3D 10)
> > +             return -EINVAL;
> >
> > -     smu->power_profile_mode =3D input[size];
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORK=
LOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external), =
false);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to get activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     switch (input[0]) {
> > +     case 0: /* Gfxclk */
> > +             activity_monitor->Gfx_FPS =3D input[1];
> > +             activity_monitor->Gfx_MinFreqStep =3D input[2];
> > +             activity_monitor->Gfx_MinActiveFreqType =3D input[3];
> > +             activity_monitor->Gfx_MinActiveFreq =3D input[4];
> > +             activity_monitor->Gfx_BoosterFreqType =3D input[5];
> > +             activity_monitor->Gfx_BoosterFreq =3D input[6];
> > +             activity_monitor->Gfx_PD_Data_limit_c =3D input[7];
> > +             activity_monitor->Gfx_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor->Gfx_PD_Data_error_rate_coeff =3D input[=
9];
> > +             break;
> > +     case 1: /* Socclk */
> > +             activity_monitor->Fclk_FPS =3D input[1];
> > +             activity_monitor->Fclk_MinFreqStep =3D input[2];
> > +             activity_monitor->Fclk_MinActiveFreqType =3D input[3];
> > +             activity_monitor->Fclk_MinActiveFreq =3D input[4];
> > +             activity_monitor->Fclk_BoosterFreqType =3D input[5];
> > +             activity_monitor->Fclk_BoosterFreq =3D input[6];
> > +             activity_monitor->Fclk_PD_Data_limit_c =3D input[7];
> > +             activity_monitor->Fclk_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor->Fclk_PD_Data_error_rate_coeff =3D input=
[9];
> > +             break;
> > +     case 2: /* Memclk */
> > +             activity_monitor->Mem_FPS =3D input[1];
> > +             activity_monitor->Mem_MinFreqStep =3D input[2];
> > +             activity_monitor->Mem_MinActiveFreqType =3D input[3];
> > +             activity_monitor->Mem_MinActiveFreq =3D input[4];
> > +             activity_monitor->Mem_BoosterFreqType =3D input[5];
> > +             activity_monitor->Mem_BoosterFreq =3D input[6];
> > +             activity_monitor->Mem_PD_Data_limit_c =3D input[7];
> > +             activity_monitor->Mem_PD_Data_error_coeff =3D input[8];
> > +             activity_monitor->Mem_PD_Data_error_rate_coeff =3D input[=
9];
> > +             break;
> > +     default:
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             if (size !=3D 10)
> > -                     return -EINVAL;
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORK=
LOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external), =
true);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to set activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, =
WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor_externa=
l), false);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     return ret;
> > +}
> >
> > -             switch (input[0]) {
> > -             case 0: /* Gfxclk */
> > -                     activity_monitor->Gfx_FPS =3D input[1];
> > -                     activity_monitor->Gfx_MinFreqStep =3D input[2];
> > -                     activity_monitor->Gfx_MinActiveFreqType =3D input=
[3];
> > -                     activity_monitor->Gfx_MinActiveFreq =3D input[4];
> > -                     activity_monitor->Gfx_BoosterFreqType =3D input[5=
];
> > -                     activity_monitor->Gfx_BoosterFreq =3D input[6];
> > -                     activity_monitor->Gfx_PD_Data_limit_c =3D input[7=
];
> > -                     activity_monitor->Gfx_PD_Data_error_coeff =3D inp=
ut[8];
> > -                     activity_monitor->Gfx_PD_Data_error_rate_coeff =
=3D input[9];
> > -                     break;
> > -             case 1: /* Socclk */
> > -                     activity_monitor->Fclk_FPS =3D input[1];
> > -                     activity_monitor->Fclk_MinFreqStep =3D input[2];
> > -                     activity_monitor->Fclk_MinActiveFreqType =3D inpu=
t[3];
> > -                     activity_monitor->Fclk_MinActiveFreq =3D input[4]=
;
> > -                     activity_monitor->Fclk_BoosterFreqType =3D input[=
5];
> > -                     activity_monitor->Fclk_BoosterFreq =3D input[6];
> > -                     activity_monitor->Fclk_PD_Data_limit_c =3D input[=
7];
> > -                     activity_monitor->Fclk_PD_Data_error_coeff =3D in=
put[8];
> > -                     activity_monitor->Fclk_PD_Data_error_rate_coeff =
=3D input[9];
> > -                     break;
> > -             case 2: /* Memclk */
> > -                     activity_monitor->Mem_FPS =3D input[1];
> > -                     activity_monitor->Mem_MinFreqStep =3D input[2];
> > -                     activity_monitor->Mem_MinActiveFreqType =3D input=
[3];
> > -                     activity_monitor->Mem_MinActiveFreq =3D input[4];
> > -                     activity_monitor->Mem_BoosterFreqType =3D input[5=
];
> > -                     activity_monitor->Mem_BoosterFreq =3D input[6];
> > -                     activity_monitor->Mem_PD_Data_limit_c =3D input[7=
];
> > -                     activity_monitor->Mem_PD_Data_error_coeff =3D inp=
ut[8];
> > -                     activity_monitor->Mem_PD_Data_error_rate_coeff =
=3D input[9];
> > -                     break;
> > -             default:
> > -                     return -EINVAL;
> > -             }
> > +static int sienna_cichlid_set_power_profile_mode(struct smu_context *s=
mu,
> > +                                              u32 workload_mask)
> > +{
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int ret;
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, =
WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor_externa=
l), true);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to set activ=
ity monitor!", __func__);
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> > +
> > +     if (custom_enabled) {
> > +             ret =3D sienna_cichlid_set_power_profile_mode_coeff(smu,
> > +                                                               smu->cu=
stom_profile_input,
> > +                                                               smu->cu=
stom_profile_size);
> > +             if (ret)
> >                       return ret;
> > -             }
> >       }
> >
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > -     if (workload_type < 0)
> > -             return -EINVAL;
> > -
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> > -                                 smu->workload_mask, NULL);
> > -     if (ret)
> > -             dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> > +                                           backend_workload_mask, NULL=
);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%0=
8x\n",
> > +                     workload_mask);
> > +             return ret;
> > +     }
> > +
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index f89c487dce72..279d01f58785 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -1056,42 +1056,29 @@ static int vangogh_get_power_profile_mode(struc=
t smu_context *smu,
> >       return size;
> >  }
> >
> > -static int vangogh_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)
> > +static int vangogh_set_power_profile_mode(struct smu_context *smu,
> > +                                       u32 workload_mask)
> >  {
> > -     int workload_type, ret;
> > -     uint32_t profile_mode =3D input[size];
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int ret;
> >
> > -     if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> > -             return 0;
> > -
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    profile_mode);
> > -     if (workload_type < 0) {
> > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %=
d on VANGOGH\n",
> > -                                     profile_mode);
> > -             return -EINVAL;
> > -     }
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> >
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
> > -                                 smu->workload_mask,
> > -                                 NULL);
> > +                                           backend_workload_mask,
> > +                                           NULL);
> >       if (ret) {
> > -             dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n",
> > -                                     workload_type);
> > +             dev_err_once(smu->adev->dev, "Fail to set workload mask 0=
x%08x\n",
> > +                          workload_mask);
> >               return ret;
> >       }
> >
> > -     smu_cmn_assign_power_profile(smu);
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu=
,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > index 75a9ea87f419..f6d0973506d6 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > @@ -864,44 +864,29 @@ static int renoir_force_clk_levels(struct smu_con=
text *smu,
> >       return ret;
> >  }
> >
> > -static int renoir_set_power_profile_mode(struct smu_context *smu, long=
 *input, uint32_t size)
> > +static int renoir_set_power_profile_mode(struct smu_context *smu,
> > +                                      u32 workload_mask)
> >  {
> > -     int workload_type, ret;
> > -     uint32_t profile_mode =3D input[size];
> > +     int ret;
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> >
> > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, profile_mode);
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> > -             return 0;
> > -
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    profile_mode);
> > -     if (workload_type < 0) {
> > -             /*
> > -              * TODO: If some case need switch to powersave/default po=
wer mode
> > -              * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUST=
OM for power saving.
> > -              */
> > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %=
d on RENOIR\n", profile_mode);
> > -             return -EINVAL;
> > -     }
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> >
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProces=
sNotify,
> > -                                 smu->workload_mask,
> > -                                 NULL);
> > +                                           backend_workload_mask,
> > +                                           NULL);
> >       if (ret) {
> > -             dev_err_once(smu->adev->dev, "Fail to set workload type %=
d\n", workload_type);
> > +             dev_err_once(smu->adev->dev, "Failed to set workload mask=
 0x08%x\n",
> > +                          workload_mask);
> >               return ret;
> >       }
> >
> > -     smu_cmn_assign_power_profile(smu);
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 80c6b1e523aa..4bc984cca6cd 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(s=
truct smu_context *smu,
> >       return size;
> >  }
> >
> > -static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> > -                                           long *input,
> > -                                           uint32_t size)
> > +static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context=
 *smu,
> > +                                                 long *input,
> > +                                                 uint32_t size)
> >  {
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > -     int workload_type, ret =3D 0;
> > -     u32 workload_mask;
> > -
> > -     smu->power_profile_mode =3D input[size];
> > +     int ret;
> >
> > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (size !=3D 9)
> >               return -EINVAL;
> > -     }
> > -
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             if (size !=3D 9)
> > -                     return -EINVAL;
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                        SMU_TABLE_ACTIVITY_MONITOR_COE=
FF,
> > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                        (void *)(&activity_monitor_ext=
ernal),
> > -                                        false);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external),
> > +                                false);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to get activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -             switch (input[0]) {
> > -             case 0: /* Gfxclk */
> > -                     activity_monitor->Gfx_FPS =3D input[1];
> > -                     activity_monitor->Gfx_MinActiveFreqType =3D input=
[2];
> > -                     activity_monitor->Gfx_MinActiveFreq =3D input[3];
> > -                     activity_monitor->Gfx_BoosterFreqType =3D input[4=
];
> > -                     activity_monitor->Gfx_BoosterFreq =3D input[5];
> > -                     activity_monitor->Gfx_PD_Data_limit_c =3D input[6=
];
> > -                     activity_monitor->Gfx_PD_Data_error_coeff =3D inp=
ut[7];
> > -                     activity_monitor->Gfx_PD_Data_error_rate_coeff =
=3D input[8];
> > -                     break;
> > -             case 1: /* Fclk */
> > -                     activity_monitor->Fclk_FPS =3D input[1];
> > -                     activity_monitor->Fclk_MinActiveFreqType =3D inpu=
t[2];
> > -                     activity_monitor->Fclk_MinActiveFreq =3D input[3]=
;
> > -                     activity_monitor->Fclk_BoosterFreqType =3D input[=
4];
> > -                     activity_monitor->Fclk_BoosterFreq =3D input[5];
> > -                     activity_monitor->Fclk_PD_Data_limit_c =3D input[=
6];
> > -                     activity_monitor->Fclk_PD_Data_error_coeff =3D in=
put[7];
> > -                     activity_monitor->Fclk_PD_Data_error_rate_coeff =
=3D input[8];
> > -                     break;
> > -             default:
> > -                     return -EINVAL;
> > -             }
> > +     switch (input[0]) {
> > +     case 0: /* Gfxclk */
> > +             activity_monitor->Gfx_FPS =3D input[1];
> > +             activity_monitor->Gfx_MinActiveFreqType =3D input[2];
> > +             activity_monitor->Gfx_MinActiveFreq =3D input[3];
> > +             activity_monitor->Gfx_BoosterFreqType =3D input[4];
> > +             activity_monitor->Gfx_BoosterFreq =3D input[5];
> > +             activity_monitor->Gfx_PD_Data_limit_c =3D input[6];
> > +             activity_monitor->Gfx_PD_Data_error_coeff =3D input[7];
> > +             activity_monitor->Gfx_PD_Data_error_rate_coeff =3D input[=
8];
> > +             break;
> > +     case 1: /* Fclk */
> > +             activity_monitor->Fclk_FPS =3D input[1];
> > +             activity_monitor->Fclk_MinActiveFreqType =3D input[2];
> > +             activity_monitor->Fclk_MinActiveFreq =3D input[3];
> > +             activity_monitor->Fclk_BoosterFreqType =3D input[4];
> > +             activity_monitor->Fclk_BoosterFreq =3D input[5];
> > +             activity_monitor->Fclk_PD_Data_limit_c =3D input[6];
> > +             activity_monitor->Fclk_PD_Data_error_coeff =3D input[7];
> > +             activity_monitor->Fclk_PD_Data_error_rate_coeff =3D input=
[8];
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                        SMU_TABLE_ACTIVITY_MONITOR_COE=
FF,
> > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                        (void *)(&activity_monitor_ext=
ernal),
> > -                                        true);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to set activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external),
> > +                                true);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to set activity moni=
tor!", __func__);
> > +             return ret;
> >       }
> >
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > +     return ret;
> > +}
> >
> > -     if (workload_type < 0)
> > -             return -EINVAL;
> > +static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> > +                                           u32 workload_mask)
> > +{
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int workload_type, ret;
> >
> > -     workload_mask =3D 1 << workload_type;
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> >
> >       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving pr=
ofile */
> >       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13, 0, 0) &&
> > @@ -2658,26 +2652,29 @@ static int smu_v13_0_0_set_power_profile_mode(s=
truct smu_context *smu,
> >                                                              CMN2ASIC_M=
APPING_WORKLOAD,
> >                                                              PP_SMC_POW=
ER_PROFILE_POWERSAVING);
> >               if (workload_type >=3D 0)
> > -                     workload_mask |=3D 1 << workload_type;
> > +                     backend_workload_mask |=3D 1 << workload_type;
> > +     }
> > +
> > +     if (custom_enabled) {
> > +             ret =3D smu_v13_0_0_set_power_profile_mode_coeff(smu,
> > +                                                            smu->custo=
m_profile_input,
> > +                                                            smu->custo=
m_profile_size);
> > +             if (ret)
> > +                     return ret;
> >       }
> >
> > -     smu->workload_mask |=3D workload_mask;
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > -                                            SMU_MSG_SetWorkloadMask,
> > -                                            smu->workload_mask,
> > -                                            NULL);
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
> > +                                           SMU_MSG_SetWorkloadMask,
> > +                                           backend_workload_mask,
> > +                                           NULL);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%0=
8x\n",
> > +                     workload_mask);
> > +             return ret;
> >       }
> >
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> > +
> >       return ret;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index c5d3e25cc967..225629eb9422 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -2528,79 +2528,89 @@ do {                                           =
                                                       \
> >       return result;
> >  }
> >
> > -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,=
 long *input, uint32_t size)
> > +static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context=
 *smu,
> > +                                                 long *input, uint32_t=
 size)
> >  {
> >
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > -     int workload_type, ret =3D 0;
> > +     int ret;
> > +
> > +     if (size !=3D 8)
> > +             return -EINVAL;
> >
> > -     smu->power_profile_mode =3D input[size];
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORK=
LOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external), =
false);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to get activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     switch (input[0]) {
> > +     case 0: /* Gfxclk */
> > +             activity_monitor->Gfx_ActiveHystLimit =3D input[1];
> > +             activity_monitor->Gfx_IdleHystLimit =3D input[2];
> > +             activity_monitor->Gfx_FPS =3D input[3];
> > +             activity_monitor->Gfx_MinActiveFreqType =3D input[4];
> > +             activity_monitor->Gfx_BoosterFreqType =3D input[5];
> > +             activity_monitor->Gfx_MinActiveFreq =3D input[6];
> > +             activity_monitor->Gfx_BoosterFreq =3D input[7];
> > +             break;
> > +     case 1: /* Fclk */
> > +             activity_monitor->Fclk_ActiveHystLimit =3D input[1];
> > +             activity_monitor->Fclk_IdleHystLimit =3D input[2];
> > +             activity_monitor->Fclk_FPS =3D input[3];
> > +             activity_monitor->Fclk_MinActiveFreqType =3D input[4];
> > +             activity_monitor->Fclk_BoosterFreqType =3D input[5];
> > +             activity_monitor->Fclk_MinActiveFreq =3D input[6];
> > +             activity_monitor->Fclk_BoosterFreq =3D input[7];
> > +             break;
> > +     default:
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             if (size !=3D 8)
> > -                     return -EINVAL;
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORK=
LOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external), =
true);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to set activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, =
WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor_externa=
l), false);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     return ret;
> > +}
> >
> > -             switch (input[0]) {
> > -             case 0: /* Gfxclk */
> > -                     activity_monitor->Gfx_ActiveHystLimit =3D input[1=
];
> > -                     activity_monitor->Gfx_IdleHystLimit =3D input[2];
> > -                     activity_monitor->Gfx_FPS =3D input[3];
> > -                     activity_monitor->Gfx_MinActiveFreqType =3D input=
[4];
> > -                     activity_monitor->Gfx_BoosterFreqType =3D input[5=
];
> > -                     activity_monitor->Gfx_MinActiveFreq =3D input[6];
> > -                     activity_monitor->Gfx_BoosterFreq =3D input[7];
> > -                     break;
> > -             case 1: /* Fclk */
> > -                     activity_monitor->Fclk_ActiveHystLimit =3D input[=
1];
> > -                     activity_monitor->Fclk_IdleHystLimit =3D input[2]=
;
> > -                     activity_monitor->Fclk_FPS =3D input[3];
> > -                     activity_monitor->Fclk_MinActiveFreqType =3D inpu=
t[4];
> > -                     activity_monitor->Fclk_BoosterFreqType =3D input[=
5];
> > -                     activity_monitor->Fclk_MinActiveFreq =3D input[6]=
;
> > -                     activity_monitor->Fclk_BoosterFreq =3D input[7];
> > -                     break;
> > -             default:
> > -                     return -EINVAL;
> > -             }
> > +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> > +                                           u32 workload_mask)
> > +{
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int ret;
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF, =
WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                    (void *)(&activity_monitor_externa=
l), true);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to set activ=
ity monitor!", __func__);
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> > +
> > +     if (custom_enabled) {
> > +             ret =3D smu_v13_0_7_set_power_profile_mode_coeff(smu,
> > +                                                            smu->custo=
m_profile_input,
> > +                                                            smu->custo=
m_profile_size);
> > +             if (ret)
> >                       return ret;
> > -             }
> >       }
> >
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > -     if (workload_type < 0)
> > -             return -EINVAL;
> > -
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> > -                                 smu->workload_mask, NULL);
> > +                                           backend_workload_mask, NULL=
);
> >
> > -     if (ret)
> > -             dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%0=
8x\n",
> > +                     workload_mask);
> > +             return ret;
> > +     }
> > +
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > index 59b369eff30f..272a44b6faf7 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > @@ -1717,89 +1717,100 @@ static int smu_v14_0_2_get_power_profile_mode(=
struct smu_context *smu,
> >       return size;
> >  }
> >
> > -static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> > -                                           long *input,
> > -                                           uint32_t size)
> > +static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context=
 *smu,
> > +                                                 long *input,
> > +                                                 uint32_t size)
> >  {
> >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >               &(activity_monitor_external.DpmActivityMonitorCoeffInt);
> > -     int workload_type, ret =3D 0;
> > -     uint32_t current_profile_mode =3D smu->power_profile_mode;
> > -     smu->power_profile_mode =3D input[size];
> > +     int ret;
> >
> > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
, smu->power_profile_mode);
> > +     if (size !=3D 9)
> >               return -EINVAL;
> > +
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external),
> > +                                false);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to get activity moni=
tor!", __func__);
> > +             return ret;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > -             if (size !=3D 9)
> > -                     return -EINVAL;
> > +     switch (input[0]) {
> > +     case 0: /* Gfxclk */
> > +             activity_monitor->Gfx_FPS =3D input[1];
> > +             activity_monitor->Gfx_MinActiveFreqType =3D input[2];
> > +             activity_monitor->Gfx_MinActiveFreq =3D input[3];
> > +             activity_monitor->Gfx_BoosterFreqType =3D input[4];
> > +             activity_monitor->Gfx_BoosterFreq =3D input[5];
> > +             activity_monitor->Gfx_PD_Data_limit_c =3D input[6];
> > +             activity_monitor->Gfx_PD_Data_error_coeff =3D input[7];
> > +             activity_monitor->Gfx_PD_Data_error_rate_coeff =3D input[=
8];
> > +             break;
> > +     case 1: /* Fclk */
> > +             activity_monitor->Fclk_FPS =3D input[1];
> > +             activity_monitor->Fclk_MinActiveFreqType =3D input[2];
> > +             activity_monitor->Fclk_MinActiveFreq =3D input[3];
> > +             activity_monitor->Fclk_BoosterFreqType =3D input[4];
> > +             activity_monitor->Fclk_BoosterFreq =3D input[5];
> > +             activity_monitor->Fclk_PD_Data_limit_c =3D input[6];
> > +             activity_monitor->Fclk_PD_Data_error_coeff =3D input[7];
> > +             activity_monitor->Fclk_PD_Data_error_rate_coeff =3D input=
[8];
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                        SMU_TABLE_ACTIVITY_MONITOR_COE=
FF,
> > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                        (void *)(&activity_monitor_ext=
ernal),
> > -                                        false);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to get activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > +     ret =3D smu_cmn_update_table(smu,
> > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > +                                (void *)(&activity_monitor_external),
> > +                                true);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "[%s] Failed to set activity moni=
tor!", __func__);
> > +             return ret;
> > +     }
> >
> > -             switch (input[0]) {
> > -             case 0: /* Gfxclk */
> > -                     activity_monitor->Gfx_FPS =3D input[1];
> > -                     activity_monitor->Gfx_MinActiveFreqType =3D input=
[2];
> > -                     activity_monitor->Gfx_MinActiveFreq =3D input[3];
> > -                     activity_monitor->Gfx_BoosterFreqType =3D input[4=
];
> > -                     activity_monitor->Gfx_BoosterFreq =3D input[5];
> > -                     activity_monitor->Gfx_PD_Data_limit_c =3D input[6=
];
> > -                     activity_monitor->Gfx_PD_Data_error_coeff =3D inp=
ut[7];
> > -                     activity_monitor->Gfx_PD_Data_error_rate_coeff =
=3D input[8];
> > -                     break;
> > -             case 1: /* Fclk */
> > -                     activity_monitor->Fclk_FPS =3D input[1];
> > -                     activity_monitor->Fclk_MinActiveFreqType =3D inpu=
t[2];
> > -                     activity_monitor->Fclk_MinActiveFreq =3D input[3]=
;
> > -                     activity_monitor->Fclk_BoosterFreqType =3D input[=
4];
> > -                     activity_monitor->Fclk_BoosterFreq =3D input[5];
> > -                     activity_monitor->Fclk_PD_Data_limit_c =3D input[=
6];
> > -                     activity_monitor->Fclk_PD_Data_error_coeff =3D in=
put[7];
> > -                     activity_monitor->Fclk_PD_Data_error_rate_coeff =
=3D input[8];
> > -                     break;
> > -             default:
> > -                     return -EINVAL;
> > -             }
> > +     return ret;
> > +}
> >
> > -             ret =3D smu_cmn_update_table(smu,
> > -                                        SMU_TABLE_ACTIVITY_MONITOR_COE=
FF,
> > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > -                                        (void *)(&activity_monitor_ext=
ernal),
> > -                                        true);
> > -             if (ret) {
> > -                     dev_err(smu->adev->dev, "[%s] Failed to set activ=
ity monitor!", __func__);
> > -                     return ret;
> > -             }
> > -     }
> > +static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> > +                                           u32 workload_mask)
> > +{
> > +     u32 backend_workload_mask =3D 0;
> > +     bool custom_enabled =3D false;
> > +     int ret;
> > +
> > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > +                                       &backend_workload_mask,
> > +                                       &custom_enabled);
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> > +     /* disable deep sleep if compute is enabled */
> > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
> >               smu_v14_0_deep_sleep_control(smu, false);
> > -     else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
> > +     else
> >               smu_v14_0_deep_sleep_control(smu, true);
> >
> > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -                                                    CMN2ASIC_MAPPING_W=
ORKLOAD,
> > -                                                    smu->power_profile=
_mode);
> > -     if (workload_type < 0)
> > -             return -EINVAL;
> > +     if (custom_enabled) {
> > +             ret =3D smu_v14_0_2_set_power_profile_mode_coeff(smu,
> > +                                                            smu->custo=
m_profile_input,
> > +                                                            smu->custo=
m_profile_size);
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
> > -                                                                      =
         smu->workload_mask, NULL);
> > +                                           backend_workload_mask, NULL=
);
> > +     if (ret) {
> > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x%0=
8x\n",
> > +                     workload_mask);
> > +             return ret;
> > +     }
> >
> > -     if (!ret)
> > -             smu_cmn_assign_power_profile(smu);
> > +     smu->backend_workload_mask =3D backend_workload_mask;
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu_cmn.c
> > index fd2aa949538e..91a3bf074f78 100644
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
> > @@ -1226,3 +1218,33 @@ void smu_cmn_generic_plpd_policy_desc(struct smu=
_dpm_policy *policy)
> >  {
> >       policy->desc =3D &xgmi_plpd_policy_desc;
> >  }
> > +
> > +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> > +                                    u32 workload_mask,
> > +                                    u32 *backend_workload_mask,
> > +                                    bool *custom_enabled)
> > +{
> > +     int workload_type;
> > +     u32 profile_mode;
> > +
> > +     *custom_enabled =3D false;
> > +     *backend_workload_mask =3D 0;
> > +
> > +     for (profile_mode =3D 0; profile_mode < PP_SMC_POWER_PROFILE_COUN=
T; profile_mode++) {
> > +             if (!(workload_mask & (1 << profile_mode)))
> > +                     continue;
> > +
> > +             /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > +             workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > +                                                            CMN2ASIC_M=
APPING_WORKLOAD,
> > +                                                            profile_mo=
de);
> > +
> > +             if (workload_type < 0)
> > +                     continue;
> > +
> > +             *backend_workload_mask |=3D 1 << workload_type;
> > +
> > +             if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)
> > +                     *custom_enabled =3D true;
> > +     }
> > +}
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/a=
md/pm/swsmu/smu_cmn.h
> > index 8a801e389659..8d40c02efa00 100644
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
> > @@ -149,5 +147,10 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_d=
evice *adev);
> >  void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
> >  void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
> >
> > +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> > +                                    u32 workload_mask,
> > +                                    u32 *backend_workload_mask,
> > +                                    bool *custom_enabled);
> > +
> >  #endif
> >  #endif
