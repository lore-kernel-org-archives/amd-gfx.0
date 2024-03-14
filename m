Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25207C54E5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 05:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59E010F611;
	Thu, 14 Mar 2024 05:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3JraKc7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B18310F617
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 05:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKD3dcg4QTvO5Ngdr5gbHBA1QK3VPLdfOcXTGveRBIgV0Nd/2pXjTgl/v/S4DZpp5YXdRv69QOsWeA1IC1bxnoDeg8SjoHbiRm3cLTbyklQOq+4WyZcVcoAfbqAPS+eaF+MDMnSZHD9Y6ebe+uzFEm/Tdy17IXFnnrOQdLPsoOT6T02AOgtO4hXx5JkVBYjM0GhmTVUgmdn66pZTAlf5nqPObzXizfaG+y2WPI8MEJZBSqHu4fBlCjhSVq1bYjkZFcCrIG2lcKIoDLuj+pGkxMEOKzidPwwooxCF8Mn90wbRqJRxpCgjVWTRHt/g0oOUNolCxy5jjIoHSNKkmPBtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kYgZ3jNizt9VvsyaCejSnYpAywj+7tTUZaxv7xRF+U=;
 b=ayGy2qJH0xVPMyXuPZJCoXJxForsWfLPyEgUJ5ir2RE8WDMEarHKRM9/ZbfXNJN0dWmm9AIIAixq8Jc/RYH4vDy1lwZ/SsAB4Tc9VFWyin5bwE9YQ2HbJGdKuMdFVoxE9VrNyVQN0OOix0T1KcWUXT4gDb952eNtDAPCYFXsTBlzEe4e52PqFoh/IGPGFqe+2SaNlIiJ3coNr0cx4LiLiEzAy1uG6KSkBsRzILKKkZ6nlNQYeLCpzD3rkOzajEDfzuNMEnpyTe0DC2AAvqo4rNEJx51W3kRz+M/mby4rK8ZsiceG459NJLnMyYJaO2HlWZD/pC91tOzwJck41/6tMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kYgZ3jNizt9VvsyaCejSnYpAywj+7tTUZaxv7xRF+U=;
 b=C3JraKc7rVTsTfuHFlNP77DsqqGURug1ds+MEzo8V8PRwOUUdSpwma31sUWNQXIDqlF39c9E11wsTfWdwqbxBhcTdoxb1pl2S8fKb6zpzaFF4Odb6gBG1g/Ie/4Ey7XBgIcQFDgF8ACvSIDiF3tahYYS/z80lUh9Y0IDon0spV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 05:40:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 05:40:58 +0000
Message-ID: <c5f9d534-f9dc-47bd-a610-ce9406b5a852@amd.com>
Date: Thu, 14 Mar 2024 11:10:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amd/pm: Add support for DPM policies
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, shuzhou.liu@amd.com
References: <20240313110256.669474-1-lijo.lazar@amd.com>
 <20240313110256.669474-2-lijo.lazar@amd.com>
In-Reply-To: <20240313110256.669474-2-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2621471d-ba7c-4633-b71c-08dc43e95331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt9wSxxoUMteWuRELAB+UEKh/ZVm125vkYdJmi8jupCgq9hmBQDeLk3NGjl/7mxUhJAqi46zAiTsx7n9A8fJONLYwpW4tqGSkSu29SkvkV6MOaPM9ugT/U/9xQWywqczeuN3EVV25HKkF8nunTLrTRx+2RZZ0tUdqRmz0RkVZWxjl9g9r4K79mTVwvasbIrSXqaxtd48bXCiArEmyuTd7LWZAWizWkUJXg1J4gT7vExM5+dZzH47pXNQRyJLa8e3iPNVoiy6vHBJYjQleXl7sKl0ltXqA78gMEK3L2H0xwFZAvDs8FwO51DlXw78ZL5QSjRZ/yGmmfB875cPx8JlQScoAijJafuAfvrB5w7VBGGuDGe3wTISyoSlTWXoIgZgBc2MAoSIl/iLDBi6zx//o2NFtwnsl1HPu6y1sQC50ei2XE6TsbKTirDwl5ub/4bcyCew5K3CBz9uVf963Bnxob04h7yrmsJ/BT+Ft+sHxweScPSafNq+Om6muIEnPAY/qPxpecsN/cuO5rnP5R8Ou+5khmxf5S5xaH+H6sBnUCiJtqHQE9KObdi3T3acrl40+s+hV9zSWtyluIWCGOWsuzoOLUqDnPzz3nkqrblrzi2wBRiKDe0ecQwshQxyXrkSZGgEJtY006n/YiObg+koSqyipiBRDo0Phw90dZfsJbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dzK25DcUtnWkF3WUVsdkxmd2U3TU1NUjZqWGVFbmU5RTBjQ05neU5RUDZt?=
 =?utf-8?B?R29pOWlzdjlOUE5TUmRJakljMG1BYjlqWS94a01MaDloVWh1eStyVVBEVmdM?=
 =?utf-8?B?cEt1OFY1a1hneWJOT2xybnhMME1ZNE1mNFFWemc2aUJwc1lnU2R0WTcvelho?=
 =?utf-8?B?Vlh2Q25ObFpUMXlXK2szRGZwT2lrU283Y2I1UnlFdnR2S1NLQ2ViL3ZUK3Zo?=
 =?utf-8?B?ckhvSXpYZEFjeUgyamsvR0tjZE1tS3VxM3NRZXNaUUkrQVF3ZDhTQXlRNER1?=
 =?utf-8?B?ZEFNRGJ6bFhCYlZISm8rbWd0bjAzaDk1QVI0b3d2UW1JWDQrcUV5VytNd1cz?=
 =?utf-8?B?RWVGZ3FvOXVGeHQwNVZhZzI5eUdJRkZNKy8wVjJhcXRkVkpIQjE4aXBSeFcw?=
 =?utf-8?B?NTRkMndITHN6cjEvbThTaVdEdWlvUGNsUmVFYjJhTngwMTJKdHc1VlMzVzF6?=
 =?utf-8?B?ekNDNEdMWlBYSll1dHlybXpHVnl5ZS9LbWVHd0crRFREU3pPcFJDdUpYZHBm?=
 =?utf-8?B?Q2R5cFlNVzZ3ZlVRdHg0ZnY0YXh2MmF4QVJoTUFyYmhvaHVsaDdKVk9KSElH?=
 =?utf-8?B?TVZXcFFyUXVmd1VMQWN4SWdWSTdNd3diK1hYa1krUkVYRHNSaE91ZHpWMitC?=
 =?utf-8?B?NThENEpUUEh1RlJlNG5NYWVESTVxY3ZhZ0FTMS9pZnEyeHV5cGV4aWpMU2tK?=
 =?utf-8?B?YlNnTUVRMEF0eXVmRk16WGRnQ0s3TXJJT3NiT0Fwb2lyRkFXcGIveWlTUHZW?=
 =?utf-8?B?cVJRbTBkTFpEemFBY2dxTlpmWmpGNk8wNDNtcmRCTzBWMTZxYm1iSll2enVk?=
 =?utf-8?B?UUw4NWp1SGRPNW52Kzd5c3NlYmd0a3UvVU82YVJBdS9ZSEdteWZZS1VEajZZ?=
 =?utf-8?B?V04weVRoU2w4akZiemg4ZTNGZDloMUpTZFdkVG5UekhmZmU4VXpkRENNWUJB?=
 =?utf-8?B?NjBqTFd3Q2pQdENDdURpNG5ObFdMZVVuU0NtSUVUL2RxaDc2U29GMG9abmlj?=
 =?utf-8?B?VU93NVJqZWZIWEhxMTNpZGVackJyVmZlWE1yNUw4TnlTNXIzNllaeS9tSk5x?=
 =?utf-8?B?TXNWKzR6cHRoS2NqZ05PS3BGY0Q2SEtVR3VKODc2N3o0Zm1RZDFrOGNWTndv?=
 =?utf-8?B?TUh4T2xSY0laV3BZcVpTMFV4bkZuZHRDMHJCTkJIVU5Lc2diVllVNjVBSVNi?=
 =?utf-8?B?WDZSRGI3aXBDbzAzV2dRRFVPT1d3QjFXekw4bWphT05rN1Bpc0FXWjNVK1Zi?=
 =?utf-8?B?VFBXaUtFZ2lET2dXWHFRZWpOY2ZTQnExa3NqYTVRNktlNWUwMENVcGF1UmJM?=
 =?utf-8?B?T0lzM3BndXJpbHN6N3VzSk1qdktHRWhja3Y4N0Z6dWwwMS9RUUlnbStPVDBz?=
 =?utf-8?B?ekhRbm52eis5M0x3OWR0UEVQNnZhMjd3WGpYbGNnTk1QMlpTTmc0aXlTeWVP?=
 =?utf-8?B?SStoME9kQTVUUk5kR1l1OUt1N3BueHowd284WVdrZERoQkNPTjQ0c2ZlSTho?=
 =?utf-8?B?RCtBSitaZS9Ud3JXZDV2WHN2STFMZ0UwUVl4NXpYdFRQTCt4Q1VvVnlZbVdi?=
 =?utf-8?B?b1krMmllamZMS2lvU0trR0NvZ1FPcWVSOG01Yy9kTkpVWDlhYnRxNmdwRGtP?=
 =?utf-8?B?YS9EYTlLZURWZVp1cXZCMEhPR0VzL1Q4UHk4N1VmRDZNdkpMMTBNUHBiYmVV?=
 =?utf-8?B?SVJRRU9wdHAwWEpMSjFKdHpIOXFtZ1lwY0N0d1h4YzliRVcyOGc5R1FacHpX?=
 =?utf-8?B?Z1hkcVE2VnQ5SDBON204Q1htd0JXV0Z1aHB3d3BTc2NmWGlhNjRKQ1RocEJt?=
 =?utf-8?B?Y2FzOWRSK2tTUG5yeStTZ1Rtd1BvYjduTi9EeVRIOXNvR0xKMmxzUnlCeUl0?=
 =?utf-8?B?T1JYKy90TEh3Z3orOXNtZVZGY2t3Zk14a0VJWENsK1lhTzJES1pmTDgyUUJ2?=
 =?utf-8?B?Nnd5d1ROUVVva2NHSFc5QndPRjA2UzNQaTN0YTJBNUhJTFkxeFY0eWVZQnd0?=
 =?utf-8?B?RjBWQ0JtSGxqY0tYb2x1c2RaUDVNTUdUR0dsdEtqdGdnT2xBZkorU0szamZv?=
 =?utf-8?B?U0p2UFFZOVVYb0Z1SnNubmpZTjd1czdBQkJadWNtL1d2RSszbzM1ZkdBb1Bj?=
 =?utf-8?Q?l11Io0NhIgHJPXdA3DURKYIBv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2621471d-ba7c-4633-b71c-08dc43e95331
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 05:40:58.5472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yTXKZgQpWfcqtD5bz2t8GP5eVXfnpX4tMRQO/L74RMUSRY81Li6WoezUeWUWi4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

This one is missing some NULL checks. Will send a v2.

Thanks,
Lijo

On 3/13/2024 4:32 PM, Lijo Lazar wrote:
> Add support to set/get information about different DPM policies. The
> support is only available on SOCs which use swsmu architecture.
> 
> A DPM policy type may be defined with different levels. For example, a
> policy may be defined to select Pstate preference and then later a
> pstate preference may be chosen.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 ++++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 92 ++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 95 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 ++++++
>  6 files changed, 265 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 32054ecf0b87..e48da7acd7a7 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -272,6 +272,22 @@ enum pp_xgmi_plpd_mode {
>  	XGMI_PLPD_COUNT,
>  };
>  
> +enum pp_pm_policy {
> +	PP_PM_POLICY_NONE = -1,
> +	PP_PM_POLICY_SOC_PSTATE = 0,
> +	PP_PM_POLICY_NUM,
> +};
> +
> +enum pp_policy_soc_pstate {
> +	SOC_PSTATE_DEFAULT = 0,
> +	SOC_PSTATE_0,
> +	SOC_PSTATE_1,
> +	SOC_PSTATE_2,
> +	SOC_PSTAT_COUNT,
> +};
> +
> +#define PP_POLICY_MAX_LEVELS 5
> +
>  #define PP_GROUP_MASK        0xF0000000
>  #define PP_GROUP_SHIFT       28
>  
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index f84bfed50681..db3addd07120 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -411,6 +411,35 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device *adev, int mode)
>  	return ret;
>  }
>  
> +ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	int ret = -EOPNOTSUPP;
> +
> +	if (is_support_sw_smu(adev)) {
> +		mutex_lock(&adev->pm.mutex);
> +		ret = smu_get_pm_policy_info(smu, buf);
> +		mutex_unlock(&adev->pm.mutex);
> +	}
> +
> +	return ret;
> +}
> +
> +int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
> +			     int policy_level)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	int ret = -EOPNOTSUPP;
> +
> +	if (is_support_sw_smu(adev)) {
> +		mutex_lock(&adev->pm.mutex);
> +		ret = smu_set_pm_policy(smu, policy_type, policy_level);
> +		mutex_unlock(&adev->pm.mutex);
> +	}
> +
> +	return ret;
> +}
> +
>  int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
>  {
>  	void *pp_handle = adev->powerplay.pp_handle;
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f09b9d49297e..d8c8eaff3355 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2155,6 +2155,96 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t amdgpu_get_pm_policy(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +	if (adev->in_suspend && !adev->in_runpm)
> +		return -EPERM;
> +
> +	return amdgpu_dpm_get_pm_policy_info(adev, buf);
> +}
> +
> +static ssize_t amdgpu_set_pm_policy(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int policy_type, ret, num_params = 0;
> +	char delimiter[] = " \n\t";
> +	char tmp_buf[128];
> +	char *tmp, *param;
> +	long val;
> +
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +	if (adev->in_suspend && !adev->in_runpm)
> +		return -EPERM;
> +
> +	count = min(count, sizeof(tmp_buf));
> +	memcpy(tmp_buf, buf, count);
> +	tmp_buf[count - 1] = '\0';
> +	tmp = tmp_buf;
> +
> +	tmp = skip_spaces(tmp);
> +	if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) == 0) {
> +		policy_type = PP_PM_POLICY_SOC_PSTATE;
> +		tmp += strlen("soc_pstate");
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	tmp = skip_spaces(tmp);
> +	while ((param = strsep(&tmp, delimiter))) {
> +		if (!strlen(param)) {
> +			tmp = skip_spaces(tmp);
> +			continue;
> +		}
> +		ret = kstrtol(param, 0, &val);
> +		if (ret)
> +			return -EINVAL;
> +		num_params++;
> +		if (num_params > 1)
> +			return -EINVAL;
> +	}
> +
> +	if (num_params != 1)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	ret = amdgpu_dpm_set_pm_policy(adev, policy_type, val);
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static int amdgpu_pm_policy_attr_update(struct amdgpu_device *adev,
> +					 struct amdgpu_device_attr *attr,
> +					 uint32_t mask,
> +					 enum amdgpu_device_attr_states *states)
> +{
> +	if (amdgpu_dpm_get_pm_policy_info(adev, NULL) == -EOPNOTSUPP)
> +		*states = ATTR_STATE_UNSUPPORTED;
> +
> +	return 0;
> +}
> +
> +
>  static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -2193,6 +2283,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
>  			      .attr_update = ss_bias_attr_update),
>  	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
> +	AMDGPU_DEVICE_ATTR_RW(pm_policy,				ATTR_FLAG_BASIC,
> +			      .attr_update = amdgpu_pm_policy_attr_update),
>  	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
>  			      .attr_update = amdgpu_pm_metrics_attr_update),
>  };
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 621200e0823f..a98d1bda4430 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -594,4 +594,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>  						  unsigned int *num_states);
>  int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>  				   struct dpm_clocks *clock_table);
> +int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
> +			     int policy_level);
> +ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 246b211b1e85..1c23e0985377 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3465,6 +3465,101 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
>  	return 0;
>  }
>  
> +static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char *sysbuf,
> +				 size_t *size)
> +{
> +	size_t offset = *size;
> +	int level;
> +
> +	offset += sysfs_emit_at(sysbuf, offset, "%s \n", policy->desc->name);
> +	for_each_set_bit(level, &policy->level_mask, PP_POLICY_MAX_LEVELS) {
> +		if (level == policy->current_level)
> +			offset += sysfs_emit_at(
> +				sysbuf, offset, "%d : %s*\n", level,
> +				policy->desc->get_desc(policy, level));
> +		else
> +			offset += sysfs_emit_at(
> +				sysbuf, offset, "%d : %s\n", level,
> +				policy->desc->get_desc(policy, level));
> +	}
> +
> +	*size = offset;
> +}
> +
> +ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf)
> +{
> +	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
> +	struct smu_dpm_policy_ctxt *policy_ctxt;
> +	struct smu_dpm_policy *dpm_policy;
> +	size_t offset = 0;
> +	int i;
> +
> +	policy_ctxt = dpm_ctxt->dpm_policies;
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt ||
> +	    !policy_ctxt->policy_mask)
> +		return -EOPNOTSUPP;
> +
> +	if (!sysbuf)
> +		return -EINVAL;
> +
> +	for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
> +		dpm_policy = &policy_ctxt->policies[i];
> +		if (!dpm_policy->level_mask || !dpm_policy->desc)
> +			continue;
> +		smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
> +	}
> +
> +	return offset;
> +}
> +
> +struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
> +					 enum pp_pm_policy p_type)
> +{
> +	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
> +	struct smu_dpm_policy_ctxt *policy_ctxt;
> +	int i;
> +
> +	policy_ctxt = dpm_ctxt->dpm_policies;
> +	for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
> +		if (policy_ctxt->policies[i].policy_type == p_type)
> +			return &policy_ctxt->policies[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
> +		      int level)
> +{
> +	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
> +	struct smu_dpm_policy *dpm_policy = NULL;
> +	struct smu_dpm_policy_ctxt *policy_ctxt;
> +	int ret = -EOPNOTSUPP;
> +
> +	policy_ctxt = dpm_ctxt->dpm_policies;
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt ||
> +	    !policy_ctxt->policy_mask)
> +		return ret;
> +
> +	if (level < 0 || level >= PP_POLICY_MAX_LEVELS)
> +		return -EINVAL;
> +
> +	dpm_policy = smu_get_pm_policy(smu, p_type);
> +
> +	if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy->set_policy)
> +		return ret;
> +
> +	if (dpm_policy->current_level == level)
> +		return 0;
> +
> +	ret = dpm_policy->set_policy(smu, level);
> +
> +	if (!ret)
> +		dpm_policy->current_level = level;
> +
> +	return ret;
> +}
> +
>  int smu_set_xgmi_plpd_mode(struct smu_context *smu,
>  			   enum pp_xgmi_plpd_mode mode)
>  {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a870bdd49a4e..39405e4ef590 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -362,6 +362,27 @@ struct smu_table_context {
>  	void				*gpu_metrics_table;
>  };
>  
> +struct smu_context;
> +struct smu_dpm_policy;
> +
> +struct smu_dpm_policy_desc {
> +	const char *name;
> +	char *(*get_desc)(struct smu_dpm_policy *dpm_policy, int level);
> +};
> +
> +struct smu_dpm_policy {
> +	struct smu_dpm_policy_desc *desc;
> +	enum pp_pm_policy policy_type;
> +	unsigned long level_mask;
> +	int current_level;
> +	int (*set_policy)(struct smu_context *ctxt, int level);
> +};
> +
> +struct smu_dpm_policy_ctxt{
> +	struct smu_dpm_policy policies[PP_PM_POLICY_NUM];
> +	unsigned long policy_mask;
> +};
> +
>  struct smu_dpm_context {
>  	uint32_t dpm_context_size;
>  	void *dpm_context;
> @@ -372,6 +393,7 @@ struct smu_dpm_context {
>  	struct smu_power_state *dpm_request_power_state;
>  	struct smu_power_state *dpm_current_power_state;
>  	struct mclock_latency_table *mclk_latency_table;
> +	struct smu_dpm_policy_ctxt *dpm_policies;
>  };
>  
>  struct smu_power_gate {
> @@ -1547,6 +1569,9 @@ typedef struct {
>  	uint32_t		MmHubPadding[8];
>  } WifiBandEntryTable_t;
>  
> +struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
> +					 enum pp_pm_policy p_type);
> +
>  #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
>  int smu_get_power_limit(void *handle,
>  			uint32_t *limit,
> @@ -1594,5 +1619,9 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
>  int smu_send_rma_reason(struct smu_context *smu);
> +int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
> +		      int level);
> +ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf);
> +
>  #endif
>  #endif
