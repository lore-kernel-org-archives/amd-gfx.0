Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E043FB519E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 06:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0EF610E22B;
	Tue,  7 Apr 2026 06:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cYpjrsX0";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6FB10E22B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 06:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFLovKW+Q2HDV1fXhFdA22m7PJYsYRKzaR64GoPMX6VC8qEXHIEyVxgxjyYSFe/AbqnERZkdsGztTL+sv5kCilfi4TdxlFg7AMsgsTfEFkY/P18yTTrpjdWmTY/HqG7v1L2JgX1rKIe9MCZgQ0jgPPvDEqs6KEdvUSMEEsUoK+amuCcCJ4yHI4m2Jg/H8ZGMXWf2b5cAv5yLOhHIZUZhWjPj/1wMzJjilEBT2+ZNLIrmFJFJIaQjBqZYpsK1EePX1n7Kp3Pn0du9I4DJkFz0qYFfHCCXJF9O2PHUIk0zj3hWs9a4sfLuRbe4dW0nhwEjd/wmNnxBmQYO/uwKEeAcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoIB8dlxNuSiHys2Y5S/B70HC1VGcS6fEZuEmK2Cyz0=;
 b=W6lqBiVqq+8Et7T4yYYGwNrjVmMjH2el219z4GFza8NZaq2q7avXvbN4aPCqBkgXdP5xOxiKRGXkisDsV7NFSXmQW3/nAj0mHJeuqpooFEftKQy3fgHqWIdWn2RkqLGPjavm6NZDFGOdSqgmOWwZDSmNkx1/EcsH3m3VLLYGGttsDQUfvwoiwIr3o5S8lgwKRrEyN00FzCHjagsCim4J2U8TfdwvASLawJqVWPVSdAVrfWmWzzLCBbyrjAG6X2izRPf8XAwsc0qkhWimwKSDikILSda4dMLyn97u6fu9nsl8rEs693mSBVhoVEaRcYYfjoP5aLbAZKrVNOSFYFrrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoIB8dlxNuSiHys2Y5S/B70HC1VGcS6fEZuEmK2Cyz0=;
 b=cYpjrsX0JSRCya2qO+FysnKKr3R8n7ZImgma7t+FLuzaVF9ShSlly7t/uDN+jwVL97e17hZ0tHLaOAfNdSom7/hvXv8uVIuUdLwd03UZHFI2YYL5/rcMp3UdvbyFQhnInje7n6yZ8Z7wUIP/B/4HwJzH2oZYMW6OeMJbZT+hQEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 06:38:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 06:38:09 +0000
Message-ID: <89e0dd8b-f7f5-4c84-98a8-2b867709db03@amd.com>
Date: Tue, 7 Apr 2026 12:08:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: add read arg support to
 smu_cmn_update_table
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260407030931.2024335-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260407030931.2024335-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0096.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6040c8-c426-401c-9281-08de94703bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: eRw96XBXjeCEnVWA64bJiuDsl7Lj03Trp46GoCf0wQVA0ZtnX5uf8lEG+2AckynkrTH3wl8DShLJ9eDcw8JrC+cNDCPv+UvU91myRYQsSaQolMNq3UgI9CfcpDCS1L0TS3wW/i5KNEwVE0QA1dB+TS7jdeGa5o2KZwT1hPsuOQQ5Hi8Ss8opCYkkzkBbNuwtCqAL7Xac7UTIQc9TF7aEssqiUfQV7TlictwOkc83s4k0USwV9cp/R7VzwmWtiGKRe/sXKFLs6KYHhl08JItdKQO5D91NwIwb0uHn2Q5WTeHf+UE0zcQ21TdHOQELo30FQAn2KjLDF8HtuUkPRdCev3faiXf/dzThE9ft8tfF7Te7NYJIr2qhYFLSfAFwGfbLUvCSxTmxjULtuxdmAdi82mzdpCPqsvNjk1yaH4ZWqnaVpzbCHtErg1GYGNYBMdqXyDJz+5Ink3tkq3fN3y/FvqX2vZN3annhuU00AsN0KxEW/s4qoiVG+I22vD0VCUDOZVc2+KAShDTdo9v3LELej9Hpe90njBdBZYAsEx8AfxJRrGKpv4b2CI9LdHe+uC2Rh5cR4DBT+m2agrF4URaDt2d6p2pDVIL07KuEKPPmvQAyr090DStOYfuTcVyCUFd9myWFsFD3ceBc13KTd67lR+c/WiiB4SKzkofnRUX3LiaTOVA4b6B5W++2LtRdBIMkwT8bfC+AbPHJswoTRJhn66+lH7T8/5hDmnuYDx5azcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0gxRWNRN0JCblNSZVFzaW45bVN5SU1BSURWRW9BbnYxYkVXem5Kc1lCcFpt?=
 =?utf-8?B?K1JEZ29VQzJsdXdBSSt5dFdIM2FOWEhnTTYvVDdrQWhXUUF5M1ptcDN6bTVx?=
 =?utf-8?B?bG1TTWJQbGh5eEU4R0VCeTNobW5oK0tvTTV5UTNCS1BUTzkxbjh0MTFvcTd6?=
 =?utf-8?B?dzM1em1jVE1iNmxHVGNsdzU0cjB0eWQybWtOd2dYR0lPNllHVnBmeDhpNjMr?=
 =?utf-8?B?SkV1SEpvSHordnBWL3p0ZmNSYXZ0MXpRQ1pEOTI2SU1iUjFqZzlWTWVLS3Bu?=
 =?utf-8?B?TXM4dWJhSDJBa0QydUI2R29Zb2cwTXVlWHllUHc2QzhMSnVZUnhsU3B1QTls?=
 =?utf-8?B?UFg3dWJXNXVpN0JIM2JqYktuakplejl2bzAzTXdYRzMvZWJFeXllVjlzWm1F?=
 =?utf-8?B?c1hzSE9Tc1JKaTAwUkNHTG5RcjQvYnRLaVRCaTZDWXNZVnAwYU9obGh3aW5L?=
 =?utf-8?B?c1M1NmVkbm8yclhOTld5MnJneG53SWoxekFrdjRQeStGKytsWm1rRmhqTHhx?=
 =?utf-8?B?Zm5WVTJFeXpWZ1pNbWNva2VhSG9ibTBYNUsxWmxGUjBMaWpiem1WWlIrVTJ4?=
 =?utf-8?B?b1lZU0FUZmpDVEZ3RHdEOEdSQ0lUakVYcjhsb1lLZnpKTkR2MjNkblFvNDFn?=
 =?utf-8?B?eXNKemdSLzhZQVY1WC9ZaGVjcDJQWU1XV3dSN0pHcUc1Zy83MG9Ka2V4T3g5?=
 =?utf-8?B?ZjZrb3NRcDFVNUE0a2dkSXlBR0Q4SHdtK2ppS29RQWcvL3Y3elFTMnJWVWJk?=
 =?utf-8?B?UDNwWEowS29vdXhOaDI2L0pzOTZsNGRZZFNrTXBwZWdSODV6VytIMkRUbml5?=
 =?utf-8?B?L1plWmtnakxQZnUyMVl4MkxNOHRFQ3VKNlcwNi8rOWVkK2VzaWVTZW81TEJF?=
 =?utf-8?B?eXY0Rlh0MVFJQWVvVDdHL1hvSDNVWjZrVHpwcjl3dlhWbEVsZGt2RlVBUDJ1?=
 =?utf-8?B?VGZ1eFlYZzZGU3I3dElIVFllNGpNUXZUaHNIMXVuWEwzd09KOC9YMlpMUGxL?=
 =?utf-8?B?M2R5TVRiY2RxQ1Bud0w3VVhDMW9YT1RGVERlYXN3UUUyUGdzNnJhcExlR0xq?=
 =?utf-8?B?NXFvWGI4VEp1ejRUR0ZYUC8veEZkVjZ2UTdtdjVwUXVXbVVvVVpJL0lIN0J5?=
 =?utf-8?B?UmpkOXRUUHlKNWtyalFYYU5DekkwR2VzMzl4TCt0dHI5SG8vNHZFNXZOVmJE?=
 =?utf-8?B?anNyYVlxMUxqUHFOV0x5aEFFZmdma0xwVEFoRHlKU285VmJncU9obUZnR001?=
 =?utf-8?B?TmtGQTE5TjhYYmozdXlpSTZNMFF5aitkMFBuclhmMU83RG1zMWVGWXV1SWty?=
 =?utf-8?B?azdpRXljc0lDbFV4T3JMbDNFTUpHd2U5VEVWdE9wekVrbWhVenJFUzV6VTRp?=
 =?utf-8?B?QTZaVVF1UmRHbDV5ZXJQakJyREl2VXFKblBKUXM2dnN0OTRBSkswRmlRZUg0?=
 =?utf-8?B?YzZ3a3JMN2h1OHBtNVJ0QjFtdkFpY2FGRllaWlEzWGg5b0xtajRQTEpnUDk3?=
 =?utf-8?B?M0lKWGxEVW9XQU5hZldac0E1WkMzdWxGZWFwcWJIY0ZXQkoyd3lKTmdmVHpM?=
 =?utf-8?B?QzdYYmkrV09DVnI2WlMwaHRwbHJOenFKSEZNd3IrT3dFaUtLRWEzQjArL2Uw?=
 =?utf-8?B?YzJRRllNTjZYalpQbFg0VUhPM01nOTZITXZOMTl3eEViTnZUaWNUVXpNemlX?=
 =?utf-8?B?S1g5NGk4TUlCRFJTWnp0TTBUMS9yMFdXZzk4aFZRVGc2WW5hTm1vc2Q2bndt?=
 =?utf-8?B?a1dhdllDb3pQOWpoS1NtMDdZcnNIK1VKU2lJaWw5N2pjcHh5NTAzWXZMREEv?=
 =?utf-8?B?K1VGbkphWHI1REREMmgwUkVqQTY0MlZ6eVAwMlNDVkxoYTZPV0pGY01JTFNN?=
 =?utf-8?B?b2pub1l5aFFRSGtKQ2ljY0N4Z2N4R1VYNWJJRnB1ZjlTclZmMUFyaDVpWlNa?=
 =?utf-8?B?TkJvTDI1V3U5Nk1zVGhUa2lLUFBWK0pXQSt2UlVzWHJ2aHZLWE12U3d6KzFw?=
 =?utf-8?B?d0wxYkU1bW8yUGFIMXhBZ2FzRUhaQXV1VHg4cUNzcTJ2RlJRUG1KYnduWnJ2?=
 =?utf-8?B?cVMrYytETVlZQUxNK1E1elBGY3M5aXpHeXVtLzd0OU11RHZNcC80N2ZyZGRT?=
 =?utf-8?B?dkpXM1JHNXpERS82VUt1MWczNXMrR3NPd1RCVXNDZVcrVWhBbEJwbUxQZGVr?=
 =?utf-8?B?T1J1WlJ0Um1LWmlUSytNK2MvRmp3MER1MUJGaTNHWGZOTU5JTEJydE9pZ2lS?=
 =?utf-8?B?RFBERzNXMEVEYVRMbmxUWFpwYzd3NE9nSjQ4bmk0aFE2dVptUWhCbnJpaUhJ?=
 =?utf-8?Q?4lEaDnX6lwPLLSy0wS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6040c8-c426-401c-9281-08de94703bc4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:38:09.7035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+aZiKZt/KbL8Kic027iBKg2tzaEWisW/qXeUpYtMd0QqfNzFYaGSHHOlP9ZabV+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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



On 07-Apr-26 8:39 AM, Yang Wang wrote:
> Extend the smu_cmn_update_table function to support reading a 32-bit return
> argument from the SMU firmware during table transfer operations.
> 
> - Rename the original function to smu_cmn_update_table_read_arg
> - Add a uint32_t *read_arg output parameter to capture firmware response
> - Pass the read_arg pointer to the SMU message command
> - Keep full backward compatibility using a macro wrapper for the old API
> 
> This allows the driver to retrieve status codes, results, or configuration
> feedback from the SMU firmware after table data transfer.
> 
> No functional changes for existing users of the original smu_cmn_update_table()
> API.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Minor nits below -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 37 +++++++++++++------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 14 ++++---
>   3 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 126fc54cb511..d76e0b005308 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -584,6 +584,7 @@ struct cmn2asic_mapping {
>   /* Message flags for smu_msg_args */
>   #define SMU_MSG_FLAG_ASYNC	BIT(0) /* Async send - skip post-poll */
>   #define SMU_MSG_FLAG_LOCK_HELD	BIT(1) /* Caller holds ctl->lock */
> +#define SMU_MSG_FLAG_FORCE_READ_ARG	BIT(2)	/* force read smu arg from pmfw */
>   
>   /* smu_msg_ctl flags */
>   #define SMU_MSG_CTL_DEBUG_MAILBOX	BIT(0) /* Debug mailbox supported */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 006ef585a377..3d49e58794d2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -496,7 +496,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
>   	}
>   
>   	/* Read output args */
> -	if (ret == 0 && args->num_out_args > 0) {
> +	if ((ret == 0 || (args->flags & SMU_MSG_FLAG_FORCE_READ_ARG)) &&
> +	    args->num_out_args > 0) {
>   		__smu_msg_v1_read_out_args(ctl, args);
>   		dev_dbg(adev->dev, "smu send message: %s(%d) resp : 0x%08x",
>   			smu_get_message_name(smu, args->msg), index, reg);
> @@ -1060,20 +1061,24 @@ int smu_cmn_check_fw_version(struct smu_context *smu)
>   	return 0;
>   }
>   
> -int smu_cmn_update_table(struct smu_context *smu,
> -			 enum smu_table_id table_index,
> -			 int argument,
> -			 void *table_data,
> -			 bool drv2smu)
> +int smu_cmn_update_table_read_arg(struct smu_context *smu,
> +				    enum smu_table_id table_index,
> +				    int argument,
> +				    void *table_data,
> +				    uint32_t *read_arg,
> +				    bool drv2smu)
>   {
> -	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct amdgpu_device *adev = smu->adev;

May move this down to follow reverse christmas tree declaration style.

> +	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct smu_table *table = &smu_table->driver_table;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +	struct smu_msg_args args;
>   	int table_id = smu_cmn_to_asic_specific_index(smu,
>   						      CMN2ASIC_MAPPING_TABLE,
>   						      table_index);
>   	uint32_t table_size;
>   	int ret = 0;
> +
>   	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
>   		return -EINVAL;
>   
> @@ -1088,11 +1093,19 @@ int smu_cmn_update_table(struct smu_context *smu,
>   		amdgpu_hdp_flush(adev, NULL);
>   	}
>   
> -	ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
> -					  SMU_MSG_TransferTableDram2Smu :
> -					  SMU_MSG_TransferTableSmu2Dram,
> -					  table_id | ((argument & 0xFFFF) << 16),
> -					  NULL);
> +	args.msg = drv2smu ? SMU_MSG_TransferTableDram2Smu : SMU_MSG_TransferTableSmu2Dram;
> +	args.args[0] = ((argument & 0xFFFF) << 16) | (table_id  & 0xffff);
> +	args.num_args = 1;
> +	args.out_args[0] = 0;
> +	args.num_out_args = read_arg ? 1 : 0;
> +	args.flags = read_arg ? SMU_MSG_FLAG_FORCE_READ_ARG : 0;
> +	args.timeout = 0;
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (read_arg)
> +		*read_arg = args.out_args[0];
> +
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index d129907535bd..1cd2ccb11b29 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -168,11 +168,15 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
>   			    uint32_t *if_version,
>   			    uint32_t *smu_version);
>   
> -int smu_cmn_update_table(struct smu_context *smu,
> -			 enum smu_table_id table_index,
> -			 int argument,
> -			 void *table_data,
> -			 bool drv2smu);
> +#define smu_cmn_update_table(smu, table_index, argument, table_data, drv2smu) \
> +	smu_cmn_update_table_read_arg((smu), (table_index), (argument), (table_data), NULL, (drv2smu))
> +

May move this down after function declaration.

Thanks,
Lijo

> +int smu_cmn_update_table_read_arg(struct smu_context *smu,
> +				  enum smu_table_id table_index,
> +				  int argument,
> +				  void *table_data,
> +				  uint32_t *read_arg,
> +				  bool drv2smu);
>   
>   int smu_cmn_vram_cpy(struct smu_context *smu, void *dst,
>   		     const void *src, size_t len);

