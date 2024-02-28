Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA9AC5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 04:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7C910E8AB;
	Wed, 28 Feb 2024 04:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlwMPHdZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2642410E8AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 04:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwfvi/OwUbkfNgHhsIvjaSjrfr0WR3gWEsjUnDQbZVjpEY03xTk7t95hDcDDYZAH6GesOKkkNpFAonpJID7sQ/6BbYbkBTrb7sqvl1VPinIGQ9Lxeuf4TszuNTKQmXx+1GeTCHmIESpAjYFkeLUC0Suu+Wo4xpkFTk7/oM/esQC0XgshWqkLXsm16WZNQ7OLWGV807CVbt9AnXrHIbFu6Z/E24v4VkPMNAfRnJdZnixSxM3Yr7j49lyhlvPy5pQ08bY7sT2GBqdZ6AVoeptlYQeLdfVyMMeYjjGVYV0OAgyVV4UbQOp9lz24x768/212cZbEM2KjzT0NtHvfyZ4rsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqJA7i7/9z07fdt6o17R2E9OydHHs97j3q00rNFGSnU=;
 b=fvap4JWIAokZedJqfVimIqTYofpXuSKjYIdx6o6KJDfFVHXAcGG90jzKglpDAyCB533Ra9TchKLcZmUDOaGlYpcru+5Dhmn3ldcm1wJFvHuFpbSpUKYf0C06GikYBeniPffOoh+sHw1bKwa2Nr2Eqd0gF8XVyETPaJbY3y8doBaCCfF2Touo6MZasPiNVFkA5m+YkxHic0R/ygEBQFMF2MpriH2EuXbV9NlgyLRT5vF4hjW7Qz75WN2LA8cb7avGkxZ7O01gvpH8FOaXa0KaYoN89IXGA3KAmYpHsnyGDdaSjo37+xyxSjOkOpbhr7RRsL+KkcxVILbnRAXTd3/KoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqJA7i7/9z07fdt6o17R2E9OydHHs97j3q00rNFGSnU=;
 b=IlwMPHdZfuV0PGnLipKxcdW6Kij5+OIBvi6undAWoHb42bX5MmwzTS5griN/QzeNdk7DBqb0C65Tx989RPp7Y9lctS8QHWAUP0qxAcVk+zn6pD1OIXqFj5ChbWNSdJXDB62/v3iPUGvUIiWKZt9fHIyTIPPiqHmYk4HdjHNsRlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Wed, 28 Feb 2024 04:08:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 04:08:40 +0000
Message-ID: <40567a6d-4262-45f5-ae8a-7dff0d1d0afe@amd.com>
Date: Wed, 28 Feb 2024 09:38:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Skip reporting pcie width/speed on vfs
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 Yang Wang <kevinyang.wang@amd.com>
References: <20240228040050.2100853-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240228040050.2100853-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c176ab-54e4-4975-3c61-08dc3812f1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTz18UVjkWJeN7Qgm52xY0KRNshOp5mVperPXc37kSorLWq9G1zJD8sPwb8AZl86oqBFtPNS+sR9oOSbPAFchhKlGCh7VAvwm+mri6G2rny1LydpYgQh1/rInElomAKctBKlvzVNlKi4dG8EARgP5Dk0caQ2FiCkXu27bk4DHLXUxcewl19FK3TaySn964cBqnYj3E+SzyZHZ1slRU04y+ZsnBAPUSKxiGs9NzdvovMQYK9VIYprMb9C3yRf1D9I9WDXrn3HXdz11MZcVCPLBRkvCQboBgMWwbSFST4gT6NybKqpGZLUeatZDmD6LP00YsMq/apaJ2vT+9fLinhnuMbR9AajWXa2xTpcUHduT0VcEJw7Ta25SdYqxECyHa8JWe4dDO5xB7g2J7wGT8IGwyePa4k0dG0na+Cuz7Y5bGND+LQjsInOmJUbgxA5HC6SbG3vmSCqHQ0nFxGIlIIqy3tZ+oBaYNUjyqHTHeMc4f0KsmEaetmknPEPQOAoN0unbvpCJsKi4AZff6BXQytDWZRnti4oPtqldBmFxhaz7D8N6YwRIDMkpTSnze0k6Z2of8ZTBO6/CDSn4k66KRxKD9grGS38hLq66Bdyn3YG9DJBsT7tM23qsP7v7lt8CmxVTO15gLBIAb54I+XorFmjbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFRQUWd4eFFTVGpvNEhmVkorS1dEVHgwakNpdEpyazZmdGZNNzJsc2pFYURo?=
 =?utf-8?B?VkVsRDZ3M0VHZGFMMXF1MTBvMHhJeHphVGNHTWxvS0x0OGd2Qmx5c1JmbFc2?=
 =?utf-8?B?TFk3KzdNRm0ybTlobFF6MFY3UUNiRTlNcCtGYy9YVktDczQ0RkFMYm5rait5?=
 =?utf-8?B?bFcwR3dWNGFRNlArT1JoZVEzc2Foa2lIaGlmSDBjbkZvQ3dreXAvTkJkbmlL?=
 =?utf-8?B?MS9Da2d5R01pTTBPU056elM2c0RyZEYwY2xST29Gb3NhR3VzMDZLZUpOMUgx?=
 =?utf-8?B?dStFdytxaXp5TUhjaTVRak4yRGdZYkd6M0dnK1VkZTcvZmZwVktvY1lteEFT?=
 =?utf-8?B?QmVtRFFrUm1xV1RZVklCd1FLQklpb3ZrSm5Ed1g4RlZOSHAwVHZDRDlBeEdP?=
 =?utf-8?B?cmxlaE1vclViblI4SHdXbG1MMmhrOGhCaTl6bVJxMHk2K2l4QXpML3NpTTk2?=
 =?utf-8?B?NXp4YXRxOVRDOVN5bGtwRkRwNlVIcXFJQzkzOHU0WE1SSWdBQmYrclJodjFU?=
 =?utf-8?B?THlIcHlHOTRPR3ZBWUxyNFJZVCtCeXFtemM5Q1JocVkzYnpnNjh2Yk1DSzVK?=
 =?utf-8?B?WEZIcWhKUlBCYmZrUXcwOEpBY0RTYjBRemdMZDRGNE5Ta0RGc0lGTDd6QWFP?=
 =?utf-8?B?NnZpMnB6U2xadG5ReHFOWGlwV3ltVE53VG5ST3dFYUFPMVdjbFMyVjIrendu?=
 =?utf-8?B?OGVUdlQ5OHFtUzdaSEJpcFFHdmdOQTJnK1VBVXJuWlE1SExjS0M0YmswSWU3?=
 =?utf-8?B?V3ZzM1pZSHNMb25XS0tHTjVoMTNZV0NVUUx5Q0RPcXZSb3E5L28rdkk4RCtS?=
 =?utf-8?B?U0t1WnA3NjdWVzR3REFhS1FLZVVFMy9kMHZrdFp5UnVvQXJxaU1jRTBNeHZJ?=
 =?utf-8?B?ZVlXMWVkL01rTThESXUxMTVtVWFvVzZMS1RMODRxSFdoRGxPM3BIRk4wYXA0?=
 =?utf-8?B?ZkxTV0xBN2ppOHpyYjFncE03Tno5alRTZXhtcW90TkVMQTFiLzljakQ1cFNp?=
 =?utf-8?B?U0RyYnlDNVJwYjVEWXUvSVNTdFEyeEVpK2F2WW85OHZBWVZCZVpHTDRLRTdi?=
 =?utf-8?B?cWdtY0EzYVJFaXUyQjROOU91M0tqbTFIdEdLOXRWbHZOZnp1a2ZIS3JLTmVL?=
 =?utf-8?B?TG1kUlN3L3lrOTNNek1YTTRvZTMycDJkeDdJaXV6c0NJenVRMzNkZngyMjdz?=
 =?utf-8?B?eE01OEI3eVZUcG9jbm1HTTJaN1VpMHNWR0Fqcjk3UkVROW9DMXkyYzdiYldM?=
 =?utf-8?B?Sm5sNXlHUE9LcXF2MnlPNkNjYTBIc3l2MWpFWmNIbWhUamc2TTVvWWNPc1A1?=
 =?utf-8?B?ZTY5MHN1Y0hudWJnMVJmdlF2c3BpblRBZzFHdmF6ZEVybDl1MS95VW52ZTZD?=
 =?utf-8?B?TXBMOHJVbEw1KzNEK053cFZPMFEyZVNaVGo0cFp2aDZjSmVZNVNYcUtTLzdl?=
 =?utf-8?B?emJxZDFQNjNBRWlZR2hTbEc5MDNyelhkZDdkcnVMZEtTaTZqUEpzeUgxUFFN?=
 =?utf-8?B?VU42TnUyK3JqV2xjUDd2VEtzbHp0Umt5UEtia0ZiU3JndEovWi92azFBY3VP?=
 =?utf-8?B?RUJVM0J6dDRIOGUxQSs1UDcwbVNtZ0haNVVJYnE3dUZOTW9RdkRGZHlFK1Ew?=
 =?utf-8?B?LzNRNTFTOGp5ZzFmVHArU1gxNnE1aXdIQW82TnRtdEhESnN6enE1YjFoanBI?=
 =?utf-8?B?dGswTzhZNExQSzgrcTRtRmxpcDFpeng5d1ZGRVJpckk5SFZRSE16dmgwUWN4?=
 =?utf-8?B?cm1GbXJod3l3eGhRUkYvb3lqZjd6bGxacHZNUzhPQldPVDBDSldoM3VnbEEx?=
 =?utf-8?B?SXQyTkt0USt5MjNUSUg3WVhYY2JsTHA5NHlJZkhKQ3FPNXJUVEt2cmJOek5k?=
 =?utf-8?B?N0xuWDVVV2FyZjcxZS9SbmRrd2U5S1F4L2szUUh2WUlUaUNMVkptUGFIcits?=
 =?utf-8?B?S0pQOVF2OE91dkxaYjM5SWt1R0pXRk5XRHVkcEdLZUZYaHJDWlRVazg0dkw2?=
 =?utf-8?B?U2M3N0JuRXpBbG9oZm9LOXhEaXp2RExxVEZyZzBLSndYSFV1NUgxK2VucnJV?=
 =?utf-8?B?Z1F5YXdJYXltZzVxU0lSczdDUlBDTjRqQlZObm1EcUlZOHVOb1ZWcVJBVEZy?=
 =?utf-8?Q?fhFUoB2BVn0DCZvtQ4wiXDyTn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c176ab-54e4-4975-3c61-08dc3812f1bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:08:39.9915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9sNIgcQxkNw/XDxlstaT6bANJavzl8Q45eL0dxjnPThhThw21YhB+t7Mg91/0f+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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



On 2/28/2024 9:30 AM, Asad Kamal wrote:
> Skip reporting pcie link width/speed on vfs for
> smu_v13_0_6 & smu_v13_0_2
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ++++++----
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++--------
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f1440869d1ce..f122ef49106c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1747,10 +1747,12 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
>  
>  	gpu_metrics->current_fan_speed = 0;
>  
> -	gpu_metrics->pcie_link_width =
> -		smu_v13_0_get_current_pcie_link_width(smu);
> -	gpu_metrics->pcie_link_speed =
> -		aldebaran_get_current_pcie_link_speed(smu);
> +	if (!amdgpu_sriov_vf(smu->adev)) {
> +		gpu_metrics->pcie_link_width =
> +			smu_v13_0_get_current_pcie_link_width(smu);
> +		gpu_metrics->pcie_link_speed =
> +			aldebaran_get_current_pcie_link_speed(smu);
> +	}
>  
>  	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 2b7a60b23d6b..69c64bc6e2dc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2229,14 +2229,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
>  
>  	if (!(adev->flags & AMD_IS_APU)) {
> -		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
> -		if (link_width_level > MAX_LINK_WIDTH)
> -			link_width_level = 0;
> -
> -		gpu_metrics->pcie_link_width =
> -			DECODE_LANE_WIDTH(link_width_level);
> -		gpu_metrics->pcie_link_speed =
> -			smu_v13_0_6_get_current_pcie_link_speed(smu);
> +		if (!amdgpu_sriov_vf(adev)) {
> +			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
> +			if (link_width_level > MAX_LINK_WIDTH)
> +				link_width_level = 0;
> +
> +			gpu_metrics->pcie_link_width =
> +				DECODE_LANE_WIDTH(link_width_level);
> +			gpu_metrics->pcie_link_speed =
> +				smu_v13_0_6_get_current_pcie_link_speed(smu);
> +		}
>  		gpu_metrics->pcie_bandwidth_acc =
>  				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
>  		gpu_metrics->pcie_bandwidth_inst =
