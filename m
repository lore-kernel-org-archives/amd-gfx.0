Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E3CCF3186
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 21:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B45E10E189;
	Tue,  1 Oct 2024 21:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GKJAaB8w";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AC710E189
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 21:13:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 61313A4326C;
 Tue,  1 Oct 2024 21:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35539C4CEC6;
 Tue,  1 Oct 2024 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727817215;
 bh=CIU7QipSaoJ6H/9lc/iCnmLCnX8cFWOcRHuCyNhGn+4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=GKJAaB8wNuZCJHna56BlYFgLy9TUAsT6lYgwRC08B38C1IM3bTEUNElMP3cZVnuHh
 oLq316IKUJ+bRKJ1zvgU9mn/P921aTnPoCr1wpgqRx2CuLF1yZycudPkn/fLeZQBXp
 WgbCdKwRI995s3BHQXzZbEbCix7BD3HJjlOoc1F9szMyyb1R60kv7DHjBNvnD7GULX
 RDF7HX6zj+0E5WYcSjNPHQhOMraX4n9WveuqIzeU8IKLBXUKxKYZlrdWqrLAgakkw1
 VnJlnmIh+rNNokX4WSf0KT6FShpWmYWBz2NwbKErLw/LoWZqr5CkfpBDDmV+BeLPtl
 k+VVkDeTte0Jw==
Date: Tue, 1 Oct 2024 16:13:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
Message-ID: <20241001211330.GA227163@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5165976761005ACA332486148E6B2@DM4PR12MB5165.namprd12.prod.outlook.com>
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

On Fri, Sep 27, 2024 at 09:57:20AM +0000, Feng, Kenneth wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

I don't know what I can do with this.

1) The "AMD Official Use Only - AMD Internal Distribution Only" above
suggests to me that I can't act on it.  Is there any way you can get
rid of that notice?

2) Even if I could act on this, I don't see any comments or reactions
below.

> -----Original Message-----
> From: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
> Sent: Wednesday, September 25, 2024 3:54 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
> Subject: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for debugfs getters
> 
> Don't wake up the GPU for reading pm values. Instead, take a runtime powermanagement ref when trying to read it iff the GPU is already awake.
> Kenneth - just a nit-pick iff(typo) -> if
> 
> This avoids spurious wake ups (eg: from applets).
> 
> We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care about "is the GPU awake?" not about "is the GPU awake and something else prevents suspend?".
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c8f34b1a4d8e..f1f339b75380 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         amdgpu_dpm_get_current_power_state(adev, &pm);
> 
> @@ -268,9 +268,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         level = amdgpu_dpm_get_performance_level(adev);
> 
> @@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         if (amdgpu_dpm_get_pp_num_states(adev, &data))
>                 memset(&data, 0, sizeof(data));
> @@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         amdgpu_dpm_get_current_power_state(adev, &pm);
> 
> @@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         size = amdgpu_dpm_get_pp_table(adev, &table);
> 
> @@ -840,9 +840,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>                 ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size); @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>         if (size <= 0)
> @@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>         if (ret == -ENOENT)
> @@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         value = amdgpu_dpm_get_sclk_od(adev);
> 
> @@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         value = amdgpu_dpm_get_mclk_od(adev);
> 
> @@ -1379,9 +1379,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>         if (size <= 0)
> @@ -1467,9 +1467,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       r = pm_runtime_resume_and_get(adev->dev);
> -       if (r < 0)
> -               return r;
> +       r = pm_runtime_get_if_active(adev->dev, true);
> +       if (r <= 0)
> +               return r ?: -EPERM;
> 
>         /* get the sensor value */
>         r = amdgpu_dpm_read_sensor(adev, sensor, query, &size); @@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>         if (!adev->asic_funcs->get_pcie_usage)
>                 return -ENODATA;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
> 
> @@ -1711,9 +1711,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = drm_to_adev(ddev);
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>         if (!ret)
> @@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
> 
> @@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(ddev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(ddev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>         if (size <= 0)
> @@ -2700,9 +2700,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(adev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(adev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
> 
> @@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       err = pm_runtime_resume_and_get(adev->dev);
> -       if (err < 0)
> -               return err;
> +       err = pm_runtime_get_if_active(adev->dev, true);
> +       if (err <= 0)
> +               return err ?: -EPERM;
> 
>         err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
> 
> @@ -2855,9 +2855,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       err = pm_runtime_resume_and_get(adev->dev);
> -       if (err < 0)
> -               return err;
> +       err = pm_runtime_get_if_active(adev->dev, true);
> +       if (err <= 0)
> +               return err ?: -EPERM;
> 
>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
> 
> @@ -2916,9 +2916,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       err = pm_runtime_resume_and_get(adev->dev);
> -       if (err < 0)
> -               return err;
> +       err = pm_runtime_get_if_active(adev->dev, true);
> +       if (err <= 0)
> +               return err ?: -EPERM;
> 
>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
> 
> @@ -2986,9 +2986,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(adev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(adev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
> 
> @@ -3152,9 +3152,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       r = pm_runtime_resume_and_get(adev->dev);
> -       if (r < 0)
> -               return r;
> +       r = pm_runtime_get_if_active(adev->dev, true);
> +       if (r <= 0)
> +               return r ?: -EPERM;
> 
>         r = amdgpu_dpm_get_power_limit(adev, &limit,
>                                       pp_limit_level, power_type);
> @@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>         if (adev->in_suspend && !adev->in_runpm)
>                 return -EPERM;
> 
> -       ret = pm_runtime_resume_and_get(adev->dev);
> -       if (ret < 0)
> -               return ret;
> +       ret = pm_runtime_get_if_active(adev->dev, true);
> +       if (ret <= 0)
> +               return ret ?: -EPERM;
> 
>         size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>         if (size == 0)
> --
> 2.40.1
> 
