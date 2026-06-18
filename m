Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE493CD98F0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 07:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F5C10F1BF;
	Thu, 18 Jun 2026 07:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYUvzEAm";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125A910F1CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 07:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAI1yAc7gc24JtT+N8/KXGMG7XL3xB4eM/U/T1+QAwm5CDDNktBCfrCrjvtNj5RythlK609rFoj5eIaopuBDEJUIM2q715cJns0tLN3LN+/GlG25tAOYnrvxfNDg+2AGQrBh54xBQCWynXz26y2FPdjUyQ5HyjZTrxnzaOWWpJN9juJ6BMuA/mzUhtGuR7tBfYQCywVSwYPpDnFJkXxsHUaeBViqBeITTC6W8bMEafudYbmReH5A6VPOt+vtAY2IHn099XTVbLoaqQ2z2+NGishs6ZNn360CZq2IH9kGPc/m2EOTuA7oxbBoLZ7Ys9vNj06n/fK+hVZ/0ZSBNa3uHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NSWoOlQtJZOUwbTNX/JS2b0a922jJmp4jBATgBeMkw=;
 b=POwHF929FGAPN020z0yD29a8UnOEWLYnmyrsjz+lFByTorBzvtg51S4JtiQv4aL85tJDpSwq7hWcWw6ehBGjiB+ZZZtvcv2igZMycwskpqLO6NyvkvL0oTBtE8G7TjKPBRfy3Bye3K8uumlm5VDJlUDA58xjO8sORNVc0njueCsUIEAgH7Bjd145tNm/8GOs2CY7ycwxODmZYpKDPfgAcv48cG7OHnV6FSYhaRWm3JY8IdXOc7FwqWFgACm4g7tyCC/fVoGVLlxCTYoS6LDvJWvG2ZZ+U2khauLz9qeKUGXDDa8k0YakqFwSA9KpIdv6CYxL+CgRUigZ7uPlgKZWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NSWoOlQtJZOUwbTNX/JS2b0a922jJmp4jBATgBeMkw=;
 b=gYUvzEAm70XHp0CxYg3l8gEFYbZgUfMwg6FEIhaIjnKr3suOb/Vs4b0X4SP9gulwJxUBgrySPEMI5eF9ojEkMNpF3iZKO6G/YX71t3UTBEjvh7bQSELJGJw0EhvrIk1HocxDMhV8V4Ogx0cQDAbLrd4NrJe1+7FN2KZJhLi7G48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:47:51 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 07:47:51 +0000
Message-ID: <21a3f315-d3ee-4592-82f8-523be815fcc8@amd.com>
Date: Thu, 18 Jun 2026 13:17:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix amdgpu_pm_info power display units
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com,
 zdenek.koprivik@post.cz
References: <20260618052135.2334397-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260618052135.2334397-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0254.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7d99cf-7133-4c4c-4f04-08decd0de610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YfcWTHR1GKc+G4OG3RWKnjVonkW6by9evCP5qxsKfKZ2sbIoi7uN2xLY9pinojmSL/i35lt13cC0bLzKB8pBmvj1+DALDhJfTflakrd1+zQ2cIm7O/a3ohoHC5r/DfqjKQxT2u97JJoOVTHpR7lDfe8Pe7wPXBL1uDlQfwTpE/dbB7TM4tNvSFVI9fW9GeURMfxWoqHAHzM+D03qKiBmjZwPLAaWqG3fN6nYZdeMcy6gzKHQOdEL40Knmd5RCo3N8stKDIuo9vOBwZw0Gi9w6VYvVnI+eQWuW5ui/Teo++cGg8nJMPDy7OLK7IL/F8P+DwldKXlK5ohr1DpWtLIWVp1GoIkI68cJp2ZCmewi5GO0diISn76059oinOd8jQDLxGK3Fg54ttV7m3FgPUocIz0Zy20CIGAovA9m5cUo3B+A8B/QimcFxZGkxYcRq8uvn38yOfSv++wIg/09hOKJBUZQ1a/T+ayuMXMSGnumV1R8TBbveMqDL+LDKnGRT0dDiuEO0OWwAS2jTwxQ1u1gLxk50h0N/gs8R9qVtXbvpP4UnlCNlNcmOq837Y99o4/z4oRyp8z67sDFHLPskej+CUGLFvYyx/ja0zb3YvzAOnUw+4F62C6tZZ9QPH3NIWSLqd2dyXtU5quG+2kdAcF6JGtrkLkWlotCaF39nFyqdX+R1UOSN8y36lZ322VeU+pW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlGUzE5eWs1MHVrY0RPVjY3OERTekdGaS9YRnJUWEg0NUpvbmJOamU3OGxz?=
 =?utf-8?B?MHNCSkxZWXhOTktOYUh1VVAwMk0yRDVzeHpkL09YcSsxVTgrQVFxdFpKUHQ2?=
 =?utf-8?B?WkE1K1VSVkxIMVA2Sk52NGo3LytRaS95RkFiNjQxaTdxUGhrVWQzdkR5ZVpC?=
 =?utf-8?B?dWxwcVVuekp2VWM5MGtmanprRlVIRnlyb3NsTGRyN2w2YkdmZlR6dEdXVDZY?=
 =?utf-8?B?b0ptYXlJbE8xQ0d6VVEzSE05WWsyZWdBYXFjWDdtL004MkRRY0RlOVFOc0Rn?=
 =?utf-8?B?VDhRTWJsZER6dGhKQkZhQjRCQU5vck1LZEpjQXg1bE4yS3l0b1lzbHI4OE5h?=
 =?utf-8?B?REFvTkZRVjRvd0lHOFJ3OEQ1TUpJMnVhNWFWSlZ0clFveVpWYVhZdDd3d3JE?=
 =?utf-8?B?eWRPYllVYmVLL0lndTUwYlZOYTdsTGtUQUdEcEx4ZEptZ1VjSXI0YUdjajFw?=
 =?utf-8?B?YjZHbFIrcWwrMVlVRTkyTnplSVlOUkdPdzF2K29oUWhmOXhuNVltRUwyWk5n?=
 =?utf-8?B?eUErcFZYUHB3RmJyeUg0cEpSTlBhblhoa2lWV2FvdjRaSG5tbWp4OEdoMXla?=
 =?utf-8?B?MlZ3OXdkVmIxZ0Y0TVYvNkdiV2IwSkNwbWxscjQ5TjNvZXFvWVVYRm1aY2JX?=
 =?utf-8?B?ZHZpTjhQL25ubmNIUENGQXN0UGJzSldHek5QK09aemdTaEZwSElRV1hhcWJw?=
 =?utf-8?B?d0hjaE0wZ3drcWdYWWkwNnBFUUNjRlJqNHJpN0JsWVVaTXBJOW1TS3RHdnlr?=
 =?utf-8?B?ZkpjSnByNzYwdVlGWENaTEYxSGdvVnpmRmZiV3FCSUwzMzlsVHUxcXhETDNs?=
 =?utf-8?B?NUM4c0ZGQXlBUTIzSmVnTDdiR1VNeGtGM0hmQTV3L3hobzI3UGh2SFF6dzM0?=
 =?utf-8?B?Vi9WYkVFcGFrSVpLVnJoSGRYNUhQQWVUcnJKTmkrRzZLWlltL0t0dms5TWtL?=
 =?utf-8?B?c3ZHNGRvdXhNdElIYXdDMUpuL0VWV2E2NWdQcTBYU1hzbm9SUGdCMGVYam5I?=
 =?utf-8?B?d2VkRDNheU5MTk0rNlR4dnN3RUc0TWYvVTYvZElHZWN1UWNFT0JjRjlqSmdT?=
 =?utf-8?B?d25tdU1OTytqbmY4b0l6aklVSmg2Z0dHK3FrOHhYRTA5MDVBQ1BzVm1YZ2Mr?=
 =?utf-8?B?OFFEdGxHN1NyWElhdEZtRWxjNkR4MWR2V0M1NXo4TlduSXo3dDlMd1YzSlJM?=
 =?utf-8?B?NzdWbVVRa1hsNDJ4YmdQVUlVSitCSHUrQThIbWo5UWdDUStmZ1ZlRnpqb0cy?=
 =?utf-8?B?YzMxT1d0MWRja2IyOEd2SGI1U1MrcFZkRncyOWJkVlhkY2FQTEJlaHpBcjJN?=
 =?utf-8?B?bSsvWk9wR1JlVmVYbGtsQnJJUVFmemM1WWowTzlSRkdRTStMbkxXZUdIdGtx?=
 =?utf-8?B?QzBzQ2ZIZzdzTVN5NytEdmplTnZhZWpPa0xQcGNraDQzcTQ4Wk5FNUcyVzUw?=
 =?utf-8?B?aFBKcWZ6UDUySG50OVBxRzA2Z1NHazY5cUV6MG5rVkJiYnNWM21tQjdjTkU2?=
 =?utf-8?B?OWhZYXNhMXg2S3NNVnppMGJyVEhabG1BWWhGaXZWcXF3UnRTRlVybVc4T1ZI?=
 =?utf-8?B?UmJ1Qk84c0lLWG1JMW1YcWk4UTMwa0VGbEVJK25mZ0JvOVYzbHZvTkxpaytJ?=
 =?utf-8?B?bmthZXRMdlhncTllZHNTaDUyTkZIV0pkbmJpTnRLRUtmSzdwN0RESTBJRDA2?=
 =?utf-8?B?MzhLMjVPa2RGK21UUzI3RU0yajNyd1plRzlPOERINXEvTWtjeGhhWStTM3VV?=
 =?utf-8?B?bEpyS0h0ZXBsS1FQMDhqV25qaVUzbWYrZU5NZkdVUTNTODFLbGtVaVBHcDNZ?=
 =?utf-8?B?enROWGhKRkZMY1FrdS9Ma0pXazMvQjFMajFvcVFQWUFzSUFNNHgyZjhaNm44?=
 =?utf-8?B?a1hHN0s4UGkreDBPbkFWM0NXUzdvRCtCN2RlQ0dmVnZZR3p3d3ZCQWRQeTRB?=
 =?utf-8?B?WEl1NGh3cU5QREdHdlJiS0p3V2U0RUsvbytnZUpnVFA4R09FSWJPVGtIWnMr?=
 =?utf-8?B?TldyU21PMFVsZy91Yk5hWGc2engxZFRteDlva0xMZTlnU25ZWHFibm9FVDdJ?=
 =?utf-8?B?SFJkZlJpQmFRcEJ5OU5lcURZVVRndEFkMHBlektLcGlTMXl0a3FDeXQzTEtQ?=
 =?utf-8?B?VWYrcE5rMEdGcnFDNTYwRW1XeVhVOW1MQ0pKdzdsQ3Y1WTBpYVBoMGF2MWt3?=
 =?utf-8?B?N3ZRbTluU01mWFBYU3BESjdZdGsyaURudDhwQXJIKzBLQnpKYnh6RzdMMDBi?=
 =?utf-8?B?WWtQTmY0U0JCcnJVdk15Y095N0ozdDdkbzdYVi9HNitZMFk0MUdUL1g2ZHNq?=
 =?utf-8?B?MHAvK1VRMytiNzhzR0wvQW51cTVjdGxTMWo2TmU4VmR0cm9mLzJBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7d99cf-7133-4c4c-4f04-08decd0de610
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:47:51.4767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F530B786s/mj8l+rLP9A9zw0loKAIUlk/jKCMgmLJ6i9EYmFxNZCaS+9Dec+fIG5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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



On 18-Jun-26 10:51 AM, Yang Wang wrote:
> amdgpu_pm_info displayed power sensor readings with the wrong fractional unit.
> It treated the low byte of the raw sensor value as the decimal part of watts,
> while that field represents milliwatts in the decoded value. As a result,
> debugfs could report misleading SoC power when the remainder was not already
> a two-digit centiwatt value.
> 
> Example with query = 0x00000354:
> 
>    raw field        value
>    ---------------------
>    query >> 8       3 W
>    query & 0xff     84 mW
>    decoded power    3084 mW
> 
>    output           value
>    ---------------------
>    before           3.84 W
>    after            3.08 W
> 
> Fixes: f0b8f65b4825 ("drm/amd/amdgpu: fix the GPU power print error in pm info")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f69bb77ecbfe..719b743adc37 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -41,6 +41,8 @@
>   
>   #define DEVICE_ATTR_IS(_name)		(attr_id == device_attr_id__##_name)
>   
> +#define power_2_mwatt(power)	(((power) >> 8) * 1000 + ((power) & 0xff))
> +
>   struct od_attribute {
>   	struct kobj_attribute	attribute;
>   	struct list_head	entry;
> @@ -3354,7 +3356,6 @@ static int amdgpu_hwmon_get_power(struct device *dev,
>   				  enum amd_pp_sensors sensor)
>   {
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
> -	unsigned int uw;
>   	u32 query = 0;
>   	int r;
>   
> @@ -3363,9 +3364,7 @@ static int amdgpu_hwmon_get_power(struct device *dev,
>   		return r;
>   
>   	/* convert to microwatts */
> -	uw = (query >> 8) * 1000000 + (query & 0xff) * 1000;
> -
> -	return uw;
> +	return power_2_mwatt(query) * 1000;
>   }
>   
>   static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
> @@ -4908,7 +4907,7 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
>   {
>   	uint32_t mp1_ver = amdgpu_ip_version(adev, MP1_HWIP, 0);
>   	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> -	uint32_t value;
> +	uint32_t value, mwatt, centiwatt;
>   	uint64_t value64 = 0;
>   	uint32_t query = 0;
>   	int size;
> @@ -4933,17 +4932,21 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
>   		seq_printf(m, "\t%u mV (VDDNB)\n", value);
>   	size = sizeof(uint32_t);
>   	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size)) {
> +		mwatt = power_2_mwatt(query);
> +		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);

Instead of doing multiply and then divide twice, isn't it just better to 
wrap it under two macros and use?

power_w(value) / fractional_mw(value)

Here, it would then be fractional_mw(val)/10.

Thanks,
Lijo

>   		if (adev->flags & AMD_IS_APU)
> -			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", query >> 8, query & 0xff);
> +			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
>   		else
> -			seq_printf(m, "\t%u.%02u W (average SoC)\n", query >> 8, query & 0xff);
> +			seq_printf(m, "\t%u.%02u W (average SoC)\n", centiwatt / 100, centiwatt % 100);
>   	}
>   	size = sizeof(uint32_t);
>   	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size)) {
> +		mwatt = power_2_mwatt(query);
> +		centiwatt = DIV_ROUND_CLOSEST(mwatt, 10);
>   		if (adev->flags & AMD_IS_APU)
> -			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", query >> 8, query & 0xff);
> +			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", centiwatt / 100, centiwatt % 100);
>   		else
> -			seq_printf(m, "\t%u.%02u W (current SoC)\n", query >> 8, query & 0xff);
> +			seq_printf(m, "\t%u.%02u W (current SoC)\n", centiwatt / 100, centiwatt % 100);
>   	}
>   	size = sizeof(value);
>   	seq_printf(m, "\n");

