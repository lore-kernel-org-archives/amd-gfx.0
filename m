Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFABC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 06:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF38A61C9D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 06:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF38A61C9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC916E808;
	Wed,  7 Jul 2021 06:27:00 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A306E063
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 06:26:59 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id h1so491823plf.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jul 2021 23:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v4xYnAUvwELytQ4GbqvjwZYXajbTF6L30p4GaUwn+lE=;
 b=GuG1fmqyv5jsFF8mtCsR2OvddooxFTr4Y7iPD74kPUIGxBbBojuePGGdLqLpmd/ao7
 /Wng4Pc1R9s5zcNgiPsvMCsVG/Zjvn0/xUyw5z6JRlJbSZUp8LnKvuMhAtJiKCY5nXXp
 6O4cMsP2N9DxgfaLKHYeWMuAsjcA3Mmz+Xj1+xwnQ0qaGRPaR1BADA7IZUQmD6qsdg89
 vvPdFk4XtqMICAdBxQl1wIpO8A/gH5BkGJ/VH8Xw1Q8LFSypGgebX9VlCkHHm+aaDFvB
 L+I3yKrJJa0qbLJ8hCvjZ8j8W8C6OsRPJ4OojYJiEE8xCasfOXbm+wXCLTFRtcqsxmlu
 R0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v4xYnAUvwELytQ4GbqvjwZYXajbTF6L30p4GaUwn+lE=;
 b=S1ylJvxglosBSGckgwSaWOrSb5B5Dons89JLEsP+a1PSxHah/fHYluRhe486JcEdzF
 tdeje6OSMElU5Bhtipzq3UHpHqNiaZzpaks00Pfrk2A4gnVkYfYCF8wLCeyZOweqMhH4
 /HTAUQykzj0RZuaMOKt7w4YgXY/3c0ks79Eayw0u9DH6X6PxJ4V3BarC8rgpKxdRsxbf
 9mkSyAafLRd+dEedGs2pEGM7wK7/rsMmRH3gscdlBD2K8HJdwmebkmO1hY27LHVXjN6X
 xSpUVIbZJBRk7Vs216MGWBE1v2jJwlnKi6EwOQLl79Kv4FShARvxgWPLqZ9FHYmubUSf
 Ze9A==
X-Gm-Message-State: AOAM533j7oi18vWTbj+9yJx2OZQ2EKqvZXaid5VyZ5F3EdOuTTqDf7mV
 k9ogP14pmHAmhisgXtD7/LWpltap57Xai8SsNqg=
X-Google-Smtp-Source: ABdhPJzkJMbELKZW2y4lOuNd6dQ3Nnh6TCQ6tldoq1CDCvI5KWGOZNLXGICQrmvamOPuh76d3VtUDS5CrvaqhD5pNxc=
X-Received: by 2002:a17:90a:d3d2:: with SMTP id
 d18mr4454122pjw.102.1625639219159; 
 Tue, 06 Jul 2021 23:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-5-evan.quan@amd.com>
In-Reply-To: <20210707015647.139127-5-evan.quan@amd.com>
From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>
Date: Wed, 7 Jul 2021 08:26:47 +0200
Message-ID: <CA+nq7DuCPuUG=KqGXg7sVyaSw9VanVOGuRJ7tWTOBU84e1z55A@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amd/pm: drop the unnecessary intermediate
 percent-based transition
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0048944977=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0048944977==
Content-Type: multipart/alternative; boundary="00000000000030e53605c682a008"

--00000000000030e53605c682a008
Content-Type: text/plain; charset="UTF-8"

Hi Evan,

Bit of a drive by comment but I think that maybe all the
*_fan_speed_percent() function names are a bit confusing if they no longer
operate on percents but on a duty cycle unit of 0-255. No good idea what to
call them though :-\

Also max() could be used in a bunch of places instead of

    if (speed > 255)
              speed = 255;

Regards,
Nils

Den ons 7 juli 2021 03:59Evan Quan <evan.quan@amd.com> skrev:

> Currently, the readout of fan speed pwm is transited into percent-based
> and then pwm-based. However, the transition into percent-based is totally
> unnecessary and make the final output less accurate.
>
> Change-Id: Ib99e088cda1875b4e2601f7077a178af6fe8a6cb
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  4 ----
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  4 ++--
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  | 12 ++++++------
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  2 +-
>  .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 10 +++++-----
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  2 +-
>  .../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    | 12 ++++++------
>  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 12 ++----------
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 +++++++-------
>  10 files changed, 35 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 769f58d5ae1a..e9c98e3f4cfb 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2469,8 +2469,6 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device
> *dev,
>                 return err;
>         }
>
> -       value = (value * 100) / 255;
> -
>         if (adev->powerplay.pp_funcs->set_fan_speed_percent)
>                 err = amdgpu_dpm_set_fan_speed_percent(adev, value);
>         else
> @@ -2515,8 +2513,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device
> *dev,
>         if (err)
>                 return err;
>
> -       speed = (speed * 255) / 100;
> -
>         return sprintf(buf, "%i\n", speed);
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0541bfc81c1b..aa353a628c50 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3212,7 +3212,7 @@ static int smu7_force_dpm_level(struct pp_hwmgr
> *hwmgr,
>
>         if (!ret) {
>                 if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK &&
> hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> -                       smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +                       smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>                 else if (level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK &&
> hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
>                         smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);
>         }
> @@ -4988,7 +4988,7 @@ static void smu7_set_fan_control_mode(struct
> pp_hwmgr *hwmgr, uint32_t mode)
>  {
>         switch (mode) {
>         case AMD_FAN_CTRL_NONE:
> -               smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +               smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>                 break;
>         case AMD_FAN_CTRL_MANUAL:
>                 if
> (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> index 6cfe148ed45b..70ccc127e3fd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> @@ -70,12 +70,12 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>                 return -EINVAL;
>
>
> -       tmp64 = (uint64_t)duty * 100;
> +       tmp64 = (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
>         *speed = (uint32_t)tmp64;
>
> -       if (*speed > 100)
> -               *speed = 100;
> +       if (*speed > 255)
> +               *speed = 255;
>
>         return 0;
>  }
> @@ -214,8 +214,8 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>         if (hwmgr->thermal_controller.fanInfo.bNoFan)
>                 return 0;
>
> -       if (speed > 100)
> -               speed = 100;
> +       if (speed > 255)
> +               speed = 255;
>
>         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>                 smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
> @@ -227,7 +227,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>                 return -EINVAL;
>
>         tmp64 = (uint64_t)speed * duty100;
> -       do_div(tmp64, 100);
> +       do_div(tmp64, 255);
>         duty = (uint32_t)tmp64;
>
>         PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 25979106fd25..44c5e2588046 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4199,7 +4199,7 @@ static void vega10_set_fan_control_mode(struct
> pp_hwmgr *hwmgr, uint32_t mode)
>
>         switch (mode) {
>         case AMD_FAN_CTRL_NONE:
> -               vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +               vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>                 break;
>         case AMD_FAN_CTRL_MANUAL:
>                 if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index 9b46b27bd30c..6b4c4294afca 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -78,11 +78,11 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>
>         if (hwmgr->thermal_controller.
>                         advanceFanControlParameters.usMaxFanRPM != 0)
> -               percent = current_rpm * 100 /
> +               percent = current_rpm * 255 /
>                         hwmgr->thermal_controller.
>                         advanceFanControlParameters.usMaxFanRPM;
>
> -       *speed = percent > 100 ? 100 : percent;
> +       *speed = percent > 255 ? 255 : percent;
>
>         return 0;
>  }
> @@ -257,8 +257,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>         if (hwmgr->thermal_controller.fanInfo.bNoFan)
>                 return 0;
>
> -       if (speed > 100)
> -               speed = 100;
> +       if (speed > 255)
> +               speed = 255;
>
>         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>                 vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
> @@ -270,7 +270,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>                 return -EINVAL;
>
>         tmp64 = (uint64_t)speed * duty100;
> -       do_div(tmp64, 100);
> +       do_div(tmp64, 255);
>         duty = (uint32_t)tmp64;
>
>         WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 0791309586c5..cbe5f8027ee0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -2769,7 +2769,7 @@ static void vega20_set_fan_control_mode(struct
> pp_hwmgr *hwmgr, uint32_t mode)
>  {
>         switch (mode) {
>         case AMD_FAN_CTRL_NONE:
> -               vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +               vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>                 break;
>         case AMD_FAN_CTRL_MANUAL:
>                 if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> index 43d754952bd9..eb007c00d7c6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> @@ -129,12 +129,12 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>         if (!duty100)
>                 return -EINVAL;
>
> -       tmp64 = (uint64_t)duty * 100;
> +       tmp64 = (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
>         *speed = (uint32_t)tmp64;
>
> -       if (*speed > 100)
> -               *speed = 100;
> +       if (*speed > 255)
> +               *speed = 255;
>
>         return 0;
>  }
> @@ -147,8 +147,8 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>         uint32_t duty;
>         uint64_t tmp64;
>
> -       if (speed > 100)
> -               speed = 100;
> +       if (speed > 255)
> +               speed = 255;
>
>         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>                 vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
> @@ -160,7 +160,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct
> pp_hwmgr *hwmgr,
>                 return -EINVAL;
>
>         tmp64 = (uint64_t)speed * duty100;
> -       do_div(tmp64, 100);
> +       do_div(tmp64, 255);
>         duty = (uint32_t)tmp64;
>
>         WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 15c0b8af376f..96ca359c10a5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -6555,12 +6555,12 @@ static int si_dpm_get_fan_speed_percent(void
> *handle,
>         if (duty100 == 0)
>                 return -EINVAL;
>
> -       tmp64 = (u64)duty * 100;
> +       tmp64 = (u64)duty * 255;
>         do_div(tmp64, duty100);
>         *speed = (u32)tmp64;
>
> -       if (*speed > 100)
> -               *speed = 100;
> +       if (*speed > 255)
> +               *speed = 255;
>
>         return 0;
>  }
> @@ -6580,7 +6580,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
>         if (si_pi->fan_is_controlled_by_smc)
>                 return -EINVAL;
>
> -       if (speed > 100)
> +       if (speed > 255)
>                 return -EINVAL;
>
>         duty100 = (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >>
> FMAX_DUTY100_SHIFT;
> @@ -6589,7 +6589,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
>                 return -EINVAL;
>
>         tmp64 = (u64)speed * duty100;
> -       do_div(tmp64, 100);
> +       do_div(tmp64, 255);
>         duty = (u32)tmp64;
>
>         tmp = RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 54fb3d7d23ee..94c15526ad21 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2565,23 +2565,17 @@ static int smu_get_fan_speed_percent(void *handle,
> u32 *speed)
>  {
>         struct smu_context *smu = handle;
>         int ret = 0;
> -       uint32_t percent;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
>
>         mutex_lock(&smu->mutex);
>
> -       if (smu->ppt_funcs->get_fan_speed_percent) {
> -               ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
> -               if (!ret) {
> -                       *speed = percent > 100 ? 100 : percent;
> -               }
> -       }
> +       if (smu->ppt_funcs->get_fan_speed_percent)
> +               ret = smu->ppt_funcs->get_fan_speed_percent(smu, speed);
>
>         mutex_unlock(&smu->mutex);
>
> -
>         return ret;
>  }
>
> @@ -2596,8 +2590,6 @@ static int smu_set_fan_speed_percent(void *handle,
> u32 speed)
>         mutex_lock(&smu->mutex);
>
>         if (smu->ppt_funcs->set_fan_speed_percent) {
> -               if (speed > 100)
> -                       speed = 100;
>                 ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
>                 if (!ret && !(smu->user_dpm_profile.flags &
> SMU_DPM_USER_PROFILE_RESTORE)) {
>                         smu->user_dpm_profile.custom_fan_speed |=
> SMU_CUSTOM_FAN_SPEED_PWM;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0cdf55a0dba2..f0ae0920c07e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1191,8 +1191,8 @@ smu_v11_0_set_fan_speed_percent(struct smu_context
> *smu, uint32_t speed)
>         uint32_t duty100, duty;
>         uint64_t tmp64;
>
> -       if (speed > 100)
> -               speed = 100;
> +       if (speed > 255)
> +               speed = 255;
>
>         if (smu_v11_0_auto_fan_control(smu, 0))
>                 return -EINVAL;
> @@ -1203,7 +1203,7 @@ smu_v11_0_set_fan_speed_percent(struct smu_context
> *smu, uint32_t speed)
>                 return -EINVAL;
>
>         tmp64 = (uint64_t)speed * duty100;
> -       do_div(tmp64, 100);
> +       do_div(tmp64, 255);
>         duty = (uint32_t)tmp64;
>
>         WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> @@ -1274,12 +1274,12 @@ int smu_v11_0_get_fan_speed_percent(struct
> smu_context *smu,
>         if (!duty100)
>                 return -EINVAL;
>
> -       tmp64 = (uint64_t)duty * 100;
> +       tmp64 = (uint64_t)duty * 255;
>         do_div(tmp64, duty100);
>         *speed = (uint32_t)tmp64;
>
> -       if (*speed > 100)
> -               *speed = 100;
> +       if (*speed > 255)
> +               *speed = 255;
>
>         return 0;
>  }
> @@ -1320,7 +1320,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context
> *smu,
>
>         switch (mode) {
>         case AMD_FAN_CTRL_NONE:
> -               ret = smu_v11_0_set_fan_speed_percent(smu, 100);
> +               ret = smu_v11_0_set_fan_speed_percent(smu, 255);
>                 break;
>         case AMD_FAN_CTRL_MANUAL:
>                 ret = smu_v11_0_auto_fan_control(smu, 0);
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000030e53605c682a008
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Evan,<div dir=3D"auto"><br></div><div dir=3D"auto=
">Bit of a drive by comment but I think that maybe all the *_fan_speed_perc=
ent() function names are a bit confusing if they no longer operate on perce=
nts but on a duty cycle unit of 0-255. No good idea what to call them thoug=
h :-\</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also max() could b=
e used in a bunch of places instead of</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">=C2=A0<span style=3D"font-family:sans-serif;font-size:12.8px=
">=C2=A0 =C2=A0if (speed &gt; 255)</span></div><span style=3D"font-family:s=
ans-serif;font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 speed =3D 255;</span><br><br>Regards,</div><div dir=3D"auto">Nils<br><b=
r><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_a=
ttr">Den ons 7 juli 2021 03:59Evan Quan &lt;<a href=3D"mailto:evan.quan@amd=
.com">evan.quan@amd.com</a>&gt; skrev:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Currently, the readout of fan speed pwm is transited into percent-based=
<br>
and then pwm-based. However, the transition into percent-based is totally<b=
r>
unnecessary and make the final output less accurate.<br>
<br>
Change-Id: Ib99e088cda1875b4e2601f7077a178af6fe8a6cb<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" target=3D=
"_blank" rel=3D"noreferrer">evan.quan@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/pm/amdgpu_pm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ----<br>
=C2=A0.../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c=C2=A0 =C2=A0 |=C2=A0 =
4 ++--<br>
=C2=A0.../gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c=C2=A0 | 12 ++++++--=
----<br>
=C2=A0.../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c=C2=A0 |=C2=A0 2 +-<=
br>
=C2=A0.../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c=C2=A0 =C2=A0 | 10 +++=
++-----<br>
=C2=A0.../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c=C2=A0 |=C2=A0 2 +-<=
br>
=C2=A0.../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c=C2=A0 =C2=A0 | 12 +++=
+++------<br>
=C2=A0drivers/gpu/drm/amd/pm/powerplay/si_dpm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 10 +++++-----<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 12 ++----------<br>
=C2=A0drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c=C2=A0 =C2=A0 =C2=A0| 1=
4 +++++++-------<br>
=C2=A010 files changed, 35 insertions(+), 47 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 769f58d5ae1a..e9c98e3f4cfb 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2469,8 +2469,6 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *d=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D (value * 100) / 255;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;powerplay.pp_funcs-&gt;set_fan_spe=
ed_percent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D amdgpu_dpm_=
set_fan_speed_percent(adev, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
@@ -2515,8 +2513,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *d=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D (speed * 255) / 100;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%i\n&quot;, speed);<b=
r>
=C2=A0}<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
index 0541bfc81c1b..aa353a628c50 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3212,7 +3212,7 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmg=
r,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (level =3D=3D AM=
D_DPM_FORCED_LEVEL_PROFILE_PEAK &amp;&amp; hwmgr-&gt;dpm_level !=3D AMD_DPM=
_FORCED_LEVEL_PROFILE_PEAK)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (level !=3D=
 AMD_DPM_FORCED_LEVEL_PROFILE_PEAK &amp;&amp; hwmgr-&gt;dpm_level =3D=3D AM=
D_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -4988,7 +4988,7 @@ static void smu7_set_fan_control_mode(struct pp_hwmgr=
 *hwmgr, uint32_t mode)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_NONE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu7_fan_ctrl_set_f=
an_speed_percent(hwmgr, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smu7_fan_ctrl_set_f=
an_speed_percent(hwmgr, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_MANUAL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (phm_cap_enabled=
(hwmgr-&gt;platform_descriptor.platformCaps,<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c<br>
index 6cfe148ed45b..70ccc127e3fd 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c<br>
@@ -70,12 +70,12 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr=
 *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 255;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_div(tmp64, duty100);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *speed =3D (uint32_t)tmp64;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -214,8 +214,8 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr=
 *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hwmgr-&gt;thermal_controller.fanInfo.bNoFan=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smu7_fan_ctrl_stop_=
smc_fan_control(hwmgr);<br>
@@ -227,7 +227,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr=
 *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp64 =3D (uint64_t)speed * duty100;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 duty =3D (uint32_t)tmp64;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr-&gt;device,=
 CGS_IND_REG__SMC,<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
index 25979106fd25..44c5e2588046 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -4199,7 +4199,7 @@ static void vega10_set_fan_control_mode(struct pp_hwm=
gr *hwmgr, uint32_t mode)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_NONE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vega10_fan_ctrl_set=
_fan_speed_percent(hwmgr, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vega10_fan_ctrl_set=
_fan_speed_percent(hwmgr, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_MANUAL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PP_CAP(PHM_Plat=
formCaps_MicrocodeFanControl))<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
index 9b46b27bd30c..6b4c4294afca 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
@@ -78,11 +78,11 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwm=
gr *hwmgr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hwmgr-&gt;thermal_controller.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 advanceFanControlParameters.usMaxFanRPM !=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0percent =3D current=
_rpm * 100 /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0percent =3D current=
_rpm * 255 /<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 hwmgr-&gt;thermal_controller.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 advanceFanControlParameters.usMaxFanRPM;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D percent &gt; 100 ? 100 : percent;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D percent &gt; 255 ? 255 : percent;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -257,8 +257,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwm=
gr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hwmgr-&gt;thermal_controller.fanInfo.bNoFan=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vega10_fan_ctrl_sto=
p_smc_fan_control(hwmgr);<br>
@@ -270,7 +270,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwm=
gr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp64 =3D (uint64_t)speed * duty100;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 duty =3D (uint32_t)tmp64;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
index 0791309586c5..cbe5f8027ee0 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -2769,7 +2769,7 @@ static void vega20_set_fan_control_mode(struct pp_hwm=
gr *hwmgr, uint32_t mode)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_NONE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vega20_fan_ctrl_set=
_fan_speed_percent(hwmgr, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vega20_fan_ctrl_set=
_fan_speed_percent(hwmgr, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_MANUAL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PP_CAP(PHM_Plat=
formCaps_MicrocodeFanControl))<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c<br>
index 43d754952bd9..eb007c00d7c6 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c<br>
@@ -129,12 +129,12 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_h=
wmgr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!duty100)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 255;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_div(tmp64, duty100);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *speed =3D (uint32_t)tmp64;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -147,8 +147,8 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwm=
gr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t duty;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t tmp64;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vega20_fan_ctrl_sto=
p_smc_fan_control(hwmgr);<br>
@@ -160,7 +160,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwm=
gr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp64 =3D (uint64_t)speed * duty100;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 duty =3D (uint32_t)tmp64;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/am=
d/pm/powerplay/si_dpm.c<br>
index 15c0b8af376f..96ca359c10a5 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c<br>
@@ -6555,12 +6555,12 @@ static int si_dpm_get_fan_speed_percent(void *handl=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (duty100 =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (u64)duty * 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (u64)duty * 255;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_div(tmp64, duty100);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *speed =3D (u32)tmp64;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -6580,7 +6580,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (si_pi-&gt;fan_is_controlled_by_smc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 100)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 255)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 duty100 =3D (RREG32(CG_FDO_CTRL1) &amp; FMAX_DU=
TY100_MASK) &gt;&gt; FMAX_DUTY100_SHIFT;<br>
@@ -6589,7 +6589,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp64 =3D (u64)speed * duty100;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 duty =3D (u32)tmp64;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D RREG32(CG_FDO_CTRL0) &amp; ~FDO_STATIC_=
DUTY_MASK;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 54fb3d7d23ee..94c15526ad21 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -2565,23 +2565,17 @@ static int smu_get_fan_speed_percent(void *handle, =
u32 *speed)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct smu_context *smu =3D handle;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t percent;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt;pm=
.dpm_enabled)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;smu-&gt;mutex);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;ppt_funcs-&gt;get_fan_speed_percent=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu-&gt;ppt=
_funcs-&gt;get_fan_speed_percent(smu, &amp;percent);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*speed =3D percent &gt; 100 ? 100 : percent;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (smu-&gt;ppt_funcs-&gt;get_fan_speed_percent=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu-&gt;ppt=
_funcs-&gt;get_fan_speed_percent(smu, speed);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;smu-&gt;mutex);<br>
<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
@@ -2596,8 +2590,6 @@ static int smu_set_fan_speed_percent(void *handle, u3=
2 speed)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;smu-&gt;mutex);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu-&gt;ppt_funcs-&gt;set_fan_speed_percent=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 100)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0speed =3D 100;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu-&gt;ppt=
_funcs-&gt;set_fan_speed_percent(smu, speed);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret &amp;&amp;=
 !(smu-&gt;user_dpm_profile.flags &amp; SMU_DPM_USER_PROFILE_RESTORE)) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 smu-&gt;user_dpm_profile.custom_fan_speed |=3D SMU_CUSTOM_FAN_SP=
EED_PWM;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 0cdf55a0dba2..f0ae0920c07e 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -1191,8 +1191,8 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *s=
mu, uint32_t speed)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t duty100, duty;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t tmp64;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (smu_v11_0_auto_fan_control(smu, 0))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
@@ -1203,7 +1203,7 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *s=
mu, uint32_t speed)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp64 =3D (uint64_t)speed * duty100;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 duty =3D (uint32_t)tmp64;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,<br>
@@ -1274,12 +1274,12 @@ int smu_v11_0_get_fan_speed_percent(struct smu_cont=
ext *smu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!duty100)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 255;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_div(tmp64, duty100);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *speed =3D (uint32_t)tmp64;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (*speed &gt; 255)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D 255;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -1320,7 +1320,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *sm=
u,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_NONE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_v11_0_s=
et_fan_speed_percent(smu, 100);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D smu_v11_0_s=
et_fan_speed_percent(smu, 255);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMD_FAN_CTRL_MANUAL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D smu_v11_0_a=
uto_fan_control(smu, 0);<br>
-- <br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div></div></div>

--00000000000030e53605c682a008--

--===============0048944977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0048944977==--
