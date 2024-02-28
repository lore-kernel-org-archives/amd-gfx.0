Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E81C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 06:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA8A10E350;
	Wed, 28 Feb 2024 06:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IlcvCQM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1133910E350
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd3YtjYEa0IUTio0YbhseUt5uMgKJpKE1MWRGDcLow84n3DEEV50F9n/OzyxDnAFGsHFS3PEleSAtmbg0G69Xf2cZsnhQmBSp8+3eB9Wqwjl/svARuwQNPPo5HSVnx+YFhq7yvVbkKDNUHKkDpdNMfbAMC9x+0nSBuLJH2T7Ov+AlWGKOyMe2ZwqpgXEENFmAYVQnIEEqRgX0MBInZcGptj5O5Fho7r3h6TZMeO6YpTqfUy1hLXrK6ChSkr/s71VjJ3zESZq41cd1OGsNVC4jTOQ04qmF/ZhFfNaBcRbAvwuUBoe05R20nFuG9aNBjWhZzQzU7Znd5nHQMcT+bzZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1Tm9UdoV61pkVd07SOfTKP9rAAGf3LdawrEI9pGlSE=;
 b=Jz5N2/lnAEqjkEfyX8pzbKN/0bmbKf+sLBALFpFwCbO9XMYhNNDaGSwQmxN+j0oDetO0GqUgKkXTmEf4tF/2a1pUE8URrl24OD6ayKBNSpFDJUrl7Q62cV1ji0wZfpqifobNAJYjhp31VzPz5q5/9AzSljD4QkrxLjTMmaNTVS0dySU8O3Zbvw5IWjHQuMV1CfQsX7IVUo7jrAy8/Pp8Ty2I6YT7XTS3of3mG6KhQaPbZ6hHyjGA9CDj9MbvXMybP2Yx+dJwr8Pipgs123P62HBY34Nb/FZ/E5M0ti1NVrkPxOuZE3iFIPZQ+vlhD/s0vttO4wYudOZ6Xe9xi3mh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1Tm9UdoV61pkVd07SOfTKP9rAAGf3LdawrEI9pGlSE=;
 b=2IlcvCQML8Es8erwamq/KEbbT7e5Y42R94ZSn93HqJwpQEjdoiZW8WvTiw2AgIg4ztIOtptcDLGSy8jX4mzMI25GoSvlfF92m+v2k4vkS77nQlYtwM9h1jva50jbuyorSFfytsljeTdrCIQVA17imhrAfSUorJXoOra06UBerQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 06:18:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 06:18:47 +0000
Message-ID: <fe3224d1-4cda-4871-99cb-6a6f168a861a@amd.com>
Date: Wed, 28 Feb 2024 11:48:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable pp_od_clk_voltage for gfx 9.4.3 SRIOV
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.zhang@amd.com, Davis.Ming@amd.com, vignesh.chander@amd.com
References: <20240228055821.4136268-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240228055821.4136268-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 353ac622-c655-45bb-c5fc-08dc38251f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TjKvteOLZwlJNu/3+kH9KO4UsKaFLpAs2ehhm4AXanTwlqeHPW8CFigma5UYQQ3pHtI518CR8U/AUEKN8vpiETZLkhwmKVBxwbdx+WrrXEJeTJHNy+2mIwREAqfxXqXRk9gfnqwXpP1bJNhRa+JBeIKn88pPGBbhBkN8Zczs6ToUpcwTJDFjlEQQ0TO2MPQ6uhgXp/OJWIEZ352alp7273jTkxz0rMxY3Xc8xKptCEDhQS4eQPSlAq1J1lbTz/+jKUV8/EBUpmIdDwb+j/37V6fWxpqOBWGhX3OcEccImpuw3d2QK9hAsDoPZ5qJQLu44uqdKALj6hSKKXQ05MrUUVVh9ZWWtSs0uS6h8whQQ3fzttWjev1X6cNLl0sQg4lPi7R24OrgJyPDk1MVOKDPxoeZm/e4AEoR3MCuwI/P1YnuZrfghowT7D5SUqgtesRmykuvxT0xWSLPpK3Dvf4S7wXLMYCqRHjP3jyuxj0XoH/HWJL1jSWwxJCIvCB61xPfsdjdFF9RlAvG1eZ772eHGkereG0QAaadOp0UpiWUsNVd2m/oW9yRL1NkiUPPDzndWulupFCfSayt1QB5K2kQWb+WTFyzr4sdm9P9aFNc+2hKE1HnSQpW8f6VbxqOKAWn54Jt1FGGfkKi+0dTDxv3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHdtT3VHMEhtUVQvbXBnMC8wbCtUYS9ZbnN6aVU0anZyeGZJM3F0VEhmMUs4?=
 =?utf-8?B?OURDRWlHem45eE5zY29XVEJvRnlkc0xpNXYwTjg1SGxFSWdlSG56dGgrZVdW?=
 =?utf-8?B?ZEE4aytoZ3NaWTlMeTJxZ0t2b1VQWG91aitjK3RTYVBpS3ZqTFR0MGlBTTY0?=
 =?utf-8?B?TEF6ZkVGMGo2cE0xcG92VzhnU3NEQ05ZQ3ZvQUx4bVdGQUhKWkFTTTRETVhr?=
 =?utf-8?B?eVNzNVFMNEEyY2pEMkpwM0RxYklEUitONUpIQ09OVVBOQUNEVDVtU2lQd3k5?=
 =?utf-8?B?L0huTGJiVFJUZUhES0JnUjc3VmRQYU9OVDhZYzRFa0poc2NBOU1XMTBLdFpo?=
 =?utf-8?B?SVlCWjczcFd2RG5DS2dmajJ5bytaRUFLcUt2VFd4UjV0cnZOazEzQkRGRnlL?=
 =?utf-8?B?cVphT0Ewenh0SjVwMnlqVVkzTGliNzlpWWRnQ29vcEpYa0RSYlIveG83N0xG?=
 =?utf-8?B?MGxsV29ueWRyd1ozTHN2ZVYyNXllWmhRbWNiRWRaNlZxWnFmVmxVSENBWlZJ?=
 =?utf-8?B?Z1htbHJINXFZdkpUS0F2bTlsbUpsVkM5Y0E0ZXhJMkJPZmRNNUFIOHdseDg4?=
 =?utf-8?B?Y1FPd0E0MWpVV000cW9RZHZVZnhTS1NIQlhJamZIY0poWlRCSTlmY1dwbUp5?=
 =?utf-8?B?K3NXdlJ5TzNUcFVJRnR0SXdzb2RaVjZQbEtCbUVWZW9EK3laNUFwKzkzVzYz?=
 =?utf-8?B?QzhmS2pNYS9QVnFqd1FkUjNBUTZVOWV6dVM3WHNLTjhiazdKZnZRbG9PUFVo?=
 =?utf-8?B?bnJDcDhvU2hIU0JlL1ZLcG0rNmtNZEd4eTczRlVvNUd0eUJiaEgwRXNHb0kx?=
 =?utf-8?B?REJNTi9IK29ZQUk5Njc2YTA0K0ZKYkpyR25aREJ6L0VhelhoemkxRWlQdzgy?=
 =?utf-8?B?SURQQk9MNFRua0RFN2pmWkV2d3NmYTgxeCs4dWE1cHN0dXNJMFFtRHJuWTdC?=
 =?utf-8?B?UFp1YVhlSXFZdE5adkNSUm5FZXpQdy9pNUlOWUx2V1R1K0syZnRTUkFWVXo4?=
 =?utf-8?B?TmpORW9YOUU1aFlHNVMxeXVVelMzVjEvM3pHZ3dIdkNydUpLS3gybGE2VytX?=
 =?utf-8?B?SGxOeU5RMXdROFlSa3ZJTUxZTFY4bUZuR1QwRGtITS9GZTZNbnpZOU1nSTFO?=
 =?utf-8?B?Vy9QK0F0blg0NnhCWGRBWmFUQzVlSHlGQWMrSjQ4V3dBaDF6WFE3U0M2YzZQ?=
 =?utf-8?B?L3RJRjFodGhjVXVqV0Y2ZW5GZmZPajhuUjkyLzJINmNUWlFmdVFoNjdnczM0?=
 =?utf-8?B?OGNyWFRMQ3VkK0xxVGc5Q1U5aEVLTk9EUjVjUlcvc0Z1S29kaVpkUWpmVEJH?=
 =?utf-8?B?UDc5V0gza1V4TGRlejdqRzRDd2pkWUlYWnJ1TmFLT2NxYjhwbTFscERpTTYx?=
 =?utf-8?B?QVFXZzFoQXBLcmQvUmdzOTVVUlI4WkRhcS80My91VHlUQ3ZJalNPSjN5UlZN?=
 =?utf-8?B?WFJzVXBOMDBGZ0I2UnB2NkpZKytPTGdaTndOODBZYXRwODNhQm1ZNTJ4aUk5?=
 =?utf-8?B?Q2xpenVuOGl2VVBYVm5nWVFrUHFRK25XZXh2L1d4OEdncUFsNSs0SVFHS1NW?=
 =?utf-8?B?eFlYdlJBbE50Q290Y3d0WDRQUSs0aTJNa0RsRDU5aVVQWFpMSUU3UXB6eEJ3?=
 =?utf-8?B?K1FTeHNzT2tiMHRFUFpDN1FGbHorblNhWXZIREg1cVZDNDlOQVoxSTV0U2Vr?=
 =?utf-8?B?dXUvTGFRMG56T2hiRHhKNzVZK2NKVDdHTmlHNUVtRTBjSGt0MG4yeXVRRUo2?=
 =?utf-8?B?dEowTCtETk1yaU4xSnRvRFY0OUpBbWFJSm5KcDRsRFJhSVZsK2tWcmRSM3pV?=
 =?utf-8?B?RlJXenBvUjZzaTVjaGpJUVp2WEdYNXFDOCtLMEs4Qkh5dkRLd0V2ckRNRWpN?=
 =?utf-8?B?OUN4V08xRTZ2Wlp1RGZYSDNSKzhKeEJBM2NuZ2RuL1BrVm1za001ZXVCeldJ?=
 =?utf-8?B?T1BVTzVvOFRtblFLaVRwV2Qzc29mNVNESG5IQ0J4KzBaWS8yOGNlTDNXZitD?=
 =?utf-8?B?aFhBb1lrQTRtNklKQkVzMS95aGtiYjhKT1ZvdU1qbmhJb2FrZktMeC9oMXFz?=
 =?utf-8?B?alBKQnV1TUc4UGpVdUNNU1R5ZjlHYXhVdWVKVFpLdzZmdGpoTGZQZEhaNkli?=
 =?utf-8?Q?JFKVRRbdqnRqODpqxGX3Xmk3t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353ac622-c655-45bb-c5fc-08dc38251f4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 06:18:47.3573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEzPhrv4WDPe9UaE1ycxckBh3wu7s/B5Dw9JsW7LMhR8wKeXnCwt1RLlMiyDiX+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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



On 2/28/2024 11:28 AM, Yang Wang wrote:
> enabel pp_od_clk_voltage node for gfx 9.4.3 SRIOV and BM.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 087d57850304..233b562950a7 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2034,6 +2034,28 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  	return 0;
>  }
>  
> +static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +					 uint32_t mask, enum amdgpu_device_attr_states *states)
> +{
> +	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
> +	if (gc_ver == IP_VERSION(9, 4, 3)) {
> +		*states = ATTR_STATE_SUPPORTED;

For VF, need an additional check to support this only in one-VF mode.

Thanks,
Lijo

> +		return 0;
> +	}
> +
> +	if (!(attr->flags & mask)) {
> +		*states = ATTR_STATE_UNSUPPORTED;
> +		return 0;
> +	}
> +
> +	if (amdgpu_dpm_is_overdrive_supported(adev))
> +		*states = ATTR_STATE_SUPPORTED;
> +
> +	return 0;
> +}
> +
>  /* Following items will be read out to indicate current plpd policy:
>   *  - -1: none
>   *  - 0: disallow
> @@ -2118,7 +2140,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
> +	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC,
> +			      .attr_update = pp_od_clk_voltage_attr_update),
>  	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
> @@ -2163,10 +2186,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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
