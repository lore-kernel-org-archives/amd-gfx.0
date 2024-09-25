Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE75CF9C72
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 14:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0131A10E836;
	Wed, 25 Sep 2024 14:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="ixxVTQ/n";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="oW8mc6/k";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE15210E836
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727274555;
 bh=EuJfz2OTBVW2zqQ68uRRreH
 Yo3Yfq1l7CDS75+ghdNo=; b=ixxVTQ/nS4gD9EMUCB9l16PSJz+ep5aNhK/7PbzdX+DLfOhcfS
 sIe990i/GWvgQVyOpOrrzDzq3fifV9EmhkoMBckGDHw2cbAP6ejTE65BXMl46gmGpl8mxsfm0QM
 O2vbWJWjaqf+qdDom585HywHcw5WbBdW/Uj/Znb5YV+YpjVY+1/ansFcgeN2CTHtLMx6VevQR38
 tFJmjkzB/gEefpi43H8tDJ/bIddSxiGJTOLA6vQtmDGPu06O6OIGU74T388e6Hl5bTgWHzq31cN
 d7zAsMkG88S9m5XE3qvpTx+HQIAh84+m8GV+DrKEegb7t0RHtIn1hCssPLq9DdWV2BQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1727274555; bh=EuJfz2OTBVW2zqQ68uRRreH
 Yo3Yfq1l7CDS75+ghdNo=; b=oW8mc6/kip0uNll5luR4/00tEHRRkXoK18pintYqpQCIBFyk6j
 HkptU3E+Y00xc1UqAAn1oYjgg9TLfli7+qDw==;
Message-ID: <96b08208-0bb2-4f6d-967b-dd9594994250@damsy.net>
Date: Wed, 25 Sep 2024 16:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] drm/amd/pm: stop extra checks for runtime pm state
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-7-pierre-eric.pelloux-prayer@amd.com>
 <30fb4696-0ac6-40cf-a493-7849e34cf0db@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <30fb4696-0ac6-40cf-a493-7849e34cf0db@amd.com>
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



Le 25/09/2024 à 15:37, Lazar, Lijo a écrit :
> 
> 
> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
>> pm_runtime_get_if_in_use already checks if the GPU is active,
>> so there's no need for manually checking runtimepm status:
>>
>>     if (adev->in_suspend && !adev->in_runpm)
>>        return -EPERM;
>>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 46 ------------------------------
>>   1 file changed, 46 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index f1f339b75380..13be5e017a01 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -142,8 +142,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
> 
> I believe this check is for accesses before the device is fully resumed
> from a suspend sequence. That is not tied to runtime PM.

AFAICT in_suspend / in_runpm are only set from resume / suspend sequences, so checking 
runtime_status != RPM_ACTIVE like pm_runtime_get_if_in_use does should provide the same result.

(= during resume the device status is RPM_RESUMING)

Pierre-Eric


> 
> Thanks,
> Lijo
> 
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -265,8 +263,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -361,8 +357,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -396,8 +390,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -523,8 +515,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -837,8 +827,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -927,8 +915,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -993,8 +979,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -1242,8 +1226,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -1299,8 +1281,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -1376,8 +1356,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -1464,8 +1442,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	r = pm_runtime_get_if_active(adev->dev, true);
>>   	if (r <= 0)
>> @@ -1574,8 +1550,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	if (adev->flags & AMD_IS_APU)
>>   		return -ENODATA;
>> @@ -1784,8 +1758,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -1822,8 +1794,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(ddev->dev, true);
>>   	if (ret <= 0)
>> @@ -2697,8 +2667,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(adev->dev, true);
>>   	if (ret <= 0)
>> @@ -2825,8 +2793,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	err = pm_runtime_get_if_active(adev->dev, true);
>>   	if (err <= 0)
>> @@ -2852,8 +2818,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	err = pm_runtime_get_if_active(adev->dev, true);
>>   	if (err <= 0)
>> @@ -2913,8 +2877,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	err = pm_runtime_get_if_active(adev->dev, true);
>>   	if (err <= 0)
>> @@ -2983,8 +2945,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(adev->dev, true);
>>   	if (ret <= 0)
>> @@ -3149,8 +3109,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	r = pm_runtime_get_if_active(adev->dev, true);
>>   	if (r <= 0)
>> @@ -3682,8 +3640,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	ret = pm_runtime_get_if_active(adev->dev, true);
>>   	if (ret <= 0)
>> @@ -4649,8 +4605,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>>   
>>   	if (amdgpu_in_reset(adev))
>>   		return -EPERM;
>> -	if (adev->in_suspend && !adev->in_runpm)
>> -		return -EPERM;
>>   
>>   	r = pm_runtime_resume_and_get(dev->dev);
>>   	if (r < 0)
