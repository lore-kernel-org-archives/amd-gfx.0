Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5997410E361;
	Thu,  9 Dec 2021 16:53:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716EA89CF6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 11:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ27S84T3S/eM4/vDs1mzRVPBjFcxSdGLOIN2MoOljq+GEytGEjNl0uzBcguDGRm0Bfj+yDe6cB9QeaPUKXkdjpPSgARTdc6VmKwSw0jnzKfhdQCtViJUgx+9FhfrpxP4mK4peMl5ZMDTDcU5idTopOP9uGYWUb+cnzC3ihKRHEJ2nKe6/WCLg+waae8VSrZrdaBtK0DP/DPGq3OIK6yklkDwTgE6tmlVK2Edp82CCpbbfzHruBGd9x03wTKe7YK43yhwnxSjekWEKVD5YSNhvV75nGLYBEYgBmw5/ymadlKl2Vj9cjvGpSsUu2gM4Vjpj6EIvMBAkI3E+6k0Vok+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1Cusa25sjE75YHBdpA4Z70SvdTEYFcHPXkXeq0ze0s=;
 b=XIQxQEvBDjKTHpWJahDaiR5B5AWdD1JAtSO/j5EY0JiaB38COMtODGWc4kKyyDFFJ4vWqTL9/vxLJOE9wV76sQnUtuhK8g4Q5HmiCbKY4Aj0q0XD15DrNsZH6hfkcho9a9A7hvJRCISjp9rMqzvIIbeJuBP8PlxniY3eHEOsADPqfwKdK4klpUtZOPLdAhTiQcgI02w0J+ZvwLZsFnn0LK0dSRH6gquHZyfUoTvtxKnVN3dPcDf2vyj0301gA38h3lsUNqUT0j83K0rVYAZ7P5Z5m/hbxh+yVCzG+nC2M9lr+1TUcYh/yVp4Kt1i7Rjxzn4FT5cCobPmw/kntFcvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1Cusa25sjE75YHBdpA4Z70SvdTEYFcHPXkXeq0ze0s=;
 b=Eql0Cpz7fb6pqvG/2Dechbi/FzCR3LoQ8ar0qqdMZA8m6Krh5Kfa2hKbGdcZiLr/RSKJ9MULEvsJOKmvXH54Pt+xqeyPw8tRyheUn4usXMHBFlB4urSPU1ImGMI2ZCyb9Nj/+lXbvmzudUoEVagY+t6ul7OpNl+s+22T6VL9z9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 11:58:12 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 11:58:12 +0000
Message-ID: <62915ae3-64b6-f2a3-d59d-e72dba1e56d1@amd.com>
Date: Thu, 9 Dec 2021 17:27:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 02/17] drm/amd/pm: do not expose power implementation
 details to amdgpu_pm.c
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203030540.1710564-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::17) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 222a35db-b5ed-481c-7025-08d9bb0b2c6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29401BED4ECAB797DBCCAB8997709@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1090EEyvmgE0Zob1badbHpKcdsScaKdYRAuwxITz+mzJ3A+LxijNsyjJFAy6i8B7J9O1iFhNrr9hglBAUIftjVTNKuyTG3kwJccy979kDHbLUbjLZHRh8FLSC4Wvl/veqvd+dD4tvLIllN6tVs9NL8T9P8KaU91JyVyHzE7gpJR83fsmV78U6HEuPwnWltz9K2mRDDhyc9tGpYtGugus+FpPYyX1cF/AaD3Cq8XFoqtl4HH7EeJkY+twx0tpkrZq5yBvgl9eMysZYGU5do8Z8J/FbVWL44YXPvwddoPs4QuaC7yQirFwL0KxFCBauGVknXcsawlFaVhoV5HNk9qotKdf/MRpxmqrrJRZQZF/z6FGTLd4OWl7ubULdM11IX9BNX6Q2F/BetQsM037Za4F3twUUjWVOAK9dNjDqGZUd+YxpjdS8lCVnn9/HM7862VoO334tPvutVkWJCpl/6NfOIVFBPH1yPBeYT1cXc4GongipRTJZnL2XVEzji8+YXLr1iO4HaEwlzKojdGXyoP7ILCrIj3Wc44+iIWfbshHBZYezeIykIzDHWt7Ot0v0170QaoX7JZ8gNq628zeIctc7jfwGSRrxvQs9XmHNTb2cB77b16d5ntctspOQBuAwThlPSIWEU/81VS1tKyTz9jlLps/oMw5r3gnP8rxn0lpv8Rf3adsHq8vSPMqAcQmptPD1HPg5yFIF71u9u2QvS0DL5FG9JAHij36c2ya1YIppE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(8676002)(508600001)(6512007)(8936002)(66946007)(66556008)(38100700002)(66476007)(6486002)(5660300002)(316002)(4326008)(31686004)(36756003)(30864003)(31696002)(6666004)(2616005)(86362001)(6506007)(53546011)(26005)(83380400001)(186003)(43740500002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZIR2tCMlliQUJhQjA4VVF1MXZDaGx2OU1zZk5YS3ExQVpHTUFSbDBmT2pG?=
 =?utf-8?B?VHpoV2dvcWF6RkZuV0hJSnZ3QnpuUnA3Y3hlRGtQZ1g2RUlGbEhKSHZydzNF?=
 =?utf-8?B?L2MycmE4c0pPWVF2WjlheHdicUlQVUQ1cE5oRmlHbHZDK0xaQURVRVNoVDlx?=
 =?utf-8?B?allETG9kVzQ3UzZtdGJzZ3JIczcrTGZUTzhmUDVpNU15RVJYd0F3ZE9BdTNr?=
 =?utf-8?B?eHliOVNvREZydWJmU1lFQnJNRWZ0MVZqRU1Sakcvc09qZE5hUlFoN0dvMGdP?=
 =?utf-8?B?NzBHSThsZ3k0VDdvQXJvbThGRTVTK2pVV2dOM3VMWnJLQjNHVnVkbDJDYXRt?=
 =?utf-8?B?bFh6NVJ2TGE3MDdiUGZLeGNzUWdWTmF6WisxTmlTVjJuZ1VGYWRzbHIvZDFs?=
 =?utf-8?B?Unc2S1ZIZllMOHlRNmpiQ0hZd3A3N0tlV0FWTU5zMjRKcGp3OGhBTmRhdW9P?=
 =?utf-8?B?OCtYNTJhdjlWcWo4N01XcUM0ZnJ4cWtWVjJyT2RPbkdOVEk0akNJNU56WlFy?=
 =?utf-8?B?RzJXNVZBcDFUNTVZSjJ6OWpyMkJYQ1RrUWkxaERLTUw5N2xkVzgwSjdwTHFk?=
 =?utf-8?B?b1Jsck1HYlpLOUY4TEJsc0lMSnBzOU9IUFF3dzNpRmZjK2IrL1hJdFFwMmU2?=
 =?utf-8?B?QmduSGlNVU9oTWg5cVh2bFU1UnFORXJYK2QwM3k0RjRZdForbEx4aGh3OGZS?=
 =?utf-8?B?UWcvcWNLSlBVbUdzaUhJNlNKZUUvMWpOLzBsRTZvNDFKT0xrWDdsaTBkWEt6?=
 =?utf-8?B?blZpYnMyM2hYakdnWS85TnRlemw3TGt0RGZqVzVZOEJjRWx5TTBLbkh2Yk1o?=
 =?utf-8?B?RTlZMmYwL1kyaE50TE9TSjlBMk8xcjBQRHdlNzRZQVh5bGkrdmJSeXN6TzZr?=
 =?utf-8?B?WXdPRVRmZW95NVBGcDIxT0dmNmpyWlhGeStLTDdaWk42NlBIVER5blR0MFl3?=
 =?utf-8?B?eldCOGxZYlFDU1Q2S0pseTVnSGRhUHRjY0xQYnhTbHVqLzdwQWd4bmw1bG5U?=
 =?utf-8?B?MjQ5WGhtMG9SaFVlWlFVbUJ1aHZZb3NyOHQyQnR5cm0wOXJQdUF3bS9ZZGRR?=
 =?utf-8?B?WVR0NU52cFcxeVlMYTNRSzRDZGZUS0trL3RuV0hzZ3hLanllcGtDSlo3c0w0?=
 =?utf-8?B?dHNaZHZjcENkUWtZK1EvWnhzRW9veHZPT0FmVlNUOG5XU0VIMGVJN3o3M3Fw?=
 =?utf-8?B?RWR3RFpEKzEyRmEvMVUySjRxQVdpU0hSV3JTakRHUm1UaVJibFVHYnFlMkNP?=
 =?utf-8?B?elM0YlZVVUpDYjhpTlVGTzBWTkp0cUw2cGZLbDlBYlZaUm1ucjVMMFhzZm9P?=
 =?utf-8?B?YitQMzUxUUlmZHRSQUtreXZaZWpNWml4R2tNRTdhV3BXREtxbGltelNLTWJD?=
 =?utf-8?B?bTdJSjhTVS83Qi95Sldyb3FxY3p4cXpWcVh1RkNhVzk4NFpPTmNuM1ZlT1Jx?=
 =?utf-8?B?SjNzOCsyUjFaelZBaGJxOTJCUnFobGkzOU9tNUF3b1VaNUQzUzRDUGQ2akN3?=
 =?utf-8?B?cnZTZ1JNWWVqMUFFMGc5dnJKZGoyeWp0R1V0aTVvNkI5dWh3cDllemRqWmJD?=
 =?utf-8?B?bE1LUnZod3dlN00xR1VYb3lBV3ZmcXE1TDBTZU9LUWJXWU5LRWdiTGRkZjU5?=
 =?utf-8?B?WFVEckhnR1NOWEU0TTZpZHRlbHY4Ymp0NUJQcm1TdzlvT0lKTnZlYy9HTlBP?=
 =?utf-8?B?QVNVbnNJWFZXYVk3WkRVdGlqR3dpSk1FbG1YaVo4b2llNHdzSm1lZHA3SGVQ?=
 =?utf-8?B?Z0hDZEZVUTJtUnViTy9GblhuckNMMXF4VnBrN1cwcUMwYVcvalRHRmNXV2Nx?=
 =?utf-8?B?TUhybFE1WGZkRHJ5anl1QUoyWCtCZzJBOGt4QnJ0ZTYvOTRzQ0NidCtzWFps?=
 =?utf-8?B?L1Flbi83emxTMkY2VFlPVWhYRmNkQzhKWUZ0cEVSRXk5elhiamVDREt2UWxY?=
 =?utf-8?B?YlpDQXNnb0RHWjA3T1JvQ1g4Vitmdy9tUlBXcFhrMU5lTGhJcXg2TW5jbVVX?=
 =?utf-8?B?cTJ2QytCN0lCcnNEUzNaNzlsMThoSEFSUklzVVlhcU0xZ3RndjZwNGM3NHBn?=
 =?utf-8?B?WjFYZGRBTEtJZElTQ2swd29hcVVnOHRleDBhdkZHaFNCUWF4Z1NJUlcweUU5?=
 =?utf-8?Q?xrEg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222a35db-b5ed-481c-7025-08d9bb0b2c6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:58:12.0526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adQbVe97oeKm8TCIxDvgNVrNrCQcg59KLi+nH29Vwe1c9f70vMa63G2CXEg4EFhU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 8:35 AM, Evan Quan wrote:
> amdgpu_pm.c holds all the user sysfs/hwmon interfaces. It's another
> client of our power APIs. It's not proper to spike into power
> implementation details there.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I397853ddb13eacfce841366de2a623535422df9a
> --
> v1->v2:
>    - drop unneeded "return;" in amdgpu_dpm_get_current_power_state(Guchun)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 456 ++++++++++++++++++-
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 519 ++++++++--------------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 160 +++----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |   3 -
>   4 files changed, 707 insertions(+), 431 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 54abdf7080de..2c789eb5d066 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1453,7 +1453,9 @@ static void amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   	if (equal)
>   		return;
>   
> -	amdgpu_dpm_set_power_state(adev);
> +	if (adev->powerplay.pp_funcs->set_power_state)
> +		adev->powerplay.pp_funcs->set_power_state(adev->powerplay.pp_handle);
> +
>   	amdgpu_dpm_post_set_power_state(adev);
>   
>   	adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
> @@ -1704,3 +1706,455 @@ int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>   
>   	return smu_get_ecc_info(&adev->smu, umc_ecc);
>   }
> +
> +struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
> +						     uint32_t idx)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_vce_clock_state)
> +		return NULL;
> +
> +	return pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
> +					     idx);
> +}
> +
> +void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev,
> +					enum amd_pm_state_type *state)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_current_power_state) {
> +		*state = adev->pm.dpm.user_state;
> +		return;
> +	}
> +
> +	*state = pp_funcs->get_current_power_state(adev->powerplay.pp_handle);
> +	if (*state < POWER_STATE_TYPE_DEFAULT ||
> +	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
> +		*state = adev->pm.dpm.user_state;
> +}
> +
> +void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
> +				enum amd_pm_state_type state)
> +{
> +	adev->pm.dpm.user_state = state;
> +
> +	if (adev->powerplay.pp_funcs->dispatch_tasks)
> +		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
> +	else
> +		amdgpu_pm_compute_clocks(adev);
> +}
> +
> +enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum amd_dpm_forced_level level;
> +
> +	if (pp_funcs->get_performance_level)
> +		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
> +	else
> +		level = adev->pm.dpm.forced_level;
> +
> +	return level;
> +}
> +
> +int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
> +				       enum amd_dpm_forced_level level)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (pp_funcs->force_performance_level) {
> +		if (adev->pm.dpm.thermal_active)
> +			return -EINVAL;
> +
> +		if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
> +						      level))
> +			return -EINVAL;
> +	}
> +
> +	adev->pm.dpm.forced_level = level;
> +

If the function is not implemented, why change the force level and 
return success?

> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
> +				 struct pp_states_info *states)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_pp_num_states)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_pp_num_states(adev->powerplay.pp_handle, states);
> +}
> +
> +int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
> +			      enum amd_pp_task task_id,
> +			      enum amd_pm_state_type *user_state)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->dispatch_tasks)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->dispatch_tasks(adev->powerplay.pp_handle, task_id, user_state);
> +}
> +
> +int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_pp_table)
> +		return 0;
> +
> +	return pp_funcs->get_pp_table(adev->powerplay.pp_handle, table);
> +}
> +
> +int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
> +				      uint32_t type,
> +				      long *input,
> +				      uint32_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fine_grain_clk_vol)
> +		return 0;
> +

Better for this also to return -EOPNOTSUPP. There are a few other funcs 
below also which returns 0, instead they should return EOPNOTSUPP. Let 
the caller decide what to do when not supported instead of returning 
'fake success'.

> +	return pp_funcs->set_fine_grain_clk_vol(adev->powerplay.pp_handle,
> +						type,
> +						input,
> +						size);
> +}
> +
> +int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
> +				  uint32_t type,
> +				  long *input,
> +				  uint32_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->odn_edit_dpm_table)
> +		return 0;
> +
> +	return pp_funcs->odn_edit_dpm_table(adev->powerplay.pp_handle,
> +					    type,
> +					    input,
> +					    size);
> +}
> +
> +int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  char *buf)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->print_clock_levels)
> +		return 0;
> +
> +	return pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
> +					    type,
> +					    buf);
> +}
> +
> +int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
> +				    uint64_t ppfeature_masks)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_ppfeature_status)
> +		return 0;
> +
> +	return pp_funcs->set_ppfeature_status(adev->powerplay.pp_handle,
> +					      ppfeature_masks);
> +}
> +
> +int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_ppfeature_status)
> +		return 0;
> +
> +	return pp_funcs->get_ppfeature_status(adev->powerplay.pp_handle,
> +					      buf);
> +}
> +
> +int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
> +				 enum pp_clock_type type,
> +				 uint32_t mask)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->force_clock_level)
> +		return 0;
> +
> +	return pp_funcs->force_clock_level(adev->powerplay.pp_handle,
> +					   type,
> +					   mask);
> +}
> +
> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_sclk_od)
> +		return 0;
> +
> +	return pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
> +}
> +
> +int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_sclk_od)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
> +
> +	if (amdgpu_dpm_dispatch_task(adev,
> +				     AMD_PP_TASK_READJUST_POWER_STATE,
> +				     NULL) == -EOPNOTSUPP) {
> +		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> +		amdgpu_pm_compute_clocks(adev);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_mclk_od)
> +		return 0;
> +
> +	return pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
> +}
> +
> +int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_mclk_od)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
> +
> +	if (amdgpu_dpm_dispatch_task(adev,
> +				     AMD_PP_TASK_READJUST_POWER_STATE,
> +				     NULL) == -EOPNOTSUPP) {
> +		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> +		amdgpu_pm_compute_clocks(adev);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
> +				      char *buf)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_power_profile_mode)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->get_power_profile_mode(adev->powerplay.pp_handle,
> +						buf);
> +}
> +
> +int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
> +				      long *input, uint32_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_power_profile_mode)
> +		return 0;
> +
> +	return pp_funcs->set_power_profile_mode(adev->powerplay.pp_handle,
> +						input,
> +						size);
> +}
> +
> +int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_gpu_metrics)
> +		return 0;
> +
> +	return pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle, table);
> +}
> +
> +int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t *fan_mode)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_fan_control_mode)
> +		return -EOPNOTSUPP;
> +
> +	*fan_mode = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle);
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fan_speed_pwm)
> +		return -EINVAL;

To be consistent, use EOPNOTSUPP when the function is not implemented. 
The return of EINVAL from actual function call shouldn't be mixed with this.

> +
> +	return pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle, speed);
> +}
> +
> +int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t *speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_fan_speed_pwm)
> +		return -EINVAL;
> +
> +	return pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle, speed);
> +}
> +
> +int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t *speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_fan_speed_rpm)
> +		return -EINVAL;
> +
> +	return pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle, speed);
> +}
> +
> +int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t speed)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fan_speed_rpm)
> +		return -EINVAL;
> +
> +	return pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle, speed);
> +}
> +
> +int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t mode)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_fan_control_mode)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle, mode);
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> +			       uint32_t *limit,
> +			       enum pp_power_limit_level pp_limit_level,
> +			       enum pp_power_type power_type)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_power_limit)
> +		return -ENODATA;
> +

Again, this is mixing API error code based on caller's usage. In 
standalone implementatoin, this should also just return EOPNOTSUPP. 
hwmon API implementation can decide what to return when there is no API 
support.

> +	return pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> +					 limit,
> +					 pp_limit_level,
> +					 power_type);
> +}
> +
> +int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> +			       uint32_t limit)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_power_limit)
> +		return -EINVAL;
> +
> +	return pp_funcs->set_power_limit(adev->powerplay.pp_handle, limit);
> +}
> +
> +int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return false;
> +
> +	return is_support_cclk_dpm(adev);
> +}
> +
> +int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
> +						       struct seq_file *m)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->debugfs_print_current_performance_level)
> +		return -EOPNOTSUPP;
> +
> +	pp_funcs->debugfs_print_current_performance_level(adev->powerplay.pp_handle,
> +							  m);
> +
> +	return 0;
> +}
> +
> +int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
> +				       void **addr,
> +				       size_t *size)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->get_smu_prv_buf_details)
> +		return -ENOSYS;
> +
> +	return pp_funcs->get_smu_prv_buf_details(adev->powerplay.pp_handle,
> +						 addr,
> +						 size);
> +}
> +
> +int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
> +{
> +	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +
> +	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
> +	    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
> +		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
> +		return true;
> +
> +	return false;
> +}
> +
> +int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
> +			    const char *buf,
> +			    size_t size)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	if (!pp_funcs->set_pp_table)
> +		return -EOPNOTSUPP;
> +
> +	return pp_funcs->set_pp_table(adev->powerplay.pp_handle,
> +				      buf,
> +				      size);
> +}
> +
> +int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
> +{
> +	return adev->smu.cpu_core_num;
> +}
> +
> +void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return;
> +
> +	amdgpu_smu_stb_debug_fs_init(adev);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..3382d30b5d90 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -34,7 +34,6 @@
>   #include <linux/nospec.h>
>   #include <linux/pm_runtime.h>
>   #include <asm/processor.h>
> -#include "hwmgr.h"
>   
>   static const struct cg_flag_name clocks[] = {
>   	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock Gating"},
> @@ -132,7 +131,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	enum amd_pm_state_type pm;
>   	int ret;
>   
> @@ -147,11 +145,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (pp_funcs->get_current_power_state) {
> -		pm = amdgpu_dpm_get_current_power_state(adev);
> -	} else {
> -		pm = adev->pm.dpm.user_state;
> -	}
> +	amdgpu_dpm_get_current_power_state(adev, &pm);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -191,19 +185,8 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev)) {
> -		mutex_lock(&adev->pm.mutex);
> -		adev->pm.dpm.user_state = state;
> -		mutex_unlock(&adev->pm.mutex);

Here the code just sets the state and exits. However, when moved to 
refactored function, it is calling pm_compute_clocks.

> -	} else if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
> -	} else {
> -		mutex_lock(&adev->pm.mutex);
> -		adev->pm.dpm.user_state = state;
> -		mutex_unlock(&adev->pm.mutex);
> +	amdgpu_dpm_set_power_state(adev, state);
>   
> -		amdgpu_pm_compute_clocks(adev);
> -	}
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> @@ -290,10 +273,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_performance_level)
> -		level = amdgpu_dpm_get_performance_level(adev);
> -	else
> -		level = adev->pm.dpm.forced_level;
> +	level = amdgpu_dpm_get_performance_level(adev);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -318,7 +298,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	enum amd_dpm_forced_level level;
>   	enum amd_dpm_forced_level current_level;
>   	int ret = 0;
> @@ -358,11 +337,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (pp_funcs->get_performance_level)
> -		current_level = amdgpu_dpm_get_performance_level(adev);
> -	else
> -		current_level = adev->pm.dpm.forced_level;
> -
> +	current_level = amdgpu_dpm_get_performance_level(adev);
>   	if (current_level == level) {
>   		pm_runtime_mark_last_busy(ddev->dev);
>   		pm_runtime_put_autosuspend(ddev->dev);
> @@ -390,25 +365,12 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	if (pp_funcs->force_performance_level) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (adev->pm.dpm.thermal_active) {
> -			mutex_unlock(&adev->pm.mutex);
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -		ret = amdgpu_dpm_force_performance_level(adev, level);
> -		if (ret) {
> -			mutex_unlock(&adev->pm.mutex);
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		} else {
> -			adev->pm.dpm.forced_level = level;
> -		}
> -		mutex_unlock(&adev->pm.mutex);
> +	if (amdgpu_dpm_force_performance_level(adev, level)) {
> +		pm_runtime_mark_last_busy(ddev->dev);
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return -EINVAL;
>   	}
> +
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> @@ -421,7 +383,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct pp_states_info data;
>   	uint32_t i;
>   	int buf_len, ret;
> @@ -437,11 +398,8 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (pp_funcs->get_pp_num_states) {
> -		amdgpu_dpm_get_pp_num_states(adev, &data);
> -	} else {
> +	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>   		memset(&data, 0, sizeof(data));
> -	}
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -463,7 +421,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	struct pp_states_info data = {0};
>   	enum amd_pm_state_type pm = 0;
>   	int i = 0, ret = 0;
> @@ -479,15 +436,16 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (pp_funcs->get_current_power_state
> -		 && pp_funcs->get_pp_num_states) {
> -		pm = amdgpu_dpm_get_current_power_state(adev);
> -		amdgpu_dpm_get_pp_num_states(adev, &data);
> -	}
> +	amdgpu_dpm_get_current_power_state(adev, &pm);
> +
> +	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> +	if (ret)
> +		return ret;
> +
>   	for (i = 0; i < data.nums; i++) {
>   		if (pm == data.states[i])
>   			break;
> @@ -525,6 +483,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   	enum amd_pm_state_type state = 0;
> +	struct pp_states_info data;
>   	unsigned long idx;
>   	int ret;
>   
> @@ -533,41 +492,49 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> -	if (strlen(buf) == 1)
> -		adev->pp_force_state_enabled = false;
> -	else if (is_support_sw_smu(adev))
> -		adev->pp_force_state_enabled = false;
> -	else if (adev->powerplay.pp_funcs->dispatch_tasks &&
> -			adev->powerplay.pp_funcs->get_pp_num_states) {
> -		struct pp_states_info data;
> -
> -		ret = kstrtoul(buf, 0, &idx);
> -		if (ret || idx >= ARRAY_SIZE(data.states))
> -			return -EINVAL;
> +	adev->pp_force_state_enabled = false;
>   
> -		idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
> +	if (strlen(buf) == 1)
> +		return count;
>   
> -		amdgpu_dpm_get_pp_num_states(adev, &data);
> -		state = data.states[idx];
> +	ret = kstrtoul(buf, 0, &idx);
> +	if (ret || idx >= ARRAY_SIZE(data.states))
> +		return -EINVAL;
>   
> -		ret = pm_runtime_get_sync(ddev->dev);
> -		if (ret < 0) {
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return ret;
> -		}
> +	idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
>   
> -		/* only set user selected power states */
> -		if (state != POWER_STATE_TYPE_INTERNAL_BOOT &&
> -		    state != POWER_STATE_TYPE_DEFAULT) {
> -			amdgpu_dpm_dispatch_task(adev,
> -					AMD_PP_TASK_ENABLE_USER_STATE, &state);
> -			adev->pp_force_state_enabled = true;
> -		}
> -		pm_runtime_mark_last_busy(ddev->dev);
> +	ret = pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
>   		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
> +	if (ret)
> +		goto err_out;
> +
> +	state = data.states[idx];
> +
> +	/* only set user selected power states */
> +	if (state != POWER_STATE_TYPE_INTERNAL_BOOT &&
> +	    state != POWER_STATE_TYPE_DEFAULT) {
> +		ret = amdgpu_dpm_dispatch_task(adev,
> +				AMD_PP_TASK_ENABLE_USER_STATE, &state);
> +		if (ret)
> +			goto err_out;
> +
> +		adev->pp_force_state_enabled = true;
>   	}
>   
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
>   	return count;
> +
> +err_out:
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +	return ret;
>   }
>   
>   /**
> @@ -601,17 +568,13 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_pp_table) {
> -		size = amdgpu_dpm_get_pp_table(adev, &table);
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		if (size < 0)
> -			return size;
> -	} else {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return 0;
> -	}
> +	size = amdgpu_dpm_get_pp_table(adev, &table);
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	if (size <= 0)
> +		return size;
>   
>   	if (size >= PAGE_SIZE)
>   		size = PAGE_SIZE - 1;
> @@ -642,15 +605,13 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>   	}
>   
>   	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
> -	if (ret) {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> -		return ret;
> -	}
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> +	if (ret)
> +		return ret;
> +
>   	return count;
>   }
>   
> @@ -866,46 +827,32 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
> -		ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
> -							parameter,
> -							parameter_size);
> -		if (ret) {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -	}
> +	if (amdgpu_dpm_set_fine_grain_clk_vol(adev,
> +					      type,
> +					      parameter,
> +					      parameter_size))
> +		goto err_out;
>   
> -	if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
> -		ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
> -						    parameter, parameter_size);
> -		if (ret) {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -	}
> +	if (amdgpu_dpm_odn_edit_dpm_table(adev, type,
> +					  parameter, parameter_size))
> +		goto err_out;
>   

This is one example of returning 'fake success' effect. If the function 
is not implemented it proceeds. There is no need to proceed if there is 
no support.


Thanks,
Lijo

>   	if (type == PP_OD_COMMIT_DPM_TABLE) {
> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -			amdgpu_dpm_dispatch_task(adev,
> -						 AMD_PP_TASK_READJUST_POWER_STATE,
> -						 NULL);
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return count;
> -		} else {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> +		if (amdgpu_dpm_dispatch_task(adev,
> +					     AMD_PP_TASK_READJUST_POWER_STATE,
> +					     NULL))
> +			goto err_out;
>   	}
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
>   	return count;
> +
> +err_out:
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +	return -EINVAL;
>   }
>   
>   static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
> @@ -928,8 +875,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->print_clock_levels) {
> -		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> +	size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> +	if (size > 0) {
>   		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
>   		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
>   		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
> @@ -985,17 +932,14 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->set_ppfeature_status) {
> -		ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
> -		if (ret) {
> -			pm_runtime_mark_last_busy(ddev->dev);
> -			pm_runtime_put_autosuspend(ddev->dev);
> -			return -EINVAL;
> -		}
> -	}
> +	ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
> +
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> +	if (ret)
> +		return -EINVAL;
> +
>   	return count;
>   }
>   
> @@ -1019,9 +963,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_ppfeature_status)
> -		size = amdgpu_dpm_get_ppfeature_status(adev, buf);
> -	else
> +	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
> +	if (size <= 0)
>   		size = sysfs_emit(buf, "\n");
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
> @@ -1080,9 +1023,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->print_clock_levels)
> -		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
> -	else
> +	size = amdgpu_dpm_print_clock_levels(adev, type, buf);
> +	if (size <= 0)
>   		size = sysfs_emit(buf, "\n");
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
> @@ -1151,10 +1093,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->force_clock_level)
> -		ret = amdgpu_dpm_force_clock_level(adev, type, mask);
> -	else
> -		ret = 0;
> +	ret = amdgpu_dpm_force_clock_level(adev, type, mask);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1305,10 +1244,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev))
> -		value = 0;
> -	else if (adev->powerplay.pp_funcs->get_sclk_od)
> -		value = amdgpu_dpm_get_sclk_od(adev);
> +	value = amdgpu_dpm_get_sclk_od(adev);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1342,19 +1278,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev)) {
> -		value = 0;
> -	} else {
> -		if (adev->powerplay.pp_funcs->set_sclk_od)
> -			amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
> -
> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -			amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
> -		} else {
> -			adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> -			amdgpu_pm_compute_clocks(adev);
> -		}
> -	}
> +	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1382,10 +1306,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev))
> -		value = 0;
> -	else if (adev->powerplay.pp_funcs->get_mclk_od)
> -		value = amdgpu_dpm_get_mclk_od(adev);
> +	value = amdgpu_dpm_get_mclk_od(adev);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1419,19 +1340,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev)) {
> -		value = 0;
> -	} else {
> -		if (adev->powerplay.pp_funcs->set_mclk_od)
> -			amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
> -
> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
> -			amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_READJUST_POWER_STATE, NULL);
> -		} else {
> -			adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
> -			amdgpu_pm_compute_clocks(adev);
> -		}
> -	}
> +	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1479,9 +1388,8 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_power_profile_mode)
> -		size = amdgpu_dpm_get_power_profile_mode(adev, buf);
> -	else
> +	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
> +	if (size <= 0)
>   		size = sysfs_emit(buf, "\n");
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
> @@ -1545,8 +1453,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->set_power_profile_mode)
> -		ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
> +	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1812,9 +1719,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_gpu_metrics)
> -		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> -
> +	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>   	if (size <= 0)
>   		goto out;
>   
> @@ -2053,7 +1958,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   {
>   	struct device_attribute *dev_attr = &attr->dev_attr;
>   	const char *attr_name = dev_attr->attr.name;
> -	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>   	enum amd_asic_type asic_type = adev->asic_type;
>   
>   	if (!(attr->flags & mask)) {
> @@ -2076,9 +1980,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>   		*states = ATTR_STATE_UNSUPPORTED;
> -		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
> -		    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
> -			(!is_support_sw_smu(adev) && hwmgr->od_enabled))
> +		if (amdgpu_dpm_is_overdrive_supported(adev))
>   			*states = ATTR_STATE_SUPPORTED;
>   	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>   		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
> @@ -2105,8 +2007,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
> -		if (!adev->powerplay.pp_funcs->get_power_profile_mode ||
> -		    amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
> +		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	}
>   
> @@ -2389,17 +2290,14 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -
> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
> +	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> +	if (ret)
> +		return -EINVAL;
> +
>   	return sysfs_emit(buf, "%u\n", pwm_mode);
>   }
>   
> @@ -2427,17 +2325,14 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_dpm_set_fan_control_mode(adev, value);
> +	ret = amdgpu_dpm_set_fan_control_mode(adev, value);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> +	if (ret)
> +		return -EINVAL;
> +
>   	return count;
>   }
>   
> @@ -2469,32 +2364,29 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> +	err = kstrtou32(buf, 10, &value);
> +	if (err)
> +		return err;
> +
>   	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (err < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   		return err;
>   	}
>   
> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
> +	err = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
> +	if (err)
> +		goto out;
> +
>   	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
>   		pr_info("manual fan speed control should be enabled first\n");
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>   	}
>   
> -	err = kstrtou32(buf, 10, &value);
> -	if (err) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return err;
> -	}
> -
> -	if (adev->powerplay.pp_funcs->set_fan_speed_pwm)
> -		err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
> -	else
> -		err = -EINVAL;
> +	err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
>   
> +out:
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> @@ -2523,10 +2415,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>   		return err;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_fan_speed_pwm)
> -		err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
> -	else
> -		err = -EINVAL;
> +	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -2556,10 +2445,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>   		return err;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
> -		err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
> -	else
> -		err = -EINVAL;
> +	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -2653,10 +2539,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>   		return err;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
> -		err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
> -	else
> -		err = -EINVAL;
> +	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -2681,32 +2564,28 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> +	err = kstrtou32(buf, 10, &value);
> +	if (err)
> +		return err;
> +
>   	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (err < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   		return err;
>   	}
>   
> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
> +	err = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
> +	if (err)
> +		goto out;
>   
>   	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -ENODATA;
> -	}
> -
> -	err = kstrtou32(buf, 10, &value);
> -	if (err) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return err;
> +		err = -ENODATA;
> +		goto out;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
> -		err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
> -	else
> -		err = -EINVAL;
> +	err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
>   
> +out:
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> @@ -2735,17 +2614,14 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -
> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
> +	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> +	if (ret)
> +		return -EINVAL;
> +
>   	return sysfs_emit(buf, "%i\n", pwm_mode == AMD_FAN_CTRL_AUTO ? 0 : 1);
>   }
>   
> @@ -2781,16 +2657,14 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>   		return err;
>   	}
>   
> -	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -		return -EINVAL;
> -	}
> -	amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
> +	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> +	if (err)
> +		return -EINVAL;
> +
>   	return count;
>   }
>   
> @@ -2926,7 +2800,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>   					enum pp_power_limit_level pp_limit_level)
>   {
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	enum pp_power_type power_type = to_sensor_dev_attr(attr)->index;
>   	uint32_t limit;
>   	ssize_t size;
> @@ -2937,16 +2810,13 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> -	if ( !(pp_funcs && pp_funcs->get_power_limit))
> -		return -ENODATA;
> -
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>   	if (r < 0) {
>   		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   		return r;
>   	}
>   
> -	r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
> +	r = amdgpu_dpm_get_power_limit(adev, &limit,
>   				      pp_limit_level, power_type);
>   
>   	if (!r)
> @@ -3001,7 +2871,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>   		size_t count)
>   {
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int limit_type = to_sensor_dev_attr(attr)->index;
>   	int err;
>   	u32 value;
> @@ -3027,10 +2896,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>   		return err;
>   	}
>   
> -	if (pp_funcs && pp_funcs->set_power_limit)
> -		err = pp_funcs->set_power_limit(adev->powerplay.pp_handle, value);
> -	else
> -		err = -EINVAL;
> +	err = amdgpu_dpm_set_power_limit(adev, value);
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -3303,6 +3169,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
>   	umode_t effective_mode = attr->mode;
> +	uint32_t speed = 0;
>   
>   	/* under multi-vf mode, the hwmon attributes are all not supported */
>   	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -3367,20 +3234,18 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
>   		return 0;
>   
> -	if (!is_support_sw_smu(adev)) {
> -		/* mask fan attributes if we have no bindings for this asic to expose */
> -		if ((!adev->powerplay.pp_funcs->get_fan_speed_pwm &&
> -		     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
> -		    (!adev->powerplay.pp_funcs->get_fan_control_mode &&
> -		     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
> -			effective_mode &= ~S_IRUGO;
> +	/* mask fan attributes if we have no bindings for this asic to expose */
> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> +	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
> +	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -EOPNOTSUPP) &&
> +	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
> +		effective_mode &= ~S_IRUGO;
>   
> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
> -		     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
> -		    (!adev->powerplay.pp_funcs->set_fan_control_mode &&
> -		     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
> -			effective_mode &= ~S_IWUSR;
> -	}
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> +	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
> +	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -EOPNOTSUPP) &&
> +	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
> +		effective_mode &= ~S_IWUSR;
>   
>   	if (((adev->family == AMDGPU_FAMILY_SI) ||
>   		 ((adev->flags & AMD_IS_APU) &&
> @@ -3397,22 +3262,20 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
>   		return 0;
>   
> -	if (!is_support_sw_smu(adev)) {
> -		/* hide max/min values if we can't both query and manage the fan */
> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
> -		     !adev->powerplay.pp_funcs->get_fan_speed_pwm) &&
> -		     (!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
> -		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
> -		    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
> -		     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
> -			return 0;
> +	/* hide max/min values if we can't both query and manage the fan */
> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)) &&
> +	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
> +	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
> +		return 0;
>   
> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
> -		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
> -		    (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
> -		     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
> -			return 0;
> -	}
> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL) &&
> +	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
> +	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
> +		return 0;
>   
>   	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
>   	     adev->family == AMDGPU_FAMILY_KV) &&	/* not implemented yet */
> @@ -3542,14 +3405,15 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
>   	uint16_t *p_val;
>   	uint32_t size;
>   	int i;
> +	uint32_t num_cpu_cores = amdgpu_dpm_get_num_cpu_cores(adev);
>   
> -	if (is_support_cclk_dpm(adev)) {
> -		p_val = kcalloc(adev->smu.cpu_core_num, sizeof(uint16_t),
> +	if (amdgpu_dpm_is_cclk_dpm_supported(adev)) {
> +		p_val = kcalloc(num_cpu_cores, sizeof(uint16_t),
>   				GFP_KERNEL);
>   
>   		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_CPU_CLK,
>   					    (void *)p_val, &size)) {
> -			for (i = 0; i < adev->smu.cpu_core_num; i++)
> +			for (i = 0; i < num_cpu_cores; i++)
>   				seq_printf(m, "\t%u MHz (CPU%d)\n",
>   					   *(p_val + i), i);
>   		}
> @@ -3677,27 +3541,11 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>   		return r;
>   	}
>   
> -	if (!adev->pm.dpm_enabled) {
> -		seq_printf(m, "dpm not enabled\n");
> -		pm_runtime_mark_last_busy(dev->dev);
> -		pm_runtime_put_autosuspend(dev->dev);
> -		return 0;
> -	}
> -
> -	if (!is_support_sw_smu(adev) &&
> -	    adev->powerplay.pp_funcs->debugfs_print_current_performance_level) {
> -		mutex_lock(&adev->pm.mutex);
> -		if (adev->powerplay.pp_funcs->debugfs_print_current_performance_level)
> -			adev->powerplay.pp_funcs->debugfs_print_current_performance_level(adev, m);
> -		else
> -			seq_printf(m, "Debugfs support not implemented for this asic\n");
> -		mutex_unlock(&adev->pm.mutex);
> -		r = 0;
> -	} else {
> +	if (amdgpu_dpm_debugfs_print_current_performance_level(adev, m)) {
>   		r = amdgpu_debugfs_pm_info_pp(m, adev);
> +		if (r)
> +			goto out;
>   	}
> -	if (r)
> -		goto out;
>   
>   	amdgpu_device_ip_get_clockgating_state(adev, &flags);
>   
> @@ -3723,21 +3571,18 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>   					 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_device *adev = file_inode(f)->i_private;
> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -	void *pp_handle = adev->powerplay.pp_handle;
>   	size_t smu_prv_buf_size;
>   	void *smu_prv_buf;
> +	int ret = 0;
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
>   	if (adev->in_suspend && !adev->in_runpm)
>   		return -EPERM;
>   
> -	if (pp_funcs && pp_funcs->get_smu_prv_buf_details)
> -		pp_funcs->get_smu_prv_buf_details(pp_handle, &smu_prv_buf,
> -						  &smu_prv_buf_size);
> -	else
> -		return -ENOSYS;
> +	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
> +	if (ret)
> +		return ret;
>   
>   	if (!smu_prv_buf || !smu_prv_buf_size)
>   		return -EINVAL;
> @@ -3770,6 +3615,6 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
>   					 &amdgpu_debugfs_pm_prv_buffer_fops,
>   					 adev->pm.smu_prv_buffer_size);
>   
> -	amdgpu_smu_stb_debug_fs_init(adev);
> +	amdgpu_dpm_stb_debug_fs_init(adev);
>   #endif
>   }
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 7289d379a9fb..039c40b1d0cb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -262,9 +262,6 @@ enum amdgpu_pcie_gen {
>   #define amdgpu_dpm_pre_set_power_state(adev) \
>   		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
>   
> -#define amdgpu_dpm_set_power_state(adev) \
> -		((adev)->powerplay.pp_funcs->set_power_state((adev)->powerplay.pp_handle))
> -
>   #define amdgpu_dpm_post_set_power_state(adev) \
>   		((adev)->powerplay.pp_funcs->post_set_power_state((adev)->powerplay.pp_handle))
>   
> @@ -280,100 +277,13 @@ enum amdgpu_pcie_gen {
>   #define amdgpu_dpm_enable_bapm(adev, e) \
>   		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
>   
> -#define amdgpu_dpm_set_fan_control_mode(adev, m) \
> -		((adev)->powerplay.pp_funcs->set_fan_control_mode((adev)->powerplay.pp_handle, (m)))
> -
> -#define amdgpu_dpm_get_fan_control_mode(adev) \
> -		((adev)->powerplay.pp_funcs->get_fan_control_mode((adev)->powerplay.pp_handle))
> -
> -#define amdgpu_dpm_set_fan_speed_pwm(adev, s) \
> -		((adev)->powerplay.pp_funcs->set_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
> -
> -#define amdgpu_dpm_get_fan_speed_pwm(adev, s) \
> -		((adev)->powerplay.pp_funcs->get_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
> -
> -#define amdgpu_dpm_get_fan_speed_rpm(adev, s) \
> -		((adev)->powerplay.pp_funcs->get_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
> -
> -#define amdgpu_dpm_set_fan_speed_rpm(adev, s) \
> -		((adev)->powerplay.pp_funcs->set_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
> -
> -#define amdgpu_dpm_force_performance_level(adev, l) \
> -		((adev)->powerplay.pp_funcs->force_performance_level((adev)->powerplay.pp_handle, (l)))
> -
> -#define amdgpu_dpm_get_current_power_state(adev) \
> -		((adev)->powerplay.pp_funcs->get_current_power_state((adev)->powerplay.pp_handle))
> -
> -#define amdgpu_dpm_get_pp_num_states(adev, data) \
> -		((adev)->powerplay.pp_funcs->get_pp_num_states((adev)->powerplay.pp_handle, data))
> -
> -#define amdgpu_dpm_get_pp_table(adev, table) \
> -		((adev)->powerplay.pp_funcs->get_pp_table((adev)->powerplay.pp_handle, table))
> -
> -#define amdgpu_dpm_set_pp_table(adev, buf, size) \
> -		((adev)->powerplay.pp_funcs->set_pp_table((adev)->powerplay.pp_handle, buf, size))
> -
> -#define amdgpu_dpm_print_clock_levels(adev, type, buf) \
> -		((adev)->powerplay.pp_funcs->print_clock_levels((adev)->powerplay.pp_handle, type, buf))
> -
> -#define amdgpu_dpm_force_clock_level(adev, type, level) \
> -		((adev)->powerplay.pp_funcs->force_clock_level((adev)->powerplay.pp_handle, type, level))
> -
> -#define amdgpu_dpm_get_sclk_od(adev) \
> -		((adev)->powerplay.pp_funcs->get_sclk_od((adev)->powerplay.pp_handle))
> -
> -#define amdgpu_dpm_set_sclk_od(adev, value) \
> -		((adev)->powerplay.pp_funcs->set_sclk_od((adev)->powerplay.pp_handle, value))
> -
> -#define amdgpu_dpm_get_mclk_od(adev) \
> -		((adev)->powerplay.pp_funcs->get_mclk_od((adev)->powerplay.pp_handle))
> -
> -#define amdgpu_dpm_set_mclk_od(adev, value) \
> -		((adev)->powerplay.pp_funcs->set_mclk_od((adev)->powerplay.pp_handle, value))
> -
> -#define amdgpu_dpm_dispatch_task(adev, task_id, user_state)		\
> -		((adev)->powerplay.pp_funcs->dispatch_tasks)((adev)->powerplay.pp_handle, (task_id), (user_state))
> -
>   #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
>   		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
>   
> -#define amdgpu_dpm_get_vce_clock_state(adev, i)				\
> -		((adev)->powerplay.pp_funcs->get_vce_clock_state((adev)->powerplay.pp_handle, (i)))
> -
> -#define amdgpu_dpm_get_performance_level(adev)				\
> -		((adev)->powerplay.pp_funcs->get_performance_level((adev)->powerplay.pp_handle))
> -
>   #define amdgpu_dpm_reset_power_profile_state(adev, request) \
>   		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
>   			(adev)->powerplay.pp_handle, request))
>   
> -#define amdgpu_dpm_get_power_profile_mode(adev, buf) \
> -		((adev)->powerplay.pp_funcs->get_power_profile_mode(\
> -			(adev)->powerplay.pp_handle, buf))
> -
> -#define amdgpu_dpm_set_power_profile_mode(adev, parameter, size) \
> -		((adev)->powerplay.pp_funcs->set_power_profile_mode(\
> -			(adev)->powerplay.pp_handle, parameter, size))
> -
> -#define amdgpu_dpm_set_fine_grain_clk_vol(adev, type, parameter, size) \
> -		((adev)->powerplay.pp_funcs->set_fine_grain_clk_vol(\
> -			(adev)->powerplay.pp_handle, type, parameter, size))
> -
> -#define amdgpu_dpm_odn_edit_dpm_table(adev, type, parameter, size) \
> -		((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
> -			(adev)->powerplay.pp_handle, type, parameter, size))
> -
> -#define amdgpu_dpm_get_ppfeature_status(adev, buf) \
> -		((adev)->powerplay.pp_funcs->get_ppfeature_status(\
> -			(adev)->powerplay.pp_handle, (buf)))
> -
> -#define amdgpu_dpm_set_ppfeature_status(adev, ppfeatures) \
> -		((adev)->powerplay.pp_funcs->set_ppfeature_status(\
> -			(adev)->powerplay.pp_handle, (ppfeatures)))
> -
> -#define amdgpu_dpm_get_gpu_metrics(adev, table) \
> -		((adev)->powerplay.pp_funcs->get_gpu_metrics((adev)->powerplay.pp_handle, table))
> -
>   struct amdgpu_dpm {
>   	struct amdgpu_ps        *ps;
>   	/* number of valid power states */
> @@ -598,4 +508,74 @@ void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
>   				 enum gfx_change_state state);
>   int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>   			    void *umc_ecc);
> +struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct amdgpu_device *adev,
> +						     uint32_t idx);
> +void amdgpu_dpm_get_current_power_state(struct amdgpu_device *adev, enum amd_pm_state_type *state);
> +void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
> +				enum amd_pm_state_type state);
> +enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
> +int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
> +				       enum amd_dpm_forced_level level);
> +int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
> +				 struct pp_states_info *states);
> +int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
> +			      enum amd_pp_task task_id,
> +			      enum amd_pm_state_type *user_state);
> +int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table);
> +int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
> +				      uint32_t type,
> +				      long *input,
> +				      uint32_t size);
> +int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
> +				  uint32_t type,
> +				  long *input,
> +				  uint32_t size);
> +int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  char *buf);
> +int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
> +				    uint64_t ppfeature_masks);
> +int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev, char *buf);
> +int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
> +				 enum pp_clock_type type,
> +				 uint32_t mask);
> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value);
> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value);
> +int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
> +				      char *buf);
> +int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
> +				      long *input, uint32_t size);
> +int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
> +int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t *fan_mode);
> +int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t speed);
> +int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
> +				 uint32_t *speed);
> +int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t *speed);
> +int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
> +				 uint32_t speed);
> +int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
> +				    uint32_t mode);
> +int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
> +			       uint32_t *limit,
> +			       enum pp_power_limit_level pp_limit_level,
> +			       enum pp_power_type power_type);
> +int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> +			       uint32_t limit);
> +int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);
> +int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
> +						       struct seq_file *m);
> +int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
> +				       void **addr,
> +				       size_t *size);
> +int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
> +int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
> +			    const char *buf,
> +			    size_t size);
> +int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
> +void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d8cd7c8c4479..51358383f672 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -470,9 +470,6 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = &adev->smu;
>   
> -	if (!is_support_sw_smu(adev))
> -		return false;
> -
>   	if (!smu_feature_is_enabled(smu, SMU_FEATURE_CCLK_DPM_BIT))
>   		return false;
>   
> 
