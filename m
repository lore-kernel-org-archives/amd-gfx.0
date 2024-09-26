Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC180CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACF210EB26;
	Thu, 26 Sep 2024 09:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="dzGOauyr";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="FWiwhp6X";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1A510EB26
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727342342;
 bh=NHJo3yrkAkJkodRaCWFm+a6
 nKZIDiYNZi4xzn8l70Bo=; b=dzGOauyrk0BDK9taMOern2tXYAS0fDRq4cCiCAaSiACZAKxqrD
 iLp9eWghwp++g7K1EZYgY+hy3L9vItA46+jzOMtAPKsyl221U08SYEPKHlIwMNhJSYvIvohjEHT
 s9hMf/OD3FRquR+eV2foVJg+IyCEq4VkXtCQi6mcGh52+I7mbVD/KHNVNzAXjufupbDUH28yDwn
 rYpT9MEOQf18NuGly/J9fJt1oKcAJ70wG2ozsS92Pi9h301UmPF88hFEqS5/ExI8N+nekDlOC6O
 R/FnzD6NFsfhl51Fdgkumcwb1A+yR7PZ8ZmqOynqVkl/lSESiNisPcbM9j1uudkg1Mg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727342342; bh=NHJo3yrkAkJkodRaCWFm+a6
 nKZIDiYNZi4xzn8l70Bo=; b=FWiwhp6XGo7B88BhN5PFLwPFznJsXaIysaA+fzdZsub4rPTZ3L
 /1iZBSb2tcuQICGZjTAHbKHJ+oBhpu2E5tBA==;
Message-ID: <51a14be4-a6f5-470f-a28c-f098bd90d6f0@damsy.net>
Date: Thu, 26 Sep 2024 11:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] drm/amd/pm: don't update runpm last_usage on
 debugfs getter
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-5-pierre-eric.pelloux-prayer@amd.com>
 <72c141b5-f531-4b70-8776-776a2f9acdd3@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <72c141b5-f531-4b70-8776-776a2f9acdd3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 26/09/2024 à 10:55, Lazar, Lijo a écrit :
> 
> 
> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
>> Reading pm values from the GPU shouldn't prevent it to be suspended
>> by resetting the last active timestamp (eg: if an background app
>> monitors GPU sensors every second, it would prevent the autosuspend
>> sequence to trigger).
>>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 --------------------------
>>   1 file changed, 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 042a4dd1bd6a..c8f34b1a4d8e 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -151,7 +151,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>>   
>>   	amdgpu_dpm_get_current_power_state(adev, &pm);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return sysfs_emit(buf, "%s\n",
>> @@ -275,7 +274,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>   
>>   	level = amdgpu_dpm_get_performance_level(adev);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return sysfs_emit(buf, "%s\n",
>> @@ -373,7 +371,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>>   	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>>   		memset(&data, 0, sizeof(data));
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
>> @@ -410,7 +407,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>>   
>>   	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	if (ret)
>> @@ -536,7 +532,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>>   
>>   	size = amdgpu_dpm_get_pp_table(adev, &table);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	if (size <= 0)
>> @@ -866,7 +861,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>   	if (size == 0)
>>   		size = sysfs_emit(buf, "\n");
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -944,7 +938,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>   	if (size <= 0)
>>   		size = sysfs_emit(buf, "\n");
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -1014,7 +1007,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>>   	if (size == 0)
>>   		size = sysfs_emit(buf, "\n");
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -1259,7 +1251,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>>   
>>   	value = amdgpu_dpm_get_sclk_od(adev);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return sysfs_emit(buf, "%d\n", value);
>> @@ -1317,7 +1308,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>>   
>>   	value = amdgpu_dpm_get_mclk_od(adev);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return sysfs_emit(buf, "%d\n", value);
>> @@ -1397,7 +1387,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>>   	if (size <= 0)
>>   		size = sysfs_emit(buf, "\n");
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -1485,7 +1474,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>   	/* get the sensor value */
>>   	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	return r;
>> @@ -1601,7 +1589,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>   
>>   	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return sysfs_emit(buf, "%llu %llu %i\n",
>> @@ -1734,7 +1721,6 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>>   	else
>>   		size = sysfs_emit(buf, "failed to get thermal limit\n");
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -1807,7 +1793,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>>   
>>   	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>>   
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -1854,7 +1839,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>>   	memcpy(buf, gpu_metrics, size);
>>   
>>   out:
>> -	pm_runtime_mark_last_busy(ddev->dev);
>>   	pm_runtime_put_autosuspend(ddev->dev);
>>   
>>   	return size;
>> @@ -2722,7 +2706,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>   
>>   	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (ret)
>> @@ -2851,7 +2834,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>>   
>>   	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (err)
>> @@ -2879,7 +2861,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>>   
>>   	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (err)
>> @@ -2941,7 +2922,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>>   
>>   	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (err)
>> @@ -3012,7 +2992,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>   
>>   	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (ret)
>> @@ -3053,7 +3032,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>>   
>>   	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> 
> Monitoring not affecting runtime PM is valid reasoning for get
> operations, but not so much for set operations.

Good catch: only the getter functions should be modified by this commit.
I'll fix it.

Pierre-Eric


> Thanks,
> Lijo
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (err)
>> @@ -3186,7 +3164,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>   	else
>>   		size = sysfs_emit(buf, "\n");
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	return size;
>> @@ -3269,7 +3246,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>>   
>>   	err = amdgpu_dpm_set_power_limit(adev, value);
>>   
>> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	if (err)
>> @@ -3717,7 +3693,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>>   	if (size == 0)
>>   		size = sysfs_emit(buf, "\n");
>>   
>> -	pm_runtime_mark_last_busy(adev->dev);
>>   	pm_runtime_put_autosuspend(adev->dev);
>>   
>>   	return size;
>> @@ -4694,7 +4669,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>>   	seq_printf(m, "\n");
>>   
>>   out:
>> -	pm_runtime_mark_last_busy(dev->dev);
>>   	pm_runtime_put_autosuspend(dev->dev);
>>   
>>   	return r;
