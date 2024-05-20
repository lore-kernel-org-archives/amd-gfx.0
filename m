Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CAAC04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 05:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671D810E3AD;
	Mon, 20 May 2024 05:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5tUS4bEA";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246C410E3AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 05:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJWIs9xLH2HQ0ADskR+z8kFFHTQ4UeHpdKpbKSjojKW37htuE7cwHgLiQ9yj7LDtLgMYa9oLZ1TBcFbOA5KzttuKRn7NjJzfB9hXHrjQamYeOS2rjMT8IbTRyg9/FMPWWrzyGrmu0bq9JbvmCsZxKH+D5T5bNM6UMMGfAyZDbnsaHB920bjX0F5tRtYBifIYIhunGLivZ5uUNU/tdN3o2P1k4xYLn1q5f/dqvl0/6YTeuZvwkJs5pqhlHHfrN2Y+reBxb7NBh8NcqKdHds1Gw9xv4zTlzGwBwjezNFET4FR2TRdabj0FsaR29eqJXCTbXLI/wH6wSpT945czM8IsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfYtr6RMCmbmzek2MX/4SdRL6QZvfovLebhCrwsJj2U=;
 b=lwCM6cScxx35gYsnLbppecPOOklxnVwnxvSnhnmK29jzLiUnQxrOKumiGvqXppkLEHVRVx8Ako/oAnlINuQIGDs5O1iPk7dvf9DrgW5NVdHt69baK99lWzXM2Zt7YJyAiy7bJ6x/0yv4Gt6LTMN5YtJWVnKwCHGZ4GSNiWWZsN29h6gkzctWcbzQKR6PYTReBdDq5HSRz/eBtoDKoCPwOdiqS1FzgYnFMj/Rgch+MJYSVhRtEE7TGIzc21TBO7kxL59TM6DhJ3bWhwuCXpzgsAWfWD+f4H2HIqP2CIFJFO/QO6NfFxjjgyB1xLVioKL3NYsOuBCjRiwxjqzAPf+DbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfYtr6RMCmbmzek2MX/4SdRL6QZvfovLebhCrwsJj2U=;
 b=5tUS4bEAFQ/cm1yBtJytAUuh7OAe5u+j1qKfYDDHidQWOiC5N7Nodm5QEkUfFqiEsUoNexH7T4P9AB4YiAxUjasFLS/OQO4A9qercjrKGim0aD7hKDkR0qTrL9mvM2GmEudEjoWKJfDfNU6bJnkr4zDX7fX43bb0HtL2aIBkMpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Mon, 20 May 2024 05:21:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 05:21:56 +0000
Message-ID: <d56be2f9-a41b-4711-bbd1-b43e0ac8bc51@amd.com>
Date: Mon, 20 May 2024 10:51:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amd/pm: Use gpu_metrics_v1_6 for
 SMUv13.0.6"
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com,
 charis.poag@amd.com, Shuzhou.Liu@amd.com
References: <20240520050115.19806-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240520050115.19806-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c93456-303c-4e34-37b5-08dc788cc41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFU4TUU5SUdOaDRUZ1hxellMK0NwMkNoYkVmc240RE8xb1ZMOHowbHhJMWEv?=
 =?utf-8?B?a3VIakF6TTVXTFM3ZDNRVGkwWjV4K3UxZnlpd2c4RERtQitLVXk2NDZrOFMx?=
 =?utf-8?B?QzE4VEx2ZXdBYmJRMmk2UEdFdDFDemVpOE5QSHRPb2NJMzR6eHZIRG1kMUZX?=
 =?utf-8?B?aXNoZGs0VDgwR25KakMzSUUycTFWQTA2VXQ3Z1hyd2ZjSXhBYUtwakttWmN0?=
 =?utf-8?B?OG90TGJNTGdZc01iTE9CUjRKV3V6REtMRm1tc3pKUXlmNWxKUWtuTUQxaHJq?=
 =?utf-8?B?NmQrUFp4NjFuRERaVGNkYVNPU0hhMnJ4d0lWWEszbGJLQU0wenRJelZrZWY5?=
 =?utf-8?B?VG1pOUMxR1JxcFZFN3hPMEdINnl1NjN3R2pQVDY2QjV0aGdwck1FaHN2S1Z2?=
 =?utf-8?B?OXU0YjFQdDFyNWdRajVKQlVUTDdIMWZNQmpDQXNLa0VWZnZzTW43QnZoaldS?=
 =?utf-8?B?WkZEZC8rRENUaTViNEh1a050WHd3REVGVUlnSlBuTjdiM1FhNHRLSFhMTldq?=
 =?utf-8?B?UFFwQmFlMi9GcWdtRUhJUFdzWUVxWmRoZUhwOHduVTZESDNhMEprTlBLK1VG?=
 =?utf-8?B?cWRTZUJrdWV3R0k3UUxsaVJ1Vnk3eS9ueEIrVmRLSnBYOTV4UXBYRWUwT3cr?=
 =?utf-8?B?ZUovRy82dVJaeTZCa2xDQjBDOWU2R1ljdGZUeC84Sml5WThNSDZOcVR6Q3N6?=
 =?utf-8?B?ZlpheFVrdkhVTHAxSEZRcUQwS2MyVnRhSGhmNnluRVdVYUQvYnYxWWNIQ3Nt?=
 =?utf-8?B?THpuNjdVQzZEZEM1Y1NEQnVSQ3ErTkJXUkhYZ3lEazVobVVJblE3V2dyRnUw?=
 =?utf-8?B?amRGNVFDM3BGZ2J6ZWFKVy8zR1h1UXRwVE5QNDBLTEQwNmdHQU1OMVRWRkls?=
 =?utf-8?B?VjA3ZHhjaFZWYllQWnFJeFhLcUI0TGx3YWg2RVE1K0hCdWc1TFQ4TFdKVUJ1?=
 =?utf-8?B?U3kwa0pURXZYdEVGZzlwL2xUS2xHZ3BVRVpNRFU1Sys0V01mdVkwOGpmNWx0?=
 =?utf-8?B?VWlyL21JT254NGVlN3BKbDZyZEEvcm5qaFkwdzBGSmk4djhmVE1PZm1UTnRj?=
 =?utf-8?B?dWJNSTFDQnpRaUI2VGJubFEvL2lNZFRPOXQxVHRYSmpwV09USVVQSWhRVXRt?=
 =?utf-8?B?Mi9zWmZzVmdDMWVOUER2a3cwdmN4TzBOQWJxZExHOHBwVU1XZllJZ2RDZVcy?=
 =?utf-8?B?R1h6L2tJeVptN2YyTDIxMk9jbzZqWkdzdXkzYTg0U1hjSitvWDNkd0FKV0dT?=
 =?utf-8?B?NGtRQmxpSzhpYnFkaHB1YlFhbHdvK2VJeUJYbDFycnZ3ZkRITVlEREVzLzh6?=
 =?utf-8?B?VjlkWHRDS1l6TVJuMkdjRVByMUpwaXJ6WU5qR1plVmZIQktUTXRTdWI4K2JY?=
 =?utf-8?B?NHBPbTFTbUJ2dXNlVkFtUXNzdlFUdG1GR01PeTVBMW02ZFJLUm5KM2xNendC?=
 =?utf-8?B?YXZ3d1VqeFJFRC92L2JIcTRyWHJXUUpvQy9wN1Bnd3RaL1VTZ0s3dzRiU3JF?=
 =?utf-8?B?cWd2NmhIUFhYaW9MNUNhM2txbGdpb3VESFllV0FzcmlGVFNWYkVDdUljaHhu?=
 =?utf-8?B?VGFoY2FFQUxOcDZHWHIwUkJXNnBXUjBuaERyZEZieW5ibWlMcDIxRldEdERo?=
 =?utf-8?B?RVZyb3FlWlluc2RKcWgrcDZaWE9vSUMxQy9WQTZGc3hhZ2JPMjZhREZDd2pz?=
 =?utf-8?B?QjZtYm1vWFNGS29VUUxQQ0pVL050VllEWTF2a1B3YWdWSkIrS202S25RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1huQkJUNjhLVTQvYWZ0aFh1OThBaE43R0V3aGVXSE1xeno3SUJ5YWxHcFFR?=
 =?utf-8?B?WWVnc3VOa3dyVzFmWTdiYnYxWDNZZ2dON1VKNnFUMTQ5MEc2bFU3RkxRVXFy?=
 =?utf-8?B?Y1ZqRWR4OW1ET3oyY2xseXU2cUl4eC9iL1A1OFg4UHpSaUQ2eEd6S1RWQzZF?=
 =?utf-8?B?R2ErOUJRejdObFFOYjE1SkhHcFFOOHJVUFdaVGNnSXJiTm1NeHZzVmRGQm9s?=
 =?utf-8?B?dU1UakVWOUZ1ekZrWkQ4ZDhGVExJa01JQjM3VE8wMHVabVJ1Z1VTckhoSkhy?=
 =?utf-8?B?b0p1ZjhqdndHU05qUDNGY3lwckR3RkdXUVd0VE1SOGttajRROW5rQXNqUkQ5?=
 =?utf-8?B?OWdqaDNpbHRxWHVROWlQbjdCYUtPVlk2NlJHanVnZ3VTc1A3bWVNdzdWcE9l?=
 =?utf-8?B?Mkk2WUUwZ2NBSDFYODVLa1pLRW1SbWswQkRSUkhpMS9rWFhNWEt5TENpcC9x?=
 =?utf-8?B?TjJ4b2prdWVCc0czWSt4dlUxK1hFWEUzczBjcFQ0S200RTRhOVFOQTlVbWhY?=
 =?utf-8?B?VERhNk81NVdGSEYvY0wxUTU0QXFWeHN2djdtYnA1ZStpbUZUKzc2V2x6aWtl?=
 =?utf-8?B?NUxoVGhpRi9MK1pSbk14ZDJNVmxDaHFzaUhiMGhiaTlJdmQ5QVJFRUdvcFpR?=
 =?utf-8?B?YkczWFI0Z3B3VEpmWGZOZ01HaFd4allJejE4S1pIQXI3NWNHNkJ4eE5KRzNL?=
 =?utf-8?B?MTRwaXpJSFBpZlZzV3EwZFUzSituRVFvaUxSSGxGYjBxcnF1bzNpTi93Z3RH?=
 =?utf-8?B?MWVLVDJ2MmF5SXhHbFAzcGpSbkVTY3o2eGtHUVo3czJkV1QyM3B4VlZ6UmFp?=
 =?utf-8?B?WGJjZk5DYysva2p3YWUvWTB1eFpDTkhsbzNrdFh4dytpT1Y5U1NKcXBsSWJ6?=
 =?utf-8?B?Nnpwc2Y0OHZ1Q0UwZ21ldzZ1amE3RXRDMnpVdHZmbTRvWHZ2UDlibzRCUXNp?=
 =?utf-8?B?Ry81Z0puTS9WeDU0MDdkSlpNWmRsNEM1MmozY2U5WFcxSHFxbEJJZHF5NmJL?=
 =?utf-8?B?K2dFWEtpaXNJVklQNnRnNS9NN3dzelNLdEsrQnk3bXI0SnVCVVM2M0FJcmQz?=
 =?utf-8?B?QXlwcmVmR05POG9pNGlUdnRuQ1ZvZlJ6alBYcy9lNjNzVWdhZWwweHU1ek9x?=
 =?utf-8?B?Unc5Z0szTnhFMm94M0taL0s1R0FyQkF0d241QW40UnJ2K3NsVlRoZ1djUStO?=
 =?utf-8?B?WXhYMTU4WDU2NElxRkZiemw2cVE3VGhsV2J5QzlhSkdPY2U3bFowaEdzVlhu?=
 =?utf-8?B?S0JOb2xrZ3NRZnFsaE5MOFg5RnI1ZzRGK3lab001LzcwZmZmR1NaWk85Wjli?=
 =?utf-8?B?aVFmdXVHeVNJemJKTUprWXBHNzF2ZW5TMXNrV1lRajNFcDl4N2cxaHBWVHJ5?=
 =?utf-8?B?T09GNXM5VG5jd3hoNWpnbXZlcXE0RWtvZnl5M21oMFVoYjl1aUZHUWJQWFF0?=
 =?utf-8?B?dkZRN0dES3NLcUszVVNRaHV5TldzNkJETFJDZE9zMHdIeTR0dGR1OEZDZjlq?=
 =?utf-8?B?cHdyNUhKcmFWczdPWlJ1VG1CQWFuc1dHZXZObE83THBVYjlZVEVaYitpeWw1?=
 =?utf-8?B?R2p4T2htQ09ZMHpGclhuZjdBN0ZLNVNnWjdTK1VBMHlLNVdHajlacXhnVUQz?=
 =?utf-8?B?bDNPNVc1SWJrY2pTNVIyUWRoaDdYVjRBbmlhVkl0WG9jRDBwbDVmYWpTUlpQ?=
 =?utf-8?B?dmwvTTFCUGFIdE5NanJRMGxnSWwyZFoyZVc2bzVacE5GdTVTTTBhK1AzRTRB?=
 =?utf-8?B?NHM3ZTlrRWhucTE2Mzh5OFVZOG9IQStSaW85cllOK2FOSGtxSVZVR0ZkZ2xG?=
 =?utf-8?B?eEdTVWR6Uk5MUXdEbzJTbWJJWVpqVSszajdzT1p6a1hLNzYralBVbzlWRnIx?=
 =?utf-8?B?aEVzZmg3YlppTm1Nei9WZzBVOVJPZk5HMndkR3ZtVGVDelFpQ1RKZDV5bGNU?=
 =?utf-8?B?OXZRYUVWZ0FRSG1IN2swYmdIVkg2bDZaWVl1V0R0dVlnUElTUGtXZDdpNUg0?=
 =?utf-8?B?WVlrdnkrRStUd1lkOFlCNlh4Ry9BQXJidVZCRlZLUWtYdTY0RXowWDVWems0?=
 =?utf-8?B?L2E1Vkt3dktyS0ZXaFpsbGRLOXBhOVNFS0tKU1VlTVhTWFI3TFZMN2M4cjY0?=
 =?utf-8?Q?soo+viEJKhEd+yAHVZKJDQkC1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c93456-303c-4e34-37b5-08dc788cc41b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 05:21:56.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX53VxXl52mR6RT56gKyk7AWkRQHyYGda4rOPirvDeqP4+dYQS0HesMQMGEhcW4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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



On 5/20/2024 10:31 AM, Asad Kamal wrote:
> Remove gpu_metrics_v1_6 usage for SMUv13.0.6 temporarily and use
> gpu_metrics_v1_5 until tool support is ready for it.
> 
> This reverts commit e6efb71ae640eada28f44cc97aa79e8ae4901e63.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ceb2174baff6..81a241ed18f5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -351,7 +351,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
>  		return -ENOMEM;
>  	smu_table->metrics_time = 0;
>  
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_5);
>  	smu_table->gpu_metrics_table =
>  		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>  	if (!smu_table->gpu_metrics_table) {
> @@ -2290,8 +2290,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>  static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>  {
>  	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_6 *gpu_metrics =
> -		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_5 *gpu_metrics =
> +		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0, xcc_id, inst, i, j;
>  	MetricsTableX_t *metrics_x;
> @@ -2307,7 +2307,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  
>  	metrics_a = (MetricsTableA_t *)metrics_x;
>  
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
>  
>  	gpu_metrics->temperature_hotspot =
>  		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
> @@ -2349,16 +2349,6 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  
>  	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
>  
> -	/* Total accumulated cycle counter */
> -	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter);
> -
> -	/* Accumulated throttler residencies */
> -	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc);
> -	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc);
> -	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc);
> -	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc);
> -	gpu_metrics->hbm_thm_residency_acc = GET_METRIC_FIELD(HbmThmResidencyAcc);
> -
>  	/* Throttle status is not reported through metrics now */
>  	gpu_metrics->throttle_status = 0;
>  
