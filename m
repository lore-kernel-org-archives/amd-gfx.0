Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC20C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 10:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9EB10EAB1;
	Thu, 22 May 2025 10:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="abpVyA+Z";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F79110EAB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 10:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQctSaDKef89BtEb8Thlh4V6Bf0oag60+E1RGNfEQZwXzo4vkOlbEjsd0lQuVrx0SAJglR2pjKiIRR/CEBNZrM1ADY/ES+ol5pO725dgp0+s0ev7tTFYP9zIZEnbBHlzWfKCwfoZQ/Ux4KqAI6te0lVM+vUdUvcDDJzQNYVNGmoB6Kx42RdNL34TUPSf8agi7ou4Fe5FiIYM+Mp10uQwO1b9daS6OYzWsgh5SU3QJkGAC9fXvqf9FQ6ZH3F4nUXdl2F1gi11l3KSS74CC2AbjysCWyWKoOuYjVmBG+GshZolP4/w55LiQuYjwTlmKwlJ91asGiLxtIWCe4dgxVxnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7Pwp23KaChAjwkeQ/rWDRrumXMROtxUAi39o28qeuU=;
 b=qMybcUOXBAqB2+1kAZZ11Xg3isL3qRCyoc3XTwWWRmGBa5J5mMobUXPvRWJ6uBfRklJnIt2JNtvKxJyClx0Fgr4oJjUEponaZdxCCm08A4HBuwCHKq5x4Sx4dEAOwHnpEdUJx8lVI7BNGnW60OcObQUR+F2OL48GHKpsEcQ5mIOGHePRy8QStenZPUY2qCjqFNQMyVyAuuWuW/XExMn992kdazEO01iKZF+9WZIeLCdWhB8NOMaGw+tsGgoi2v7BNzXX9C3I/s8J2lzL1X8Ul54zbE1cV2lx4w9mQeU31gfowj4S6S61Dyb30D9NLz+J0yM5jK5hIHqDuG5COKLSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7Pwp23KaChAjwkeQ/rWDRrumXMROtxUAi39o28qeuU=;
 b=abpVyA+ZLYPNVclvrFAgcKQeWRYYZH2bDtJOfNdW5NwjQSqv7ZvXxZINfWHKpuf3j2bRRZUFbl5R14SjEJk32l1deWycyQm93tU5tlpI6aOqpZSTl+90cJAe2oks9AEJr6cgp3mK6WIjC+Fu6w/lTg+33Hx6yH2SBGY0p/H8b8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 10:48:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 10:48:49 +0000
Message-ID: <e4ea4e6e-a613-4d31-8428-6b16b9305545@amd.com>
Date: Thu, 22 May 2025 16:18:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Optimize get gpu metrics data function
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>
References: <20250522091641.716955-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522091641.716955-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b69ca5-7fe3-4cc3-65c4-08dd991e3bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHZDbWxxdzBKOGtKYUFaRmt1dU4wRGFXbXI3UWFYNzg0QVBHN1luZG54QkRF?=
 =?utf-8?B?Nnd1M2JjYklZNlpLVHJ4Wm11TzNweURtQzBvdDcxSENJZVVmQ2xvZUwvWjRq?=
 =?utf-8?B?Vk1XeU84Z3hCcWgvaVV0dTg4ZHV5azBlYlk0OU5xL0QyOXB3RWNJZ05rSmQ2?=
 =?utf-8?B?VmR0bnpGb1hnZktORzZ6NDEyOFhCWXZ5TlFEQ3JwcVZVR3hzUTBsZkV4OWk4?=
 =?utf-8?B?MDdLbjRCN2JvSGdHa1h6eXUvMkRuaml6TnNZWkdHSFNjMVM4ZGhSMkFMZVZh?=
 =?utf-8?B?SG5TU2tTNENSbTBvdHFVcjhKTC95eTRLL2dNVkZHU2MzSzJZUitJYzJ3ZkxC?=
 =?utf-8?B?T3R4ZWF2bEF0enBZbG9UeUQrVXpSQ3NJQTRRUmcrMm5LdGkzRFBrNng2Vnh5?=
 =?utf-8?B?Tkp2ZlRPdlMxeG5QNTUwalZoWXlIdTArZ2xNdFMyNktJMlJvemdmSGN4NldC?=
 =?utf-8?B?VitEVmk4dHlPT2UyVU9RYTRERFpDbVJjOUYwQnJ3U2wvOEhkaTEzNkhjVFda?=
 =?utf-8?B?cnpjdUJqZ0NQYXZLL0ozT1lOQkc3YldtK0ovSkxadHAxRExMRFFTaElUUTZh?=
 =?utf-8?B?dUN0aklMR2kvbGJtQ0svcUNkUlpiYkV5SW1mcEEvYjlWajNLdDhKeGdIZ3FO?=
 =?utf-8?B?eCtYYVhBMGtDdytBbzg1K05uK3FBeU4xVGJGbmhmRFB0VDdNV1FNWnRXWTdi?=
 =?utf-8?B?WnB3YmZOOFhoSWJyYjJLZ2hmekpXSEFRNmdHVHR2UUowQ1BzNXg5SWpBYWZK?=
 =?utf-8?B?T1A0bnpwVzZBRmRKWnFGdnA3R2JkNXVRVlV3ald5UFY2QXVWUmdyOHdKL21z?=
 =?utf-8?B?MTdFaTNEd0xMeVAyUUFCcElFamRZdS9TT3VwZk1malhCbXlRUmNnYmppSFRp?=
 =?utf-8?B?dGNhV2VjUUFXYmVQYWRlZ3I2S3VMZjFVMlhRaDdsR1NpYTBhR0RYeWNINmc5?=
 =?utf-8?B?QzhRd2tRcUYwVW9uOVRpQnh1VDcySVpmN2pIR2VEZWswT2xZL1lFNlhTNFE5?=
 =?utf-8?B?dmpHNEtNMzl6MUJIQUlXSzd6RW5ERVlJSjRkZnhJWXNnOW1VaEtHRERLbndH?=
 =?utf-8?B?YlptMUw2SGlUM05IR3VBbTNTaFFFeTRXN0ZiN25uN2JGSForSDYrUGdRT202?=
 =?utf-8?B?RUozTUkvSDRSZXVwY1lHbXM1cCtYdmlNeVdsQXZaWm1VL1R3UmlieEhBN3Bm?=
 =?utf-8?B?QnJrQjI1VXhTUWtrZmZtZ1NZcVZuNTZIQUh3VVhWOERUdzBoZFBFRzFESjJ3?=
 =?utf-8?B?OTB3eC9pbnRCNmJZWlJQdXhQNmlLdGpFQ2VMcW1POFNXRmtiZHIzeGFoMW1Y?=
 =?utf-8?B?SDR6ZTdycFdLQVhUa2JlSzhkU2RuTUh1dUtKUkpQNEJrV0wzQ1g5amJ3ZWZh?=
 =?utf-8?B?NWViRkVER25YWlRCTUdXZlVDNVFvMTJoM1p2cEJzYm5LU0l3YWNwaFZJVC9K?=
 =?utf-8?B?azRvN2ZNL0c3RUwyb3BzUU9qOXBkLzNPWFltWC8rdU9EKy9ZTHZvbnp4MDZ3?=
 =?utf-8?B?SzJ4cjIxSksyQmU1NVVmbHpGR3JVeDhUc1NEd0VJOWtVY3hOaEk0NDh6QWNh?=
 =?utf-8?B?SHZ0T3JUSWczbzFJUVgvN2tSd3BSWVV2bWhLdHBTR1Y2L2ZsbjJ2TVdTS0U0?=
 =?utf-8?B?NjkrL3NCV0Nob0tBV1JTUGxHMjZYS2laeGE1ZVlsamM3VHk5VitFbUp4Tnor?=
 =?utf-8?B?WVpMOERvdktEQWNkRncxM1lwN2wwdTg4ZVErd1pXRG9DRzZmdDRUNFZ5UW02?=
 =?utf-8?B?VEVGNmxZZlhtZUp1WmhlZk5odGowVGhnVEU3ZkV4QzhjVWpWWXNPYTlRVVI5?=
 =?utf-8?B?MzB6WFRvd2R2Q3NXQUVFb0paRFdCZHFabEErWnM4SUJ6YVp3Syt6YVhHR0l5?=
 =?utf-8?B?ckVwbkhJdXlMRDBVOE5sb3A2MW52dnFuZmRjVHdoN3BjdUZWTjhVOWJPUWhu?=
 =?utf-8?Q?tDDY3CE2/2E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVxbjdFUUpvTlh3bVQ3QTFHQzZRb2k2Y2NjTm00OUxzMTYveXBibXQ2MDAy?=
 =?utf-8?B?WHowNEpNdStiSmRSR3NrZWxKVlFQN2trT0pMa29LRVhuQ0FmbVRZV1YzRUZ6?=
 =?utf-8?B?Q1k0OWFjaGhZTmVvYkdHSkJVL1VIWFV4anZPNFl4ZXd1T3NQOVZLSU40K3Y0?=
 =?utf-8?B?U0k4cy9iRVZFMDNmeC8yZ0V5aE9qM1pMby9OcEFCQ0FhNmhnZDVFOGFvcDhR?=
 =?utf-8?B?Mk5JdmJJYTZOZExES0JwVSs0aktpUCtaTjFTeENIQ2VTWjNneGhPOTVTZU5r?=
 =?utf-8?B?cXVId043ZngzY2dpMHpQTWxHT1MvYXJYVzI2OUJsUUcyOSszMDdmVWpzYUYw?=
 =?utf-8?B?ZmdST3ZTODNRdXRzQXZPbzZaZEJtMnlXcGkzNndQbVY4VnVMWllKdktHYUNJ?=
 =?utf-8?B?MWxSN1pIekNTTE9kcUhhTURBc2YrdTZDOWtieDZ2MmdwdVFiaHh3TEliR3dv?=
 =?utf-8?B?b0FxdzNBd0dBeDhDZjFMZm1PM3dqRzJOU0kzdFR0NnJCdU9OdlpjakNzUXpM?=
 =?utf-8?B?Q3lGRDlOMGVUZitJUnJldHRTYXlmK1p0MzNKMmJGakQwY1JNajY2N1VGL3lp?=
 =?utf-8?B?TVA4Ynlpayt0VG5yc05tUE9ReUdLdUkxTTM2UkR2WmYrSGZEbW0rZU1COUps?=
 =?utf-8?B?VUVaU1RNUlBQc1dManp0SWZEcGdqTHJndXc4a0w5a3BVRmhpMEp5SU1ic2Nz?=
 =?utf-8?B?UkdLc3NpZ3lZbU1xdFFpcnRWWWJJT1JRdDY1QlhrNHc4TjVvcE5YTnR1Vndi?=
 =?utf-8?B?UVdVNXRvU3pGOUJVL3BXaDhhSmJXc25pYnFldlE1b3d0YnZRR2hCSnZLQlNp?=
 =?utf-8?B?Qy9mZkpacXcwRFlORWplNUVSMTFBV2h2VXBtT01FS1FqbERTTGZzbllEcHJt?=
 =?utf-8?B?d3MvT2VqdGFWdFYzOEd2ZGRXNE5NdTFja1Vid1J2Y2tzS01DRlNDNUlEVHRm?=
 =?utf-8?B?SDFxUnMyc2c1NzQ5WWZpY2IvSTlpbHZNRERibkU5enpHZmtTaGFSM1lETUNI?=
 =?utf-8?B?cnJDY2JEaGdJSE9vYWRlVG4wYTlnNmVYNG5rZEFBTno3UHUySGtzNjQ5NEZq?=
 =?utf-8?B?NHZuWElHZHZ5dXRrRVFjOTU0Wmh4NDBPTFRxU0F1SU5VbUhWb1huUUV6Y3I4?=
 =?utf-8?B?MGFyanowRVJoSEw3V0pVSXAzdHJTMWdFMDVJRGNuOUlLTU9MS082NzBXaTVI?=
 =?utf-8?B?Rnh6SDlkdFBDQTlUNnpJUEJ5OU5BTlZ6L3JXTnFCUEhaZmtKeGFBRytaWEsv?=
 =?utf-8?B?QWFHbTNwSUhOMk5xd1JhNk9ib1pacFhVVnNNMjdZQWNNdy9Rb05PdGd6UkVs?=
 =?utf-8?B?OEFCajBKRVpxSWJSY0dnUzZpMzlQbUdRQkM5YzY5TDdFdjlsNkx0djI5VWlu?=
 =?utf-8?B?ck1NdHdncWNqbmMveVlabk1LNWZBWExQNGw5SkpvVWJJd2k4WVBMVVhPNkVK?=
 =?utf-8?B?OFhJS0Q1dmtxYWxZKzJxa3hQN2UvS1lxSUVDM240bTY0eXFqK2Z2Ui9pa0Vv?=
 =?utf-8?B?TnhtWVlGd2RLTUxsak91V0l4SkJpK1YvUzFlVmJhR1RSVjM0bVovUFMwYitw?=
 =?utf-8?B?K0w1MDJJVWRhQzdlclFCQTlUVUs3U0JKS3NJSmpJM1d4Y0Y2czdNcmpKR2FQ?=
 =?utf-8?B?YTA5ODA3UkRtZi96RjY5YnpWY3pEdE1oOUNENzgrZmpMOGt5QnJ4OFRtbnFn?=
 =?utf-8?B?ei9JS2tKR3h4R3paZ3JwOWtIVVQrZkNCRGhiY2dudjNFaHdOMEIweldBSkk5?=
 =?utf-8?B?S3M4ampmT3RSY002ZFdiMUJMeG52RkZIeU5pTU9wSjZWaCtreWxYWXAvdXZ2?=
 =?utf-8?B?ZlpiV01vT21kMW1VbjVpRUdWTU9vNnllRHhVUGhKZkhjekhDUVlCYmVsTmFp?=
 =?utf-8?B?NEs3dU1Pd1FYb2Q5VkNseGRNdDMrVkloVjNYL2dBSUpIalNKUFFnM3EzNkRZ?=
 =?utf-8?B?anBvZU9SdE8xSGRzeVU3dGhVR0MrY3ZJYVk3ZkxWcUhqS05EVTE1TXhLWGky?=
 =?utf-8?B?dXpPNHRML3ZJMFE2Nmx3OGs4L1VMeWJ6NEpDM2t6NlRxNzdlT093ckVtRzBs?=
 =?utf-8?B?dnphM1BoZk0zckQzTFA5NE01THd4TE92M01sSEhxajFWK1lNV292QmlYNFor?=
 =?utf-8?Q?jK51YtL5BIKgp2uSSTRl8pViS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b69ca5-7fe3-4cc3-65c4-08dd991e3bd8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:48:49.2299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdOKvvIHURrOR6kdzArTH7NN71zNcsJCPHnlyi6eLJjQXf4FfP2g4+hiHTukhXiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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



On 5/22/2025 2:46 PM, Asad Kamal wrote:
> Optimize get gpu metrics data function for smu_v13_0_12 to
> allocate metrics structure only once
> 
> v2: Free and alloc moved to same function(Kevin)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 6 ++----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 8 ++++++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 5a8824cc1c63..411756a2e79f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -322,7 +322,7 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>  	return ret;
>  }
>  
> -ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
> +ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics)
>  {
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	struct gpu_metrics_v1_8 *gpu_metrics =
> @@ -334,8 +334,7 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
>  	struct amdgpu_xcp *xcp;
>  	u32 inst_mask;
>  
> -	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
> -	memcpy(metrics, smu_table->metrics_table, sizeof(MetricsTable_t));
> +	metrics = (MetricsTable_t *)smu_metrics;
>  
>  	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
>  
> @@ -477,7 +476,6 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
>  	gpu_metrics->firmware_timestamp = metrics->Timestamp;
>  
>  	*table = (void *)gpu_metrics;
> -	kfree(metrics);
>  
>  	return sizeof(*gpu_metrics);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 78d831c20768..22dd3cf5a28d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2660,6 +2660,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	MetricsTableV2_t *metrics_v2;
>  	struct amdgpu_xcp *xcp;
>  	u16 link_width_level;
> +	ssize_t num_bytes;
>  	u8 num_jpeg_rings;
>  	u32 inst_mask;
>  	bool per_inst;
> @@ -2672,8 +2673,11 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	}
>  
>  	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
> -	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
> -		return smu_v13_0_12_get_gpu_metrics(smu, table);
> +	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
> +		num_bytes = smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0);
> +		kfree(metrics_v0);
> +		return num_bytes;
> +	}
>  
>  	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
>  	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 1ccc150882eb..253c1cf9f386 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -80,7 +80,7 @@ int smu_v13_0_12_get_max_metrics_size(void);
>  int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
>  int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>  				      MetricsMember_t member, uint32_t *value);
> -ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
> +ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics);
>  extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
>  extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
>  #endif

