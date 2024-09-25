Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD47CF9C72
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 14:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1EB10E83F;
	Wed, 25 Sep 2024 14:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="aKb2vR3H";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="Lmlm+BtV";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F8710E83F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727274746;
 bh=+8gWgoBlhOJNj0chjgeO6/0
 g9eHSDXSPy59d4K1Q78U=; b=aKb2vR3Hm8EcRkDW7eZV+5gOrlxMBPOcnzoEXFbrEMMRec+mrX
 A8Enz7LbyAcb0PKXJQA2pLIVusZ57Mu5BXSouuAxBCSmZJsMR3irSUcfHfELLNAVSaipMJCjqvP
 pzjmLBrzIBYqdEi3Aw/Y8w1cYofPvYpbmO9dltd8g/LWao+T+YrlD1scs/3IcjkNoGv2ziYlwo4
 YaPRsgnbc7HcPZYNxegmtecVWePghq+ORmryTDwIQFMnJj9fZnpvQSL+Nsc9Hc0uIRtNOgjjpG3
 5dTPHgerh8eZF8aGLr/1r7eny+Clxq1fRmGLj5MEsnJAd7cxaJVFt82lV28TX2X+Rfg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727274746; bh=+8gWgoBlhOJNj0chjgeO6/0
 g9eHSDXSPy59d4K1Q78U=; b=Lmlm+BtVFHBOWDw6d8Zv0E/pvjG11PgunbynUHFUsHnctPrPbT
 gJq/qc0OzryajMEM8TpnbRtXaTXn2ZHBnOAA==;
Message-ID: <e1619a8a-80ca-48dc-9e62-ccf9462561fe@damsy.net>
Date: Wed, 25 Sep 2024 16:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
 <74f68af1-ed33-422c-b6f0-d1a036a550b1@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <74f68af1-ed33-422c-b6f0-d1a036a550b1@amd.com>
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



Le 25/09/2024 à 15:35, Lazar, Lijo a écrit :
> 
> 
> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
>> Don't wake up the GPU for reading pm values. Instead, take a runtime
>> powermanagement ref when trying to read it iff the GPU is already
>> awake.
>>
>> This avoids spurious wake ups (eg: from applets).
>>
>> We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care
>> about "is the GPU awake?" not about "is the GPU awake and something else
>> prevents suspend?".
>>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
>>   1 file changed, 69 insertions(+), 69 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index c8f34b1a4d8e..f1f339b75380 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
> 
> Not all our devices support runtime PM.
> 
> As per the API documentation -
> 
> "-EINVAL is returned if runtime PM is disabled for the
> device, in which case also the usage_count will remain unmodified."

This doc is about "dev->power.disable_depth > 0", not about runtime PM being disabled (like you 
would get by using pm_runtime_forbid).

When runtime PM is disabled, usage_count is always >= 1 and the status is RPM_ACTIVE so 
pm_runtime_get_if_active will succeed.

I tested on 2 dGPUs without runtime PM, and both seemed to work fine.

Pierre-Eric

> 
> If that's true, this won't be working on devices without runtime PM support.
> 
> Thanks,
> Lijo
>>   
>>   	amdgpu_dpm_get_current_power_state(adev, &pm);
>>   
>> @@ -268,9 +268,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	level = amdgpu_dpm_get_performance_level(adev);
>>   
>> @@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>>   		memset(&data, 0, sizeof(data));
>> @@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	amdgpu_dpm_get_current_power_state(adev, &pm);
>>   
>> @@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	size = amdgpu_dpm_get_pp_table(adev, &table);
>>   
>> @@ -840,9 +840,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>>   		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
>> @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>>   	if (size <= 0)
>> @@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>>   	if (ret == -ENOENT)
>> @@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	value = amdgpu_dpm_get_sclk_od(adev);
>>   
>> @@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	value = amdgpu_dpm_get_mclk_od(adev);
>>   
>> @@ -1379,9 +1379,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>>   	if (size <= 0)
>> @@ -1467,9 +1467,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	r = pm_runtime_resume_and_get(adev->dev);
>> -	if (r < 0)
>> -		return r;
>> +	r = pm_runtime_get_if_active(adev->dev, true);
>> +	if (r <= 0)
>> +		return r ?: -EPERM;
>>   
>>   	/* get the sensor value */
>>   	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>> @@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>   	if (!adev->asic_funcs->get_pcie_usage)
>>   		return -ENODATA;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>>   
>> @@ -1711,9 +1711,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>>   	struct drm_device *ddev = dev_get_drvdata(dev);
>>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>>   	if (!ret)
>> @@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>>   
>> @@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(ddev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(ddev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>>   	if (size <= 0)
>> @@ -2700,9 +2700,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(adev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(adev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>   
>> @@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	err = pm_runtime_resume_and_get(adev->dev);
>> -	if (err < 0)
>> -		return err;
>> +	err = pm_runtime_get_if_active(adev->dev, true);
>> +	if (err <= 0)
>> +		return err ?: -EPERM;
>>   
>>   	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>   
>> @@ -2855,9 +2855,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	err = pm_runtime_resume_and_get(adev->dev);
>> -	if (err < 0)
>> -		return err;
>> +	err = pm_runtime_get_if_active(adev->dev, true);
>> +	if (err <= 0)
>> +		return err ?: -EPERM;
>>   
>>   	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>   
>> @@ -2916,9 +2916,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	err = pm_runtime_resume_and_get(adev->dev);
>> -	if (err < 0)
>> -		return err;
>> +	err = pm_runtime_get_if_active(adev->dev, true);
>> +	if (err <= 0)
>> +		return err ?: -EPERM;
>>   
>>   	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>   
>> @@ -2986,9 +2986,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(adev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(adev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>   
>> @@ -3152,9 +3152,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	r = pm_runtime_resume_and_get(adev->dev);
>> -	if (r < 0)
>> -		return r;
>> +	r = pm_runtime_get_if_active(adev->dev, true);
>> +	if (r <= 0)
>> +		return r ?: -EPERM;
>>   
>>   	r = amdgpu_dpm_get_power_limit(adev, &limit,
>>   				      pp_limit_level, power_type);
>> @@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>>   	if (adev->in_suspend && !adev->in_runpm)
>>   		return -EPERM;
>>   
>> -	ret = pm_runtime_resume_and_get(adev->dev);
>> -	if (ret < 0)
>> -		return ret;
>> +	ret = pm_runtime_get_if_active(adev->dev, true);
>> +	if (ret <= 0)
>> +		return ret ?: -EPERM;
>>   
>>   	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>>   	if (size == 0)
