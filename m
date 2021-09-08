Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64540C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 07:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B230610E9
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 07:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B230610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qtec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA696E135;
	Wed,  8 Sep 2021 07:23:20 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEBC6E141
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 07:23:20 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id l18so1861619lji.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Sep 2021 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtec.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OwKf0HV67IDirrorXU7BYF7m3DFElUntNg+ywW6Bkus=;
 b=TBrqYtXJU/It1vvMMVp8YZrFMHDejXJ5Rd8rlP6f1u4tYOz8hIJdUmmHfvIc9+LKyq
 dmUZZVmO9ck+1GotxAD0ewnoUzs5T0XzcKq+jLdUTBfVpQgbe+BTgTPLuh4t755h9IkJ
 PbYBitvtLnr3BZ7NNYAHo/jjWhhPiz/+HRB5Mnwb/GUOAXwLL1aYM3AsbeuulrRGr0Kn
 iBMhnGQC5oGYvJn2wDQexnwa9L1yt231l8Nv1IuF51bi5c15xhgBIQjGLZDtF2Nn5lht
 NRziK3WJAAiDln4oMbkNdpoForXXInLxLs5J9ERq2fkEL0lQe9/lnkPvfNPLDXExSyKf
 OChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OwKf0HV67IDirrorXU7BYF7m3DFElUntNg+ywW6Bkus=;
 b=a1aV1rXEgsg2Ah4rsnhfVwMhERZMC7UO70DjwNVGT+M54ZdYh90l4aauo4Gs/1eNkY
 Yqxz/7jJJtm627wOdCpv95s5CUigyysxgvRWj+K1zqGJIw0xuNA6wYEHUlfsfp5123/x
 tCJXMUuioJkHPFkF6QvtrU7Vx4fgFeIj6/Tz3RGs5gA4qzTcdu3HaehpOmx2YAO7N1S8
 VTahTnuTI1w8H206oSgOfwE+qpZytXLk66QxBC9gcjZ2NnjRzRqVi1jKSMXtessXs1J3
 r6lqjyeHgr24hXDAkScapdrY3Q2u74Ur6cmTihs2lCZab+3HWaOI27NSzrmD6ozh5utZ
 BNmg==
X-Gm-Message-State: AOAM5326aaOfIBw1kU6BcEAHayGh7Uj28f538Y30y+KqhqRwpntJ93Ci
 cxQ/vfI4Yo0qsLj+qylDY4r4IERLY9MMLtUCErNEAB6Uj83976yB
X-Google-Smtp-Source: ABdhPJyfGpBHMqxjSHJiKpELu/+6DbgTVDN1eWaIe5fSF5aORjK1o3PgkEW6WhoK9hCE6RsLUpH7cr/C0RBQFBZzREk=
X-Received: by 2002:a05:651c:28f:: with SMTP id
 b15mr1754198ljo.186.1631085798012; 
 Wed, 08 Sep 2021 00:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210907085301.482579-1-daniel@qtec.com>
 <CADnq5_N3ue6c6XzX+Nu=adsfhCZ6jkUVwNvQqy-Z_TjjGgsPmA@mail.gmail.com>
In-Reply-To: <CADnq5_N3ue6c6XzX+Nu=adsfhCZ6jkUVwNvQqy-Z_TjjGgsPmA@mail.gmail.com>
From: Daniel Gomez <daniel@qtec.com>
Date: Wed, 8 Sep 2021 09:23:06 +0200
Message-ID: <CAH1Ww+QXyoE-YvCZhG3PQ0n43E0R8ydt=GMb08xYF3YqV8o5UQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] drm/amdgpu/powerplay/smu10: Add custom profile
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Gomez <dagmcr@gmail.com>, 
 "Quan, Evan" <evan.quan@amd.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>, xinhui pan <Xinhui.Pan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 7 Sept 2021 at 19:23, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Sep 7, 2021 at 4:53 AM Daniel Gomez <daniel@qtec.com> wrote:
> >
> > Add custom power profile mode support on smu10.
> > Update workload bit list.
> > ---
> >
> > Hi,
> >
> > I'm trying to add custom profile for the Raven Ridge but not sure if
> > I'd need a different parameter than PPSMC_MSG_SetCustomPolicy to
> > configure the custom values. The code seemed to support CUSTOM for
> > workload types but it didn't show up in the menu or accept any user
> > input parameter. So far, I've added that part but a bit confusing to
> > me what is the policy I need for setting these parameters or if it's
> > maybe not possible at all.
> >
> > After applying the changes I'd configure the CUSTOM mode as follows:
> >
> > echo manual > /sys/class/drm/card0/device/hwmon/hwmon1/device/power_dpm_force_performance_level
> > echo "6 70 90 0 0" > /sys/class/drm/card0/device/hwmon/hwmon1/device/pp_power_profile_mode
> >
> > Then, using Darren Powell script for testing modes I get the following
> > output:
> >
> > 05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] [1002:15dd] (rev 83)
> > === pp_dpm_sclk ===
> > 0: 200Mhz
> > 1: 400Mhz *
> > 2: 1100Mhz
> > === pp_dpm_mclk ===
> > 0: 400Mhz
> > 1: 933Mhz *
> > 2: 1067Mhz
> > 3: 1200Mhz
> > === pp_power_profile_mode ===
> > NUM        MODE_NAME BUSY_SET_POINT FPS USE_RLC_BUSY MIN_ACTIVE_LEVEL
> >   0 BOOTUP_DEFAULT :             70  60          0              0
> >   1 3D_FULL_SCREEN :             70  60          1              3
> >   2   POWER_SAVING :             90  60          0              0
> >   3          VIDEO :             70  60          0              0
> >   4             VR :             70  90          0              0
> >   5        COMPUTE :             30  60          0              6
> >   6         CUSTOM*:             70  90          0              0
> >
> > As you can also see in my changes, I've also updated the workload bit
> > table but I'm not completely sure about that change. With the tests
> > I've done, using bit 5 for the WORKLOAD_PPLIB_CUSTOM_BIT makes the
> > gpu sclk locked around ~36%. So, maybe I'm missing a clock limit
> > configuraton table somewhere. Would you give me some hints to
> > proceed with this?
>
> I don't think APUs support customizing the workloads the same way
> dGPUs do.  I think they just support predefined profiles.
>
> Alex


Thanks Alex for the quick response. Would it make sense then to remove
the custom workload code (PP_SMC_POWER_PROFILE_CUSTOM) from the smu10?
That workload was added in this commit:
f6f75ebdc06c04d3cfcd100f1b10256a9cdca407 [1] and not use at all in the
code as it's limited to PP_SMC_POWER_PROFILE_COMPUTE index. The
smu10.h also includes the custom workload bit definition and that was
a bit confusing for me to understand if it was half-supported or not
possible to use at all as I understood from your comment.

Perhaps could also be mentioned (if that's kind of standard) in the
documentation[2] so, the custom pp_power_profile_mode is only
supported in dGPUs.

I can send the patches if it makes sense.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c?id=f6f75ebdc06c04d3cfcd100f1b10256a9cdca407
[2]: https://www.kernel.org/doc/html/latest/gpu/amdgpu.html#pp-power-profile-mode

Daniel

>
>
> >
> > Thanks in advance,
> > Daniel
> >
> >
> >  drivers/gpu/drm/amd/pm/inc/smu10.h            | 14 +++--
> >  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 57 +++++++++++++++++--
> >  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h  |  1 +
> >  3 files changed, 61 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/inc/smu10.h
> > index 9e837a5014c5..b96520528240 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu10.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu10.h
> > @@ -136,12 +136,14 @@
> >  #define FEATURE_CORE_CSTATES_MASK     (1 << FEATURE_CORE_CSTATES_BIT)
> >
> >  /* Workload bits */
> > -#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
> > -#define WORKLOAD_PPLIB_VIDEO_BIT          2
> > -#define WORKLOAD_PPLIB_VR_BIT             3
> > -#define WORKLOAD_PPLIB_COMPUTE_BIT        4
> > -#define WORKLOAD_PPLIB_CUSTOM_BIT         5
> > -#define WORKLOAD_PPLIB_COUNT              6
> > +#define WORKLOAD_DEFAULT_BIT              0
> > +#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
> > +#define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
> > +#define WORKLOAD_PPLIB_VIDEO_BIT          3
> > +#define WORKLOAD_PPLIB_VR_BIT             4
> > +#define WORKLOAD_PPLIB_COMPUTE_BIT        5
> > +#define WORKLOAD_PPLIB_CUSTOM_BIT         6
> > +#define WORKLOAD_PPLIB_COUNT              7
> >
> >  typedef struct {
> >         /* MP1_EXT_SCRATCH0 */
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> > index 1de3ae77e03e..fef9f9ac1c56 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> > @@ -110,6 +110,11 @@ static int smu10_initialize_dpm_defaults(struct pp_hwmgr *hwmgr)
> >         smu10_data->num_active_display = 0;
> >         smu10_data->deep_sleep_dcefclk = 0;
> >
> > +       smu10_data->custom_profile_mode[0] = 0;
> > +       smu10_data->custom_profile_mode[1] = 0;
> > +       smu10_data->custom_profile_mode[2] = 0;
> > +       smu10_data->custom_profile_mode[3] = 0;
> > +
> >         phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> >                                         PHM_PlatformCaps_SclkDeepSleep);
> >
> > @@ -544,6 +549,10 @@ static int smu10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
> >
> >         hwmgr->backend = data;
> >
> > +       hwmgr->workload_mask = 1 << hwmgr->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> > +       hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > +       hwmgr->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> > +
> >         result = smu10_initialize_dpm_defaults(hwmgr);
> >         if (result != 0) {
> >                 pr_err("smu10_initialize_dpm_defaults failed\n");
> > @@ -1408,9 +1417,15 @@ static int conv_power_profile_to_pplib_workload(int power_profile)
> >         int pplib_workload = 0;
> >
> >         switch (power_profile) {
> > +       case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT:
> > +               pplib_workload = WORKLOAD_DEFAULT_BIT;
> > +               break;
> >         case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
> >                 pplib_workload = WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
> >                 break;
> > +       case PP_SMC_POWER_PROFILE_POWERSAVING:
> > +               pplib_workload = WORKLOAD_PPLIB_POWER_SAVING_BIT;
> > +               break;
> >         case PP_SMC_POWER_PROFILE_VIDEO:
> >                 pplib_workload = WORKLOAD_PPLIB_VIDEO_BIT;
> >                 break;
> > @@ -1430,22 +1445,24 @@ static int conv_power_profile_to_pplib_workload(int power_profile)
> >
> >  static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
> >  {
> > +       struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
> >         uint32_t i, size = 0;
> >         static const uint8_t
> > -               profile_mode_setting[6][4] = {{70, 60, 0, 0,},
> > +               profile_mode_setting[7][4] = {{70, 60, 0, 0,},
> >                                                 {70, 60, 1, 3,},
> >                                                 {90, 60, 0, 0,},
> >                                                 {70, 60, 0, 0,},
> >                                                 {70, 90, 0, 0,},
> >                                                 {30, 60, 0, 6,},
> >                                                 };
> > -       static const char *profile_name[6] = {
> > +       static const char *profile_name[7] = {
> >                                         "BOOTUP_DEFAULT",
> >                                         "3D_FULL_SCREEN",
> >                                         "POWER_SAVING",
> >                                         "VIDEO",
> >                                         "VR",
> > -                                       "COMPUTE"};
> > +                                       "COMPUTE",
> > +                                       "CUSTOM"};
> >         static const char *title[6] = {"NUM",
> >                         "MODE_NAME",
> >                         "BUSY_SET_POINT",
> > @@ -1459,11 +1476,15 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
> >         size += sysfs_emit_at(buf, size, "%s %16s %s %s %s %s\n",title[0],
> >                         title[1], title[2], title[3], title[4], title[5]);
> >
> > -       for (i = 0; i <= PP_SMC_POWER_PROFILE_COMPUTE; i++)
> > +       for (i = 0; i < PP_SMC_POWER_PROFILE_CUSTOM; i++)
> >                 size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n",
> >                         i, profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
> >                         profile_mode_setting[i][0], profile_mode_setting[i][1],
> >                         profile_mode_setting[i][2], profile_mode_setting[i][3]);
> > +       size += sysfs_emit_at(buf, size, "%3d %14s%s: %14d %3d %10d %14d\n", i,
> > +                       profile_name[i], (i == hwmgr->power_profile_mode) ? "*" : " ",
> > +                       smu10_data->custom_profile_mode[0], smu10_data->custom_profile_mode[1],
> > +                       smu10_data->custom_profile_mode[2], smu10_data->custom_profile_mode[3]);
> >
> >         return size;
> >  }
> > @@ -1480,16 +1501,42 @@ static bool smu10_is_raven1_refresh(struct pp_hwmgr *hwmgr)
> >
> >  static int smu10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint32_t size)
> >  {
> > +       struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
> > +       uint8_t busy_set_point, FPS, use_rlc_busy, min_active_level;
> > +       uint32_t power_profile_mode = input[size];
> >         int workload_type = 0;
> >         int result = 0;
> >
> > -       if (input[size] > PP_SMC_POWER_PROFILE_COMPUTE) {
> > +       if (input[size] > PP_SMC_POWER_PROFILE_CUSTOM) {
> >                 pr_err("Invalid power profile mode %ld\n", input[size]);
> >                 return -EINVAL;
> >         }
> >         if (hwmgr->power_profile_mode == input[size])
> >                 return 0;
> >
> > +       if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> > +               if (size != 0 && size != 4)
> > +                       return -EINVAL;
> > +
> > +               if (size == 0) {
> > +                       if (smu10_data->custom_profile_mode[0] != 0)
> > +                               goto out;
> > +                       else
> > +                               return -EINVAL;
> > +               }
> > +
> > +               smu10_data->custom_profile_mode[0] = busy_set_point = input[0];
> > +               smu10_data->custom_profile_mode[1] = FPS = input[1];
> > +               smu10_data->custom_profile_mode[2] = use_rlc_busy = input[2];
> > +               smu10_data->custom_profile_mode[3] = min_active_level = input[3];
> > +               smum_send_msg_to_smc_with_parameter(hwmgr,
> > +                                       PPSMC_MSG_SetCustomPolicy,
> > +                                       busy_set_point | FPS<<8 |
> > +                                       use_rlc_busy << 16 | min_active_level<<24,
> > +                                       NULL);
> > +       }
> > +
> > +out:
> >         /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> >         workload_type =
> >                 conv_power_profile_to_pplib_workload(input[size]);
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> > index 808e0ecbe1f0..4c4b2b1b510a 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> > @@ -302,6 +302,7 @@ struct smu10_hwmgr {
> >         uint32_t                             num_active_display;
> >
> >         bool                                                    fine_grain_enabled;
> > +       uint8_t                              custom_profile_mode[4];
> >  };
> >
> >  struct pp_hwmgr;
> > --
> > 2.30.2
> >
