Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BC8C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A3010E31E;
	Tue, 14 May 2024 08:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwgKuHzM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A909E10E31E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlBY5rVSno+96dogo9Z8B223Ed62gp8GEfkn82DVz8Ek74MHkQpYwgnQttpmIRkIk+bI8yULgYAgMUQAdSguWKRUUBRtMFQBuadYGy+q3sJO4DvqlbGsELcSaUQGW+fWs1tTT2ZhA27AjK+cM+uVJaFXqTk7DNzkWwjj6JWs7iiaW8Ri2yCQPURkLxtTwmTyjRZVepxQ47/FkSoYy2vdgvtBs9/l4X8jDjDl8uWXhxmsLpuJSnh5EIzwIfYWBH7trLj+3pNUZFiC+IvCb16i7PqrYoKQLX6BKPwszp2ki+WVC5ilKJV3V/aCq6CkeOAtTbE0lcYU+GRgWc7vZCVQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9bdXkdUc8nQW803ehZR4GQpv90yRtxYJXJY863b1zs=;
 b=Ru54VIzbCYPj7cglm7ARcOHb4wmI7Uy3S+wzvAg7XhiWD9MfZM0kpwtWYnIa3pyNBLfHectJIbLf6HfhQLsvN4E2rVqkLZxjMWV2+WnR81cSjYj1r2ynQU3J3DddZt22V6I1aJxmLD6DiNB4z1VlUS8NjFMoNqqmXhtEAfOu/ggaTwNY8Dq4hDWQ/0B9PTN+YM0LwmXLkcC5xrz8nfLNHR0fjolTcPfOG/G6o16XQfJflAcf5XVPtVzcluAdrk9r36GVctuxvclWooxoonTuqlGAiihdn1MLsFp5Exu7X910LinVXMRLIv7VHPZlff311LajxTllj/Nw/mJNUa95eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9bdXkdUc8nQW803ehZR4GQpv90yRtxYJXJY863b1zs=;
 b=MwgKuHzMoeQ5BjKVk8ZBchO4U9pbBi9oLxUI+K7OELA8slf8++FpJxZGXq9lXx3P/UUq5HFOSSTk2pjcEl41exSpimZrePBTR0hDkqbMjOr+TvWT6W9SYcO86G6ogqH609HyIUfVun+uWcBd5MWi+5R0em+Rq62MEGJR5N4h5EQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:19:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:19:38 +0000
Message-ID: <d318acf8-6378-476d-b9ca-a0c56621cecb@amd.com>
Date: Tue, 14 May 2024 13:49:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] drm/amd/pm: check specific index for aldebaran
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240514065807.3651928-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240514065807.3651928-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b71f36-57bf-4e95-3112-08dc73ee9877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGhnOC9sbEk3bURQWnBpcTE3TlJGQ0JXV2dEVk5abS9JcVBCUndmZWRMNzV2?=
 =?utf-8?B?QUJhZzBwZHNVeTBrL2JwSDJZbFNyTml0Z1FGYzRxTHB3R2FxRGU4WTU2d2Ra?=
 =?utf-8?B?cGRsVFYxbitScE1ib3RGeDJITGxlUVo4SDVrTFpsSEIwdjU1dTVKa3laaE9B?=
 =?utf-8?B?eVRHY1NwSG9LU1dxZGxGNytkTVE2WVEwNDdyWjhBS2kxWEd2T1VMYTI4dDhQ?=
 =?utf-8?B?NVIzVklmRWlGV010KzlNOWVLNDBUSGNOWHpTQ0NrZGNYblZ1emc1dlcwcUhk?=
 =?utf-8?B?QlY5azlEV0VpZHpQcWxlRnI4clZYWGtYYjM0am9EVlRUcjJpNU40RnV2cVcv?=
 =?utf-8?B?dGNwVVdzOXJKOTl1L1NaT2xVVWl5c1UybUZoTVNJckRLaTZySnZTNUxyc2Yr?=
 =?utf-8?B?bjFrYVZoYzdqaFM3dndQMUs1TkUyTWZVOUpXZ0hIVWFjc1A2TW0zSlNIMXJH?=
 =?utf-8?B?OSs3T3hyZVlQNEtNWE96cDJXRWd5cDN1OUdQT0RXSGRnUHJac3NsSHFlbTdL?=
 =?utf-8?B?a1ZCTjcrbFRyMS9xd09WcU43MFY0dDU1akRKZ2xHY3pJTUFCclQ4YmJCUDFU?=
 =?utf-8?B?Nkp0K0tJQ2Q1a09SNXVzSW1ydDJmdUpjVm9lajg0czBTODFCczVXTWZibmF0?=
 =?utf-8?B?L2hCS1Z1QlJ3K1RvNWxjMERVaGRQRlJNVGxjRlQyT2dhWDI4ckxieXU4MlJa?=
 =?utf-8?B?WmVmRk8yTTE0T2dqWE16NUdaU1RSaHZWY0RQbmxJSzdEZ2FvVWRwNzdtS2hR?=
 =?utf-8?B?M3llVFhwd3BhV2NPVHlFWHpSTVBqTU9CZkR0Q0hydUtkMDVkVkFHSE1wNW94?=
 =?utf-8?B?NC85c2VPMThQZVFaeFdCSjFLdjY2dm0vNHQ4dEgwbm02M21FL1puR3IvS1Zh?=
 =?utf-8?B?S2VwNHh4aTk5STRnRWlLL0h0cStxUUhHV25nZkI0M3BRZkZzZlNxMEpwRjV3?=
 =?utf-8?B?SWxWcUNwVDRaSGg5dldzb1FnMjdUK2o2OVRYMGh1SHlsREhXYkJFTFB0MFAx?=
 =?utf-8?B?ZWw1b0tIeTViK3dtSEw5Ulc5RkVjQzFEUjRBRS8rdmYvVUNQZE5BeFNPbHJB?=
 =?utf-8?B?bVo4Mm0vSFNYMWMvSXp0dVpOSTN3WVhZeE9JMXNESitUN2N2UithRkhXVHJV?=
 =?utf-8?B?YmtDL2VOd0hBY0F6bWpJdDFnYXoyWlcxNlpEbDFBN0RrSDFnOVVWaE12YjJj?=
 =?utf-8?B?ZEs1SXRuSDhoSjFTVDh2M3F1TFdNc3lqK21tWVI5NWNVa3A5RzdaM3NCRnpD?=
 =?utf-8?B?MGRRK2FkZndOaUNHcGsxcmpRWWRyczJtdG5oUVJZMmZ1SEVjR3hVeHhxVWRm?=
 =?utf-8?B?RGYxYlp4YU5CYzJXaHVCalkyZ2xOeHFLbDFXc0VsVGFyWDhoZEE1bjRzc2pW?=
 =?utf-8?B?ZnNLM3NOUlJBZXYvUURGeEJkTUxmQWdOR1d0L09LTmoyMndTSW1jbXBDK3V6?=
 =?utf-8?B?b21PUmV3WTkwaFZTeEZTM3Z3bHBmRlc0S2kwUkxlMExoUDB1WnFXUE85OVVX?=
 =?utf-8?B?NDVhT2pDVDZHSXJldGF4UVpTREtROXFPczh1QWtrc0tqRmN4Sk45cGVGcWc0?=
 =?utf-8?B?T2wxbW9pWGtWNnJqTThWL2tPN2dILzluZ3JQRFlmcStWcG5lK1lNYjlHd01n?=
 =?utf-8?B?YU5CNUM3SW4xenUyRjdFTjB4TlJrL3J4a1ZyQ1RkZW1uN1JKd2pvd0lEalRN?=
 =?utf-8?B?TkVvVzJ2Ymo1aUorL3c4U2JUL0Z4LzlKM3EwYjZvSnYwNkp2alEwUmJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpiMDhJclByWkNzMG0xV0l0SVcyd0IrRDBmK1hCdDJBQUVaSEhqL3ZHQ1BQ?=
 =?utf-8?B?T1hHaG02VXU2TGMwWTc2anY5RlQ3dENWOGcyMjZSYXBFemhqVHdFV0h5QlpG?=
 =?utf-8?B?cDB5WC91RVpnUGNYRzM4TkNIbnVqQ0NOaXY5NWIxdG5valpMbTZLNkp4eGJz?=
 =?utf-8?B?WDFGY2IxbFI0VUNSUG11azVLK0lFWnlzc09HNFE0bTgyY2dqSE5FRFNwS0sz?=
 =?utf-8?B?QkRaZjM2R2thTmtYNTU0cytYamV5VmF5ejI5WFVZYVRVYmFyL3kzNmJTb1Nh?=
 =?utf-8?B?SjQycWlGczNsS3c3UHpnSm5Wa0p6bTUvR0w3ZHBibjBkTmM5QThnbll5dHhs?=
 =?utf-8?B?Q2VWOGR1U3lqTks4MkpQV1JFVjJVNno4VEt0R0tkV0dwUURDMW93UlBZWGVp?=
 =?utf-8?B?OUxoNkpqa3RqYUJXdGt4SnkrbnFUTnFmMjVQVHNoMHZldlFGdVJsVE5TZll2?=
 =?utf-8?B?QUYyamF3c3V6MVlaVC9hbE5oN05EK2dJUlk5TGNFT0JLbGQ3UXlYa1pib1Vm?=
 =?utf-8?B?ZlhkeFVSZVV6RWNra0FmcnVOdENIRmtwRm1YV3BYMXZXZlhwMkU3bXRsYVp1?=
 =?utf-8?B?SFBKbDNCY2RKNHJqdUdtRmREc1pnRDVRTkNyNzJYa2lNMlE2YTJCMkpDZ3Vp?=
 =?utf-8?B?NWVNNHZYR1FKOHNIWW5rNVVITWdYaGhVRWJLSk4wQzlXTkV0R2pWazhZZnBm?=
 =?utf-8?B?aDhTaUl5ZEFOamorb0UrdnVKTk5Qei9kdnVmOUtaREM5eTExSGovcXhZczF2?=
 =?utf-8?B?M0hYUlJla0lSb3VHR2RqcmIvR0xzYmQ1MDNaWHNhZTAwUlA5Yk5FMnNNTTBQ?=
 =?utf-8?B?U25rRUVPU2tadFlWVit5aUF3c0xWU2VWczdxYVFLQ1FjVXpHVkt5bE9tQ0hB?=
 =?utf-8?B?emlIUkg4cVZLdTdBNFM3OG9PQWR4N0JucTFMcWZyVHFnYjhRRXd5bVU1Y1Zu?=
 =?utf-8?B?ZUNFNjBDdlhpTnNDbDhGZ1FyZjV1Uk1UaWJnWVlBTmhXNFdTZEhmUWhZUzBS?=
 =?utf-8?B?eE5sR1FwbkpsTGg1Smw1ZGozZzlRUUQ2a1AwZ2s1akxUbTA3ZnllK212MmZW?=
 =?utf-8?B?MkdEVXdBdm9FR2hjODd0cUJ6dkNKWmlCQnZQOHR5ZTJ4QUtDeTVGN2F2M0Vl?=
 =?utf-8?B?RTBJVS9Od3ZKYW5zQ0VxWHN0ZGNRdkNKM0NvdU1VcC9DWXkxdGhzQm0rODRn?=
 =?utf-8?B?YnZHQUVtWUplOWZWSmJkL0cycTlPMXFvVmxZc3JuZWNLdEQ2THhoU3VicCtU?=
 =?utf-8?B?WDdzajJzZ1VkZHRJS010Q3crUWEvSVBjQjh3U0JGWE1pSVk3RkcrTmtCUGd6?=
 =?utf-8?B?eUhYZXpGazU1Vk9DZldjdUg5WXFyNjFCd2VMWStieTgreGtKdGM3UHU3VWlN?=
 =?utf-8?B?UkF0OTRLNHlCZVpueEZ1N01pVHRFL3FiNkNDU1pFclB6ZmpqUkg2K1F6Vkht?=
 =?utf-8?B?VUtidUVQTmdoRzVuRnNneFYxSVQrT2VndS9WdEYvVldZM1RNcDM2RVA4Wk1h?=
 =?utf-8?B?WXo5d2NxRTNTcm9RSE1iM1lVRlErVkUxeFpmd0c3czlHZHV5amhYcFhpbDJQ?=
 =?utf-8?B?VXpVdzE0dm04ZmFpSE1EdkYrLzhZU003b1FXUFViQnR5RDBvdmdUeVdicVJy?=
 =?utf-8?B?NzdpM1hBNEE0bnVQTnZ4MmR3OEkrOWcwRStWcnpSUkYxeEJmOEtnZUlncHNQ?=
 =?utf-8?B?NlN4SklpR2NLd0F0MUJBT2ZTUkVYTkdxWC94Y2Zqb2M3SENNQ3FoNWtBRHUx?=
 =?utf-8?B?UVZZeVFjODJiT1pwOTNYUWZTbkVtekc4Z1ZOOE1RSkFsRkg2VXVPRVZlUUxt?=
 =?utf-8?B?eXdzVzF4em5ZNWZIZ2c4WjZWVlcrSGZJVGhRZTVweDNaMVRxSnRMSGdMTyt0?=
 =?utf-8?B?MUl1V0FJVGJOZExHVWVyWTVFbHpjWXZjc0d0YzBKZzZCK2dlUVRmVzJia29M?=
 =?utf-8?B?WjZiQktLazl6UUMxdzNWdlpqWVRPc25KbWFHcjNzbytuYUJKVWovdVhWOWcw?=
 =?utf-8?B?V2dyVEhrVVlKZ0tvWXRhK2tRNlMyeHlwUlViaEJBRndsNkdTOVQ3ZHhlRWhV?=
 =?utf-8?B?Y3hrT2NSWncvMUF1V1FTbFNZZHQ3T2tMaDZER0tsZFh6Zk1GNTZ3dWFaSTRI?=
 =?utf-8?Q?GFxaqZdR6ibhLv1qDMhxVyxIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b71f36-57bf-4e95-3112-08dc73ee9877
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:19:38.0560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFWB3QbT9AP7mNN47xW9uGOC9K5ARo5nYo3KELSIQQebhgJtNN+KE+nBZzJeWYgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
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



On 5/14/2024 12:28 PM, Jesse Zhang wrote:
> To avoid warning problems, drop index and
> use PPSMC_MSG_GfxDriverReset instead of index for aldebaran.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index a22eb6bbb05e..d671314c46c8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1880,17 +1880,18 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
>  
>  static int aldebaran_mode2_reset(struct smu_context *smu)
>  {
> -	int ret = 0, index;
> +	int ret = 0;
>  	struct amdgpu_device *adev = smu->adev;
>  	int timeout = 10;
>  
> -	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
> -						SMU_MSG_GfxDeviceDriverReset);
> -	if (index < 0 )
> -		return -EINVAL;
>  	mutex_lock(&smu->message_lock);
>  	if (smu->smc_fw_version >= 0x00441400) {
> -		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);

For clarity, original comment is - retain this as it is, only replace
index with PPSMC_MSG_GfxDriverReset.

Changing this to msg_with_param() breaks the reset sequence.

Thanks,
Lijo

> +		ret = smu_cmn_send_smc_msg_with_param(smu, PPSMC_MSG_GfxDriverReset,
> +								SMU_RESET_MODE_2, NULL);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
> +			goto out;
> +		}
>  		/* This is similar to FLR, wait till max FLR timeout */
>  		msleep(100);
>  		dev_dbg(smu->adev->dev, "restore config space...\n");
