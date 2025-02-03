Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76F2C02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 16:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3950E10E002;
	Mon,  3 Feb 2025 16:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFyYTlPb";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7F410E002
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 16:07:08 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f83e9ad435so1011384a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2025 08:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738598828; x=1739203628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XT65kFjHjz2Jo+hmxQWCua24NTxq+jTg8+7Azt7ulGU=;
 b=EFyYTlPb+KQW8cnKVrOsrGWkYGbDCCLOrhEfGi6NTNDR2R3Mmni9NUD5hm4wND30ZR
 ecRU2Cgoe+sdx/ZJUP7kUPdrZTweve/XzztvtkR2cgRh3qRjJA8tcre/Llu10arOE8F2
 tooapbctFqRXpPKp7qUsy5Qxde55zWW9zlwoXt2/Iudl0lJ7e/t2vciJh6kPMC2VFFgK
 F44IswxsKzrYP3XT0Zo+Eq9RetNl2e7mxXr/hE8KvIUXIXsbxmC8ihZ8vdSY8avXCyQQ
 iKRYJvv4+vBEtA8kmNQc4nixnhWGL1YsVnTfkWqhpppKF8hLt8OC4DAZBnBM4iIqlQYU
 nfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738598828; x=1739203628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XT65kFjHjz2Jo+hmxQWCua24NTxq+jTg8+7Azt7ulGU=;
 b=JXbU5hPJeS1jRy6y2EhtTvjk33xFkZ6Tayz82qh4Pq4QCafH7OPmdz3/+ImZp/XIqO
 6hY47Xp/GogIKe88EqkMvpQTLMD7VTZY8a/tBsXyy+m+pY4bbli28OBtd2C4mOrA0uDq
 v1iIQnnjMfb/BD1vyKEid/FxeszbQu1veJ2CODly6ATd1wyWFufEcMriCw6JkP/XrhBP
 Lguw108I6iEOfrA7N1zV1DCSbxOM3KWM3E/KJDO+DxmODDaWQAnEtpiTIOD0M0c0FlPr
 hzObK4KVft4wRxpiGNkHw7xAR2oZXP0IhY3YqMwz16AzKLzZeoK22jSxrONK0nVj1MVD
 G4xA==
X-Gm-Message-State: AOJu0Yysu/0aqfmyxTJCs0b/S/h16sSBPmXZvSVT7foGCm0PbcQ+HKWz
 1Btfs8beVZoYGUl2oCvZUuPK8Jw6spcGq5uc3TX0SZuY2irRh84nBmcr4GreKiJsko9cEGgWZTK
 2FKW1xZ+pFRQlKvoAiBbnS6wY7ws=
X-Gm-Gg: ASbGnctCSeMaDLtUoJvUHTqlZzIosVBIw6weUHt43iz19n0CceN+3ISjz0K2/9qro1Y
 nbs3RztzqKzWNqDt58BuFjJRuJtbCf5oznwnXSnsEZ0yQYghpI6cHppFxlfHbWttl2/4iPgmX
X-Google-Smtp-Source: AGHT+IGzdfs1i7GjUY81qVM56AiWsBkuLaqL5HlWbTuLhxJSHbDIRMS0nzcgZfbfZz8uaI5PQr1cQDfongMeBOQKGiU=
X-Received: by 2002:a17:90b:2d4f:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2f9b8c21afemr105926a91.2.1738598827548; Mon, 03 Feb 2025
 08:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20250201042639.1805796-1-lijo.lazar@amd.com>
In-Reply-To: <20250201042639.1805796-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Feb 2025 11:06:55 -0500
X-Gm-Features: AWEUYZkbmAY6ARfu0rc9Rio-zomO6dFH4zPINR5rNix3DIaS3JdGrwZ-ldzewIw
Message-ID: <CADnq5_Ns10DeL1PGzdq73_mArfX8E2Rz7P_56S1+hd+81JsjfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix get_if_active usage
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 kenneth.feng@amd.com, mario.limonciello@amd.com
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

On Fri, Jan 31, 2025 at 11:53=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> If a device supports runtime pm, then pm_runtime_get_if_active returns 0
> if a device is not active and 1 if already active. However, if a device
> doesn't support runtime pm, the API returns -EINVAL. A device not
> supporting runtime pm implies it's not affected by runtime pm and it's
> active. Hence no need to get() to increment usage count. Remove < 0
> return value check.

Might be worth mentioning that this happens when CONFIG_PM is not set
assuming that is the case.  More future proof to move all of these
duplicated checks into a common helper? Also is it possible we might
miss errors with this change in the runtime pm enabled case?  E.g., if
a previous resume failed.

Alex

>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Fixes: 6e796cb4a972b ("drm/amd/pm: use pm_runtime_get_if_active for debug=
fs getters")
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 129 +++++++++++------------------
>  1 file changed, 48 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 0aca0803514e..a8db2d3c9154 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -138,16 +138,14 @@ static ssize_t amdgpu_get_power_dpm_state(struct de=
vice *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         enum amd_pm_state_type pm;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         amdgpu_dpm_get_current_power_state(adev, &pm);
>
> @@ -261,16 +259,14 @@ static ssize_t amdgpu_get_power_dpm_force_performan=
ce_level(struct device *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         enum amd_dpm_forced_level level =3D 0xff;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         level =3D amdgpu_dpm_get_performance_level(adev);
>
> @@ -357,16 +353,15 @@ static ssize_t amdgpu_get_pp_num_states(struct devi=
ce *dev,
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         struct pp_states_info data;
>         uint32_t i;
> -       int buf_len, ret;
> +       int buf_len;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         if (amdgpu_dpm_get_pp_num_states(adev, &data))
>                 memset(&data, 0, sizeof(data));
> @@ -399,9 +394,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device =
*dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         amdgpu_dpm_get_current_power_state(adev, &pm);
>
> @@ -519,16 +513,15 @@ static ssize_t amdgpu_get_pp_table(struct device *d=
ev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         char *table =3D NULL;
> -       int size, ret;
> +       int size;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         size =3D amdgpu_dpm_get_pp_table(adev, &table);
>
> @@ -840,9 +833,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct de=
vice *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         for (clk_index =3D 0 ; clk_index < 6 ; clk_index++) {
>                 ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_=
index], buf, &size);
> @@ -923,16 +915,14 @@ static ssize_t amdgpu_get_pp_features(struct device=
 *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         ssize_t size;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         size =3D amdgpu_dpm_get_ppfeature_status(adev, buf);
>         if (size <=3D 0)
> @@ -996,9 +986,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device =
*dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         ret =3D amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>         if (ret =3D=3D -ENOENT)
> @@ -1238,16 +1227,14 @@ static ssize_t amdgpu_get_pp_sclk_od(struct devic=
e *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         uint32_t value =3D 0;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         value =3D amdgpu_dpm_get_sclk_od(adev);
>
> @@ -1295,16 +1282,14 @@ static ssize_t amdgpu_get_pp_mclk_od(struct devic=
e *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         uint32_t value =3D 0;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         value =3D amdgpu_dpm_get_mclk_od(adev);
>
> @@ -1376,16 +1361,14 @@ static ssize_t amdgpu_get_pp_power_profile_mode(s=
truct device *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         ssize_t size;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         size =3D amdgpu_dpm_get_power_profile_mode(adev, buf);
>         if (size <=3D 0)
> @@ -1471,9 +1454,8 @@ static int amdgpu_hwmon_get_sensor_generic(struct a=
mdgpu_device *adev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       r =3D pm_runtime_get_if_active(adev->dev);
> -       if (r <=3D 0)
> -               return r ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         /* get the sensor value */
>         r =3D amdgpu_dpm_read_sensor(adev, sensor, query, &size);
> @@ -1574,7 +1556,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *de=
v,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         uint64_t count0 =3D 0, count1 =3D 0;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> @@ -1587,9 +1568,8 @@ static ssize_t amdgpu_get_pcie_bw(struct device *de=
v,
>         if (!adev->asic_funcs->get_pcie_usage)
>                 return -ENODATA;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>
> @@ -1715,9 +1695,8 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct de=
vice *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         ret =3D amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>         if (!ret)
> @@ -1784,16 +1763,14 @@ static ssize_t amdgpu_get_pm_metrics(struct devic=
e *dev,
>         struct drm_device *ddev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         ssize_t size =3D 0;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         size =3D amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>
> @@ -1822,16 +1799,14 @@ static ssize_t amdgpu_get_gpu_metrics(struct devi=
ce *dev,
>         struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         void *gpu_metrics;
>         ssize_t size =3D 0;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(ddev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         size =3D amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>         if (size <=3D 0)
> @@ -2709,9 +2684,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct =
device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(adev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>
> @@ -2837,9 +2811,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device =
*dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       err =3D pm_runtime_get_if_active(adev->dev);
> -       if (err <=3D 0)
> -               return err ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         err =3D amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>
> @@ -2864,9 +2837,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct d=
evice *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       err =3D pm_runtime_get_if_active(adev->dev);
> -       if (err <=3D 0)
> -               return err ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>
> @@ -2925,9 +2897,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct =
device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       err =3D pm_runtime_get_if_active(adev->dev);
> -       if (err <=3D 0)
> -               return err ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         err =3D amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>
> @@ -2995,9 +2966,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct =
device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(adev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         ret =3D amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>
> @@ -3162,9 +3132,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(=
struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       r =3D pm_runtime_get_if_active(adev->dev);
> -       if (r <=3D 0)
> -               return r ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         r =3D amdgpu_dpm_get_power_limit(adev, &limit,
>                                       pp_limit_level, power_type);
> @@ -3693,16 +3662,14 @@ static int amdgpu_retrieve_od_settings(struct amd=
gpu_device *adev,
>                                        char *buf)
>  {
>         int size =3D 0;
> -       int ret;
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
>
> -       ret =3D pm_runtime_get_if_active(adev->dev);
> -       if (ret <=3D 0)
> -               return ret ?: -EPERM;
> +       if (!pm_runtime_get_if_active(adev->dev))
> +               return -EPERM;
>
>         size =3D amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>         if (size =3D=3D 0)
> --
> 2.25.1
>
