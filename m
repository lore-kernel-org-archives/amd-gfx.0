Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDF7D2AB3C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 13:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8A310E25F;
	Tue, 29 Oct 2024 13:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uj+NRL6A";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BFF10E25F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 13:17:35 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-71e5a00d676so201369b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730207855; x=1730812655; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr5WSVHJE6OYY0KTLInvDWR27TAdLjCXQ3788gkOMnA=;
 b=Uj+NRL6AvofEJlcAEfyeMohCklhNCwdZgUOSm9dpa+BWX5FOX23iosME7b/XWZTHMk
 D5Ki3gsOVS0L1pCE+0R9OYwkjnxOsNaP83u7seQDPQh6PaapJ6MDQaHlcQ+MLGzR/5HT
 2Z43csVhB5xGvWWm+KAhT8qfXXDZthoMI8Nj1mxJSVqS6cNO+CLiVNTRgrFArVbigKrR
 0neVbVw2Gla+1yeITtsZJcNp2SLHi+U/zOdYsqYfaUri68kpJQtrIRuwNzp4wS3oW95z
 CBaRYhkG+VOaad9pD51Mpm+9CGMGjPDj3f31+jZLCymCm//r1DBuOhLF30e2B8Fk5/qk
 u3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730207855; x=1730812655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tr5WSVHJE6OYY0KTLInvDWR27TAdLjCXQ3788gkOMnA=;
 b=IJhKNluPC5mZHXRl/DmaIUJQno9OiPg6OoqwkPBMDwVAYEkww6Wh5B1+OVLFPvq8jM
 QgEh3ZqoEXDoitXuKnRvAHsGPaCFj9H+d47VesOG+Dij2SDEOOKYk9x0NGyZ8AgMjinI
 V1JeKYzVvfcDn8rmDWd78MVCq/RvuSoyevzEFGaHwCf3U67umj8asFq5tWuQrBHKyoRF
 ZH7xwk7hhkL3/D6a7HSdnDbqmhrA4NqkndEmlFLnX1l15uaaaOW92efehSWF7KfbvFW0
 JDfJmD3Ie4F3cZJHbP9dquXeckKPK/sj/hvxeUY3KQqZiHZRhdf6lzUECephYARplyy/
 hAmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6dXk72rdFh/UFlJXVqxwlrTVHuL1RXqlXCox0AODlXj5oAFWGT2U3LFgEnxV8Ziee390D7zPA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH9kmQ1buNiXJi6rM69hUBmYsB/I94XMrC6hbmZkkyOVl9wQmQ
 7+puNN0u3gr8+Aqbabsmwphr+QKwAWo6l3oURJN6qDcXDqHfvpI3AOJU7LFiJGFwFvVnNB9eNJ8
 7+W7cr0VFOMAp2drmJJKkIUKO2Y0=
X-Google-Smtp-Source: AGHT+IFZ/iNY1QfwOZLDByxd6Hl+RgG03YWlyvdY731f27MpR+KbVpE7z0BRqeLXqb38tFZr0Sfh0n6m9y6BC+1uBvE=
X-Received: by 2002:a05:6a00:1798:b0:71e:eaf5:2e with SMTP id
 d2e1a72fcca58-72063020dfamr7290858b3a.3.1730207855091; Tue, 29 Oct 2024
 06:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241024085926.25349-1-kenneth.feng@amd.com>
 <CADnq5_PYPN_B5pk3MrsYf6Q0A5GHNKZXkNjzZRrW_JVqvbxd5g@mail.gmail.com>
 <9c8d4065-fcd4-4a91-ac18-08a66c5ed12a@amd.com>
In-Reply-To: <9c8d4065-fcd4-4a91-ac18-08a66c5ed12a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:17:23 -0400
Message-ID: <CADnq5_NVaWhcNcr-RjGvVyEVJN=iydwbm7NuVhTW_uftP3nZXg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: correct the workload setting
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org, 
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

On Mon, Oct 28, 2024 at 11:48=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 10/28/2024 11:42 PM, Alex Deucher wrote:
> > On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.=
com> wrote:
> >>
> >> Correct the workload setting in order not to mix the setting
> >> with the end user. Update the workload mask accordingly.
> >>
> >> v2: changes as below:
> >> 1. the end user can not erase the workload from driver except default =
workload.
> >> 2. always shows the real highest priority workoad to the end user.
> >> 3. the real workload mask is combined with driver workload mask and en=
d user workload mask.
> >
> > I think this can be simplified.  We just need to store the user
> > workload profile and the mask of all of the currently active workload
> > profiles (the user selected profile and the any transient ones like
> > COMPUTE for KFD, VIDEO for VCN, and POWERSAVE for SMU13, etc.).  At
> > init time, the driver sets the user workload profile to FS3D or
> > DEFAULT per the current logic.  Add a new parameter to
> > ppt_funcs->set_power_profile_mode(), bool
> > update_user_workload_profile, which we set to true in
> > smu_set_power_profile_mode() which is used by the sysfs code to set
> > the user workload profile, and set to false in
> > smu_switch_power_profile() which is used internally for KFD and VCN.
> > Then the user workload profile would only get changed when the user
> > changes it via sysfs.  Meanwhile KFD and VCN can add their workload
> > types dynamically at runtime.
> >
>
> I think this approach doesn't work if we want to restore the user
> settings after a suspend/resume case (unless we expect it to be user
> driven).

We can set update_user_workload_profile =3D true in when init =3D true in
smu_adjust_power_state_dynamic().  That would cover init and resume,
but I guess we'd still need to handle the cases where a user sets
COMPUTE via sysfs and then a ROCm app runs and exits and we need to
keep compute selected.  I guess, the solution goes back to my original
idea from years ago which was to ref count each of the profiles so
that they would stay set until each user dropped its reference.
Anyway for now, I guess Kenneth's patch is fine.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 44 +++++++++++++-----=
-
> >>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
> >>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
> >>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
> >>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---
> >>  5 files changed, 106 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c
> >> index 8d4aee4e2287..1de576461a70 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> @@ -1261,25 +1261,31 @@ static int smu_sw_init(struct amdgpu_ip_block =
*ip_block)
> >>         smu->watermarks_bitmap =3D 0;
> >>         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAUL=
T;
> >>         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTU=
P_DEFAULT;
> >> +       smu->user_dpm_profile.user_workload_mask =3D 0;
> >> +       smu->user_dpm_profile.prev_user_workload_mask =3D 0;
> >>
> >>         atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
> >>         atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
> >>         atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
> >>         atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
> >>
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D=
 0;
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1=
;
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2;
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> >> -       smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =
=3D 0;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D =
1;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2=
;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] =3D 3;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_VR] =3D 4;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
> >> +       smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
> >>
> >>         if (smu->is_apu ||
> >> -           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFI=
LE_FULLSCREEN3D))
> >> -               smu->workload_mask =3D 1 << smu->workload_prority[PP_S=
MC_POWER_PROFILE_BOOTUP_DEFAULT];
> >> -       else
> >> -               smu->workload_mask =3D 1 << smu->workload_prority[PP_S=
MC_POWER_PROFILE_FULLSCREEN3D];
> >> +           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFI=
LE_FULLSCREEN3D)) {
> >> +               smu->workload_mask =3D 1 << smu->workload_priority[PP_=
SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> >> +       } else {
> >> +               smu->workload_mask =3D 1 << smu->workload_priority[PP_=
SMC_POWER_PROFILE_FULLSCREEN3D];
> >> +               smu->default_power_profile_mode =3D PP_SMC_POWER_PROFI=
LE_FULLSCREEN3D;
> >> +       }
> >> +
> >> +       smu->driver_workload_mask =3D smu->workload_mask;
> >>
> >>         smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAU=
LT;
> >>         smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D=
;
> >> @@ -2354,12 +2360,14 @@ static int smu_switch_power_profile(void *hand=
le,
> >>                 return -EINVAL;
> >>
> >>         if (!en) {
> >> -               smu->workload_mask &=3D ~(1 << smu->workload_prority[t=
ype]);
> >> +               smu->workload_mask &=3D ~(1 << smu->workload_priority[=
type]);
> >> +               smu->driver_workload_mask &=3D ~(1 << smu->workload_pr=
iority[type]);
> >>                 index =3D fls(smu->workload_mask);
> >>                 index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX =
? index - 1 : 0;
> >>                 workload[0] =3D smu->workload_setting[index];
> >>         } else {
> >> -               smu->workload_mask |=3D (1 << smu->workload_prority[ty=
pe]);
> >> +               smu->workload_mask |=3D (1 << smu->workload_priority[t=
ype]);
> >> +               smu->driver_workload_mask |=3D (1 << smu->workload_pri=
ority[type]);
> >>                 index =3D fls(smu->workload_mask);
> >>                 index =3D index <=3D WORKLOAD_POLICY_MAX ? index - 1 :=
 0;
> >>                 workload[0] =3D smu->workload_setting[index];
> >> @@ -3054,12 +3062,20 @@ static int smu_set_power_profile_mode(void *ha=
ndle,
> >>                                       uint32_t param_size)
> >>  {
> >>         struct smu_context *smu =3D handle;
> >> +       int ret;
> >>
> >>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> >>             !smu->ppt_funcs->set_power_profile_mode)
> >>                 return -EOPNOTSUPP;
> >>
> >> -       return smu_bump_power_profile_mode(smu, param, param_size);
> >> +       smu->user_dpm_profile.prev_user_workload_mask =3D
> >> +                       smu->user_dpm_profile.user_workload_mask;
> >> +       smu->user_dpm_profile.user_workload_mask =3D (1 << smu->worklo=
ad_priority[param[param_size]]);
> >> +       ret =3D smu_bump_power_profile_mode(smu, param, param_size);
> >> +       smu->user_dpm_profile.prev_user_workload_mask =3D
> >> +                       smu->user_dpm_profile.user_workload_mask;
> >> +
> >> +       return ret;
> >>  }
> >>
> >>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/g=
pu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >> index 8bb32b3f0d9c..88294d986b36 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> >> @@ -240,6 +240,8 @@ struct smu_user_dpm_profile {
> >>         /* user clock state information */
> >>         uint32_t clk_mask[SMU_CLK_COUNT];
> >>         uint32_t clk_dependency;
> >> +       uint32_t user_workload_mask;
> >> +       uint32_t prev_user_workload_mask;
> >>  };
> >>
> >>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
> >> @@ -557,7 +559,8 @@ struct smu_context {
> >>         bool disable_uclk_switch;
> >>
> >>         uint32_t workload_mask;
> >> -       uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> >> +       uint32_t driver_workload_mask;
> >> +       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> >>         uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> >>         uint32_t power_profile_mode;
> >>         uint32_t default_power_profile_mode;
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> index 3e2277abc754..0733fd3efd8b 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> >> @@ -2474,9 +2474,22 @@ static int smu_v13_0_0_set_power_profile_mode(s=
truct smu_context *smu,
> >>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt=
);
> >>         int workload_type, ret =3D 0;
> >>         u32 workload_mask;
> >> +       uint32_t index;
> >>
> >>         smu->power_profile_mode =3D input[size];
> >>
> >> +       if (smu->user_dpm_profile.prev_user_workload_mask !=3D
> >> +               smu->user_dpm_profile.user_workload_mask) {
> >> +               if (smu->workload_mask & smu->user_dpm_profile.prev_us=
er_workload_mask &&
> >> +                       !(smu->driver_workload_mask & smu->user_dpm_pr=
ofile.prev_user_workload_mask))
> >> +                       smu->workload_mask &=3D ~smu->user_dpm_profile=
.prev_user_workload_mask;
> >> +
> >> +               if (input[size] !=3D smu->default_power_profile_mode) =
{
> >> +                       smu->workload_mask &=3D ~(1 << smu->workload_p=
riority[smu->default_power_profile_mode]);
> >> +                       smu->driver_workload_mask &=3D ~(1 << smu->wor=
kload_priority[smu->default_power_profile_mode]);
> >> +               }
> >> +       }
> >
> > This is repeated in several places and could be split out into a
> > helper function.
> >
> >> +
> >>         if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> >>                 dev_err(smu->adev->dev, "Invalid power profile mode %d=
\n", smu->power_profile_mode);
> >>                 return -EINVAL;
> >> @@ -2555,12 +2568,24 @@ static int smu_v13_0_0_set_power_profile_mode(=
struct smu_context *smu,
> >>                         workload_mask |=3D 1 << workload_type;
> >>         }
> >>
> >> +       smu->workload_mask |=3D workload_mask;
> >>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >>                                                SMU_MSG_SetWorkloadMask=
,
> >> -                                              workload_mask,
> >> +                                              smu->workload_mask,
> >>                                                NULL);
> >> -       if (!ret)
> >> -               smu->workload_mask =3D workload_mask;
> >> +       if (!ret) {
> >> +               index =3D fls(smu->workload_mask);
> >> +               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX =
? index - 1 : 0;
> >> +               smu->power_profile_mode =3D smu->workload_setting[inde=
x];
> >> +               if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFIL=
E_POWERSAVING) {
> >> +                       workload_type =3D smu_cmn_to_asic_specific_ind=
ex(smu,
> >> +                                                              CMN2ASI=
C_MAPPING_WORKLOAD,
> >> +                                                              PP_SMC_=
POWER_PROFILE_FULLSCREEN3D);
> >> +                       smu->power_profile_mode =3D smu->workload_mask=
 & (1 << workload_type)
> >> +                                                                     =
          ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> >> +                                                                     =
          : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> >> +               }
> >> +       }
> >>
> >>         return ret;
> >>  }
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> >> index 23f13388455f..2323c74ee50b 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> >> @@ -2429,9 +2429,22 @@ static int smu_v13_0_7_set_power_profile_mode(s=
truct smu_context *smu, long *inp
> >>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt=
);
> >>         int workload_type, ret =3D 0;
> >> +       uint32_t index;
> >>
> >>         smu->power_profile_mode =3D input[size];
> >>
> >> +       if (smu->user_dpm_profile.prev_user_workload_mask !=3D
> >> +               smu->user_dpm_profile.user_workload_mask) {
> >> +               if (smu->workload_mask & smu->user_dpm_profile.prev_us=
er_workload_mask &&
> >> +                       !(smu->driver_workload_mask & smu->user_dpm_pr=
ofile.prev_user_workload_mask))
> >> +                       smu->workload_mask &=3D ~smu->user_dpm_profile=
.prev_user_workload_mask;
> >> +
> >> +               if (input[size] !=3D smu->default_power_profile_mode) =
{
> >> +                       smu->workload_mask &=3D ~(1 << smu->workload_p=
riority[smu->default_power_profile_mode]);
> >> +                       smu->driver_workload_mask &=3D ~(1 << smu->wor=
kload_priority[smu->default_power_profile_mode]);
> >> +               }
> >> +       }
> >> +
> >>         if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> >>                 dev_err(smu->adev->dev, "Invalid power profile mode %d=
\n", smu->power_profile_mode);
> >>                 return -EINVAL;
> >> @@ -2487,13 +2500,19 @@ static int smu_v13_0_7_set_power_profile_mode(=
struct smu_context *smu, long *inp
> >>                                                        smu->power_prof=
ile_mode);
> >>         if (workload_type < 0)
> >>                 return -EINVAL;
> >> +
> >> +       smu->workload_mask |=3D (1 << workload_type);
> >>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorklo=
adMask,
> >> -                                   1 << workload_type, NULL);
> >> +                                   smu->workload_mask, NULL);
> >>
> >>         if (ret)
> >>                 dev_err(smu->adev->dev, "[%s] Failed to set work load =
mask!", __func__);
> >> -       else
> >> -               smu->workload_mask =3D (1 << workload_type);
> >> +
> >> +       if (!ret) {
> >> +               index =3D fls(smu->workload_mask);
> >> +               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX =
? index - 1 : 0;
> >> +               smu->power_profile_mode =3D smu->workload_setting[inde=
x];
> >> +       }
> >>
> >>         return ret;
> >>  }
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >> index cefe10b95d8e..c2fd47f04e2d 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> >> @@ -1787,9 +1787,22 @@ static int smu_v14_0_2_set_power_profile_mode(s=
truct smu_context *smu,
> >>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
> >>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt=
);
> >>         int workload_type, ret =3D 0;
> >> +       uint32_t index;
> >>         uint32_t current_profile_mode =3D smu->power_profile_mode;
> >>         smu->power_profile_mode =3D input[size];
> >>
> >> +       if (smu->user_dpm_profile.prev_user_workload_mask !=3D
> >> +               smu->user_dpm_profile.user_workload_mask) {
> >> +               if (smu->workload_mask & smu->user_dpm_profile.prev_us=
er_workload_mask &&
> >> +                       !(smu->driver_workload_mask & smu->user_dpm_pr=
ofile.prev_user_workload_mask))
> >> +                       smu->workload_mask &=3D ~smu->user_dpm_profile=
.prev_user_workload_mask;
> >> +
> >> +               if (input[size] !=3D smu->default_power_profile_mode) =
{
> >> +                       smu->workload_mask &=3D ~(1 << smu->workload_p=
riority[smu->default_power_profile_mode]);
> >> +                       smu->driver_workload_mask &=3D ~(1 << smu->wor=
kload_priority[smu->default_power_profile_mode]);
> >> +               }
> >> +       }
> >> +
> >>         if (smu->power_profile_mode >=3D PP_SMC_POWER_PROFILE_COUNT) {
> >>                 dev_err(smu->adev->dev, "Invalid power profile mode %d=
\n", smu->power_profile_mode);
> >>                 return -EINVAL;
> >> @@ -1857,12 +1870,15 @@ static int smu_v14_0_2_set_power_profile_mode(=
struct smu_context *smu,
> >>         if (workload_type < 0)
> >>                 return -EINVAL;
> >>
> >> -       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >> -                                              SMU_MSG_SetWorkloadMask=
,
> >> -                                              1 << workload_type,
> >> -                                              NULL);
> >> -       if (!ret)
> >> -               smu->workload_mask =3D 1 << workload_type;
> >> +       smu->workload_mask |=3D (1 << workload_type);
> >> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorklo=
adMask,
> >> +                                                                     =
            smu->workload_mask, NULL);
> >> +
> >> +       if (!ret) {
> >> +               index =3D fls(smu->workload_mask);
> >> +               index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX =
? index - 1 : 0;
> >> +               smu->power_profile_mode =3D smu->workload_setting[inde=
x];
> >> +       }
> >>
> >>         return ret;
> >>  }
> >> --
> >> 2.34.1
> >>
