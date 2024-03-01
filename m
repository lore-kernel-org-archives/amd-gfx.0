Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02285C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 09:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5951A10EC4D;
	Fri,  1 Mar 2024 09:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QC1MEj7w";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D63710EC52
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 09:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EewHLG3dMqxGE9Uoi9RRf1DnA0AW+c67yfJmlsMVvKjI5uVpKwtt1qB47Op1REuCpuuWxPDKG/cacwhz94jZLZ7QreU8oNDUhdYjnxEbXQAYOpZhOImZHZ+XyBEbU6Uy04v77D7ewSRnC69/l10xVa6R86dBKdRwGXQeexsE+fYaFl8PqL4herwMZpfGjVtBuuO8q0FjiwE2sgmp/lXdavPKlHi3T5QZHTzX0zKakPCkeGWpw/3PSwjsjIz0sgntxqmGip1/l/TcMsO2j7jWw/iey1+QKGqaMATwzsAh4dkU22Av/6k3/xnmX4Q1yIOuNAxa9iyjjhJjo2jeZjfgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O7Q0obwZcSfHjKZ+ZhSQIJHIkw3c7UyHbhg21dBSsc=;
 b=DZfNNVEnX3xdEMeFqUG7Q7HrrAlYbONC5onS/mvZpka76y/tHpkuwb3y4595Kx4D+ZyrDFOoEtj+25ix7auRXEJnSI6nOIeqigdvdlNcMhbAed0yPp4NRmRBA+upZa/Vf1QEUnvkTAdzt+kgIBne6mwU5LPRp1y3KaVj1QYszsaAjdvi+oxwwM/NGQw9F/IQsYNLOVjtLvwOrWBeJ7JKtGtxjQyJQZh22G6ZgrDyedX9VIYLeaU3EIYup2AUWDjZhjh2C9MoK/qZU6aj3UXjv0JFcvTv+6Z0JTv8dMjEbHIJXb12wbIxRQP5KB+Dy9XK5s4Ey/xei8J7U6rxDzrqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O7Q0obwZcSfHjKZ+ZhSQIJHIkw3c7UyHbhg21dBSsc=;
 b=QC1MEj7wNlds5WEAhbrVHWFyzUj6ACRirTRzqlUrQyO7bMqzbpqRm9QnAlIvXpLghuovD1Wz6t4mBd1vkq4qVGjSdFkN5iGjVbdKwGbZT0YDYdKsBkyav31G7Je84cQ7wXJW4r0zEiBxgCQfIXE70PtDHh06ZYBvj3Xw3KB188c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 1 Mar
 2024 09:42:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 09:42:07 +0000
Message-ID: <022e14b2-6937-4329-9bf5-7a3cfe8ffd42@amd.com>
Date: Fri, 1 Mar 2024 15:11:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the error of pwm1_enable setting
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240301074506.2018577-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240301074506.2018577-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1214d061-763d-4a07-5730-08dc39d3dba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPuJR53DSabw2ZiiukuZnkiqGy1q3/XE9Oygm93uIoyUJyHVxeMbL2I3+AD8iIRUVi3LzUAaAFNixqDd6tpgtEeIhzZMGx8As5pRgYpiOLinQ0fPOG/HwhwWMjqIa/b379Nb+Qsg4woC3xljuzBtFvioApQLWkn+OYrRCyu3dt7ulsIX7bijgD0fqjAogGU02W/ZA1HVnxTHw5+zLP7ATwMwJpz6tpy4qJINlw0KyYnyAhHyu3Y9UgiNsLCahUfDzfDFG73B6TeEhgizTsOiVzd9T/XKDIXOMzzBVxZKcSMHbGqloCiuA39iOgQYjtSCEGMLi7A5eiK/Gcqzope04hkM5uHJsd6RSFDu43lNbJZwSGKnUDAWwdO1CLcEWHi06FZILWpv1i9xtyDPTXQFZMsdDr7Ld0TDfHG9qjFy21dQUzRForMh/cKTwgu0PQ1MGaUGvtzZD5vLk4qoixJ0lz7uXdRpaXmmKJEwh4WQFS2SHmqxYm9hqLHgJ0MrpyuVtiJSFMFN4oZc1TM+Vt1tV3Kjs5lYhXtK01eVwsopsz2ngNa18TZlgxUtcOtlwIoium7MgJ1OwyRkQyqta5KhVgdwUEFbIbIT8VGpHSuCZnfuKpuNlWYOXfCqDP57HcxENO0NnoDEJNFbCVJT2YWr0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JtbUFkMlpqbnhyWkZuYzJRSFJmU1RQL0FKKzRCMVc5Z2p2MEVWdGVWRllR?=
 =?utf-8?B?SEROK1NMRlkrUk1qOFM2S1g1VUdsVVVQb3kyaUx5R2J5Qk5Mckw2bGd4WFlB?=
 =?utf-8?B?VnNRdjBXL3JSTEdLb0xqckFpRU5wZUVDa3pBMHMzdnVYK2E5NUxpZC94b1Mx?=
 =?utf-8?B?a1BDb2pZYzBIakR2dktRODh6dnEveEhpZWtta000SEVXdlJNeDZxRUtLWnY1?=
 =?utf-8?B?MHdvNWNnZ1lqZmkzWG5KZ1daakZNZHB6cXhodHFRUm1FNHhlTk0wV2gzOUtn?=
 =?utf-8?B?Nm1kdVpEa05QOXJjRWI4QVR5S3BDUHhKYk16ckhZUWJITWZ3em9TVGUwME45?=
 =?utf-8?B?TVdhOFZTN0liZ3hpVmNwSysrdGg4VkZFOFpRUVFFT08yc3lkdVgwMnlCbjRW?=
 =?utf-8?B?TTd0clJVV3ppWnN1MDlnRC96anE4dWlVL1Q5cHltdkUzVFdaSHpEaitFRHln?=
 =?utf-8?B?V2VJWCtwZjZWdXdITm5KZjlJR24vTjFJU3pRYnBaWVp5aDc1cVRzTUhubDRG?=
 =?utf-8?B?SG83T0NBTVphUFQzTHp0U3JUcksyWHdCcXFjTDY2bStYTGd0Wjg5RFpvbk9i?=
 =?utf-8?B?TDNlbnBTRnVSa1hIakEwT25tajY4WG1tUFF0SXNBdGN6V3RvZis5TWZOTExj?=
 =?utf-8?B?alpHVjd0dHR5a0JldEtzZFNuQW4yU0gvdXNZdjFGZkZlUEJSK3EwN1lEWTB1?=
 =?utf-8?B?K2VxSndObGNTUFFWQXUwYm9rbHAxd0xnK01CZHNrb29MUXlCUXoyOWFzdnUv?=
 =?utf-8?B?R0pOUS92OVBtTFR1Y1VPaXdjZGRSK3RMY0ZsakV0Q29pcWNkbEtlSE1mQlRm?=
 =?utf-8?B?VTNVcnZ2TURTNVdHUVU4WU9RTUFhK05oYUdvdDJ2ZE9zOTdkMHAwOXlRdXk2?=
 =?utf-8?B?VjVZVUthZHd2STNmZmRRRjBJNVBFYWtCaS9mRFg3NVp0TklsT2xwQWdSRUNC?=
 =?utf-8?B?TWRoRkczemdqZzJVcVh0dFB4cGpOaG93YTM3ZmttTGlOOFZXNG1hK1hWTmFx?=
 =?utf-8?B?c2YxbG1ydVJuVFdSK3BSRDhvSUhzVDJ6LzkxMnIxUEVxellFMFVTbUVvbUpw?=
 =?utf-8?B?VEFCNm51eGRIc2ovQi9ma1k1UWFjMHVPdHBDRkc3YXFRVkVaNTVvK3RGMnRB?=
 =?utf-8?B?Um5ocklqODhGN1dVTGF2dG80blhNR2RpV3NjcDE4bStiUDBDY3JPZkY5Vndq?=
 =?utf-8?B?dXJoc1A1eml4OGRVMkt3Wi9NTFZya2Z2cnh4bGw4c0Z2OHZ1NGNOQUtDUCt5?=
 =?utf-8?B?TUkzUDgzQ0ppQnJERytGNEs4Mkh3dWxXUnIxK1c5a3kzbjFqWTMrWEt3UHdJ?=
 =?utf-8?B?dWJHLzJLb2RRRE1YZ1BjNTV0OHFWQ0JTWmVicGx0TC9MTDJTd05VTmFtMm5O?=
 =?utf-8?B?cGluUE5sV3ZEaUxGY0dOQ1NROHUvY2dMa1ZSWEowK2tndGg5UndFN2FFR3JY?=
 =?utf-8?B?ckxyUVlKQ3ZwQnBCdFozZGxndW5zdGtzR3lMSHNic0lRTisvZ1hmeEZuWnJV?=
 =?utf-8?B?UEdHWWcrR1o1ZTl5bkJCTGlzQm5lTkEvNndhY0orS092ajZCRjNSbGxpdTVn?=
 =?utf-8?B?RVhCUHVFdE5HWTJYbFFubWZ3Vk9sMzc0bjYrUjBpSEN0bDZZMUd0Vk9VaXhu?=
 =?utf-8?B?WHNEenJJc29NcGNQZ252NTd5MVdqeVJudkR6WUMyektaK29EK0JyN3BSWEpo?=
 =?utf-8?B?ZXFzdHhNdXFCRTFQUWswYThqM2Q2TXhPRkVYeWpKVkpPSXNYTFBzMzd4c0dT?=
 =?utf-8?B?VWt3MFh1RGl2Y1BLSjJ2RGNXQSs2QktVTHNQSjZTZldFWUlFM1c1TnRLdExP?=
 =?utf-8?B?ZlpGZzJ1a2pWSkM1WlR2L0VZVDR3VTZmVUpmdi85SjIzTk9MV0w4a1hqOVdw?=
 =?utf-8?B?WTVlL1RydDVnSlpNc3FTeWFtMGoxanJXRzlQem1sZksyaHdxdmxzVlI3Qlpi?=
 =?utf-8?B?OC96Z1IwZUVLRHZhdXB0bVh4MzJIM2Y4K2pManRFajVnWWk2aUg4akRQSFJG?=
 =?utf-8?B?TkQzSndDNWRPazlzNUNPTFNscExubjdoc3hTQ0JBTnRRRDlNRDc3QUxaRTda?=
 =?utf-8?B?bnNQdXhxVkYxbWpkRExKTmk4Y3dtUTNqa0p0SnR6UmoyQjc4YzAvMzFaekYv?=
 =?utf-8?Q?wW+GWGbJXcxo/kk8w+416k/iy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1214d061-763d-4a07-5730-08dc39d3dba0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 09:42:06.9321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lttOpa8xzaRFzrA6vLtXOnZnR6mybrMwK3L0tsd5whCOLtJIQJxy+XJbXWfjeKJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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



On 3/1/2024 1:15 PM, Ma Jun wrote:
> Fix the pwm_mode value error which used for
> pwm1_enable setting
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9e70c41ad98f..7cc5cd7616b1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2582,6 +2582,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>  	struct amdgpu_device *adev = dev_get_drvdata(dev);
>  	int err, ret;
>  	int value;
> +	u32 pwm_mode;
>  

You may move this declaration up to follow reverse Christmas tree order.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> @@ -2592,13 +2593,22 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>  	if (err)
>  		return err;
>  
> +	if (value == 0)
> +		pwm_mode = AMD_FAN_CTRL_NONE;
> +	else if (value == 1)
> +		pwm_mode = AMD_FAN_CTRL_MANUAL;
> +	else if (value == 2)
> +		pwm_mode = AMD_FAN_CTRL_AUTO;
> +	else
> +		return -EINVAL;
> +
>  	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (ret < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  		return ret;
>  	}
>  
> -	ret = amdgpu_dpm_set_fan_control_mode(adev, value);
> +	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>  
>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
