Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A976CE8374
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 16:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2919010E0FD;
	Mon, 30 Sep 2024 16:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="hsHy4d+W";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="QdFbpxa+";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5269710E0FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727715270;
 bh=9RnAhyOQkwTjtxG88TP6VEP
 kyTkWLwM95Nf648Gh+Ok=; b=hsHy4d+Wh72OYSVelG6xoVE+OwdwEkWXNJBewpO5BOCErtgOHr
 lvC/gdBCVINJqFahTZCsdCIy10pazMhUNKPotJiz7TxD4pVL2UsW+mtFeU/jEKeRGpVYwdhwi1z
 H44Q9uEjzPWMCgb81h/cTZ7UFvJds1m93ADu+8QuhNTTUvJQ12JX19fiuulzr0zl6GNVvti6sV8
 XLzNCPlWAAdWagG6IDxaIORzPRLndb2JxOEJDmTNVLhgV2cMqPZTWAftTXNnzTmNlHCljqGCHO4
 l9zFa7tW3udkQ/Xt1Vj8xWMY34T/K22aXByEbtTIqZlHCy7e2RuCmbhVn35O5duy19A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727715270; bh=9RnAhyOQkwTjtxG88TP6VEP
 kyTkWLwM95Nf648Gh+Ok=; b=QdFbpxa+fO8JBWX/fEaUvpaaS21uDa9/f8LdWX5lbJasLiyYLs
 ezlxAFJrpae3wiN+uCppgeybQbEeEdMmErCw==;
Message-ID: <6826659e-ddc9-4af6-b805-fc26a71f5a61@damsy.net>
Date: Mon, 30 Sep 2024 18:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] drm/amd/pm: add sysfs attribute access wrappers
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-8-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20240925075607.23929-8-pierre-eric.pelloux-prayer@amd.com>
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



Le 25/09/2024 à 09:54, Pierre-Eric Pelloux-Prayer a écrit :
> All attributes do the same thing wrt to runtime power management,
> so we can consolidate the handling in 2 wrappers.
> 
> For some setters this will change the behavior slightly, as rpm
> is now done before arguments validation - so the device will be
> resumed even if the arguments passed in are incorrect.
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 399 ++++---------------------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h |  16 +-
>   2 files changed, 78 insertions(+), 337 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 13be5e017a01..1bac174e6d09 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -97,6 +97,61 @@ const char * const amdgpu_pp_profile_name[] = {
>   	"UNCAPPED",
>   };
>   
> +static ssize_t amdgpu_pp_attr_show_wrapper(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	struct amdgpu_device_attr *aattr;
> +	ssize_t r;
> +	int ret;
> +
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +	ret = pm_runtime_get_if_active(dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
> +
> +	aattr = to_amdgpu_device_attr(attr);
> +
> +	r = aattr->attr_show(dev, attr, buf);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return r;
> +}
> +
> +static ssize_t amdgpu_pp_attr_store_wrapper(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	struct amdgpu_device_attr *aattr;
> +	ssize_t r;
> +	int ret;
> +
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +	if (adev->in_suspend && !adev->in_runpm)
> +		return -EPERM;
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	aattr = to_amdgpu_device_attr(attr);
> +
> +	r = aattr->attr_store(dev, attr, buf, count);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return r;
> +}
> +
> +
>   /**
>    * DOC: power_dpm_state
>    *
> @@ -138,19 +193,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	enum amd_pm_state_type pm;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
>   
>   	amdgpu_dpm_get_current_power_state(adev, &pm);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return sysfs_emit(buf, "%s\n",
>   			  (pm == POWER_STATE_TYPE_BATTERY) ? "battery" :
>   			  (pm == POWER_STATE_TYPE_BALANCED) ? "balanced" : "performance");
> @@ -164,12 +209,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	enum amd_pm_state_type  state;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>   
>   	if (strncmp("battery", buf, strlen("battery")) == 0)
>   		state = POWER_STATE_TYPE_BATTERY;
> @@ -180,15 +219,8 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   	else
>   		return -EINVAL;
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	amdgpu_dpm_set_power_state(adev, state);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   }
>   
> @@ -259,19 +291,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	enum amd_dpm_forced_level level = 0xff;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
>   
>   	level = amdgpu_dpm_get_performance_level(adev);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return sysfs_emit(buf, "%s\n",
>   			  (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
>   			  (level == AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
> @@ -293,12 +315,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	enum amd_dpm_forced_level level;
> -	int ret = 0;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>   
>   	if (strncmp("low", buf, strlen("low")) == 0) {
>   		level = AMD_DPM_FORCED_LEVEL_LOW;
> @@ -324,14 +340,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>   	if (amdgpu_dpm_force_performance_level(adev, level)) {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
>   		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>   		return -EINVAL;
>   	}
> @@ -339,9 +349,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   	adev->pm.stable_pstate_ctx = NULL;
>   	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   }
>   
> @@ -353,20 +360,11 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	struct pp_states_info data;
>   	uint32_t i;
> -	int buf_len, ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	int buf_len;
>   
>   	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>   		memset(&data, 0, sizeof(data));
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
>   	for (i = 0; i < data.nums; i++)
>   		buf_len += sysfs_emit_at(buf, buf_len, "%d %s\n", i,
> @@ -386,21 +384,12 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	struct pp_states_info data = {0};
>   	enum amd_pm_state_type pm = 0;
> -	int i = 0, ret = 0;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	int i, ret;
>   
>   	amdgpu_dpm_get_current_power_state(adev, &pm);
>   
>   	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (ret)
>   		return ret;
>   
> @@ -422,11 +411,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	if (adev->pm.pp_force_state_enabled)
>   		return amdgpu_get_pp_cur_state(dev, attr, buf);
>   	else
> @@ -445,11 +429,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   	unsigned long idx;
>   	int ret;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	adev->pm.pp_force_state_enabled = false;
>   
>   	if (strlen(buf) == 1)
> @@ -461,10 +440,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   
>   	idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>   	if (ret)
>   		goto err_out;
> @@ -482,14 +457,9 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   		adev->pm.pp_force_state_enabled = true;
>   	}
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   
>   err_out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
>   	return ret;
>   }
>   
> @@ -511,19 +481,10 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	char *table = NULL;
> -	int size, ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	int size;
>   
>   	size = amdgpu_dpm_get_pp_table(adev, &table);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (size <= 0)
>   		return size;
>   
> @@ -542,22 +503,10 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	int ret = 0;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	int ret;
>   
>   	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (ret)
>   		return ret;
>   
> @@ -725,11 +674,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   	const char delimiter[3] = {' ', '\n', '\0'};
>   	uint32_t type;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	if (count > 127 || count == 0)
>   		return -EINVAL;
>   
> @@ -775,10 +719,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   			tmp_str++;
>   	}
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	if (amdgpu_dpm_set_fine_grain_clk_vol(adev,
>   					      type,
>   					      parameter,
> @@ -796,14 +736,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   			goto err_out;
>   	}
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   
>   err_out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
>   	return -EINVAL;
>   }
>   
> @@ -825,13 +760,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   	};
>   	uint clk_index;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> -
>   	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>   		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
>   		if (ret)
> @@ -849,8 +777,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   	if (size == 0)
>   		size = sysfs_emit(buf, "\n");
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return size;
>   }
>   
> @@ -880,24 +806,12 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>   	uint64_t featuremask;
>   	int ret;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	ret = kstrtou64(buf, 0, &featuremask);
>   	if (ret)
>   		return -EINVAL;
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (ret)
>   		return -EINVAL;
>   
> @@ -911,21 +825,11 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	ssize_t size;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
>   
>   	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>   	if (size <= 0)
>   		size = sysfs_emit(buf, "\n");
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return size;
>   }
>   
> @@ -975,14 +879,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	int size = 0;
> -	int ret = 0;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	int ret;
>   
>   	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>   	if (ret == -ENOENT)
> @@ -991,8 +888,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   	if (size == 0)
>   		size = sysfs_emit(buf, "\n");
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return size;
>   }
>   
> @@ -1041,24 +936,12 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
>   	int ret;
>   	uint32_t mask = 0;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = amdgpu_dpm_force_clock_level(adev, type, mask);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (ret)
>   		return -EINVAL;
>   
> @@ -1221,20 +1104,10 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t value = 0;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	uint32_t value;
>   
>   	value = amdgpu_dpm_get_sclk_od(adev);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return sysfs_emit(buf, "%d\n", value);
>   }
>   
> @@ -1248,25 +1121,13 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>   	int ret;
>   	long int value;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	ret = kstrtol(buf, 0, &value);
>   
>   	if (ret)
>   		return -EINVAL;
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   }
>   
> @@ -1276,20 +1137,10 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	uint32_t value = 0;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	uint32_t value;
>   
>   	value = amdgpu_dpm_get_mclk_od(adev);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return sysfs_emit(buf, "%d\n", value);
>   }
>   
> @@ -1303,25 +1154,13 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>   	int ret;
>   	long int value;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	ret = kstrtol(buf, 0, &value);
>   
>   	if (ret)
>   		return -EINVAL;
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   }
>   
> @@ -1352,21 +1191,11 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	ssize_t size;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
>   
>   	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>   	if (size <= 0)
>   		size = sysfs_emit(buf, "\n");
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return size;
>   }
>   
> @@ -1388,11 +1217,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   	long int profile_mode = 0;
>   	const char delimiter[3] = {' ', '\n', '\0'};
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	tmp[0] = *(buf);
>   	tmp[1] = '\0';
>   	ret = kstrtol(tmp, 0, &profile_mode);
> @@ -1419,15 +1243,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   	}
>   	parameter[parameter_size] = profile_mode;
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (!ret)
>   		return count;
>   
> @@ -1546,10 +1363,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	uint64_t count0 = 0, count1 = 0;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
>   
>   	if (adev->flags & AMD_IS_APU)
>   		return -ENODATA;
> @@ -1557,14 +1370,8 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>   	if (!adev->asic_funcs->get_pcie_usage)
>   		return -ENODATA;
>   
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> -
>   	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return sysfs_emit(buf, "%llu %llu %i\n",
>   			  count0, count1, pcie_get_mps(adev->pdev));
>   }
> @@ -1586,11 +1393,6 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	if (adev->unique_id)
>   		return sysfs_emit(buf, "%016llx\n", adev->unique_id);
>   
> @@ -1685,18 +1487,12 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> -
>   	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>   	if (!ret)
>   		size = sysfs_emit(buf, "%u\n", limit);
>   	else
>   		size = sysfs_emit(buf, "failed to get thermal limit\n");
>   
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return size;
>   }
>   
> @@ -1719,21 +1515,12 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = amdgpu_dpm_set_apu_thermal_limit(adev, value);
>   	if (ret) {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
>   		dev_err(dev, "failed to update thermal limit\n");
>   		return ret;
>   	}
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return count;
>   }
>   
> @@ -1753,21 +1540,8 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	ssize_t size = 0;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
>   
> -	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
> -
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
> -	return size;
> +	return amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>   }
>   
>   /**
> @@ -1789,15 +1563,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	void *gpu_metrics;
> -	ssize_t size = 0;
> -	int ret;
> -
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev, true);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ssize_t size;
>   
>   	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>   	if (size <= 0)
> @@ -1809,8 +1575,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   	memcpy(buf, gpu_metrics, size);
>   
>   out:
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	return size;
>   }
>   
> @@ -1900,23 +1664,12 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>   					  struct device_attribute *attr,
>   					  const char *buf, size_t count)
>   {
> -	struct drm_device *ddev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	int r = 0;
> +	int r;
>   	int bias = 0;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_resume_and_get(ddev->dev);
> -	if (r < 0)
> -		return r;
> -
>   	r = kstrtoint(buf, 10, &bias);
>   	if (r)
> -		goto out;
> +		return r;
>   
>   	if (bias > AMDGPU_SMARTSHIFT_MAX_BIAS)
>   		bias = AMDGPU_SMARTSHIFT_MAX_BIAS;
> @@ -1928,9 +1681,6 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>   
>   	/* TODO: update bias level with SMU message */
>   
> -out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
>   	return r;
>   }
>   
> @@ -2184,11 +1934,6 @@ static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
>   	policy_attr =
>   		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);
>   }
>   
> @@ -2205,11 +1950,6 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
>   	char *tmp, *param;
>   	long val;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>   	count = min(count, sizeof(tmp_buf));
>   	memcpy(tmp_buf, buf, count);
>   	tmp_buf[count - 1] = '\0';
> @@ -2235,15 +1975,8 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
>   	policy_attr =
>   		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
>   
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>   	ret = amdgpu_dpm_set_pm_policy(adev, policy_attr->id, val);
>   
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> -
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index c12ced32f780..bf4e27b28330 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -88,6 +88,10 @@ struct amdgpu_device_attr {
>   	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
>   			   uint32_t mask, enum amdgpu_device_attr_states *states);
>   
> +	ssize_t (*attr_show)(struct device *dev, struct device_attribute *attr,
> +			     char *buf);
> +	ssize_t (*attr_store)(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count);
>   };
>   
>   struct amdgpu_device_attr_entry {
> @@ -98,10 +102,14 @@ struct amdgpu_device_attr_entry {
>   #define to_amdgpu_device_attr(_dev_attr) \
>   	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
>   
> -#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
> -	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
> -	  .attr_id = device_attr_id__##_name,				\
> -	  .flags = _flags,						\
> +#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)		\
> +	{ .dev_attr = __ATTR(_name, _mode,					\
> +			     amdgpu_pp_attr_show_wrapper,			\
> +			     _store ? amdgpu_pp_attr_store_wrapper : NULL),	\

FYI this triggers a warning on some compilers (the address of xxx will always evaluate as true) so 
I'll update this patch before merging to use AMDGPU_DEVICE_ATTR_RO / AMDGPU_DEVICE_ATTR_RW macros 
from the next patch.

Thanks,
Pierre-Eric

> +	  .attr_id = device_attr_id__##_name,					\
> +	  .flags = _flags,							\
> +	  .attr_show = _show,							\
> +	  .attr_store = _store,							\
>   	  ##__VA_ARGS__, }
>   
>   #define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
