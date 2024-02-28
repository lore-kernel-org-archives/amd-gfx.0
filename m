Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CA0C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 07:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA8810E68B;
	Wed, 28 Feb 2024 07:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YeZ1pclr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA96610E68B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 07:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiXo/iqa/YYU8jQNcrfyGEFRVW09SIL9dyCOMBpFEN9AJvlNlPSKYg/2R4JmEUbV7BugVyOrmzPLB681xEhxV2SLgzomiLDQwvWXGUOv6UAB8Rx3MNdm83RDJe5U2xwh7XO4OW/uzTyGnCIn6uNoanYUZStdkoYBSpi4DwlwVPGuSLk2PnDJshJKdTFsTnfsxlpuOggnK1JaT+hq7bjuiEUBGhgNSZsvoGOZR/1eSzptjng775QXccgGp14PeopV+DLseLCHv7ugMK+N8maUvn2jeL8I/Fts2OabDIz04K7zrQF+uyD9kr+mNA+KARKQ8x2i4foDhypWXvV/HpOOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RjL8CCK4Nvw58Jw/egtJ0R8jIc/n8Eqdv20A+qbN8A=;
 b=DD775Z3k7nqPF+cCjL9N9NBfEjOuRL6z0NDAYckvucCT0ZozsCpRGojWsvYdTjTPPREGkeyC8Hlbjxa61LEvi9Xdyv6XdkM6c6Xowh42hg1tyyF4ugBAszFnjtWL6Mz3WmuCHm4x/gNPeAtOnBvSgEk+5n6TI3W9FH3LpdRhte2dGq6SR65NRXI3PJcj+/4R3a93puYlN39vyMkhnlsZBwLFN3pR1pSQQjB2f7+Li44vfmLMezjnM2BHf6eGbxdcqgZjPfXqII01GHnnoAlG4kwB8hmfbD16geJazUAfU3p3o3F+iy6YDnufwO1muHm+T0oU3jVDahKFEi5QkV5UPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RjL8CCK4Nvw58Jw/egtJ0R8jIc/n8Eqdv20A+qbN8A=;
 b=YeZ1pclrLbyFhmRyHxRUCl2Po/I+aBMw0CMuttWAzHdXvLbUg35zk22xNSJA2r85oLiE+jXhhHzZftu/KCvGFC1/EIsyinnL8PJCIMk8GaiYsr941AWkDmI8NjUNt+bkFMqeYJCIKlV390db1QoT1R2h20cnjWkxYmW4oL3ArVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Wed, 28 Feb
 2024 07:03:32 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 07:03:32 +0000
Message-ID: <8a2eb62b-c4db-43ca-9473-6fcb9e18203f@amd.com>
Date: Wed, 28 Feb 2024 12:33:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: enable pp_od_clk_voltage for gfx 9.4.3
 SRIOV
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.zhang@amd.com, Davis.Ming@amd.com, vignesh.chander@amd.com
References: <20240228070036.4143328-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240228070036.4143328-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 08734970-ee52-4e4a-605a-08dc382b5fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HIQbYNkeyT3qeNu9AyzNPqTnHh+wuoKfCDuRgwsWNFQvl0T4GBbegpPqyPBT/PPyhS1Zu4Hl/0Z/ITozfYll5Iy+oKpxWW5JrAiIzr7Q1XEu9QW3rLNeXpx4WdA9ZuXRwqr+z+zMo2Rkr4eWsjMR+F5YA6pAkAkWgnXwjLAcQqanAa7uuKGf89GW6w7HWgBGBLnTsHhLeM6gX4cMALoMB9LZLiaKE7uyYX6FC4moAFPNrOHuwaCV6eGLgF/iTd23ahQTKBmrqhpDWy1U9NWR0ZruU6rzxjyxK9/sKICNVSN89htKxGlm+maToCCua/u9qkD3wrRCqRueJ0bkqnNYA4x+2M8+FsHbjCa/p1Vmb45I+ag/hzlWblC9TKfkQCq9VBUVVDHy6yldsrOsEYQ60DvxHUhwX9deNY0EyM/t4CQeZrNctUekOzzaXIm8kWKjSFHE6axNP3bxtQIsaS/m59kXDgZhiH+7ALorNU+ubzKkUyW7vJshYZ/cPNHz1S1VoMTy6Wvlnu0Jwe+O77zCgvbLXAoBpnVFcE2h7IeEcRBIEm3rEB/+7XsR1AhvbH/fVdfsJz9EqnSKYR3RAg75Ja6W0YsuyEbZa9uw2weOw8FS9388WRgz3ChQt7cUmunVcIrnwMrnp0VeSAybDfZ1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNVU256aSt4ZnlQM1IzQkl5VVJnRkpSaFNFdnhUQVBLVHJWY3dsVHhLVjda?=
 =?utf-8?B?T3h2SWFNb3c1ZEZlajRxZmMrOTVSQWNYSDJXOWUvb1FlSmV4ZG9BYXI3amdC?=
 =?utf-8?B?aDYyVUJUTXp2K3p2RUQrWDRFVEorOFVWSXFuZ09XR0Z5bGgwelhveXA4bGc4?=
 =?utf-8?B?Sm92VjBQN3ZtbWovWmFxUTVJbGhCVU9RbVJ1UHZOTm8raHphN2JiM29YNVNF?=
 =?utf-8?B?YVBjQzZ3TFc4cndNUEt1YjBGN3ZKbE56VUp3SlhYb3dkU3pqeGpCZUtvUkFl?=
 =?utf-8?B?enZ0dkpVQ3MwSk44UHRnM2JIUTBuNWRmeVpKRjF5UVZ6MmFFQWtrbXJmRVlq?=
 =?utf-8?B?ZjhmWC8wY3ZoeVRDaTcvVHVVMzMvZWlLYzl1Mkhyd2VWYXVVdE95dmNlM2Ez?=
 =?utf-8?B?R2tjcWx0ZlhoU2hKU2Y5M3EyTXdPdlBwMXREdURRazNTV0laK2V0ZDNscEVG?=
 =?utf-8?B?SUkrWEhsYTk5MjBVcWNYU3JqUlluWGEvdi9naUxwNkJkNkppSElTZDd5cEx4?=
 =?utf-8?B?RlgxNTVzdVZMVFFNVGE2Qi9BWGZnR2E4SHQ3T2V5c0JKcWQ4dEE5QlBrK1dW?=
 =?utf-8?B?WWV5Y3dJYXljL1RqQ2Z2Mm96dndQVzFaQWtXN3Y3Z1d1VVc4VHdueTB3SWxh?=
 =?utf-8?B?dk1LWWZPMlhKL2hjZ2FHUDhWVkhXZ2lCVExNc2RvczRqYlpLd0tQeEVjSzNn?=
 =?utf-8?B?S0FVK3JsM3BQdFJZcFRWaGFvZnhCT3NXWDR4eUJUeDNhRzBkVTZvMUJHejl1?=
 =?utf-8?B?c081bmlzSnFKd2VRb2NSb3BaUXhib0pGZEF1Yk5lREFQTmZZOHBtSnFydmRx?=
 =?utf-8?B?MS84WkpFckFONEdVRW45Y1hpWVNVOUZmMzBJRktLWkZRUDhBUktxdEF1NEpo?=
 =?utf-8?B?U3krOVBmTjNtc01RMmtkcTM3WEEzR2QwUVVQd0dTLy8xejJLcnQ4bFVQNlpu?=
 =?utf-8?B?dTlFYlIvNXoxOExtdjJ0TzBaNTNPamFtcjl5SHRSTlpVK0dJWHlMYk1wRWJs?=
 =?utf-8?B?Y1RCSTVxOGhzV2xUTjArc2pyMkNnWDhya3RsNVhrbnRLRVdpUUg0YlpMUlFN?=
 =?utf-8?B?U1M4Q09EVzg2KzFtZHVKYVY3UUh1MUtCVmdzZFU3V1NYTzQ0eG5TY3NNSmlB?=
 =?utf-8?B?WVpsRjB4YjEyVG1RZ29TVnZlbklvM3hVa2VuUTNPRUQwcFowaWZCTFJ6ck1n?=
 =?utf-8?B?aFBIeXBtTmFJUUhTSXZTVFd4d3NuTEgxOTBqZmEyRGZuaWZLRm1yTytEOUNj?=
 =?utf-8?B?VGlDNUFrdmRCK0lKbkhzVVFabjJtM1lUMHVsMUxPYWFXV1V6T0EzeDg2UVF6?=
 =?utf-8?B?c3lsblVsdFNodkVBZzNVbURWb1VHQjJCUnAxZDFicCtNZjY3R2pUMDJyTHZH?=
 =?utf-8?B?bFJ1K0h4MHkrNjc0SUUwbjQrVk5MSVZ4ZlZZbkdjbTgzYnV1S2VxeUVvbGp6?=
 =?utf-8?B?eDE0N2FkenB2OThTdm5LTWhHd1dTaExKQ1VWTmZBemY3UUpuZ1RGNnVvUHpJ?=
 =?utf-8?B?V3hJMUFGYXgyUVpMbmF4U2cvRkI2SVFRRklOYjVhWTlUZWlsZmtXdm5iSGRY?=
 =?utf-8?B?aTZPWlNmVkFKZTR2U2F4OTFzajd3a0NPNnhKQjNLTG9oRGV5VE1Uc203VUM2?=
 =?utf-8?B?VGxaZXJLMXlpMmw4bFZ5a3pCbG9rTkVhblZHUHU5Tjk5c2VGVmwzQVZ2bmtZ?=
 =?utf-8?B?NG5Dc3BlR1JXUmpFbFY3UmNVQjFBWmxzS0NGSDUvaHZlNlc5WW1wYjJzUnlL?=
 =?utf-8?B?Q0FKc3ErdjdaNUl3US9sd3R1OE1WRVhENmVvbVkzT2pGbDQrV0Nab3VKS2RU?=
 =?utf-8?B?MG82S0dKckNBZEsvRlp5bkJ0c1dON29TMlFYV3ExQW1qS09uTzZmaHBLNHdB?=
 =?utf-8?B?SmptYndOeitlMTVHcU5nQ2t0RnNCRGtlOERHS1dCMDgvaU5SSzJTb1RVamIy?=
 =?utf-8?B?KzMzU2J6RmF5c0o0RWxzeEhzeENsVHJWMFVyQUJmMnM0enNzSFNYZVN5K3Bs?=
 =?utf-8?B?bnBMdDdBWTZ1SWFDcVpoRzFOcXpvbnZqcWw5NzJvM1hBdnVqUTVrQjQ0TnVU?=
 =?utf-8?B?Z25vZHJweWlFTnFGTGNySnJsYnhTOTN0OGZ0Qk50SFB2KytEQS9IZTE2Nzdx?=
 =?utf-8?Q?CLXBqBOgUuO/4xZsRqj9h08Th?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08734970-ee52-4e4a-605a-08dc382b5fde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:03:32.6642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLPyiOMoIrNW/KLyqiu9TvKP9tJ7mCnCXCbqGwJhTJu9J04ziGILiM8Jl4YGCROO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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



On 2/28/2024 12:30 PM, Yang Wang wrote:
> v1:
> enabel pp_od_clk_voltage node for gfx 9.4.3 SRIOV and BM.
> 
> v2:
> add onevf check for gfx 9.4.3
> 
> v3:
> refine code check order to make function clearly.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 32 +++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 087d57850304..ad4e260c8052 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2034,6 +2034,31 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  	return 0;
>  }
>  
> +static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +					 uint32_t mask, enum amdgpu_device_attr_states *states)
> +{
> +	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	*states = ATTR_STATE_SUPPORTED;
> +
> +	if (!amdgpu_dpm_is_overdrive_supported(adev)) {
> +		*states = ATTR_STATE_UNSUPPORTED;
> +		return 0;
> +	}
> +
> +	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
> +	if (gc_ver == IP_VERSION(9, 4, 3)) {
> +		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +			*states = ATTR_STATE_UNSUPPORTED;
> +		return 0;
> +	}
> +
> +	if (!(attr->flags & mask))
> +		*states = ATTR_STATE_UNSUPPORTED;
> +
> +	return 0;
> +}
> +
>  /* Following items will be read out to indicate current plpd policy:
>   *  - -1: none
>   *  - 0: disallow
> @@ -2118,7 +2143,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
> +	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC,
> +			      .attr_update = pp_od_clk_voltage_attr_update),
>  	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
> @@ -2163,10 +2189,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>  		if (mp1_ver < IP_VERSION(10, 0, 0))
>  			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
> -		*states = ATTR_STATE_UNSUPPORTED;
> -		if (amdgpu_dpm_is_overdrive_supported(adev))
> -			*states = ATTR_STATE_SUPPORTED;
>  	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>  		if ((adev->flags & AMD_IS_APU &&
>  		     gc_ver != IP_VERSION(9, 4, 3)) ||
