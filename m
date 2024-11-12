Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41EED42B88
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 14:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B63F10E308;
	Tue, 12 Nov 2024 14:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b8zqW/6t";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA9710E308
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 14:25:21 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2e9c1e7268eso99585a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731421521; x=1732026321; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XtzsYotIMZZ/pWFoa/bi3h2KZrpRfrxYYeLaaM/Fup8=;
 b=b8zqW/6tl0dyslPSYn4Bmh79anr595TJM82NsQ/M0kj5/SwmjcpxOO/0ZisgO42K7o
 1qPtpfDpffGmAcuNdOrMDYEX3aS57WrsNm/VDuUy3fz+YET4wHjn/s7hZyMB5fK3bq2K
 tLK+H5+jKwZjMYYg0eGGRkPN0+9sFL9ss96OsTl7hTvaNETU4QikILnLXRopisNS1tHW
 rdafpthV1Y2+vlJxmQgezPoAp7yUvUUwGn6aCa/xFl83Zg4jJqsPNqgI9eOESKOHACPU
 UXUB+QsBWHqmZxXN8pswGCbc17Np862hLk0aBH6kuHmNNiUZZmfMUN5PuMbOl47JZCEV
 HtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731421521; x=1732026321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XtzsYotIMZZ/pWFoa/bi3h2KZrpRfrxYYeLaaM/Fup8=;
 b=hTNuKTwWLNCOkTXvC+OtbL2Zo/BNf7Od/g52wsPA5jCeUccHQLL+PJjVb2fhwCYeUc
 ldh9efkvBIYjP4pgAlTteFnANfL/KDWuBepH+SiNFPYPCbPbX97H9EPTuSmLfvLCzsIC
 QsHF49pnfu8XajL3YLlfQXNh2Wt1T5cl8IK4BZzewWkk/OHG/RjdIHzDG1+8kv35KxEJ
 W2SxgKksT8Cx3BhHsFol6I2kwumdpD9qmtBGnN12ki2aG49UKT+FeseX1+a4V3xT7+z1
 O5wOoOw1xnRBgw08o04JsJmPmDUOuAVkYQNdvRBFZ4RjxVjSAqkLkG28cDQuyyQJ2cuo
 EPjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZjP3sIhqPQAR/8wWxi2ZxQYYayhjGEe8K4wqa4ElX1cHxO/UVKsUDzMOIk+8Kxx/NIRPc0z+p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ8ipSVgzyCeIDPB7zg9mTJkK6zI9mB5L155v9H37Zm0iLgVh7
 7jzkCMP1OCv2sZfBN501bg0QmvmT/EF9h+uAhZFhYjt2xNaUqJTjvxXSomw5kxuPnflnoBIM7Hu
 +fW5VsQN8MHI1qvIrvJ07nCg8edY=
X-Google-Smtp-Source: AGHT+IG/LKy2MK2F3AR7TXw25eSTSB2aW4PnMkT2i+NpwhRmvqMZ7v4s+/Nj6+W2lDGWK2ZzvZjs4F9HI79pVz0SwoI=
X-Received: by 2002:a17:90b:4d0d:b0:2e2:9026:8bee with SMTP id
 98e67ed59e1d1-2e9b16aa2e8mr9073789a91.9.1731421521133; Tue, 12 Nov 2024
 06:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20241109053148.13617-1-alexander.deucher@amd.com>
 <4d3e76e0-51ae-4e07-bd41-5b272cd44466@amd.com>
In-Reply-To: <4d3e76e0-51ae-4e07-bd41-5b272cd44466@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Nov 2024 09:25:09 -0500
Message-ID: <CADnq5_ONqqBF7bcQfQJzkkSEEKPPuARSZn1WZLHr3yzhdF=2fQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix and simplify workload handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b947f90626b7fc63"
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

--000000000000b947f90626b7fc63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:18=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:

>
>
> On 11/9/2024 11:01 AM, Alex Deucher wrote:
> > smu->workload_mask is IP specific and should not be messed with in
> > the common code. The mask bits vary across SMU versions.
> >
> > Move all handling of smu->workload_mask in to the backends and
> > simplify the code.  Store the user's preference in
> smu->power_profile_mode
> > which will be reflected in sysfs.  For internal driver profile
> > switches for KFD or VCN, just update the workload mask so that the
> > user's preference is retained.  Remove all of the extra now unused
> > workload related elements in the smu structure.
> >
> > Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Kenneth Feng <kenneth.feng@amd.com>
> > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 ++++++------------
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-
> >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 ++--
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
> >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---
> >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  24 ++--
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
> >  12 files changed, 132 insertions(+), 170 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index c3a6b6f20455..162a3289855c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block
> *ip_block)
> >       INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
> >       atomic64_set(&smu->throttle_int_counter, 0);
> >       smu->watermarks_bitmap =3D 0;
> > -     smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -     smu->default_power_profile_mode =3D
> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -     smu->user_dpm_profile.user_workload_mask =3D 0;
> >
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> >               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> > @@ -1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block
> *ip_block)
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
> > -         !smu_is_workload_profile_available(smu,
> PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> > -             smu->driver_workload_mask =3D
> > -                     1 <<
> smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> > -     } else {
> > -             smu->driver_workload_mask =3D
> > -                     1 <<
> smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> > -             smu->default_power_profile_mode =3D
> PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > -     }
> > -
> > -     smu->workload_mask =3D smu->driver_workload_mask |
> > -
>  smu->user_dpm_profile.user_workload_mask;
> > -     smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -     smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > -     smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
> > -     smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
> > -     smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
> > -     smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
> > -     smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
> > +         !smu_is_workload_profile_available(smu,
> PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> > +             smu->power_profile_mode =3D
> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > +     else
> > +             smu->power_profile_mode =3D
> PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > +
> >       smu->display_config =3D &adev->pm.pm_display_cfg;
> >
> >       smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> > @@ -2252,24 +2228,23 @@ static int smu_enable_umd_pstate(void *handle,
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
,
> param_size);
> > +             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, param=
,
> param_size, enable);
> >
> >       return ret;
> >  }
> >
> >  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
> >                                         enum amd_dpm_forced_level level=
,
> > -                                       bool skip_display_settings,
> > -                                       bool init)
> > +                                       bool skip_display_settings)
> >  {
> >       int ret =3D 0;
> > -     int index =3D 0;
> >       long workload[1];
> >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> >
> > @@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struc=
t
> smu_context *smu,
> >       }
> >
> >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > -             smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex
> - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > +         smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> > +             workload[0] =3D smu->power_profile_mode;
> >
> > -             if (init || smu->power_profile_mode !=3D workload[0])
> > -                     smu_bump_power_profile_mode(smu, workload, 0);
> > +             smu_bump_power_profile_mode(smu, workload, 0, true);
> >       }
> >
> >       return ret;
> > @@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context
> *smu,
> >               ret =3D smu_pre_display_config_changed(smu);
> >               if (ret)
> >                       return ret;
> > -             ret =3D smu_adjust_power_state_dynamic(smu, level, false,
> false);
> > +             ret =3D smu_adjust_power_state_dynamic(smu, level, false)=
;
> >               break;
> >       case AMD_PP_TASK_COMPLETE_INIT:
> > -             ret =3D smu_adjust_power_state_dynamic(smu, level, true,
> true);
> > +             ret =3D smu_adjust_power_state_dynamic(smu, level, true);
> >               break;
> >       case AMD_PP_TASK_READJUST_POWER_STATE:
> > -             ret =3D smu_adjust_power_state_dynamic(smu, level, true,
> false);
> > +             ret =3D smu_adjust_power_state_dynamic(smu, level, true);
> >               break;
> >       default:
> >               break;
> > @@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,
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
> > @@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *handl=
e,
> >       if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
> >               return -EINVAL;
> >
> > -     if (!en) {
> > -             smu->driver_workload_mask &=3D ~(1 <<
> smu->workload_priority[type]);
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? i=
ndex
> - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > -     } else {
> > -             smu->driver_workload_mask |=3D (1 <<
> smu->workload_priority[type]);
> > -             index =3D fls(smu->workload_mask);
> > -             index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;
> > -             workload[0] =3D smu->workload_setting[index];
> > -     }
> > +     /* don't disable the user's preference */
> > +     if (!enable && type =3D=3D smu->power_profile_mode)
> > +             return 0;
> >
> > -     smu->workload_mask =3D smu->driver_workload_mask |
> > -
> smu->user_dpm_profile.user_workload_mask;
> > +     workload[0] =3D type;
> >
> >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > -             smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> > -             smu_bump_power_profile_mode(smu, workload, 0);
> > +         smu_dpm_ctx->dpm_level !=3D
> AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> > +             smu_bump_power_profile_mode(smu, workload, 0, enable);
> >
> >       return 0;
> >  }
> > @@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void
> *handle,
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
> > +             ret =3D smu_bump_power_profile_mode(smu, workload, 0, fal=
se);
>
> What if internal driver call has set the same profile preference? Once
> this is done, that setting is lost. There is a check to make sure that
> user setting is not lost, but the same is not done here and cannot be
> done with a single profile mode value.
>

Yeah, I think we need to ref count the workload hints so we keep the mask
up to date.

Alex



>
> Thanks,
> Lijo
>
> > +             if (ret)
> > +                     return ret;
> > +             /* set the new user preference */
> > +             ret =3D smu_bump_power_profile_mode(smu, param, param_siz=
e,
> true);
> > +             if (!ret)
> > +                     /* store the user's preference */
> > +                     smu->power_profile_mode =3D param[param_size];
> > +     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index fa93a8879113..cd2db06d752b 100644
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
> > @@ -557,12 +556,10 @@ struct smu_context {
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
> >       bool pm_enabled;
> >       bool is_apu;
> >
> > @@ -734,8 +731,10 @@ struct pptable_funcs {
> >        *                          create/set custom power profile modes=
.
> >        * &input: Power profile mode parameters.
> >        * &size: Size of &input.
> > +      * &enable: enable/disable the profile
> >        */
> > -     int (*set_power_profile_mode)(struct smu_context *smu, long
> *input, uint32_t size);
> > +     int (*set_power_profile_mode)(struct smu_context *smu, long *inpu=
t,
> > +                                   uint32_t size, bool enable);
> >
> >       /**
> >        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > index 4b36c230e43a..1e44cf6fec4b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct
> smu_context *smu,
> >
> >  static int arcturus_set_power_profile_mode(struct smu_context *smu,
> >                                          long *input,
> > -                                        uint32_t size)
> > +                                        uint32_t size,
> > +                                        bool enable)
> >  {
> >       DpmActivityMonitorCoeffInt_t activity_monitor;
> >       int workload_type =3D 0;
> > @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct
> smu_context *smu,
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
> > @@ -1520,18 +1522,18 @@ static int
> arcturus_set_power_profile_mode(struct smu_context *smu,
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
> >               dev_err(smu->adev->dev, "Fail to set workload type %d\n",
> workload_type);
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
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 211635dabed8..d944a9f954d0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct
> smu_context *smu, char *buf)
> >       return size;
> >  }
> >
> > -static int navi10_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size)
> > +static int navi10_set_power_profile_mode(struct smu_context *smu, long
> *input,
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
,
> smu->power_profile_mode);
> > +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 10)
> >                       return -EINVAL;
> >
> > @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct
> smu_context *smu, long *input, u
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >
> CMN2ASIC_MAPPING_WORKLOAD,
> > -
> smu->power_profile_mode);
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
> >               dev_err(smu->adev->dev, "[%s] Failed to set work load
> mask!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 844532a9b641..4967e087088b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -1704,22 +1704,23 @@ static int
> sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
> >       return size;
> >  }
> >
> > -static int sienna_cichlid_set_power_profile_mode(struct smu_context
> *smu, long *input, uint32_t size)
> > +static int sienna_cichlid_set_power_profile_mode(struct smu_context
> *smu,
> > +                                              long *input, uint32_t
> size,
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
,
> smu->power_profile_mode);
> > +     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 10)
> >                       return -EINVAL;
> >
> > @@ -1781,16 +1782,18 @@ static int
> sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >
> CMN2ASIC_MAPPING_WORKLOAD,
> > -
> smu->power_profile_mode);
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
> >               dev_err(smu->adev->dev, "[%s] Failed to set work load
> mask!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index f89c487dce72..b5dba4826f81 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct
> smu_context *smu,
> >       return size;
> >  }
> >
> > -static int vangogh_set_power_profile_mode(struct smu_context *smu, lon=
g
> *input, uint32_t size)
> > +static int vangogh_set_power_profile_mode(struct smu_context *smu, lon=
g
> *input,
> > +                                       uint32_t size, bool enable)
> >  {
> >       int workload_type, ret;
> >       uint32_t profile_mode =3D input[size];
> > @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct
> smu_context *smu, long *input,
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
t
> smu_context *smu, long *input,
> >               return -EINVAL;
> >       }
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
> >                                   smu->workload_mask,
> >                                   NULL);
> > -     if (ret) {
> > +     if (ret)
> >               dev_err_once(smu->adev->dev, "Fail to set workload type
> %d\n",
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
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > index 75a9ea87f419..2d1eae79ab9d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct
> smu_context *smu,
> >       return ret;
> >  }
> >
> > -static int renoir_set_power_profile_mode(struct smu_context *smu, long
> *input, uint32_t size)
> > +static int renoir_set_power_profile_mode(struct smu_context *smu, long
> *input,
> > +                                      uint32_t size, bool enable)
> >  {
> >       int workload_type, ret;
> >       uint32_t profile_mode =3D input[size];
> > @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct
> smu_context *smu, long *input, u
> >       }
> >
> >       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAV=
ING)
> > +         profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)
> >               return 0;
> >
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct
> smu_context *smu, long *input, u
> >               return -EINVAL;
> >       }
> >
> > +     if (enable)
> > +             smu->workload_mask |=3D (1 << workload_type);
> > +     else
> > +             smu->workload_mask &=3D ~(1 << workload_type);
> >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_ActiveProcessNotify,
> >                                   smu->workload_mask,
> >                                   NULL);
> > -     if (ret) {
> > +     if (ret)
> >               dev_err_once(smu->adev->dev, "Fail to set workload type
> %d\n", workload_type);
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
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index 80c6b1e523aa..3cc734331891 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -2573,22 +2573,22 @@ static int
> smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
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
,
> smu->power_profile_mode);
> > +     if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 9)
> >                       return -EINVAL;
> >
> > @@ -2641,13 +2641,18 @@ static int
> smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >
> CMN2ASIC_MAPPING_WORKLOAD,
> > -
> smu->power_profile_mode);
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
> >       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving
> profile */
> >       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13,
> 0, 0) &&
> >            ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
> > @@ -2658,25 +2663,13 @@ static int
> smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
> >
> CMN2ASIC_MAPPING_WORKLOAD,
> >
> PP_SMC_POWER_PROFILE_POWERSAVING);
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
> > -             if (smu->power_profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_POWERSAVING) {
> > -                     workload_type =3D smu_cmn_to_asic_specific_index(=
smu,
> > -
> CMN2ASIC_MAPPING_WORKLOAD,
> > -
> PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> > -                     smu->power_profile_mode =3D smu->workload_mask & =
(1
> << workload_type)
> > -
>      ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> > -
>      : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > -             }
> > -     }
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index c5d3e25cc967..1aafd23857f0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -2528,22 +2528,23 @@ do {
>                                                       \
> >       return result;
> >  }
> >
> > -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> long *input, uint32_t size)
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
,
> smu->power_profile_mode);
> > +     if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 8)
> >                       return -EINVAL;
> >
> > @@ -2590,17 +2591,19 @@ static int
> smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >
> CMN2ASIC_MAPPING_WORKLOAD,
> > -
> smu->power_profile_mode);
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
> >               dev_err(smu->adev->dev, "[%s] Failed to set work load
> mask!", __func__);
> > -     else
> > -             smu_cmn_assign_power_profile(smu);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > index 59b369eff30f..695480833603 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > @@ -1719,21 +1719,22 @@ static int
> smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
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
> >       uint32_t current_profile_mode =3D smu->power_profile_mode;
> > -     smu->power_profile_mode =3D input[size];
> >
> > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> smu->power_profile_mode);
> > +     if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > +             dev_err(smu->adev->dev, "Invalid power profile mode %d\n"=
,
> profile_mode);
> >               return -EINVAL;
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > +     if (enable && profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> >               if (size !=3D 9)
> >                       return -EINVAL;
> >
> > @@ -1783,7 +1784,7 @@ static int
> smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> >               }
> >       }
> >
> > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> > +     if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE)
> >               smu_v14_0_deep_sleep_control(smu, false);
> >       else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
> >               smu_v14_0_deep_sleep_control(smu, true);
> > @@ -1791,15 +1792,16 @@ static int
> smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
> >       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >       workload_type =3D smu_cmn_to_asic_specific_index(smu,
> >
> CMN2ASIC_MAPPING_WORKLOAD,
> > -
> smu->power_profile_mode);
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
> > -
>        smu->workload_mask, NULL);
> > -
> > -     if (!ret)
> > -             smu_cmn_assign_power_profile(smu);
> > +                                           smu->workload_mask, NULL);
> >
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
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
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > index 8a801e389659..1de685defe85 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table,
> uint8_t frev, uint8_t crev);
> >  int smu_cmn_set_mp1_state(struct smu_context *smu,
> >                         enum pp_mp1_state mp1_state);
> >
> > -void smu_cmn_assign_power_profile(struct smu_context *smu);
> > -
> >  /*
> >   * Helper function to make sysfs_emit_at() happy. Align buf to
> >   * the current page boundary and record the offset.
>

--000000000000b947f90626b7fc63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Nov 12, 2024 at 1:18=E2=80=AFAM L=
azar, Lijo &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@amd.com</a>=
&gt; wrote:</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
<br>
On 11/9/2024 11:01 AM, Alex Deucher wrote:<br>
&gt; smu-&gt;workload_mask is IP specific and should not be messed with in<=
br>
&gt; the common code. The mask bits vary across SMU versions.<br>
&gt; <br>
&gt; Move all handling of smu-&gt;workload_mask in to the backends and<br>
&gt; simplify the code.=C2=A0 Store the user&#39;s preference in smu-&gt;po=
wer_profile_mode<br>
&gt; which will be reflected in sysfs.=C2=A0 For internal driver profile<br=
>
&gt; switches for KFD or VCN, just update the workload mask so that the<br>
&gt; user&#39;s preference is retained.=C2=A0 Remove all of the extra now u=
nused<br>
&gt; workload related elements in the smu structure.<br>
&gt; <br>
&gt; Fixes: 8cc438be5d49 (&quot;drm/amd/pm: correct the workload setting&qu=
ot;)<br>
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; Cc: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com" target=3D=
"_blank">kenneth.feng@amd.com</a>&gt;<br>
&gt; Cc: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com" target=3D"_bl=
ank">lijo.lazar@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c=C2=A0 =C2=A0 =C2=A0| 1=
08 ++++++------------<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |=C2=A0 11 +-<br>
&gt;=C2=A0 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |=C2=A0 20 ++--<br=
>
&gt;=C2=A0 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c=C2=A0 =C2=A0|=C2=A0 =
20 ++--<br>
&gt;=C2=A0 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c=C2=A0 =C2=A0|=C2=A0 =
21 ++--<br>
&gt;=C2=A0 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c=C2=A0 |=C2=A0 17 +-=
-<br>
&gt;=C2=A0 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c=C2=A0 =C2=A0|=C2=A0 =
17 +--<br>
&gt;=C2=A0 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c=C2=A0 |=C2=A0 33 ++=
+---<br>
&gt;=C2=A0 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c=C2=A0 |=C2=A0 21 ++=
--<br>
&gt;=C2=A0 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c=C2=A0 |=C2=A0 24 ++=
--<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A08 --<br>
&gt;=C2=A0 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A02 -<br>
&gt;=C2=A0 12 files changed, 132 insertions(+), 170 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index c3a6b6f20455..162a3289855c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block *i=
p_block)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&amp;smu-&gt;interrupt_work, smu_i=
nterrupt_work_fn);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic64_set(&amp;smu-&gt;throttle_int_count=
er, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;watermarks_bitmap =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D PP_SMC_POWER_PROFI=
LE_BOOTUP_DEFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;default_power_profile_mode =3D PP_SMC_POW=
ER_PROFILE_BOOTUP_DEFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;user_dpm_profile.user_workload_mask =3D 0=
;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev-&gt;vcn.num_vcn_in=
st; i++)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&amp;=
smu-&gt;smu_power.power_gate.vcn_gated[i], 1);<br>
&gt; @@ -1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block =
*ip_block)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&amp;smu-&gt;smu_power.power_gate=
.vpe_gated, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_set(&amp;smu-&gt;smu_power.power_gate=
.umsch_mm_gated, 1);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT] =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D] =3D 1;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_PO=
WERSAVING] =3D 2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_VI=
DEO] =3D 3;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_VR=
] =3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_CO=
MPUTE] =3D 5;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_CU=
STOM] =3D 6;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;is_apu ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!smu_is_workload_profile_available(=
smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_worklo=
ad_mask =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01 &lt;&lt; smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_worklo=
ad_mask =3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01 &lt;&lt; smu-&gt;workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN=
3D];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;default_power=
_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask =3D smu-&gt;driver_workload=
_mask |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;user_dpm_profile.user_=
workload_mask;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[0] =3D PP_SMC_POWER_PROF=
ILE_BOOTUP_DEFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[1] =3D PP_SMC_POWER_PROF=
ILE_FULLSCREEN3D;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[2] =3D PP_SMC_POWER_PROF=
ILE_POWERSAVING;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[3] =3D PP_SMC_POWER_PROF=
ILE_VIDEO;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[4] =3D PP_SMC_POWER_PROF=
ILE_VR;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[5] =3D PP_SMC_POWER_PROF=
ILE_COMPUTE;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_setting[6] =3D PP_SMC_POWER_PROF=
ILE_CUSTOM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!smu_is_workload_profile_available(=
smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile=
_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile=
_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;display_config =3D &amp;adev-&gt;pm.=
pm_display_cfg;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;smu_dpm.dpm_level =3D AMD_DPM_FORCED=
_LEVEL_AUTO;<br>
&gt; @@ -2252,24 +2228,23 @@ static int smu_enable_umd_pstate(void *handle,=
<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int smu_bump_power_profile_mode(struct smu_context *smu,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long=
 *param,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
32_t param_size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long *param,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t param_siz=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;ppt_funcs-&gt;set_power_profile_=
mode)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu-&gt;ppt_f=
uncs-&gt;set_power_profile_mode(smu, param, param_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu-&gt;ppt_f=
uncs-&gt;set_power_profile_mode(smu, param, param_size, enable);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int smu_adjust_power_state_dynamic(struct smu_context *sm=
u,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0enum amd_dpm_forced_level level,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
skip_display_settings,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
init)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =
skip_display_settings)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int index =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long workload[1];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct smu_dpm_context *smu_dpm_ctx =3D &amp=
;(smu-&gt;smu_dpm);<br>
&gt;=C2=A0 <br>
&gt; @@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(stru=
ct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu_dpm_ctx-&gt;dpm_level !=3D AMD_DPM_F=
ORCED_LEVEL_MANUAL &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm_l=
evel !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&gt=
;workload_mask);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &gt; =
0 &amp;&amp; index &lt;=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu-&=
gt;workload_setting[index];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm_level !=3D AMD_=
DPM_FORCED_LEVEL_PERF_DETERMINISM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu-&=
gt;power_profile_mode;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (init || smu-&gt;p=
ower_profile_mode !=3D workload[0])<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0smu_bump_power_profile_mode(smu, workload, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_bump_power_profil=
e_mode(smu, workload, 0, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; @@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context =
*smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_pre_=
display_config_changed(smu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_po=
wer_state_dynamic(smu, level, false, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_po=
wer_state_dynamic(smu, level, false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_PP_TASK_COMPLETE_INIT:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_po=
wer_state_dynamic(smu, level, true, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_po=
wer_state_dynamic(smu, level, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_PP_TASK_READJUST_POWER_STATE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_po=
wer_state_dynamic(smu, level, true, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_adjust_po=
wer_state_dynamic(smu, level, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; @@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int smu_switch_power_profile(void *handle,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum PP_SMC_POWER_PR=
OFILE type,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool en)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct smu_context *smu =3D handle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct smu_dpm_context *smu_dpm_ctx =3D &amp=
;(smu-&gt;smu_dpm);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long workload[1];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t index;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt=
;pm.dpm_enabled)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; @@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *hand=
le,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(type &lt; PP_SMC_POWER_PROFILE_CUSTOM)=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!en) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_worklo=
ad_mask &amp;=3D ~(1 &lt;&lt; smu-&gt;workload_priority[type]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&gt=
;workload_mask);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &gt; =
0 &amp;&amp; index &lt;=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu-&=
gt;workload_setting[index];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_worklo=
ad_mask |=3D (1 &lt;&lt; smu-&gt;workload_priority[type]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&gt=
;workload_mask);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index =3D index &lt;=
=3D WORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu-&=
gt;workload_setting[index];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* don&#39;t disable the user&#39;s preference */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!enable &amp;&amp; type =3D=3D smu-&gt;power_=
profile_mode)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask =3D smu-&gt;driver_workload=
_mask |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 smu-&gt;user_dpm_profile.user_workload_mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0workload[0] =3D type;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu_dpm_ctx-&gt;dpm_level !=3D AMD_DPM_F=
ORCED_LEVEL_MANUAL &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm_l=
evel !=3D AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_bump_power_profil=
e_mode(smu, workload, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_dpm_ctx-&gt;dpm_level !=3D AMD_=
DPM_FORCED_LEVEL_PERF_DETERMINISM)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_bump_power_profil=
e_mode(smu, workload, 0, enable);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; @@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void *ha=
ndle,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t para=
m_size)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct smu_context *smu =3D handle;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0long workload[1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt=
;pm.dpm_enabled ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!smu-&gt;ppt_funcs-&gt;set_pow=
er_profile_mode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;user_dpm_profile.user_workload_mask &=
amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; smu-&gt;workload_priority[par=
am[param_size]]))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;user_dpm_profile.user_workload_mask =3D<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; smu-&gt;w=
orkload_priority[param[param_size]]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask =3D smu-&gt;user_dpm_profil=
e.user_workload_mask |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;driver_worklo=
ad_mask;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ret =3D smu_bump_power_profile_mode(smu, param, p=
aram_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (param[param_size] !=3D smu-&gt;power_profile_=
mode) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear the old user=
 preference */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0workload[0] =3D smu-&=
gt;power_profile_mode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_bump_powe=
r_profile_mode(smu, workload, 0, false);<br>
<br>
What if internal driver call has set the same profile preference? Once<br>
this is done, that setting is lost. There is a check to make sure that<br>
user setting is not lost, but the same is not done here and cannot be<br>
done with a single profile mode value.<br></blockquote><div><br></div><div>=
Yeah, I think we need to ref count the workload hints so we keep the mask u=
p to date.</div><div><br></div><div>Alex<br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set the new user p=
reference */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_bump_powe=
r_profile_mode(smu, param, param_size, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* store the user&#39;s preference */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0smu-&gt;power_profile_mode =3D param[param_size];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/g=
pu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; index fa93a8879113..cd2db06d752b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* user clock state information */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t clk_mask[SMU_CLK_COUNT];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t clk_dependency;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t user_workload_mask;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define SMU_TABLE_INIT(tables, table_id, s, a, d)=C2=A0 =C2=A0 \=
<br>
&gt; @@ -557,12 +556,10 @@ struct smu_context {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t hard_min_uclk_req_from_dal;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool disable_uclk_switch;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* backend specific workload mask */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t workload_mask;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t driver_workload_mask;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t workload_priority[WORKLOAD_POLICY_MAX];<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t workload_setting[WORKLOAD_POLICY_MAX];<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0/* default/user workload preference */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t power_profile_mode;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t default_power_profile_mode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool pm_enabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_apu;<br>
&gt;=C2=A0 <br>
&gt; @@ -734,8 +731,10 @@ struct pptable_funcs {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create/set custom power pr=
ofile modes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * &amp;input: Power profile mode parameters=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * &amp;size: Size of &amp;input.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * &amp;enable: enable/disable the profile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int (*set_power_profile_mode)(struct smu_context =
*smu, long *input, uint32_t size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int (*set_power_profile_mode)(struct smu_context =
*smu, long *input,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t size, bool=
 enable);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @dpm_set_vcn_enable: Enable/disable VCN e=
ngine dynamic power<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
&gt; index 4b36c230e43a..1e44cf6fec4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
&gt; @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struc=
t smu_context *smu,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int arcturus_set_power_profile_mode(struct smu_context *s=
mu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 long *input,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
32_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
32_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=
 enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffInt_t activity_monito=
r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type =3D 0;<br>
&gt; @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struc=
t smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUS=
TOM) &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (smu-&gt;smc_fw_version &gt;=3D 0x=
360d00)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(profile_mode =3D=3D PP_SMC_POWER_P=
ROFILE_CUSTOM) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(smu-&gt;smc_fw_version &gt;=3D 0x3=
60d00)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 10=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 <br>
&gt; @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(str=
uct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0SMU_MSG_SetWorkloadMask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0smu-&gt;workload_mask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;=
adev-&gt;dev, &quot;Fail to set workload type %d\n&quot;, workload_type);<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_profile(smu);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int arcturus_set_performance_level(struct smu_context *sm=
u,<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; index 211635dabed8..d944a9f954d0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struc=
t smu_context *smu, char *buf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return size;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int navi10_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)<br>
&gt; +static int navi10_set_power_profile_mode(struct smu_context *smu, lon=
g *input,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t si=
ze, bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffInt_t activity_monito=
r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt; PP_SMC_POWER_=
PROFILE_CUSTOM) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profile=
_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (profile_mode &gt; PP_SMC_POWER_PROFILE_CUSTOM=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SMC_=
POWER_PROFILE_CUSTOM) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 10=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 <br>
&gt; @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struc=
t smu_context *smu, long *input, u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0workload_type =3D smu_cmn_to_asic_specific_i=
ndex(smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2ASIC_MAPPING_WORKLOAD,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (workload_type &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_SetWorkloadMask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mas=
k, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;=
adev-&gt;dev, &quot;[%s] Failed to set work load mask!&quot;, __func__);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_=
profile(smu);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b=
/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
&gt; index 844532a9b641..4967e087088b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
&gt; @@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mo=
de(struct smu_context *smu, char *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return size;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int sienna_cichlid_set_power_profile_mode(struct smu_context *=
smu, long *input, uint32_t size)<br>
&gt; +static int sienna_cichlid_set_power_profile_mode(struct smu_context *=
smu,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 long *input, uint32_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffIntExternal_t activit=
y_monitor_external;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffInt_t *activity_monit=
or =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;(activity_m=
onitor_external.DpmActivityMonitorCoeffInt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret =3D 0;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt; PP_SMC_POWER_=
PROFILE_CUSTOM) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profile=
_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (profile_mode &gt; PP_SMC_POWER_PROFILE_CUSTOM=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SMC_=
POWER_PROFILE_CUSTOM) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 10=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 <br>
&gt; @@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mo=
de(struct smu_context *smu, long *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0workload_type =3D smu_cmn_to_asic_specific_i=
ndex(smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2ASIC_MAPPING_WORKLOAD,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (workload_type &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_SetWorkloadMask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mas=
k, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;=
adev-&gt;dev, &quot;[%s] Failed to set work load mask!&quot;, __func__);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_=
profile(smu);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; index f89c487dce72..b5dba4826f81 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c<br>
&gt; @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct=
 smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return size;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int vangogh_set_power_profile_mode(struct smu_context *smu, lo=
ng *input, uint32_t size)<br>
&gt; +static int vangogh_set_power_profile_mode(struct smu_context *smu, lo=
ng *input,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint3=
2_t size, bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt; @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct=
 smu_context *smu, long *input,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode =3D=3D PP_SMC_POWER_PROFILE=
_BOOTUP_DEFAULT ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0profile_mode =3D=3D PP_SMC_POWER_PR=
OFILE_POWERSAVING)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt; @@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(stru=
ct smu_context *smu, long *input,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_ActiveProcessNotify,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mas=
k,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err_once(smu=
-&gt;adev-&gt;dev, &quot;Fail to set workload type %d\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worklo=
ad_type);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_profile(smu);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int vangogh_set_soft_freq_limited_range(struct smu_contex=
t *smu,<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
&gt; index 75a9ea87f419..2d1eae79ab9d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
&gt; @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_cont=
ext *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int renoir_set_power_profile_mode(struct smu_context *smu, lon=
g *input, uint32_t size)<br>
&gt; +static int renoir_set_power_profile_mode(struct smu_context *smu, lon=
g *input,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t si=
ze, bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt; @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct sm=
u_context *smu, long *input, u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (profile_mode =3D=3D PP_SMC_POWER_PROFILE=
_BOOTUP_DEFAULT ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0profile_mode =3D=3D PP_SMC_POWER_PR=
OFILE_POWERSAVING)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt; @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct =
smu_context *smu, long *input, u<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_ActiveProcessNotify,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mas=
k,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err_once(smu=
-&gt;adev-&gt;dev, &quot;Fail to set workload type %d\n&quot;, workload_typ=
e);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_profile(smu);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int renoir_set_peak_clock_by_device(struct smu_context *s=
mu)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; index 80c6b1e523aa..3cc734331891 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; @@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(=
struct smu_context *smu,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int smu_v13_0_0_set_power_profile_mode(struct smu_context=
 *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0long *input,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffIntExternal_t activit=
y_monitor_external;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffInt_t *activity_monit=
or =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;(activity_m=
onitor_external.DpmActivityMonitorCoeffInt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 workload_mask;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt;=3D PP_SMC_POW=
ER_PROFILE_COUNT) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profile=
_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (profile_mode &gt;=3D PP_SMC_POWER_PROFILE_COU=
NT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SMC_=
POWER_PROFILE_CUSTOM) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 9)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 <br>
&gt; @@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(=
struct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0workload_type =3D smu_cmn_to_asic_specific_i=
ndex(smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2ASIC_MAPPING_WORKLOAD,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (workload_type &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0workload_mask =3D 1 &lt;&lt; workload_type;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D workload_mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~workload_mask;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Add optimizations for SMU13.0.0/10.=C2=A0=
 Reuse the power saving profile */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((amdgpu_ip_version(smu-&gt;adev, MP1_HWI=
P, 0) =3D=3D IP_VERSION(13, 0, 0) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((smu-&gt;adev-&gt;pm.fw_vers=
ion =3D=3D 0x004e6601) ||<br>
&gt; @@ -2658,25 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(=
struct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 C=
MN2ASIC_MAPPING_WORKLOAD,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
P_SMC_POWER_PROFILE_POWERSAVING);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (workload_typ=
e &gt;=3D 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0workload_mask |=3D 1 &lt;&lt; workload_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0smu-&gt;workload_mask |=3D 1 &lt;&lt; workload_type;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask |=3D workload_mask;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 SMU_MSG_SetWorkloadMask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 smu-&gt;workload_mask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_=
profile(smu);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_pro=
file_mode =3D=3D PP_SMC_POWER_PROFILE_POWERSAVING) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0workload_type =3D smu_cmn_to_asic_specific_index(smu,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2ASIC=
_MAPPING_WORKLOAD,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PP_SMC_P=
OWER_PROFILE_FULLSCREEN3D);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0smu-&gt;power_profile_mode =3D smu-&gt;workload_mask &amp; (1 &lt;&l=
t; workload_type)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? PP_SMC_POWER_PROFI=
LE_FULLSCREEN3D<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: PP_SMC_POWER_PROFI=
LE_BOOTUP_DEFAULT;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; index c5d3e25cc967..1aafd23857f0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; @@ -2528,22 +2528,23 @@ do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return result;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu=
, long *input, uint32_t size)<br>
&gt; +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0long *input, uint32_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffIntExternal_t activit=
y_monitor_external;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffInt_t *activity_monit=
or =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;(activity_m=
onitor_external.DpmActivityMonitorCoeffInt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret =3D 0;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt; PP_SMC_POWER_=
PROFILE_WINDOW3D) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profile=
_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (profile_mode &gt; PP_SMC_POWER_PROFILE_WINDOW=
3D) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SMC_=
POWER_PROFILE_CUSTOM) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 8)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 <br>
&gt; @@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(=
struct smu_context *smu, long *inp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0workload_type =3D smu_cmn_to_asic_specific_i=
ndex(smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2ASIC_MAPPING_WORKLOAD,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (workload_type &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_SetWorkloadMask,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mas=
k, NULL);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;=
adev-&gt;dev, &quot;[%s] Failed to set work load mask!&quot;, __func__);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_=
profile(smu);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; index 59b369eff30f..695480833603 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; @@ -1719,21 +1719,22 @@ static int smu_v14_0_2_get_power_profile_mode(=
struct smu_context *smu,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int smu_v14_0_2_set_power_profile_mode(struct smu_context=
 *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0long *input,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uint32_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool enable)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffIntExternal_t activit=
y_monitor_external;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DpmActivityMonitorCoeffInt_t *activity_monit=
or =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;(activity_m=
onitor_external.DpmActivityMonitorCoeffInt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t profile_mode =3D input[size];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int workload_type, ret =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t current_profile_mode =3D smu-&gt;po=
wer_profile_mode;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D input[size];<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode &gt;=3D PP_SMC_POW=
ER_PROFILE_COUNT) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, smu-&gt;power_profile=
_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (profile_mode &gt;=3D PP_SMC_POWER_PROFILE_COU=
NT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(smu-&gt;adev-=
&gt;dev, &quot;Invalid power profile mode %d\n&quot;, profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_POWE=
R_PROFILE_CUSTOM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable &amp;&amp; profile_mode =3D=3D PP_SMC_=
POWER_PROFILE_CUSTOM) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size !=3D 9)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 <br>
&gt; @@ -1783,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(st=
ruct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (smu-&gt;power_profile_mode =3D=3D PP_SMC_POWE=
R_PROFILE_COMPUTE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMP=
UTE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_v14_0_deep_s=
leep_control(smu, false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (current_profile_mode =3D=3D PP_SMC_=
POWER_PROFILE_COMPUTE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_v14_0_deep_s=
leep_control(smu, true);<br>
&gt; @@ -1791,15 +1792,16 @@ static int smu_v14_0_2_set_power_profile_mode(=
struct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PP=
LIB_*_BIT */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0workload_type =3D smu_cmn_to_asic_specific_i=
ndex(smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CMN2ASIC_MAPPING_WORKLOAD,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu-&gt;power_profile_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 profile_mode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (workload_type &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (enable)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 |=3D (1 &lt;&lt; workload_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workload_mask=
 &amp;=3D ~(1 &lt;&lt; workload_type);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_cmn_send_smc_msg_with_param(smu,=
 SMU_MSG_SetWorkloadMask,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu-&gt;workl=
oad_mask, NULL);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu_cmn_assign_power_=
profile(smu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu-&gt;workload_mask, NULL);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.c<br>
&gt; index fd2aa949538e..63c4f75fa118 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *s=
mu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -void smu_cmn_assign_power_profile(struct smu_context *smu)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0uint32_t index;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0index =3D fls(smu-&gt;workload_mask);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0index =3D index &gt; 0 &amp;&amp; index &lt;=3D W=
ORKLOAD_POLICY_MAX ? index - 1 : 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0smu-&gt;power_profile_mode =3D smu-&gt;workload_s=
etting[index];<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)<b=
r>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *p =3D NULL;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.h<br>
&gt; index 8a801e389659..1de685defe85 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
&gt; @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, ui=
nt8_t frev, uint8_t crev);<br>
&gt;=C2=A0 int smu_cmn_set_mp1_state(struct smu_context *smu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0enum pp_mp1_state mp1_state);<br>
&gt;=C2=A0 <br>
&gt; -void smu_cmn_assign_power_profile(struct smu_context *smu);<br>
&gt; -<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Helper function to make sysfs_emit_at() happy. Align buf=
 to<br>
&gt;=C2=A0 =C2=A0* the current page boundary and record the offset.<br>
</blockquote></div></div>

--000000000000b947f90626b7fc63--
