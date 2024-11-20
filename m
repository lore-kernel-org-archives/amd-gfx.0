Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33713D63954
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 14:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D521D10E013;
	Wed, 20 Nov 2024 14:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FaXdeKJX";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E295E10E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 14:18:37 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21206ad207cso2675795ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 06:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732112317; x=1732717117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I78b30rty2TO1dCipf1mbZihJPludIrFA/3zwYgrSKA=;
 b=FaXdeKJXEBcyFbN4QdGhQ5xxtXGpd/gSyNKmhmH8MMm7dXak3ht4r/7N1iUIlgYCeY
 3tnr990aUUDn4EOHO7d+5orq/OxPWOSbMJKgfCIISBK4/OngoVUposscAVVxXLkECNis
 LwfYCrUu+WpELWkJbIPr7N3d+Cix/Pt2IMZfGvJCryRtEQJv78OXJB2PufmWV34wd0v7
 ilh/JVpy982xe/Px2r+ax/KVC7sJ8WKAAXvHeIV7NBruDUWv0hoOetMFm1UGLTECBzCi
 po5mugkl/avpVC5Y/VFR4U+cGrkE+XL5gAr9RVqz9C4eLav8qGQ7R3VGbQqi1bNEPYEq
 cQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732112317; x=1732717117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I78b30rty2TO1dCipf1mbZihJPludIrFA/3zwYgrSKA=;
 b=Rtj/l6XFVNyShj35xCOgtMih+g8W5adoyUdok7kQpMyiFKum3/AHrdx/aUBD9iYDr2
 NgdJbxAX55XyzD+1UxhvnrXRpGa3V7gV6GFCas/6Xb/hFixNNLDMGCn8/5BnZtO7pfM2
 uDsPdhAIg3zCXhxCNyxce43CoZcn5tEei+EGJxubFyb+SQE6f1Cs97KBDxGBddtImOyu
 9r1+LdHYILodN0vPq0FlLYb3LOnuCbiHlMBHSA0oqhZ07L2onhimouUl7rshaRhb/49i
 0T2eqhuOaa9z5uN5BqCdSLbxpJLWHXRJg8uwCXuHvM9gJAT7VCwffQxBHiH00HnBkbee
 1b9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUbZaUK7VqFQAkyg2uQw6wjyJwPSqghz1Quy4gV3QQ4hzVpzHyZeZ7A/OXSqHn9/sjBA1JyxTm@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw30lpLmmca++WLxKH5dr+RYlCFd1JXEyFccmT3zV0YeJtYsy+V
 U9mbzJcpIIphLtGrHXOIY8BEPTkJVO0zTGgOryxc0HQmMwE0yjjDRcJ7PF2S15KlsZ22Tm4F+LG
 lKcC/bDmIcwBASjYbbB0jrntJS6o72w==
X-Gm-Gg: ASbGncvEazj3twuiRe2rOd4TYWRSeEw3GT2wPihgw0dpxsWQ8T39bGtGg2org5whshY
 CO5fmuNpnpMNmIKq8cSlWd4pRdpoxbug=
X-Google-Smtp-Source: AGHT+IHVTxZr3kSFr26fJhV4pYSXUELyWGiv3i9Tk0E5EQOiyNR3gzjDLDzZbhm8GeIbmiQ6VxxLN+4xt1ZBu86UCw4=
X-Received: by 2002:a17:903:22c5:b0:20c:c482:1d6d with SMTP id
 d9443c01a7336-2126a3726a6mr14723235ad.8.1732112316662; Wed, 20 Nov 2024
 06:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20241119174650.17856-1-alexander.deucher@amd.com>
 <404243a3-8d46-4e01-b604-b23e269b1008@amd.com>
 <CADnq5_Pz+tGBQNOTk4feQU-9t3LiFtVR3YDAPpY1CZ=3EimxjA@mail.gmail.com>
In-Reply-To: <CADnq5_Pz+tGBQNOTk4feQU-9t3LiFtVR3YDAPpY1CZ=3EimxjA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Nov 2024 09:18:24 -0500
Message-ID: <CADnq5_OiWN_p8ncGjqdKqfBL+b_=fzwqM+zY6U0heHKo0vpy1A@mail.gmail.com>
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

On Wed, Nov 20, 2024 at 9:10=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Nov 20, 2024 at 4:32=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> =
wrote:
> >
> >
> >
> > On 11/19/2024 11:16 PM, Alex Deucher wrote:
> > > smu->workload_mask is IP specific and should not be messed with in
> > > the common code. The mask bits vary across SMU versions.
> > >
> > > Move all handling of smu->workload_mask in to the backends and
> > > simplify the code.  Store the user's preference in smu->power_profile=
_mode
> > > which will be reflected in sysfs.  For internal driver profile
> > > switches for KFD or VCN, just update the workload mask so that the
> > > user's preference is retained.  Remove all of the extra now unused
> > > workload related elements in the smu structure.
> > >
> > > v2: use refcounts for workload profiles
> > > v3: rework based on feedback from Lijo
> > > v4: fix the refcount on failure, drop backend mask
> > > v5: rework custom handling
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Kenneth Feng <kenneth.feng@amd.com>
> > > Cc: Lijo Lazar <lijo.lazar@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 150 ++++++++++------
> > >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  15 +-
> > >  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 165 +++++++++-------=
-
> > >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 166 ++++++++++------=
-
> > >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 167 +++++++++++-----=
--
> > >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
> > >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
> > >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 162 +++++++++-------=
-
> > >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 137 ++++++++------
> > >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 163 +++++++++-------=
-
> > >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  25 +++
> > >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 +
> > >  12 files changed, 714 insertions(+), 524 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/=
drm/amd/pm/swsmu/amdgpu_smu.c
> > > index eb1e2473b36a..c7d76c652da3 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint3=
2_t limit);
> > >  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
> > >  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
> > >  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_sta=
te);
> > > +static void smu_power_profile_mode_get(struct smu_context *smu,
> > > +                                    enum PP_SMC_POWER_PROFILE profil=
e_mode);
> > > +static void smu_power_profile_mode_put(struct smu_context *smu,
> > > +                                    enum PP_SMC_POWER_PROFILE profil=
e_mode);
> > >
> > >  static int smu_sys_get_pp_feature_mask(void *handle,
> > >                                      char *buf)
> > > @@ -1268,8 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *=
ip_block)
> > >       INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
> > >       atomic64_set(&smu->throttle_int_counter, 0);
> > >       smu->watermarks_bitmap =3D 0;
> > > -     smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT=
;
> > > -     smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP=
_DEFAULT;
> > >
> > >       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> > >               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> > > @@ -1277,27 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block=
 *ip_block)
> > >       atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
> > >       atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
> > >
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D =
0;
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> > > -     smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
> > > -
> > >       if (smu->is_apu ||
> > >           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFIL=
E_FULLSCREEN3D))
> > > -             smu->workload_mask =3D 1 << smu->workload_prority[PP_SM=
C_POWER_PROFILE_BOOTUP_DEFAULT];
> > > +             smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP=
_DEFAULT;
> > >       else
> > > -             smu->workload_mask =3D 1 << smu->workload_prority[PP_SM=
C_POWER_PROFILE_FULLSCREEN3D];
> > > -
> > > -     smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAUL=
T;
> > > -     smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > > -     smu->workload_setting[2] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
> > > -     smu->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VIDEO;
> > > -     smu->workload_setting[4] =3D PP_SMC_POWER_PROFILE_VR;
> > > -     smu->workload_setting[5] =3D PP_SMC_POWER_PROFILE_COMPUTE;
> > > -     smu->workload_setting[6] =3D PP_SMC_POWER_PROFILE_CUSTOM;
> > > +             smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSC=
REEN3D;
> > > +     smu_power_profile_mode_get(smu, smu->power_profile_mode);
> > > +
> > >       smu->display_config =3D &adev->pm.pm_display_cfg;
> > >
> > >       smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> > > @@ -1350,6 +1338,11 @@ static int smu_sw_fini(struct amdgpu_ip_block =
*ip_block)
> > >               return ret;
> > >       }
> > >
> > > +     if (smu->custom_profile_params) {
> > > +             kfree(smu->custom_profile_params);
> > > +             smu->custom_profile_params =3D NULL;
> > > +     }
> > > +
> > >       smu_fini_microcode(smu);
> > >
> > >       return 0;
> > > @@ -2133,6 +2126,9 @@ static int smu_suspend(struct amdgpu_ip_block *=
ip_block)
> > >       if (!ret)
> > >               adev->gfx.gfx_off_entrycount =3D count;
> > >
> > > +     /* clear this on suspend so it will get reprogrammed on resume =
*/
> > > +     smu->workload_mask =3D 0;
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -2245,25 +2241,49 @@ static int smu_enable_umd_pstate(void *handle=
,
> > >  }
> > >
> > >  static int smu_bump_power_profile_mode(struct smu_context *smu,
> > > -                                        long *param,
> > > -                                        uint32_t param_size)
> > > +                                    long *custom_params,
> > > +                                    u32 custom_params_max_idx)
> > >  {
> > > -     int ret =3D 0;
> > > +     u32 workload_mask =3D 0;
> > > +     int i, ret =3D 0;
> > > +
> > > +     for (i =3D 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
> > > +             if (smu->workload_refcount[i])
> > > +                     workload_mask |=3D 1 << i;
> > > +     }
> > > +
> > > +     if (smu->workload_mask =3D=3D workload_mask)
> > > +             return 0;
> > >
> > >       if (smu->ppt_funcs->set_power_profile_mode)
> > > -             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, par=
am, param_size);
> > > +             ret =3D smu->ppt_funcs->set_power_profile_mode(smu, wor=
kload_mask,
> > > +                                                          custom_par=
ams,
> > > +                                                          custom_par=
ams_max_idx);
> > > +
> > > +     if (!ret)
> > > +             smu->workload_mask =3D workload_mask;
> > >
> > >       return ret;
> > >  }
> > >
> > > +static void smu_power_profile_mode_get(struct smu_context *smu,
> > > +                                    enum PP_SMC_POWER_PROFILE profil=
e_mode)
> > > +{
> > > +     smu->workload_refcount[profile_mode]++;
> > > +}
> > > +
> > > +static void smu_power_profile_mode_put(struct smu_context *smu,
> > > +                                    enum PP_SMC_POWER_PROFILE profil=
e_mode)
> > > +{
> > > +     if (smu->workload_refcount[profile_mode])
> > > +             smu->workload_refcount[profile_mode]--;
> > > +}
> > > +
> > >  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
> > >                                         enum amd_dpm_forced_level lev=
el,
> > > -                                       bool skip_display_settings,
> > > -                                       bool init)
> > > +                                       bool skip_display_settings)
> > >  {
> > >       int ret =3D 0;
> > > -     int index =3D 0;
> > > -     long workload[1];
> > >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> > >
> > >       if (!skip_display_settings) {
> > > @@ -2300,14 +2320,8 @@ static int smu_adjust_power_state_dynamic(stru=
ct smu_context *smu,
> > >       }
> > >
> > >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > > -             smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_D=
ETERMINISM) {
> > > -             index =3D fls(smu->workload_mask);
> > > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ?=
 index - 1 : 0;
> > > -             workload[0] =3D smu->workload_setting[index];
> > > -
> > > -             if (init || smu->power_profile_mode !=3D workload[0])
> > > -                     smu_bump_power_profile_mode(smu, workload, 0);
> > > -     }
> > > +         smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETER=
MINISM)
> > > +             smu_bump_power_profile_mode(smu, NULL, 0);
> > >
> > >       return ret;
> > >  }
> > > @@ -2326,13 +2340,13 @@ static int smu_handle_task(struct smu_context=
 *smu,
> > >               ret =3D smu_pre_display_config_changed(smu);
> > >               if (ret)
> > >                       return ret;
> > > -             ret =3D smu_adjust_power_state_dynamic(smu, level, fals=
e, false);
> > > +             ret =3D smu_adjust_power_state_dynamic(smu, level, fals=
e);
> > >               break;
> > >       case AMD_PP_TASK_COMPLETE_INIT:
> > > -             ret =3D smu_adjust_power_state_dynamic(smu, level, true=
, true);
> > > +             ret =3D smu_adjust_power_state_dynamic(smu, level, true=
);
> > >               break;
> > >       case AMD_PP_TASK_READJUST_POWER_STATE:
> > > -             ret =3D smu_adjust_power_state_dynamic(smu, level, true=
, false);
> > > +             ret =3D smu_adjust_power_state_dynamic(smu, level, true=
);
> > >               break;
> > >       default:
> > >               break;
> > > @@ -2354,12 +2368,11 @@ static int smu_handle_dpm_task(void *handle,
> > >
> > >  static int smu_switch_power_profile(void *handle,
> > >                                   enum PP_SMC_POWER_PROFILE type,
> > > -                                 bool en)
> > > +                                 bool enable)
> > >  {
> > >       struct smu_context *smu =3D handle;
> > >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> > > -     long workload[1];
> > > -     uint32_t index;
> > > +     int ret;
> > >
> > >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> > >               return -EOPNOTSUPP;
> > > @@ -2367,21 +2380,21 @@ static int smu_switch_power_profile(void *han=
dle,
> > >       if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
> > >               return -EINVAL;
> > >
> > > -     if (!en) {
> > > -             smu->workload_mask &=3D ~(1 << smu->workload_prority[ty=
pe]);
> > > -             index =3D fls(smu->workload_mask);
> > > -             index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ?=
 index - 1 : 0;
> > > -             workload[0] =3D smu->workload_setting[index];
> > > -     } else {
> > > -             smu->workload_mask |=3D (1 << smu->workload_prority[typ=
e]);
> > > -             index =3D fls(smu->workload_mask);
> > > -             index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 : =
0;
> > > -             workload[0] =3D smu->workload_setting[index];
> > > -     }
> > > -
> > >       if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL &&
> > > -             smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_D=
ETERMINISM)
> > > -             smu_bump_power_profile_mode(smu, workload, 0);
> > > +         smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_PERF_DETER=
MINISM) {
> > > +             if (enable)
> > > +                     smu_power_profile_mode_get(smu, type);
> > > +             else
> > > +                     smu_power_profile_mode_put(smu, type);
> > > +             ret =3D smu_bump_power_profile_mode(smu, NULL, 0);
> > > +             if (ret) {
> > > +                     if (enable)
> > > +                             smu_power_profile_mode_put(smu, type);
> > > +                     else
> > > +                             smu_power_profile_mode_get(smu, type);
> > > +                     return ret;
> > > +             }
> > > +     }
> > >
> > >       return 0;
> > >  }
> > > @@ -3080,12 +3093,35 @@ static int smu_set_power_profile_mode(void *h=
andle,
> > >                                     uint32_t param_size)
> > >  {
> > >       struct smu_context *smu =3D handle;
> > > +     bool custom =3D false;
> > > +     int ret =3D 0;
> > >
> > >       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> > >           !smu->ppt_funcs->set_power_profile_mode)
> > >               return -EOPNOTSUPP;
> > >
> > > -     return smu_bump_power_profile_mode(smu, param, param_size);
> > > +     if (param[param_size] =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> > > +             custom =3D true;
> > > +             /* clear frontend mask so custom changes propogate */
> > > +             smu->workload_mask =3D 0;
> > > +     }
> > > +
> > > +     if ((param[param_size] !=3D smu->power_profile_mode) || custom)=
 {
> > > +             /* clear the old user preference */
> > > +             smu_power_profile_mode_put(smu, smu->power_profile_mode=
);
> > > +             /* set the new user preference */
> > > +             smu_power_profile_mode_get(smu, param[param_size]);
> > > +             ret =3D smu_bump_power_profile_mode(smu,
> > > +                                               custom ? param : NULL=
,
> > > +                                               custom ? param_size :=
 0);
> > > +             if (ret)
> > > +                     smu_power_profile_mode_put(smu, param[param_siz=
e]);
> > > +             else
> > > +                     /* store the user's preference */
> > > +                     smu->power_profile_mode =3D param[param_size];
> > > +     }
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/=
gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > index 06d817fb84aa..b3dfd565488a 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > @@ -556,11 +556,13 @@ struct smu_context {
> > >       uint32_t hard_min_uclk_req_from_dal;
> > >       bool disable_uclk_switch;
> > >
> > > +     /* asic agnostic workload mask */
> > >       uint32_t workload_mask;
> > > -     uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> > > -     uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> > > +     /* default/user workload preference */
> > >       uint32_t power_profile_mode;
> > > -     uint32_t default_power_profile_mode;
> > > +     uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> > > +     /* backend specific custom workload settings */
> > > +     long *custom_profile_params;
> > >       bool pm_enabled;
> > >       bool is_apu;
> > >
> > > @@ -731,9 +733,12 @@ struct pptable_funcs {
> > >        * @set_power_profile_mode: Set a power profile mode. Also used=
 to
> > >        *                          create/set custom power profile mod=
es.
> > >        * &input: Power profile mode parameters.
> > > -      * &size: Size of &input.
> > > +      * &workload_mask: mask of workloads to enable
> > > +      * &custom_params: custom profile parameters
> > > +      * &custom_params_max_idx: max valid idx into custom_params
> > >        */
> > > -     int (*set_power_profile_mode)(struct smu_context *smu, long *in=
put, uint32_t size);
> > > +     int (*set_power_profile_mode)(struct smu_context *smu, u32 work=
load_mask,
> > > +                                   long *custom_params, u32 custom_p=
arams_max_idx);
> > >
> > >       /**
> > >        * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > index 6c8e80f6b592..22a8b7bd2b58 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> > > @@ -1441,98 +1441,115 @@ static int arcturus_get_power_profile_mode(s=
truct smu_context *smu,
> > >       return size;
> > >  }
> > >
> > > -static int arcturus_set_power_profile_mode(struct smu_context *smu,
> > > -                                        long *input,
> > > -                                        uint32_t size)
> > > +#define ARCTURUS_CUSTOM_PARAMS_COUNT 10
> > > +#define ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT 2
> > > +#define ARCTURUS_CUSTOM_PARAMS_SIZE (ARCTURUS_CUSTOM_PARAMS_CLOCK_CO=
UNT * ARCTURUS_CUSTOM_PARAMS_COUNT * sizeof(long))
> > > +
> > > +static int arcturus_set_power_profile_mode_coeff(struct smu_context =
*smu,
> > > +                                              long *input)
> > >  {
> > >       DpmActivityMonitorCoeffInt_t activity_monitor;
> > > -     int workload_type =3D 0;
> > > -     uint32_t profile_mode =3D input[size];
> > > -     int ret =3D 0;
> > > +     int ret, idx;
> > >
> > > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", profile_mode);
> > > -             return -EINVAL;
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor),
> > > +                                false);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to get activity mo=
nitor!", __func__);
> > > +             return ret;
> > >       }
> > >
> > > +     idx =3D 0 * ARCTURUS_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Gfxclk */
> > > +             activity_monitor.Gfx_FPS =3D input[idx + 1];
> > > +             activity_monitor.Gfx_UseRlcBusy =3D input[idx + 2];
> > > +             activity_monitor.Gfx_MinActiveFreqType =3D input[idx + =
3];
> > > +             activity_monitor.Gfx_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor.Gfx_BoosterFreqType =3D input[idx + 5]=
;
> > > +             activity_monitor.Gfx_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor.Gfx_PD_Data_limit_c =3D input[idx + 7]=
;
> > > +             activity_monitor.Gfx_PD_Data_error_coeff =3D input[idx =
+ 8];
> > > +             activity_monitor.Gfx_PD_Data_error_rate_coeff =3D input=
[idx + 9];
> > > +     }
> > > +     idx =3D 1 * ARCTURUS_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Uclk */
> > > +             activity_monitor.Mem_FPS =3D input[idx + 1];
> > > +             activity_monitor.Mem_UseRlcBusy =3D input[idx + 2];
> > > +             activity_monitor.Mem_MinActiveFreqType =3D input[idx + =
3];
> > > +             activity_monitor.Mem_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor.Mem_BoosterFreqType =3D input[idx + 5]=
;
> > > +             activity_monitor.Mem_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor.Mem_PD_Data_limit_c =3D input[idx + 7]=
;
> > > +             activity_monitor.Mem_PD_Data_error_coeff =3D input[idx =
+ 8];
> > > +             activity_monitor.Mem_PD_Data_error_rate_coeff =3D input=
[idx + 9];
> > > +     }
> > >
> > > -     if ((profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) &&
> > > -          (smu->smc_fw_version >=3D 0x360d00)) {
> > > -             if (size !=3D 10)
> > > -                     return -EINVAL;
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor),
> > > +                                true);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to set activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
> > > -                                    WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor),
> > > -                                    false);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to get act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > +     return ret;
> > > +}
> > >
> > > -             switch (input[0]) {
> > > -             case 0: /* Gfxclk */
> > > -                     activity_monitor.Gfx_FPS =3D input[1];
> > > -                     activity_monitor.Gfx_UseRlcBusy =3D input[2];
> > > -                     activity_monitor.Gfx_MinActiveFreqType =3D inpu=
t[3];
> > > -                     activity_monitor.Gfx_MinActiveFreq =3D input[4]=
;
> > > -                     activity_monitor.Gfx_BoosterFreqType =3D input[=
5];
> > > -                     activity_monitor.Gfx_BoosterFreq =3D input[6];
> > > -                     activity_monitor.Gfx_PD_Data_limit_c =3D input[=
7];
> > > -                     activity_monitor.Gfx_PD_Data_error_coeff =3D in=
put[8];
> > > -                     activity_monitor.Gfx_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             case 1: /* Uclk */
> > > -                     activity_monitor.Mem_FPS =3D input[1];
> > > -                     activity_monitor.Mem_UseRlcBusy =3D input[2];
> > > -                     activity_monitor.Mem_MinActiveFreqType =3D inpu=
t[3];
> > > -                     activity_monitor.Mem_MinActiveFreq =3D input[4]=
;
> > > -                     activity_monitor.Mem_BoosterFreqType =3D input[=
5];
> > > -                     activity_monitor.Mem_BoosterFreq =3D input[6];
> > > -                     activity_monitor.Mem_PD_Data_limit_c =3D input[=
7];
> > > -                     activity_monitor.Mem_PD_Data_error_coeff =3D in=
put[8];
> > > -                     activity_monitor.Mem_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             default:
> > > +static int arcturus_set_power_profile_mode(struct smu_context *smu,
> > > +                                        u32 workload_mask,
> > > +                                        long *custom_params,
> > > +                                        u32 custom_params_max_idx)
> > > +{
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int ret, idx, i;
> > > +
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > > +
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> > > +             if (smu->smc_fw_version < 0x360d00)
> > >                       return -EINVAL;
> > > +             if (!smu->custom_profile_params) {
> > > +                     smu->custom_profile_params =3D
> > > +                             kzalloc(ARCTURUS_CUSTOM_PARAMS_SIZE, GF=
P_KERNEL);
> > > +                     if (!smu->custom_profile_params)
> > > +                             return -ENOMEM;
> >
> > Now that input buffer is passed, not seeing much use of this
> > intermediate buffer.
> >
> > This has the same issue as before for a failure. In a workflow like bel=
ow
> >
> > 1) Custom Profile -  GfxCLK + Params
> > 2) Custom Profile -  MemCLK + Params
> >
> > Even if 1) fails custom params are not cleared
> > smu->custom_profile_params[idx] =3D 1. // This remains 1.
> >
> > When MemCLK settings are passed, it will try to apply the failed GfxCLK
> > settings again.
> >
> > Why not pass the input params directly and avoid the extra copy? In the
> > version specific implementation, whenever an update is made, the curren=
t
> > table is fetched from FW, gets modified and then updated with new value=
s.
>
> What if the SMU gets powered down?  E.g., suspend or possibly GPU
> reset?  We need to retain the state so it can be reporgrammed.

In the backend set_power_profile, I can clear the additional custom
bits if the operation fails.  That should cover both cases.

Alex

>
> Alex
>
> >
> > Thanks,
> > Lijo
> >
> > >               }
> > > -
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
,
> > > -                                    WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor),
> > > -                                    true);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to set act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > +             if (custom_params && custom_params_max_idx) {
> > > +                     if (custom_params_max_idx !=3D ARCTURUS_CUSTOM_=
PARAMS_COUNT)
> > > +                             return -EINVAL;
> > > +                     if (custom_params[0] >=3D ARCTURUS_CUSTOM_PARAM=
S_CLOCK_COUNT)
> > > +                             return -EINVAL;
> > > +                     idx =3D custom_params[0] * ARCTURUS_CUSTOM_PARA=
MS_COUNT;
> > > +                     smu->custom_profile_params[idx] =3D 1;
> > > +                     for (i =3D 1; i < custom_params_max_idx; i++)
> > > +                             smu->custom_profile_params[idx + i] =3D=
 custom_params[i];
> > >               }
> > > -     }
> > > -
> > > -     /*
> > > -      * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> > > -      * Not all profile modes are supported on arcturus.
> > > -      */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    profile_mode);
> > > -     if (workload_type < 0) {
> > > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode=
 %d on arcturus\n", profile_mode);
> > > -             return -EINVAL;
> > > +             ret =3D arcturus_set_power_profile_mode_coeff(smu,
> > > +                                                         smu->custom=
_profile_params);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (smu->custom_profile_params) {
> > > +             memset(smu->custom_profile_params, 0, ARCTURUS_CUSTOM_P=
ARAMS_SIZE);
> > >       }
> > >
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > > -                                       SMU_MSG_SetWorkloadMask,
> > > -                                       1 << workload_type,
> > > -                                       NULL);
> > > +                                           SMU_MSG_SetWorkloadMask,
> > > +                                           backend_workload_mask,
> > > +                                           NULL);
> > >       if (ret) {
> > > -             dev_err(smu->adev->dev, "Fail to set workload type %d\n=
", workload_type);
> > > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x=
%08x\n",
> > > +                     workload_mask);
> > >               return ret;
> > >       }
> > >
> > > -     smu->power_profile_mode =3D profile_mode;
> > > -
> > > -     return 0;
> > > +     return ret;
> > >  }
> > >
> > >  static int arcturus_set_performance_level(struct smu_context *smu,
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > index faa8e7d9c3c6..92f2a55f6772 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > > @@ -2006,87 +2006,117 @@ static int navi10_get_power_profile_mode(str=
uct smu_context *smu, char *buf)
> > >       return size;
> > >  }
> > >
> > > -static int navi10_set_power_profile_mode(struct smu_context *smu, lo=
ng *input, uint32_t size)
> > > +#define NAVI10_CUSTOM_PARAMS_COUNT 10
> > > +#define NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT 3
> > > +#define NAVI10_CUSTOM_PARAMS_SIZE (NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT=
 * NAVI10_CUSTOM_PARAMS_COUNT * sizeof(long))
> > > +
> > > +static int navi10_set_power_profile_mode_coeff(struct smu_context *s=
mu,
> > > +                                            long *input)
> > >  {
> > >       DpmActivityMonitorCoeffInt_t activity_monitor;
> > > -     int workload_type, ret =3D 0;
> > > +     int ret, idx;
> > >
> > > -     smu->power_profile_mode =3D input[size];
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor), false);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to get activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", smu->power_profile_mode);
> > > -             return -EINVAL;
> > > +     idx =3D 0 * NAVI10_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Gfxclk */
> > > +             activity_monitor.Gfx_FPS =3D input[idx + 1];
> > > +             activity_monitor.Gfx_MinFreqStep =3D input[idx + 2];
> > > +             activity_monitor.Gfx_MinActiveFreqType =3D input[idx + =
3];
> > > +             activity_monitor.Gfx_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor.Gfx_BoosterFreqType =3D input[idx + 5]=
;
> > > +             activity_monitor.Gfx_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor.Gfx_PD_Data_limit_c =3D input[idx + 7]=
;
> > > +             activity_monitor.Gfx_PD_Data_error_coeff =3D input[idx =
+ 8];
> > > +             activity_monitor.Gfx_PD_Data_error_rate_coeff =3D input=
[idx + 9];
> > > +     }
> > > +     idx =3D 1 * NAVI10_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Socclk */
> > > +             activity_monitor.Soc_FPS =3D input[idx + 1];
> > > +             activity_monitor.Soc_MinFreqStep =3D input[idx + 2];
> > > +             activity_monitor.Soc_MinActiveFreqType =3D input[idx + =
3];
> > > +             activity_monitor.Soc_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor.Soc_BoosterFreqType =3D input[idx + 5]=
;
> > > +             activity_monitor.Soc_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor.Soc_PD_Data_limit_c =3D input[idx + 7]=
;
> > > +             activity_monitor.Soc_PD_Data_error_coeff =3D input[idx =
+ 8];
> > > +             activity_monitor.Soc_PD_Data_error_rate_coeff =3D input=
[idx + 9];
> > > +     }
> > > +     idx =3D 2 * NAVI10_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Memclk */
> > > +             activity_monitor.Mem_FPS =3D input[idx + 1];
> > > +             activity_monitor.Mem_MinFreqStep =3D input[idx + 2];
> > > +             activity_monitor.Mem_MinActiveFreqType =3D input[idx + =
3];
> > > +             activity_monitor.Mem_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor.Mem_BoosterFreqType =3D input[idx + 5]=
;
> > > +             activity_monitor.Mem_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor.Mem_PD_Data_limit_c =3D input[idx + 7]=
;
> > > +             activity_monitor.Mem_PD_Data_error_coeff =3D input[idx =
+ 8];
> > > +             activity_monitor.Mem_PD_Data_error_rate_coeff =3D input=
[idx + 9];
> > > +     }
> > > +
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor), true);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to set activity mo=
nitor!", __func__);
> > > +             return ret;
> > >       }
> > >
> > > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)=
 {
> > > -             if (size !=3D 10)
> > > -                     return -EINVAL;
> > > +     return ret;
> > > +}
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
, WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor), fal=
se);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to get act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > +static int navi10_set_power_profile_mode(struct smu_context *smu,
> > > +                                      u32 workload_mask,
> > > +                                      long *custom_params,
> > > +                                      u32 custom_params_max_idx)
> > > +{
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int ret, idx, i;
> > >
> > > -             switch (input[0]) {
> > > -             case 0: /* Gfxclk */
> > > -                     activity_monitor.Gfx_FPS =3D input[1];
> > > -                     activity_monitor.Gfx_MinFreqStep =3D input[2];
> > > -                     activity_monitor.Gfx_MinActiveFreqType =3D inpu=
t[3];
> > > -                     activity_monitor.Gfx_MinActiveFreq =3D input[4]=
;
> > > -                     activity_monitor.Gfx_BoosterFreqType =3D input[=
5];
> > > -                     activity_monitor.Gfx_BoosterFreq =3D input[6];
> > > -                     activity_monitor.Gfx_PD_Data_limit_c =3D input[=
7];
> > > -                     activity_monitor.Gfx_PD_Data_error_coeff =3D in=
put[8];
> > > -                     activity_monitor.Gfx_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             case 1: /* Socclk */
> > > -                     activity_monitor.Soc_FPS =3D input[1];
> > > -                     activity_monitor.Soc_MinFreqStep =3D input[2];
> > > -                     activity_monitor.Soc_MinActiveFreqType =3D inpu=
t[3];
> > > -                     activity_monitor.Soc_MinActiveFreq =3D input[4]=
;
> > > -                     activity_monitor.Soc_BoosterFreqType =3D input[=
5];
> > > -                     activity_monitor.Soc_BoosterFreq =3D input[6];
> > > -                     activity_monitor.Soc_PD_Data_limit_c =3D input[=
7];
> > > -                     activity_monitor.Soc_PD_Data_error_coeff =3D in=
put[8];
> > > -                     activity_monitor.Soc_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             case 2: /* Memclk */
> > > -                     activity_monitor.Mem_FPS =3D input[1];
> > > -                     activity_monitor.Mem_MinFreqStep =3D input[2];
> > > -                     activity_monitor.Mem_MinActiveFreqType =3D inpu=
t[3];
> > > -                     activity_monitor.Mem_MinActiveFreq =3D input[4]=
;
> > > -                     activity_monitor.Mem_BoosterFreqType =3D input[=
5];
> > > -                     activity_monitor.Mem_BoosterFreq =3D input[6];
> > > -                     activity_monitor.Mem_PD_Data_limit_c =3D input[=
7];
> > > -                     activity_monitor.Mem_PD_Data_error_coeff =3D in=
put[8];
> > > -                     activity_monitor.Mem_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             default:
> > > -                     return -EINVAL;
> > > -             }
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
, WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor), tru=
e);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to set act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> > > +             if (!smu->custom_profile_params) {
> > > +                     smu->custom_profile_params =3D kzalloc(NAVI10_C=
USTOM_PARAMS_SIZE, GFP_KERNEL);
> > > +                     if (!smu->custom_profile_params)
> > > +                             return -ENOMEM;
> > >               }
> > > +             if (custom_params && custom_params_max_idx) {
> > > +                     if (custom_params_max_idx !=3D NAVI10_CUSTOM_PA=
RAMS_COUNT)
> > > +                             return -EINVAL;
> > > +                     if (custom_params[0] >=3D NAVI10_CUSTOM_PARAMS_=
CLOCKS_COUNT)
> > > +                             return -EINVAL;
> > > +                     idx =3D custom_params[0] * NAVI10_CUSTOM_PARAMS=
_COUNT;
> > > +                     smu->custom_profile_params[idx] =3D 1;
> > > +                     for (i =3D 1; i < custom_params_max_idx; i++)
> > > +                             smu->custom_profile_params[idx + i] =3D=
 custom_params[i];
> > > +             }
> > > +             ret =3D navi10_set_power_profile_mode_coeff(smu,
> > > +                                                       smu->custom_p=
rofile_params);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (smu->custom_profile_params) {
> > > +             memset(smu->custom_profile_params, 0, NAVI10_CUSTOM_PAR=
AMS_SIZE);
> > >       }
> > >
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    smu->power_profi=
le_mode);
> > > -     if (workload_type < 0)
> > > -             return -EINVAL;
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloa=
dMask,
> > > -                                 1 << workload_type, NULL);
> > > -     if (ret)
> > > -             dev_err(smu->adev->dev, "[%s] Failed to set work load m=
ask!", __func__);
> > > +                                           backend_workload_mask, NU=
LL);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x=
%08x\n",
> > > +                     workload_mask);
> > > +             return ret;
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c =
b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > index 30d050a6e953..d3c002f8e633 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > @@ -1704,90 +1704,121 @@ static int sienna_cichlid_get_power_profile_=
mode(struct smu_context *smu, char *
> > >       return size;
> > >  }
> > >
> > > -static int sienna_cichlid_set_power_profile_mode(struct smu_context =
*smu, long *input, uint32_t size)
> > > +#define SIENNA_CICHLID_CUSTOM_PARAMS_COUNT 10
> > > +#define SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT 3
> > > +#define SIENNA_CICHLID_CUSTOM_PARAMS_SIZE (SIENNA_CICHLID_CUSTOM_PAR=
AMS_CLOCK_COUNT * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT * sizeof(long))
> > > +
> > > +static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_co=
ntext *smu,
> > > +                                                    long *input)
> > >  {
> > >
> > >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> > >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> > >               &(activity_monitor_external.DpmActivityMonitorCoeffInt)=
;
> > > -     int workload_type, ret =3D 0;
> > > +     int ret, idx;
> > >
> > > -     smu->power_profile_mode =3D input[size];
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
, false);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to get activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", smu->power_profile_mode);
> > > -             return -EINVAL;
> > > +     idx =3D 0 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Gfxclk */
> > > +             activity_monitor->Gfx_FPS =3D input[idx + 1];
> > > +             activity_monitor->Gfx_MinFreqStep =3D input[idx + 2];
> > > +             activity_monitor->Gfx_MinActiveFreqType =3D input[idx +=
 3];
> > > +             activity_monitor->Gfx_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor->Gfx_BoosterFreqType =3D input[idx + 5=
];
> > > +             activity_monitor->Gfx_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor->Gfx_PD_Data_limit_c =3D input[idx + 7=
];
> > > +             activity_monitor->Gfx_PD_Data_error_coeff =3D input[idx=
 + 8];
> > > +             activity_monitor->Gfx_PD_Data_error_rate_coeff =3D inpu=
t[idx + 9];
> > > +     }
> > > +     idx =3D 1 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Socclk */
> > > +             activity_monitor->Fclk_FPS =3D input[idx + 1];
> > > +             activity_monitor->Fclk_MinFreqStep =3D input[idx + 2];
> > > +             activity_monitor->Fclk_MinActiveFreqType =3D input[idx =
+ 3];
> > > +             activity_monitor->Fclk_MinActiveFreq =3D input[idx + 4]=
;
> > > +             activity_monitor->Fclk_BoosterFreqType =3D input[idx + =
5];
> > > +             activity_monitor->Fclk_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor->Fclk_PD_Data_limit_c =3D input[idx + =
7];
> > > +             activity_monitor->Fclk_PD_Data_error_coeff =3D input[id=
x + 8];
> > > +             activity_monitor->Fclk_PD_Data_error_rate_coeff =3D inp=
ut[idx + 9];
> > > +     }
> > > +     idx =3D 2 * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Memclk */
> > > +             activity_monitor->Mem_FPS =3D input[idx + 1];
> > > +             activity_monitor->Mem_MinFreqStep =3D input[idx + 2];
> > > +             activity_monitor->Mem_MinActiveFreqType =3D input[idx +=
 3];
> > > +             activity_monitor->Mem_MinActiveFreq =3D input[idx + 4];
> > > +             activity_monitor->Mem_BoosterFreqType =3D input[idx + 5=
];
> > > +             activity_monitor->Mem_BoosterFreq =3D input[idx + 6];
> > > +             activity_monitor->Mem_PD_Data_limit_c =3D input[idx + 7=
];
> > > +             activity_monitor->Mem_PD_Data_error_coeff =3D input[idx=
 + 8];
> > > +             activity_monitor->Mem_PD_Data_error_rate_coeff =3D inpu=
t[idx + 9];
> > >       }
> > >
> > > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)=
 {
> > > -             if (size !=3D 10)
> > > -                     return -EINVAL;
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
, true);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to set activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
, WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor_exter=
nal), false);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to get act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > +     return ret;
> > > +}
> > >
> > > -             switch (input[0]) {
> > > -             case 0: /* Gfxclk */
> > > -                     activity_monitor->Gfx_FPS =3D input[1];
> > > -                     activity_monitor->Gfx_MinFreqStep =3D input[2];
> > > -                     activity_monitor->Gfx_MinActiveFreqType =3D inp=
ut[3];
> > > -                     activity_monitor->Gfx_MinActiveFreq =3D input[4=
];
> > > -                     activity_monitor->Gfx_BoosterFreqType =3D input=
[5];
> > > -                     activity_monitor->Gfx_BoosterFreq =3D input[6];
> > > -                     activity_monitor->Gfx_PD_Data_limit_c =3D input=
[7];
> > > -                     activity_monitor->Gfx_PD_Data_error_coeff =3D i=
nput[8];
> > > -                     activity_monitor->Gfx_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             case 1: /* Socclk */
> > > -                     activity_monitor->Fclk_FPS =3D input[1];
> > > -                     activity_monitor->Fclk_MinFreqStep =3D input[2]=
;
> > > -                     activity_monitor->Fclk_MinActiveFreqType =3D in=
put[3];
> > > -                     activity_monitor->Fclk_MinActiveFreq =3D input[=
4];
> > > -                     activity_monitor->Fclk_BoosterFreqType =3D inpu=
t[5];
> > > -                     activity_monitor->Fclk_BoosterFreq =3D input[6]=
;
> > > -                     activity_monitor->Fclk_PD_Data_limit_c =3D inpu=
t[7];
> > > -                     activity_monitor->Fclk_PD_Data_error_coeff =3D =
input[8];
> > > -                     activity_monitor->Fclk_PD_Data_error_rate_coeff=
 =3D input[9];
> > > -                     break;
> > > -             case 2: /* Memclk */
> > > -                     activity_monitor->Mem_FPS =3D input[1];
> > > -                     activity_monitor->Mem_MinFreqStep =3D input[2];
> > > -                     activity_monitor->Mem_MinActiveFreqType =3D inp=
ut[3];
> > > -                     activity_monitor->Mem_MinActiveFreq =3D input[4=
];
> > > -                     activity_monitor->Mem_BoosterFreqType =3D input=
[5];
> > > -                     activity_monitor->Mem_BoosterFreq =3D input[6];
> > > -                     activity_monitor->Mem_PD_Data_limit_c =3D input=
[7];
> > > -                     activity_monitor->Mem_PD_Data_error_coeff =3D i=
nput[8];
> > > -                     activity_monitor->Mem_PD_Data_error_rate_coeff =
=3D input[9];
> > > -                     break;
> > > -             default:
> > > -                     return -EINVAL;
> > > -             }
> > > +static int sienna_cichlid_set_power_profile_mode(struct smu_context =
*smu,
> > > +                                              u32 workload_mask,
> > > +                                              long *custom_params,
> > > +                                              u32 custom_params_max_=
idx)
> > > +{
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int ret, idx, i;
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
, WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor_exter=
nal), true);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to set act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > > +
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> > > +             if (!smu->custom_profile_params) {
> > > +                     smu->custom_profile_params =3D
> > > +                             kzalloc(SIENNA_CICHLID_CUSTOM_PARAMS_SI=
ZE, GFP_KERNEL);
> > > +                     if (!smu->custom_profile_params)
> > > +                             return -ENOMEM;
> > >               }
> > > +             if (custom_params && custom_params_max_idx) {
> > > +                     if (custom_params_max_idx !=3D SIENNA_CICHLID_C=
USTOM_PARAMS_COUNT)
> > > +                             return -EINVAL;
> > > +                     if (custom_params[0] >=3D SIENNA_CICHLID_CUSTOM=
_PARAMS_CLOCK_COUNT)
> > > +                             return -EINVAL;
> > > +                     idx =3D custom_params[0] * SIENNA_CICHLID_CUSTO=
M_PARAMS_COUNT;
> > > +                     smu->custom_profile_params[idx] =3D 1;
> > > +                     for (i =3D 1; i < custom_params_max_idx; i++)
> > > +                             smu->custom_profile_params[idx + i] =3D=
 custom_params[i];
> > > +             }
> > > +             ret =3D sienna_cichlid_set_power_profile_mode_coeff(smu=
,
> > > +                                                               smu->=
custom_profile_params);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (smu->custom_profile_params) {
> > > +             memset(smu->custom_profile_params, 0, SIENNA_CICHLID_CU=
STOM_PARAMS_SIZE);
> > >       }
> > >
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    smu->power_profi=
le_mode);
> > > -     if (workload_type < 0)
> > > -             return -EINVAL;
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloa=
dMask,
> > > -                                 1 << workload_type, NULL);
> > > -     if (ret)
> > > -             dev_err(smu->adev->dev, "[%s] Failed to set work load m=
ask!", __func__);
> > > +                                           backend_workload_mask, NU=
LL);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x=
%08x\n",
> > > +                     workload_mask);
> > > +             return ret;
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > > index cd3e9ba3eff4..a55ea76d7399 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > > @@ -1056,42 +1056,27 @@ static int vangogh_get_power_profile_mode(str=
uct smu_context *smu,
> > >       return size;
> > >  }
> > >
> > > -static int vangogh_set_power_profile_mode(struct smu_context *smu, l=
ong *input, uint32_t size)
> > > +static int vangogh_set_power_profile_mode(struct smu_context *smu,
> > > +                                       u32 workload_mask,
> > > +                                       long *custom_params,
> > > +                                       u32 custom_params_max_idx)
> > >  {
> > > -     int workload_type, ret;
> > > -     uint32_t profile_mode =3D input[size];
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int ret;
> > >
> > > -     if (profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", profile_mode);
> > > -             return -EINVAL;
> > > -     }
> > > -
> > > -     if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERS=
AVING)
> > > -             return 0;
> > > -
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    profile_mode);
> > > -     if (workload_type < 0) {
> > > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode=
 %d on VANGOGH\n",
> > > -                                     profile_mode);
> > > -             return -EINVAL;
> > > -     }
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > >
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProc=
essNotify,
> > > -                                 1 << workload_type,
> > > -                                 NULL);
> > > +                                           backend_workload_mask,
> > > +                                           NULL);
> > >       if (ret) {
> > > -             dev_err_once(smu->adev->dev, "Fail to set workload type=
 %d\n",
> > > -                                     workload_type);
> > > +             dev_err_once(smu->adev->dev, "Fail to set workload mask=
 0x%08x\n",
> > > +                          workload_mask);
> > >               return ret;
> > >       }
> > >
> > > -     smu->power_profile_mode =3D profile_mode;
> > > -
> > > -     return 0;
> > > +     return ret;
> > >  }
> > >
> > >  static int vangogh_set_soft_freq_limited_range(struct smu_context *s=
mu,
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > > index a34797f3576b..37d82a71a2d7 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > > @@ -864,44 +864,27 @@ static int renoir_force_clk_levels(struct smu_c=
ontext *smu,
> > >       return ret;
> > >  }
> > >
> > > -static int renoir_set_power_profile_mode(struct smu_context *smu, lo=
ng *input, uint32_t size)
> > > +static int renoir_set_power_profile_mode(struct smu_context *smu,
> > > +                                      u32 workload_mask,
> > > +                                      long *custom_params,
> > > +                                      u32 custom_params_max_idx)
> > >  {
> > > -     int workload_type, ret;
> > > -     uint32_t profile_mode =3D input[size];
> > > +     int ret;
> > > +     u32 backend_workload_mask =3D 0;
> > >
> > > -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", profile_mode);
> > > -             return -EINVAL;
> > > -     }
> > > -
> > > -     if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > > -                     profile_mode =3D=3D PP_SMC_POWER_PROFILE_POWERS=
AVING)
> > > -             return 0;
> > > -
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    profile_mode);
> > > -     if (workload_type < 0) {
> > > -             /*
> > > -              * TODO: If some case need switch to powersave/default =
power mode
> > > -              * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CU=
STOM for power saving.
> > > -              */
> > > -             dev_dbg(smu->adev->dev, "Unsupported power profile mode=
 %d on RENOIR\n", profile_mode);
> > > -             return -EINVAL;
> > > -     }
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > >
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProc=
essNotify,
> > > -                                 1 << workload_type,
> > > -                                 NULL);
> > > +                                           backend_workload_mask,
> > > +                                           NULL);
> > >       if (ret) {
> > > -             dev_err_once(smu->adev->dev, "Fail to set workload type=
 %d\n", workload_type);
> > > +             dev_err_once(smu->adev->dev, "Failed to set workload ma=
sk 0x08%x\n",
> > > +                          workload_mask);
> > >               return ret;
> > >       }
> > >
> > > -     smu->power_profile_mode =3D profile_mode;
> > > -
> > > -     return 0;
> > > +     return ret;
> > >  }
> > >
> > >  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/d=
rivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > index 199bdd9720d3..e5440d82db15 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > @@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode=
(struct smu_context *smu,
> > >       return size;
> > >  }
> > >
> > > -static int smu_v13_0_0_set_power_profile_mode(struct smu_context *sm=
u,
> > > -                                           long *input,
> > > -                                           uint32_t size)
> > > +#define SMU_13_0_0_CUSTOM_PARAMS_COUNT 9
> > > +#define SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT 2
> > > +#define SMU_13_0_0_CUSTOM_PARAMS_SIZE (SMU_13_0_0_CUSTOM_PARAMS_CLOC=
K_COUNT * SMU_13_0_0_CUSTOM_PARAMS_COUNT * sizeof(long))
> > > +
> > > +static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_conte=
xt *smu,
> > > +                                                 long *input)
> > >  {
> > >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> > >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> > >               &(activity_monitor_external.DpmActivityMonitorCoeffInt)=
;
> > > -     int workload_type, ret =3D 0;
> > > -     u32 workload_mask, selected_workload_mask;
> > > -
> > > -     smu->power_profile_mode =3D input[size];
> > > +     int ret, idx;
> > >
> > > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", smu->power_profile_mode);
> > > -             return -EINVAL;
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
,
> > > +                                false);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to get activity mo=
nitor!", __func__);
> > > +             return ret;
> > >       }
> > >
> > > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)=
 {
> > > -             if (size !=3D 9)
> > > -                     return -EINVAL;
> > > -
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                        SMU_TABLE_ACTIVITY_MONITOR_C=
OEFF,
> > > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                        (void *)(&activity_monitor_e=
xternal),
> > > -                                        false);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to get act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > -
> > > -             switch (input[0]) {
> > > -             case 0: /* Gfxclk */
> > > -                     activity_monitor->Gfx_FPS =3D input[1];
> > > -                     activity_monitor->Gfx_MinActiveFreqType =3D inp=
ut[2];
> > > -                     activity_monitor->Gfx_MinActiveFreq =3D input[3=
];
> > > -                     activity_monitor->Gfx_BoosterFreqType =3D input=
[4];
> > > -                     activity_monitor->Gfx_BoosterFreq =3D input[5];
> > > -                     activity_monitor->Gfx_PD_Data_limit_c =3D input=
[6];
> > > -                     activity_monitor->Gfx_PD_Data_error_coeff =3D i=
nput[7];
> > > -                     activity_monitor->Gfx_PD_Data_error_rate_coeff =
=3D input[8];
> > > -                     break;
> > > -             case 1: /* Fclk */
> > > -                     activity_monitor->Fclk_FPS =3D input[1];
> > > -                     activity_monitor->Fclk_MinActiveFreqType =3D in=
put[2];
> > > -                     activity_monitor->Fclk_MinActiveFreq =3D input[=
3];
> > > -                     activity_monitor->Fclk_BoosterFreqType =3D inpu=
t[4];
> > > -                     activity_monitor->Fclk_BoosterFreq =3D input[5]=
;
> > > -                     activity_monitor->Fclk_PD_Data_limit_c =3D inpu=
t[6];
> > > -                     activity_monitor->Fclk_PD_Data_error_coeff =3D =
input[7];
> > > -                     activity_monitor->Fclk_PD_Data_error_rate_coeff=
 =3D input[8];
> > > -                     break;
> > > -             default:
> > > -                     return -EINVAL;
> > > -             }
> > > +     idx =3D 0 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Gfxclk */
> > > +             activity_monitor->Gfx_FPS =3D input[idx + 1];
> > > +             activity_monitor->Gfx_MinActiveFreqType =3D input[idx +=
 2];
> > > +             activity_monitor->Gfx_MinActiveFreq =3D input[idx + 3];
> > > +             activity_monitor->Gfx_BoosterFreqType =3D input[idx + 4=
];
> > > +             activity_monitor->Gfx_BoosterFreq =3D input[idx + 5];
> > > +             activity_monitor->Gfx_PD_Data_limit_c =3D input[idx + 6=
];
> > > +             activity_monitor->Gfx_PD_Data_error_coeff =3D input[idx=
 + 7];
> > > +             activity_monitor->Gfx_PD_Data_error_rate_coeff =3D inpu=
t[idx + 8];
> > > +     }
> > > +     idx =3D 1 * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Fclk */
> > > +             activity_monitor->Fclk_FPS =3D input[idx + 1];
> > > +             activity_monitor->Fclk_MinActiveFreqType =3D input[idx =
+ 2];
> > > +             activity_monitor->Fclk_MinActiveFreq =3D input[idx + 3]=
;
> > > +             activity_monitor->Fclk_BoosterFreqType =3D input[idx + =
4];
> > > +             activity_monitor->Fclk_BoosterFreq =3D input[idx + 5];
> > > +             activity_monitor->Fclk_PD_Data_limit_c =3D input[idx + =
6];
> > > +             activity_monitor->Fclk_PD_Data_error_coeff =3D input[id=
x + 7];
> > > +             activity_monitor->Fclk_PD_Data_error_rate_coeff =3D inp=
ut[idx + 8];
> > > +     }
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                        SMU_TABLE_ACTIVITY_MONITOR_C=
OEFF,
> > > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                        (void *)(&activity_monitor_e=
xternal),
> > > -                                        true);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to set act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
,
> > > +                                true);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to set activity mo=
nitor!", __func__);
> > > +             return ret;
> > >       }
> > >
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    smu->power_profi=
le_mode);
> > > +     return ret;
> > > +}
> > >
> > > -     if (workload_type < 0)
> > > -             return -EINVAL;
> > > +static int smu_v13_0_0_set_power_profile_mode(struct smu_context *sm=
u,
> > > +                                           u32 workload_mask,
> > > +                                           long *custom_params,
> > > +                                           u32 custom_params_max_idx=
)
> > > +{
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int workload_type, ret, idx, i;
> > >
> > > -     selected_workload_mask =3D workload_mask =3D 1 << workload_type=
;
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > >
> > >       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving =
profile */
> > >       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSIO=
N(13, 0, 0) &&
> > > @@ -2658,15 +2652,43 @@ static int smu_v13_0_0_set_power_profile_mode=
(struct smu_context *smu,
> > >                                                              CMN2ASIC=
_MAPPING_WORKLOAD,
> > >                                                              PP_SMC_P=
OWER_PROFILE_POWERSAVING);
> > >               if (workload_type >=3D 0)
> > > -                     workload_mask |=3D 1 << workload_type;
> > > +                     backend_workload_mask |=3D 1 << workload_type;
> > > +     }
> > > +
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> > > +             if (!smu->custom_profile_params) {
> > > +                     smu->custom_profile_params =3D
> > > +                             kzalloc(SMU_13_0_0_CUSTOM_PARAMS_SIZE, =
GFP_KERNEL);
> > > +                     if (!smu->custom_profile_params)
> > > +                             return -ENOMEM;
> > > +             }
> > > +             if (custom_params && custom_params_max_idx) {
> > > +                     if (custom_params_max_idx !=3D SMU_13_0_0_CUSTO=
M_PARAMS_COUNT)
> > > +                             return -EINVAL;
> > > +                     if (custom_params[0] >=3D SMU_13_0_0_CUSTOM_PAR=
AMS_CLOCK_COUNT)
> > > +                             return -EINVAL;
> > > +                     idx =3D custom_params[0] * SMU_13_0_0_CUSTOM_PA=
RAMS_COUNT;
> > > +                     smu->custom_profile_params[idx] =3D 1;
> > > +                     for (i =3D 1; i < custom_params_max_idx; i++)
> > > +                             smu->custom_profile_params[idx + i] =3D=
 custom_params[i];
> > > +             }
> > > +             ret =3D smu_v13_0_0_set_power_profile_mode_coeff(smu,
> > > +                                                            smu->cus=
tom_profile_params);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (smu->custom_profile_params) {
> > > +             memset(smu->custom_profile_params, 0, SMU_13_0_0_CUSTOM=
_PARAMS_SIZE);
> > >       }
> > >
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > > -                                            SMU_MSG_SetWorkloadMask,
> > > -                                            workload_mask,
> > > -                                            NULL);
> > > -     if (!ret)
> > > -             smu->workload_mask =3D selected_workload_mask;
> > > +                                           SMU_MSG_SetWorkloadMask,
> > > +                                           backend_workload_mask,
> > > +                                           NULL);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x=
%08x\n",
> > > +                     workload_mask);
> > > +             return ret;
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/d=
rivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > index 34c1e0c7e1e4..c5f6977e8c85 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > @@ -2530,78 +2530,105 @@ do {                                        =
                                                         \
> > >       return result;
> > >  }
> > >
> > > -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *sm=
u, long *input, uint32_t size)
> > > +#define SMU_13_0_7_CUSTOM_PARAMS_COUNT 8
> > > +#define SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT 2
> > > +#define SMU_13_0_7_CUSTOM_PARAMS_SIZE (SMU_13_0_7_CUSTOM_PARAMS_CLOC=
K_COUNT * SMU_13_0_7_CUSTOM_PARAMS_COUNT * sizeof(long))
> > > +
> > > +static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_conte=
xt *smu,
> > > +                                                 long *input)
> > >  {
> > >
> > >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> > >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> > >               &(activity_monitor_external.DpmActivityMonitorCoeffInt)=
;
> > > -     int workload_type, ret =3D 0;
> > > +     int ret, idx;
> > >
> > > -     smu->power_profile_mode =3D input[size];
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
, false);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to get activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -     if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", smu->power_profile_mode);
> > > -             return -EINVAL;
> > > +     idx =3D 0 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Gfxclk */
> > > +             activity_monitor->Gfx_ActiveHystLimit =3D input[idx + 1=
];
> > > +             activity_monitor->Gfx_IdleHystLimit =3D input[idx + 2];
> > > +             activity_monitor->Gfx_FPS =3D input[idx + 3];
> > > +             activity_monitor->Gfx_MinActiveFreqType =3D input[idx +=
 4];
> > > +             activity_monitor->Gfx_BoosterFreqType =3D input[idx + 5=
];
> > > +             activity_monitor->Gfx_MinActiveFreq =3D input[idx + 6];
> > > +             activity_monitor->Gfx_BoosterFreq =3D input[idx + 7];
> > > +     }
> > > +     idx =3D 1 * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Fclk */
> > > +             activity_monitor->Fclk_ActiveHystLimit =3D input[idx + =
1];
> > > +             activity_monitor->Fclk_IdleHystLimit =3D input[idx + 2]=
;
> > > +             activity_monitor->Fclk_FPS =3D input[idx + 3];
> > > +             activity_monitor->Fclk_MinActiveFreqType =3D input[idx =
+ 4];
> > > +             activity_monitor->Fclk_BoosterFreqType =3D input[idx + =
5];
> > > +             activity_monitor->Fclk_MinActiveFreq =3D input[idx + 6]=
;
> > > +             activity_monitor->Fclk_BoosterFreq =3D input[idx + 7];
> > >       }
> > >
> > > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)=
 {
> > > -             if (size !=3D 8)
> > > -                     return -EINVAL;
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF, WO=
RKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
, true);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to set activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
, WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor_exter=
nal), false);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to get act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > +     return ret;
> > > +}
> > >
> > > -             switch (input[0]) {
> > > -             case 0: /* Gfxclk */
> > > -                     activity_monitor->Gfx_ActiveHystLimit =3D input=
[1];
> > > -                     activity_monitor->Gfx_IdleHystLimit =3D input[2=
];
> > > -                     activity_monitor->Gfx_FPS =3D input[3];
> > > -                     activity_monitor->Gfx_MinActiveFreqType =3D inp=
ut[4];
> > > -                     activity_monitor->Gfx_BoosterFreqType =3D input=
[5];
> > > -                     activity_monitor->Gfx_MinActiveFreq =3D input[6=
];
> > > -                     activity_monitor->Gfx_BoosterFreq =3D input[7];
> > > -                     break;
> > > -             case 1: /* Fclk */
> > > -                     activity_monitor->Fclk_ActiveHystLimit =3D inpu=
t[1];
> > > -                     activity_monitor->Fclk_IdleHystLimit =3D input[=
2];
> > > -                     activity_monitor->Fclk_FPS =3D input[3];
> > > -                     activity_monitor->Fclk_MinActiveFreqType =3D in=
put[4];
> > > -                     activity_monitor->Fclk_BoosterFreqType =3D inpu=
t[5];
> > > -                     activity_monitor->Fclk_MinActiveFreq =3D input[=
6];
> > > -                     activity_monitor->Fclk_BoosterFreq =3D input[7]=
;
> > > -                     break;
> > > -             default:
> > > -                     return -EINVAL;
> > > +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *sm=
u,
> > > +                                           u32 workload_mask,
> > > +                                           long *custom_params,
> > > +                                           u32 custom_params_max_idx=
)
> > > +{
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int ret, idx, i;
> > > +
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > > +
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> > > +             if (!smu->custom_profile_params) {
> > > +                     smu->custom_profile_params =3D
> > > +                             kzalloc(SMU_13_0_7_CUSTOM_PARAMS_SIZE, =
GFP_KERNEL);
> > > +                     if (!smu->custom_profile_params)
> > > +                             return -ENOMEM;
> > >               }
> > > -
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                    SMU_TABLE_ACTIVITY_MONITOR_COEFF=
, WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                    (void *)(&activity_monitor_exter=
nal), true);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to set act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > +             if (custom_params && custom_params_max_idx) {
> > > +                     if (custom_params_max_idx !=3D SMU_13_0_7_CUSTO=
M_PARAMS_COUNT)
> > > +                             return -EINVAL;
> > > +                     if (custom_params[0] >=3D SMU_13_0_7_CUSTOM_PAR=
AMS_CLOCK_COUNT)
> > > +                             return -EINVAL;
> > > +                     idx =3D custom_params[0] * SMU_13_0_7_CUSTOM_PA=
RAMS_COUNT;
> > > +                     smu->custom_profile_params[idx] =3D 1;
> > > +                     for (i =3D 1; i < custom_params_max_idx; i++)
> > > +                             smu->custom_profile_params[idx + i] =3D=
 custom_params[i];
> > >               }
> > > +             ret =3D smu_v13_0_7_set_power_profile_mode_coeff(smu,
> > > +                                                            smu->cus=
tom_profile_params);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (smu->custom_profile_params) {
> > > +             memset(smu->custom_profile_params, 0, SMU_13_0_7_CUSTOM=
_PARAMS_SIZE);
> > >       }
> > >
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    smu->power_profi=
le_mode);
> > > -     if (workload_type < 0)
> > > -             return -EINVAL;
> > >       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloa=
dMask,
> > > -                                 1 << workload_type, NULL);
> > > +                                           backend_workload_mask, NU=
LL);
> > >
> > > -     if (ret)
> > > -             dev_err(smu->adev->dev, "[%s] Failed to set work load m=
ask!", __func__);
> > > -     else
> > > -             smu->workload_mask =3D (1 << workload_type);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x=
%08x\n",
> > > +                     workload_mask);
> > > +             return ret;
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/d=
rivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > index 884938d69fca..5f3e420101ca 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > > @@ -1717,90 +1717,115 @@ static int smu_v14_0_2_get_power_profile_mod=
e(struct smu_context *smu,
> > >       return size;
> > >  }
> > >
> > > -static int smu_v14_0_2_set_power_profile_mode(struct smu_context *sm=
u,
> > > -                                           long *input,
> > > -                                           uint32_t size)
> > > +#define SMU_14_0_2_CUSTOM_PARAMS_COUNT 9
> > > +#define SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT 2
> > > +#define SMU_14_0_2_CUSTOM_PARAMS_SIZE (SMU_14_0_2_CUSTOM_PARAMS_CLOC=
K_COUNT * SMU_14_0_2_CUSTOM_PARAMS_COUNT * sizeof(long))
> > > +
> > > +static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_conte=
xt *smu,
> > > +                                                 long *input)
> > >  {
> > >       DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
> > >       DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> > >               &(activity_monitor_external.DpmActivityMonitorCoeffInt)=
;
> > > -     int workload_type, ret =3D 0;
> > > -     uint32_t current_profile_mode =3D smu->power_profile_mode;
> > > -     smu->power_profile_mode =3D input[size];
> > > +     int ret, idx;
> > >
> > > -     if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> > > -             dev_err(smu->adev->dev, "Invalid power profile mode %d\=
n", smu->power_profile_mode);
> > > -             return -EINVAL;
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
,
> > > +                                false);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to get activity mo=
nitor!", __func__);
> > > +             return ret;
> > >       }
> > >
> > > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM)=
 {
> > > -             if (size !=3D 9)
> > > -                     return -EINVAL;
> > > +     idx =3D 0 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Gfxclk */
> > > +             activity_monitor->Gfx_FPS =3D input[idx + 1];
> > > +             activity_monitor->Gfx_MinActiveFreqType =3D input[idx +=
 2];
> > > +             activity_monitor->Gfx_MinActiveFreq =3D input[idx + 3];
> > > +             activity_monitor->Gfx_BoosterFreqType =3D input[idx + 4=
];
> > > +             activity_monitor->Gfx_BoosterFreq =3D input[idx + 5];
> > > +             activity_monitor->Gfx_PD_Data_limit_c =3D input[idx + 6=
];
> > > +             activity_monitor->Gfx_PD_Data_error_coeff =3D input[idx=
 + 7];
> > > +             activity_monitor->Gfx_PD_Data_error_rate_coeff =3D inpu=
t[idx + 8];
> > > +     }
> > > +     idx =3D 1 * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
> > > +     if (input[idx]) {
> > > +             /* Fclk */
> > > +             activity_monitor->Fclk_FPS =3D input[idx + 1];
> > > +             activity_monitor->Fclk_MinActiveFreqType =3D input[idx =
+ 2];
> > > +             activity_monitor->Fclk_MinActiveFreq =3D input[idx + 3]=
;
> > > +             activity_monitor->Fclk_BoosterFreqType =3D input[idx + =
4];
> > > +             activity_monitor->Fclk_BoosterFreq =3D input[idx + 5];
> > > +             activity_monitor->Fclk_PD_Data_limit_c =3D input[idx + =
6];
> > > +             activity_monitor->Fclk_PD_Data_error_coeff =3D input[id=
x + 7];
> > > +             activity_monitor->Fclk_PD_Data_error_rate_coeff =3D inp=
ut[idx + 8];
> > > +     }
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                        SMU_TABLE_ACTIVITY_MONITOR_C=
OEFF,
> > > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                        (void *)(&activity_monitor_e=
xternal),
> > > -                                        false);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to get act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > +     ret =3D smu_cmn_update_table(smu,
> > > +                                SMU_TABLE_ACTIVITY_MONITOR_COEFF,
> > > +                                WORKLOAD_PPLIB_CUSTOM_BIT,
> > > +                                (void *)(&activity_monitor_external)=
,
> > > +                                true);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "[%s] Failed to set activity mo=
nitor!", __func__);
> > > +             return ret;
> > > +     }
> > >
> > > -             switch (input[0]) {
> > > -             case 0: /* Gfxclk */
> > > -                     activity_monitor->Gfx_FPS =3D input[1];
> > > -                     activity_monitor->Gfx_MinActiveFreqType =3D inp=
ut[2];
> > > -                     activity_monitor->Gfx_MinActiveFreq =3D input[3=
];
> > > -                     activity_monitor->Gfx_BoosterFreqType =3D input=
[4];
> > > -                     activity_monitor->Gfx_BoosterFreq =3D input[5];
> > > -                     activity_monitor->Gfx_PD_Data_limit_c =3D input=
[6];
> > > -                     activity_monitor->Gfx_PD_Data_error_coeff =3D i=
nput[7];
> > > -                     activity_monitor->Gfx_PD_Data_error_rate_coeff =
=3D input[8];
> > > -                     break;
> > > -             case 1: /* Fclk */
> > > -                     activity_monitor->Fclk_FPS =3D input[1];
> > > -                     activity_monitor->Fclk_MinActiveFreqType =3D in=
put[2];
> > > -                     activity_monitor->Fclk_MinActiveFreq =3D input[=
3];
> > > -                     activity_monitor->Fclk_BoosterFreqType =3D inpu=
t[4];
> > > -                     activity_monitor->Fclk_BoosterFreq =3D input[5]=
;
> > > -                     activity_monitor->Fclk_PD_Data_limit_c =3D inpu=
t[6];
> > > -                     activity_monitor->Fclk_PD_Data_error_coeff =3D =
input[7];
> > > -                     activity_monitor->Fclk_PD_Data_error_rate_coeff=
 =3D input[8];
> > > -                     break;
> > > -             default:
> > > -                     return -EINVAL;
> > > -             }
> > > +     return ret;
> > > +}
> > >
> > > -             ret =3D smu_cmn_update_table(smu,
> > > -                                        SMU_TABLE_ACTIVITY_MONITOR_C=
OEFF,
> > > -                                        WORKLOAD_PPLIB_CUSTOM_BIT,
> > > -                                        (void *)(&activity_monitor_e=
xternal),
> > > -                                        true);
> > > -             if (ret) {
> > > -                     dev_err(smu->adev->dev, "[%s] Failed to set act=
ivity monitor!", __func__);
> > > -                     return ret;
> > > -             }
> > > -     }
> > > +static int smu_v14_0_2_set_power_profile_mode(struct smu_context *sm=
u,
> > > +                                           u32 workload_mask,
> > > +                                           long *custom_params,
> > > +                                           u32 custom_params_max_idx=
)
> > > +{
> > > +     u32 backend_workload_mask =3D 0;
> > > +     int ret, idx, i;
> > > +
> > > +     smu_cmn_get_backend_workload_mask(smu, workload_mask,
> > > +                                       &backend_workload_mask);
> > >
> > > -     if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE=
)
> > > +     /* disable deep sleep if compute is enabled */
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
> > >               smu_v14_0_deep_sleep_control(smu, false);
> > > -     else if (current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPU=
TE)
> > > +     else
> > >               smu_v14_0_deep_sleep_control(smu, true);
> > >
> > > -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > > -     workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > -                                                    CMN2ASIC_MAPPING=
_WORKLOAD,
> > > -                                                    smu->power_profi=
le_mode);
> > > -     if (workload_type < 0)
> > > -             return -EINVAL;
> > > +     if (workload_mask & (1 << PP_SMC_POWER_PROFILE_CUSTOM)) {
> > > +             if (!smu->custom_profile_params) {
> > > +                     smu->custom_profile_params =3D
> > > +                             kzalloc(SMU_14_0_2_CUSTOM_PARAMS_SIZE, =
GFP_KERNEL);
> > > +                     if (!smu->custom_profile_params)
> > > +                             return -ENOMEM;
> > > +             }
> > > +             if (custom_params && custom_params_max_idx) {
> > > +                     if (custom_params_max_idx !=3D SMU_14_0_2_CUSTO=
M_PARAMS_COUNT)
> > > +                             return -EINVAL;
> > > +                     if (custom_params[0] >=3D SMU_14_0_2_CUSTOM_PAR=
AMS_CLOCK_COUNT)
> > > +                             return -EINVAL;
> > > +                     idx =3D custom_params[0] * SMU_14_0_2_CUSTOM_PA=
RAMS_COUNT;
> > > +                     smu->custom_profile_params[idx] =3D 1;
> > > +                     for (i =3D 1; i < custom_params_max_idx; i++)
> > > +                             smu->custom_profile_params[idx + i] =3D=
 custom_params[i];
> > > +             }
> > > +             ret =3D smu_v14_0_2_set_power_profile_mode_coeff(smu,
> > > +                                                            smu->cus=
tom_profile_params);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else if (smu->custom_profile_params) {
> > > +             memset(smu->custom_profile_params, 0, SMU_14_0_2_CUSTOM=
_PARAMS_SIZE);
> > > +     }
> > >
> > > -     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > > -                                            SMU_MSG_SetWorkloadMask,
> > > -                                            1 << workload_type,
> > > -                                            NULL);
> > > -     if (!ret)
> > > -             smu->workload_mask =3D 1 << workload_type;
> > > +     ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloa=
dMask,
> > > +                                           backend_workload_mask, NU=
LL);
> > > +     if (ret) {
> > > +             dev_err(smu->adev->dev, "Failed to set workload mask 0x=
%08x\n",
> > > +                     workload_mask);
> > > +             return ret;
> > > +     }
> > >
> > >       return ret;
> > >  }
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm=
/amd/pm/swsmu/smu_cmn.c
> > > index 007a81e108ec..8f92b2777726 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > @@ -1221,3 +1221,28 @@ void smu_cmn_generic_plpd_policy_desc(struct s=
mu_dpm_policy *policy)
> > >  {
> > >       policy->desc =3D &xgmi_plpd_policy_desc;
> > >  }
> > > +
> > > +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> > > +                                    u32 workload_mask,
> > > +                                    u32 *backend_workload_mask)
> > > +{
> > > +     int workload_type;
> > > +     u32 profile_mode;
> > > +
> > > +     *backend_workload_mask =3D 0;
> > > +
> > > +     for (profile_mode =3D 0; profile_mode < PP_SMC_POWER_PROFILE_CO=
UNT; profile_mode++) {
> > > +             if (!(workload_mask & (1 << profile_mode)))
> > > +                     continue;
> > > +
> > > +             /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT *=
/
> > > +             workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > > +                                                            CMN2ASIC=
_MAPPING_WORKLOAD,
> > > +                                                            profile_=
mode);
> > > +
> > > +             if (workload_type < 0)
> > > +                     continue;
> > > +
> > > +             *backend_workload_mask |=3D 1 << workload_type;
> > > +     }
> > > +}
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm=
/amd/pm/swsmu/smu_cmn.h
> > > index 1de685defe85..a020277dec3e 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> > > @@ -147,5 +147,9 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_=
device *adev);
> > >  void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
> > >  void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)=
;
> > >
> > > +void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
> > > +                                    u32 workload_mask,
> > > +                                    u32 *backend_workload_mask);
> > > +
> > >  #endif
> > >  #endif
