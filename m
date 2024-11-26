Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A36D5A6DC
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 03:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A6510E056;
	Tue, 26 Nov 2024 03:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="frcP5hcb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9F710E056
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 03:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5IJ7GQXcMDXWZylv4YphSUXzT6SNDO9Dt1q7MsJNSgbJ4K9aNU7xcJQR1dLfPqvNaXRGfISvGjAtsHjq3WX0KhaJT8ToZ0sp7pZZa3ew4GxpTFjvgjxbnn23M74wyRQfYYwyE+GHARQu+7iUA3htnrdgwL1QkcSCSLAF9OBM727GQrJ/KVbuGJ9FG1g7U1+d0qHjuKT1KurHOOQRs9XzaIHk3TNjKcvN29VfGeN7UCYV8gP+ngkhzT4c/MnWmhXRdB55KMovxK3zoXvs9fDskOpjTzNIbodriP3NyAaJJNn/cAjtRGknwnp9IOAEikB6FX0/5jM39F/ZXtmnxO/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ/ksNLOXuqQ9Uf5I2RYaSl6f0DO4BznL/skW0Efeqc=;
 b=jYXRUWw7zFrkN5ipcWtXTYuiZEgcDZ4eLqqvPeRxZZ1TgJ/+kE9K6hIylm2rd/G3j313UTrTCYtnNqcGET5K9ZIl5kDMGcb8tis8L+n6MFWljQj129C6tV29zWBgGa0jcjOOxTtxIW0Djgiyo/YQSPIaK8LfBo7YuRxpluMNWR69TL0gaFNQ+SqoArC+NvnaT0LPPA9C02aCKO+SzX0xrqCpcpzsT7D2AHe1M7Qfw1V6PRB21ON0AhBcMdjXXZazZQ+hrJDFJBC6QywyXODRIgrytaSaQKqbZuHFuHp0pjAKnJxeeyDRu1BCkIirL6JT+aDF+c+b+wciPWm6s13FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ/ksNLOXuqQ9Uf5I2RYaSl6f0DO4BznL/skW0Efeqc=;
 b=frcP5hcb+KvQekC9PwWJ6Vy552PGUKC7Gk8/5vgcrqwLeG5ZFBsyDbLEaKwyShW/P+bZ9TOz6ZScMmlHdYOqUqQ0TB0uguUL5b4gIl6vTYtkan5VeF+OHPPAPW2BOR8qkzwMaMsD5emT6+2LkVmfcTi39LiUJc3G1Xb7sYi37l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.21; Tue, 26 Nov 2024 03:56:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 03:56:50 +0000
Message-ID: <c35f08ae-4c1e-430a-8ff5-1ad5e3503078@amd.com>
Date: Tue, 26 Nov 2024 09:26:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: Fill max mem bw & total app clk counter
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20241125143826.2022148-1-asad.kamal@amd.com>
 <20241125143826.2022148-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241125143826.2022148-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe4b91e-a257-45bb-73a9-08dd0dce5b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1kdU1xTmJtSHdLRHllKzFPU1RsK3BnVkNFU1hHdUJZd3RuUlZxZVRPUkFZ?=
 =?utf-8?B?K09WU2twZEJsUHlkVGxsUmpJM2RoTlBUUDgzUlhRcmpoUnRLQVdDdUZjQUc4?=
 =?utf-8?B?QU1OSnM4NlVMVjJLWUdBMnZzc1J1UUlGaDYwNlluTzFsMEZRMlF5dnNSNkR1?=
 =?utf-8?B?cEVpeEc5dVlMWWdHdzgySnV5VVdvR2FRN3ozNlp5RXBKTWx6UG1EOWpwRzhj?=
 =?utf-8?B?Y24ycjA4dnlYWkxiTVpJSmFVekJoYS90bzZjcExrSTVTV1RiMml0WCtHR1FH?=
 =?utf-8?B?dE85OGNPTnI4Y0haQnNaR2VrSEVoM0wybUxmQXMyVFhBY0M4dXlYYTBTbkpX?=
 =?utf-8?B?T0c0Uzl6b0dBYktQVWVMU3Q0SjY4K1RTMUxjejcxYkxLb1RhTWFVb0owdVl2?=
 =?utf-8?B?NWNjZDZIYi9xUTZUdjB2dTdNTkJZVHVxakt3TjBzUmYzS3d1alZqYzFtSitD?=
 =?utf-8?B?SUFFRUUyY0NLamdLY1FvYlFFZ1k0Y2RQeDBGbm4zN21XTVlWb1ZLS2hlVFlZ?=
 =?utf-8?B?R3EydzYvNy9aR2U1Ti8zMzM4OGJTTkJ6MFNDbTdHS0dxd3RZYUFSeG9HVWda?=
 =?utf-8?B?ai9kMWtUdEtwbkR5dUxFcm5IRGhWUUJ1TzJRYnhwcElrZzRWcVZYbUdlVnBV?=
 =?utf-8?B?SXlYTGozL2JRMXlFQlVLVUNvQUFiallnNTBlRHJTblR6ZHdZUW0yQkUrYUJo?=
 =?utf-8?B?Tk11V3JIQ05qdUw4UndWZFZ5TlVjelM5T29IU0pnVXRMNE4vSjE1NU9VSFlZ?=
 =?utf-8?B?Z0FTTmRMUUhIQklZa3JnL1cxcDU3cUhNTHNiNEJLdzVmNkI0WDVCREVmRCtR?=
 =?utf-8?B?NGtROGY1cVQ0MTdOTEdmNlpzalpVZmlHNmdzTVJPcXQ5bHp3L0paUmcxSmYz?=
 =?utf-8?B?cVd3S01XZFlTTER2a2hPNDREamVMazFjY2ZNTnhySmtJYW9DRjhsQWdRZkg0?=
 =?utf-8?B?bUNYYmZBVXdsUlVGeHo5a2xhV3MvTG8zbmsremhKYWlHQ1ZuRnZwUFo1aWx6?=
 =?utf-8?B?QnNvemR1WkRvVmVMeEx6Qm4yTy9UTmNVZXQ3VnNMeGw5em1LUCtKdm5WdkxF?=
 =?utf-8?B?Q25MbU1vSXZSdDQrYkVZZFg3ZjgzUG82V1dIQmVEZWo4ek5rSFBwSE9TZU1x?=
 =?utf-8?B?TXZoZEdkd1dCQlZiRmVSYkwvK3U4TUZzYXFBQTBGdVJ0bzE5cnE1dUNGeUNu?=
 =?utf-8?B?dnlxdmx6Nk5OeS9zRjlVcExWYWF2WVowbGxhUlp2dEtnYnEyd1V4REdJQll1?=
 =?utf-8?B?SEh6eGsxOEsrbTI2b2orMjNZTjgrcWVpT0l3OEhaZHdWcXExUlh3TEtXWUQr?=
 =?utf-8?B?MHRnTHc4aWJMYUFvS21kdDdrUUpnKzZCK1FlSkFhMjJndUk5UlJEWGdXTG15?=
 =?utf-8?B?T1F6Y0dQSWdNd3MzWllIaUdTYmJzajUwMDJacG5rZGxCMUFKRmVqQ0g0WUhw?=
 =?utf-8?B?TWVyYUVzOTRXUXUwL1VNOG9BZkhzNzhISDFLNHcrazYyZFA1TmZ4cnFWNmd5?=
 =?utf-8?B?cG0xdjlHQUtoUUlOZFlyTXBlYUtyWnZrTE5FLzZRNzg2bm9hN1cxVW42THdP?=
 =?utf-8?B?cVp4djFKRkpnVm1GRnMrcHVUcysrMEhxZnd4TmplY0l5ZHJsOEJSUHhUdUJ3?=
 =?utf-8?B?b3FhWVVNajFLbXJVbHRRM3VNWm5YaXQvOWVnbi9YazA3MjNZSXBKVDdjS2o2?=
 =?utf-8?B?c25KeVA2YUZkc2tzbWhldndIeGtIRllmYkhwOG53SEFSd3FUR254WlVGSnRJ?=
 =?utf-8?B?ZEVzbVl2R0FJMk5uVTN4Um1sY0JOTDQydzdUWTZQbFRsTzUrejhlOHVWWmh2?=
 =?utf-8?B?TTUwai8rbHI5MmkrYmpqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Q5WUd2dlhxS2dZWTdwa3ZNc1VUdG40UVpOTmx1TTJJak5pdDNKNGtSdHZp?=
 =?utf-8?B?MFRlQ3A0ZWtoOU1IdVdOei9aOFVBb1BqVnhFUFEwc3B0TVZydmV0NmxtTFJv?=
 =?utf-8?B?UHA1K2ZVOUlId1hBZGhhOW1YODBzRklGdlJoZWJYZ05kdmlrY0VqL1RWL0RK?=
 =?utf-8?B?WUcyTDNJWENhVlV6Z2E0TzBWNStoRzJTNzRucVVmS1J0N1dGZ3d5N3V0OHF5?=
 =?utf-8?B?KzJUSzIrcGlwbUlOWDBWTmJOaVVvL0dNUWhxeitBeVVyd0VVSmZ5cmtTYWpp?=
 =?utf-8?B?ZktsMGYrZlVPUXJZeExTOGZ6cGMzYkk4V3UzMWJLdjRreUtZL3l6YTFzeE8x?=
 =?utf-8?B?MlRCeDByTzNuNWVObldQZ0RVOTl4bHVENDRLZUFDQTJxVHVJYkU5S3lQSzQ4?=
 =?utf-8?B?Ym4vVXFTTlRYaHBOa1ppMkJYYkVLV1dGN24xRzh3N3ZDazhUUTluQVZvbjY4?=
 =?utf-8?B?dmN3SjA3MnB6ek5LM3Q4UEtza0tLem9wTjhlSzN1WFA4K25kT2gvNitYSXJN?=
 =?utf-8?B?OSt6THR1b3FzU2h3VjVQb1RrSm1uWWJicjIrbUVkMzFzTUpieUNvK2haTEVv?=
 =?utf-8?B?VUhaNENQQ2RSWGJ5QU45OC9wMWFZSFRGcHFQTE4ySEF2aVhYam5MNy9HWlRZ?=
 =?utf-8?B?NnJabW8yT1ZZTVd0eUc1eDBOdXRNZXdPL2VhQ1hEdVVXQk1BemRzSzZLR09Y?=
 =?utf-8?B?YlV3a01Pc1lGdWorallsMXNtUEROSlFEQloyVzgyblNHdzErOGorRzlXRXVi?=
 =?utf-8?B?RkJrTy9saXRDN1JsdGlobmFCQ3A3NElrZEZPYmp3YVppS0gybE5Sbk1wZUxu?=
 =?utf-8?B?UERIR0pSY3VkVGdHWEZydkptMVk5NjlTU3V2MFBua0tQNXZubkRqS0pFMlZl?=
 =?utf-8?B?SnFrK2JCSU03SVhPWkJZMVZJbVlxM0x2VXJzaFFvbU9YMkoxamNMSy9jYVFI?=
 =?utf-8?B?azFRUVd4RzYyeHU0eGp3T1ZFV2FneGxTZEdiMXZvMEdiT0ZNQVNFem1hNnVN?=
 =?utf-8?B?eHY1dHRERWtoVDhsZVNHNFUzVzg0a1RuMWs3QzcweGx0aXFydVVFZTQyQjNx?=
 =?utf-8?B?N256QStUcXMvZmFEVGlDNDdrTDh1bTdubU9BaUVLeWxNV0IrdmdGZkVUTVZF?=
 =?utf-8?B?S1NrdlF5UjZiSS9QTklGTWJ0dzI3VGh0b1R3Z0JMamUvaXFJbmEwVFJxV3lY?=
 =?utf-8?B?WWN3UEs5aERxS3ltSXM4N2RBK29hN1VwZFdrdGEyRU5xZ040WVVSTHhuZzBl?=
 =?utf-8?B?eHBaMlVtMTZnWVhIeW81MmZIUWY5WG5YVit4b3NNL1hhNFNYVU52eUxEaHZo?=
 =?utf-8?B?UFd3M0lyWWlLdWZvWktWRDNNam1hUXVFSnY2SEEwc0pzNUNkUHpGZk5zN21z?=
 =?utf-8?B?MDVEbURZL0xnSm0ydXlTL2R3dFQ5OWR1aWdjTi8vb3A5eGc5WmZ1ajZOQWFB?=
 =?utf-8?B?Q0syUk1QSnZUUjg5dlk1TUJsaU95TzBQQmZWcThFbjU5Vi91SGNKNEZrdGxk?=
 =?utf-8?B?S0FJbG5RTitZWnZFazU0ZDRJOGtScU9WcnZtU3dNKzZsQnk5VGJGajZMQ0Yv?=
 =?utf-8?B?Wk04cmZzcE1qa0YrR0dGWDAxMGkzUXcwL2dkaWZmT0xhWHBjSGh3MFd4RDg3?=
 =?utf-8?B?WEtCYkNTSXVDbXJlK0xHL1FuWFREYUc1U0Q3dzFzU0hXcUpGQUc2a2tVS2hY?=
 =?utf-8?B?OW50T25CV293TCtCcGQ0YSszUUUwNUFLcDBjMytGcnVPcEpPaTVsRzNtRlkx?=
 =?utf-8?B?MjRWdTNJMXVzYm0wMEF5MkowMEhlNVlWUm9RYlNyUmtoOWtKMDRjbEQwZzJp?=
 =?utf-8?B?ZEtOb3d6b0tXdTh1cUhzcVI4aHQzWCsxRm95L0Z3d1VEaFRKTy9ha0lIZ3RC?=
 =?utf-8?B?cXl0RVMrWmZSRHFZbkQzNzNZT3ZTWXZlbi9HMlB4MklQdE5RcDhMS3k3MXNQ?=
 =?utf-8?B?U3VETU1KQ2c1dXFiTURTbG5CdXBjRmRIUFNWTDFUVkUvSWxuZFIwdWptaC9K?=
 =?utf-8?B?TExxYkdIZTZuRmtkcjFqWGpLdTZjQ2xoZlhrWjZSejM3NmpkeHFCRjdZeU1Q?=
 =?utf-8?B?NkxyOGlnUVh4b0lpOThEbjlmMG1mTE1LMy8zN3c0bE51c2xjNFd5R3o5Q2pT?=
 =?utf-8?Q?lQOjOsZa9bhjrpLrNMBE8MPOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe4b91e-a257-45bb-73a9-08dd0dce5b33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 03:56:50.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhxzNuUvoF6zZa5PNBKCoksvQhVj2Y3S6RYsCReVX06SNXTJfBM/zqiwX/zCwM3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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



On 11/25/2024 8:08 PM, Asad Kamal wrote:
> Fill max memory bandwidth and total app clock counter to metrics v1_7
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 34 +++++++++++++++----
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ab3c93ddce46..e77fa9dbf404 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -119,6 +119,18 @@ static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_context *
>  	}
>  }
>  
> +static inline bool smu_v13_0_6_is_blw_host_limit_available(struct smu_context *smu)
> +{
> +	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> +	case IP_VERSION(13, 0, 6):
> +		return smu->smc_fw_version >= 0x557900;
> +	case IP_VERSION(13, 0, 14):
> +		return smu->smc_fw_version >= 0x05551000;
> +	default:
> +		return false;
> +	}
> +}
> +
>  struct mca_bank_ipid {
>  	enum amdgpu_mca_ip ip;
>  	uint16_t hwid;
> @@ -2318,7 +2330,7 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>  
>  static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>  {
> -	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
> +	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst, xcp_stats_xcd_fill;
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	struct gpu_metrics_v1_7 *gpu_metrics =
>  		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
> @@ -2356,6 +2368,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	gpu_metrics->average_umc_activity =
>  		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
>  
> +	gpu_metrics->mem_max_bandwidth =
> +		SMUQ10_ROUND(GET_METRIC_FIELD(MaxDramBandwidth, flag));
> +
>  	gpu_metrics->curr_socket_power =
>  		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
>  	/* Energy counter reported in 15.259uJ (2^-16) units */
> @@ -2465,6 +2480,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  				(smu->smc_fw_version >= 0x05550B00);
>  
>  	per_inst = apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_per_inst;
> +	xcp_stats_xcd_fill = per_inst || smu_v13_0_6_is_blw_host_limit_available(smu);

I think this modification is not required. Under the existing per_inst
condition, only need to add smu_v13_0_6_is_blw_host_limit_available(smu)
check and fill the new fields.

Thanks,
Lijo

>  
>  	for_each_xcp(adev->xcp_mgr, xcp, i) {
>  		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
> @@ -2485,15 +2501,21 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  
>  		}
>  
> -		if (per_inst) {
> +		if (xcp_stats_xcd_fill) {
>  			amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
>  			idx = 0;
>  			for_each_inst(k, inst_mask) {
>  				inst = GET_INST(GC, k);
> -				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
> -					SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
> -				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
> -					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
> +				if (per_inst) {
> +					gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
> +						SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
> +					gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
> +						SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
> +				}
> +				if (smu_v13_0_6_is_blw_host_limit_available(smu))
> +					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
> +						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
> +								[inst]);
>  				idx++;
>  			}
>  		}

