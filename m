Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E78C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58A810EB16;
	Fri, 23 Aug 2024 14:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROo2xA60";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9752210EB16
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:09:29 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-201f1fe3909so485785ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724422169; x=1725026969; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOgDOGa4/r1FFRBJ//7vp8aKgFmvj4MVTblD2QmruDk=;
 b=ROo2xA604SCRo0Y97u0faA9mz8TRP8aszgYJtekK9ihJ/mWTujwQoEXOnM0LG5hjKK
 vKgaPVi4oZdFp45y2xvTp+GpQkbXF4IikBjPDeXScC//d2wiPcEkeHiJJIJK8Xrfc8KX
 OmMHUfuivZ4pB718VbGdbNnNmgqoIgBsRdt4aIGzepzUBK/4AUE2DlS0og0ANTTQub6Z
 ycqmRQRQDXpYtRnIKOg5CkUBdhctmpzU+cCSreU2EpuV0wolMvBtrPGv/btBHgv/mq46
 F9GWthmrugKZEg4nu7y++7P5DDnP4RyuP5mw7wqV3A7hIlpu5/gWlCApFwtzS9AKOmAW
 cNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724422169; x=1725026969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOgDOGa4/r1FFRBJ//7vp8aKgFmvj4MVTblD2QmruDk=;
 b=M3jLlmKm8DLLlPbQiDvMDfpcHnMhKQ5Ix6a1vHYUM8S64b8BJU9R7WjT8+alrsvbC6
 lXxtxvDQq+wECUQt1bUIFvfnUY7WnSRIfyMnNfF6THuAl8wswDxhlw64LIHtx1BbKWNr
 BvhLAivW70H9DREsjotg3iuiUtiaHw1b/C/OH8+Z1NImGnDhVIh2tHIf6VvNxLMpK7h6
 cxUEvnmvKJM3PQqhmY9YydGGMPUrfFkLq+0kO298JeVgCZCP+TR7VoAcFEtWA8VM8euD
 Zwq0LZFg1efv93/huQt9STgnyeHtr1HBlmyL0HdYJ0X3HTkE62jbbMyqJvHdJeZy4vvx
 vQcg==
X-Gm-Message-State: AOJu0YytPxvThVKsUus/33q14e2ZexaxbYC3aICnO2u3W3kCCJKv9YLA
 Aux56oMzgvxeV254878EC3NujU5WQVRiRXkuyUKDnPacZOTTb0fAeo9RYNl6AWOng7bhxcNwYgp
 1XkGHacs3a7Np2kpuej+E5xzOark=
X-Google-Smtp-Source: AGHT+IHrNfxhL3zG4c/n6TsGRaPwtBM0J1/zcmWBfvffXvQRhfEg01Q1eLXK9KEYza/9Y91oJD4te27sK1d4pN2j/Jg=
X-Received: by 2002:a17:902:f202:b0:201:d9fa:6b12 with SMTP id
 d9443c01a7336-2039e4b4b7amr15029565ad.3.1724422168644; Fri, 23 Aug 2024
 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240820020435.472490-1-superm1@kernel.org>
In-Reply-To: <20240820020435.472490-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Aug 2024 10:09:16 -0400
Message-ID: <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Aug 19, 2024 at 10:30=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> If the dGPU is off, then reading the sysfs files with a sensor monitoring
> application will wake it. Change the behavior to return an error when the
> dGPU is in D3cold.

I'm a little concerned that this will generate a flurry of bug reports
if this now reports an error.  One more comment below.

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++---------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index c11952a4389bc..d6e38466fbb82 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct devi=
ce *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct devi=
ce *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (strncmp("battery", buf, strlen("battery")) =3D=3D 0)
> @@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance=
_level(struct device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance=
_level(struct device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (strncmp("low", buf, strlen("low")) =3D=3D 0) {
> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device=
 *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct devic=
e *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (adev->pm.pp_force_state_enabled)
> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct devic=
e *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         adev->pm.pp_force_state_enabled =3D false;
> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev=
,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev=
,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct de=
vice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (count > 127 || count =3D=3D 0)
> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct de=
vice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct device *=
dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D kstrtou64(buf, 0, &featuremask);
> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct device *=
dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct devic=
e *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct devic=
e *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D amdgpu_read_mask(buf, count, &mask);
> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D kstrtol(buf, 0, &value);
> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D kstrtol(buf, 0, &value);
> @@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(str=
uct device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(str=
uct device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         tmp[0] =3D *(buf);
> @@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(struct a=
mdgpu_device *adev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *de=
v,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (adev->flags & AMD_IS_APU)
> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct device *=
dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (adev->unique_id)
> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device=
 *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(ddev->dev);
> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct de=
vice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         r =3D pm_runtime_get_sync(ddev->dev);
> @@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struct d=
evice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         mode =3D amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
> @@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct d=
evice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D kstrtos32(buf, 0, &mode);
> @@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct =
device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct =
device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D kstrtoint(buf, 10, &value);
> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D kstrtou32(buf, 10, &value);
> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device =
*dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct d=
evice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct =
device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct =
device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D kstrtou32(buf, 10, &value);
> @@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct =
device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct =
device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         err =3D kstrtoint(buf, 10, &value);
> @@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(=
struct device *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct de=
vice *dev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         if (amdgpu_sriov_vf(adev))
> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct amdgp=
u_device *adev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D pm_runtime_get_sync(adev->dev);
> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_=
device *adev,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D parse_input_od_command_lines(in_buf,
> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_f=
ile *m, void *unused)
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;

I'd prefer to keep the current behavior for debugfs.

Alex

>
>         r =3D pm_runtime_get_sync(dev->dev);
> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct fil=
e *f, char __user *buf,
>
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> +       if (adev->in_suspend || adev->in_runpm)
>                 return -EPERM;
>
>         ret =3D amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &s=
mu_prv_buf_size);
> --
> 2.43.0
>
