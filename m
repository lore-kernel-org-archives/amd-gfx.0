Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F748CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 20:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B87510E852;
	Wed, 22 Oct 2025 20:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNEJjka8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D0310E854
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 20:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFexqCBwc1+xYgB4aAUtnJq4FhY2KYklN8X7c6YaCVn1ASgHJJHV/cIgEXi2yKKhg/kDRyU0HLvjOGkBVWx6ngZoeNCX1RVqdqSK7pFywOhQtA/8N2K/zDgc9H06fnxgCkkI13KkoVBWUDo6vhe9kMeHyGjwLYHkvDgZ7XdkpIj8cA2W+VYLOAuXNl5hcv5KXXutg58K9Y5eC+iFBcffKHBlw25gMWgZ/WKbVpwj+ip5FTHdmFX+eYGSe8buLrbXy3+jxfu1vWicWI6AsQ+R7vvPY7p4uRHj4weGB3wBIp16PIH1So8ddI5B2WkJYSjArPuEoxK5v1haw981N5KTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmiTlrxNIln2vuzD5PLwjy/RCx9YRPKGqjHi3Z4sNeQ=;
 b=o0whl3oLkGLQEmYkU/oLgVyjRaHylKymyfl4TIR9HV392dB7KZ+R0bT76TOmTQPNUcOc/Uc0Ps0dWvIT6EEpsr138S73wA5WSwKW0rQXHHhtg92UlijAZQd1ZIROiwG449XqtxBS1weJMoBhQJ4zk2Kn1MEfID/EDW1epOqLVlYbIV1MwjoFQPHcCcm2LU2N4ig+OrusitEcWeZvMenWHYDsAJ5dRhzK6rtAxy+XWoT0lyzfXvi05gOZ4c8E1WQCRMQ/U2oqZzFgoOS9BpcqBDdZrkbocsGrp/CCYdxo0iF9DU7Dszc7shPxpzUzIzyJfO1aP5PKdf1np8z1/mgghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmiTlrxNIln2vuzD5PLwjy/RCx9YRPKGqjHi3Z4sNeQ=;
 b=CNEJjka8AGaREalpNnmJd8Fhhq1R+PMHHxEk9p8+fdVFGukAkAwlgvXMqHQMjTpgH4UaUUl94edm74OsDCqzt6Hwll1rglN+MMpckQK7ZMlzvk33snv9zzlEjOVndG8D2Wzp8ZgjDKQQK3Lqp08+Z67LmCzWt0u1qjxj67DLFUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 20:48:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:48:22 +0000
Message-ID: <212aae51-34b9-4700-835e-4bf25a8d71ed@amd.com>
Date: Wed, 22 Oct 2025 15:48:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: fix SPDX headers on amdgpu_cper.c/h
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251022132334.977886-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251022132334.977886-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:6e::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 030b33f4-d2cc-41c4-35ec-08de11ac56db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVVKalB0UUJETkw1aVYvZUVNQ2E3eGhqMTU3d2E1cUp1T1RxSmhxTGNSbmhv?=
 =?utf-8?B?RDFWbmExUXdzNUVuQ2JEMDFHc09XZEdtUjAzRFFoRWJqcitqcXBKS3Jsd2ti?=
 =?utf-8?B?RFVvRFJubzN3QTR3alFPNEhYS0R6bVNobEE4TUhHUjFUSlcrT3Fxbm9UalRI?=
 =?utf-8?B?d2g4YjFwNyt4N3gyNFJrWDlWZ1U5QTZ0K2xvaUUzN1NBeldpRE1Ba2pkRWhv?=
 =?utf-8?B?bzlWY2tDdnVTNTV5NW43TjF1SW96aXdqc2RvNjhSTitCa0dwK3QvRWtFZzYy?=
 =?utf-8?B?TUxjSXdib0lMa2RkcU1jZ2V0MzNld1FyN2lnOGZXdUdPS0FRNVNoNm12Vktl?=
 =?utf-8?B?UVBLM01kOVgzTWtNZ3JmZ0ZFK0xYb1krcGJnRy9OdktwYko4UjQ3VFVrV2V6?=
 =?utf-8?B?dzJTa3RtWWpQU3owWC8xQ1ovODllYWF0YXBBM25uMlRnYnlFTjJ5R0d3ZGh3?=
 =?utf-8?B?SmlHeEpYbVBvM2dmZm1hYzRsMmJ1cUkwRVIzRk5IZlFrY2UvSWtXL3dIMy9p?=
 =?utf-8?B?ck1YTkxtZHFwenYyN0ZObDBHQ0NsMG11MzZZcldrdGdiMC9ZZENsZ0loRUxP?=
 =?utf-8?B?U2J3MUx3YWVLaHRaOEpSUkl4TDA0YUFKMER1R2VkV25saDVDTnplMDVER2lK?=
 =?utf-8?B?bDdXNkpISTUvUWMzUHlLTzZ5UGcwWTdjUTlyYjNFQ0NkODk4dTVhYmlmRzlz?=
 =?utf-8?B?TEFWRGlnRGFaaWQvYlpCUHU3aVdZdWJ6S1BSNlJzUmNWNmZCWTBaUjcvWXhz?=
 =?utf-8?B?WEVPaWRpM0tEcHVJdlVIWUZlYk5IekhqV3ZzQWhOcThCQlh4VVlidkgrQjJM?=
 =?utf-8?B?ZlR4T0ZtRDdqYWpYd1Evc0tLVXlvRm1UUDcxaUoxb0R6Q09sT2tXOTUvUkQ0?=
 =?utf-8?B?Sm4rNkRRYlVhaVF3VCtJd0IvdHppOW5ZYjNkU0hIWmYvTXVLUVBmcHBxSHFK?=
 =?utf-8?B?akRzWEc4bzVETDZWMXRJeE9BWlJEY3pSeUdMeHd0bzRPaEhkb2pvbEx4NWxv?=
 =?utf-8?B?ZFJlTUFoRTV0L2Zva0JBRms2U25mMU9zeEpGVFpnMnVuMzduUXFGU3NtYmw1?=
 =?utf-8?B?WnNhcndGaU8rUzhuMXJyT0ZpNDZuMi9JYW5BbWpkc2dtYXY0SUE5aVBJRkRo?=
 =?utf-8?B?bEtuUlFYcEhIdzdGK3h6U1NYLzZTVlduY0tBNWJ0a3VUNHBhY0ZtcUQ1WmQ3?=
 =?utf-8?B?N2dyNHY1UFhHMmpGb0o5MGJhOG9uRlVDSjFjMGtRcEl6bUhSMWlxc2RlWHBj?=
 =?utf-8?B?VVJsWjhYTFZRTFNwSXpkMmdOaDlnTzdYMStQQm1GbDJ1L045RDhZZDZrYWl3?=
 =?utf-8?B?N2NTN1p3Rlp6V3kzRldrbmtJQThqV0VrWThIbUZFVEZkRFRVV1BQbDhZVmxB?=
 =?utf-8?B?OWlLSmt5Y1BNdGN4UWVTRkRBZEF3ZllIcjRCRVZOZGlROVRlZkpOSlU1d2ZF?=
 =?utf-8?B?cEpoaXVXNUZndVBGQmFCUFFMRExkcm0ybVdabTB0STFlT01naHBUN3dDZ3ZK?=
 =?utf-8?B?NHVlRmptdkx5MmlMdjh3anFONFo2M0paQkttM3orbEpyRmw0WURaTGN1QnJi?=
 =?utf-8?B?SjBOYjRnQWdwaTRoemNXclJ5bUI5dElaV1JsTmVSNWY4K1dOSjBMWVdTY3dF?=
 =?utf-8?B?ZFZhc1d5V3B3OHlNM2FkbDA0dnlraFlJc3F6VjZlM29nVTYvL0NGcGJpTEIy?=
 =?utf-8?B?N2twNEs5Ly9uSVRqZ3A0OG8xb1lXc0wwZjI1a0JjWUdRTjdsOVIrMmtvOXlX?=
 =?utf-8?B?bnIxWTR2TThIQVdvdGt5T1dSLzd0NlFyRUhaMkUvcXVaN2VHR0dmWEJVYzRP?=
 =?utf-8?B?WGR6NzlubTVZdUZmNnpVWWZQMHY3ZnpqbjFrM3FHaE9HdDA1NzVkK1pUR1RX?=
 =?utf-8?B?V2NFd3ljeFp4WmdRNVdEenZxdjE5N2kxRHJKb3VUQUhPTWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDhmbjZMaytGbzZONFgwdEcyZnRiVTcxa1VDcVpvdWxybjZkRlpibld4d3Zw?=
 =?utf-8?B?VjJtdVB1WGV5clJBWkk2azdQTmpBL0hzVlI5MjdlZ3pkOFJjK3RUY3hXdXFP?=
 =?utf-8?B?RnRCcytnVy9WdkkwUTZ5YUYyS2dPalQySHlBYnhpWkgyblg2K0RJdy9VS2p1?=
 =?utf-8?B?U3dsVjEvU0V5RmV5aTd5VHZsWlVDeVJ1eDBhSFNoYlRJZUkyVllnayt6WGFG?=
 =?utf-8?B?M1J6alIvaGowMWs0aVlWUEppWURLczB1eVk4OGV5aHlibGlEOUNxZDBoYUk2?=
 =?utf-8?B?WjVKZ2t5YlBxOW9JM3RnbnpXK3Zmc1Z0eERmSWZmMDRCUWJEbUd3U3JrSTYr?=
 =?utf-8?B?d0xKdm9sNzhhSFRIU3pPNkxOc25PQ1BXcklQK2dTVytKZjFuVTZCWlVkelhV?=
 =?utf-8?B?NldESkx3Tnh1bTBicVh3MUhrOWMyL0E0UDg5bVh0UzNNQ0JCWHVrcHB3VVIw?=
 =?utf-8?B?ZEZtd0h2Y2lIYUJyZGpSM2R0U08yWXFFa0F0UEJRYXRZU3pCWDhmOFZhZUdi?=
 =?utf-8?B?VmFyYk5lcFczd0oyNzBHS2VYR3ZLSHNpM0N2bFQ5WFZXUVdkNXIrY0h0YVhG?=
 =?utf-8?B?cG5zdE9rZlVhMEVTZ2JDeXlnaGVlQ2lIMGo5LzBaZTV6d1RLbjU5REgzYVVC?=
 =?utf-8?B?bEZ6NGF4ckNlbVZFTi9Xb1BxOWxZZkErV2w0ZkQvN1dwT0Q2ZW5yVEZWSTVr?=
 =?utf-8?B?U0hpOVNLR2RhQVl0VzhpUWhwNitoTTBIT2todVBIK3VFVlRzdW1oaU1ZdW9Q?=
 =?utf-8?B?QWIyVWRBN0FKU2pXQnJONnhjelRuUk1uVHRnR1oxWFNsRk9SS1UvNkZ0SmRI?=
 =?utf-8?B?ZGVWTGFWeWRLeVZiMGNPeEJCbEZlSzJXZFZrNmRhSjlrTlRLclREcGFPaWUr?=
 =?utf-8?B?WW9TV1lmdHpnSnI3UDMvUWFRbEJJZUR2cjcrdmszMVIzRkE2M09ObWNEZzVx?=
 =?utf-8?B?R1Zja3E0WHEyVTVoYVlSZDdkdDZYNGNndUFrSGtPTFJvSHV0ZTBBYXB0OW5r?=
 =?utf-8?B?NjlyeWpQU0xzRFZ1dmdMVUc2c3NVQi8rdDVsdDJiS0kwdWxXRGcyMGptTnBQ?=
 =?utf-8?B?MWtWQkNLS3RwRE11RVJsWURZaTNVeERUWTUvK3loc2VhWi9mK2FNSE1sZGR2?=
 =?utf-8?B?VHMxeEZsWWNTSS9iZzUwL0F0WnV6TTFHSjdGT282ZWdxUHdNTDFOMlBSOWQ2?=
 =?utf-8?B?SjNSK1ZZanllUUJQakM0RWhUdWdXbHlNNms0UDVKSENCY3RrN0c0akF3elRm?=
 =?utf-8?B?Ky9zcWEzK3F0M1JMWUtrLzljdGlsU3hPRXFaTEM5N3ppcWd2U096SlBqOHdG?=
 =?utf-8?B?K1ByVTRsZEhDVFhqWlNsdDlFbjFrRnVXdEhndnJ3Rjk0V240blo2clFKVWJh?=
 =?utf-8?B?V3pQallpeDMzVUJsWUY5dDdHNnVLYnMzelRYVzR3a3R4QjR5S2pxd3o0QzYw?=
 =?utf-8?B?OHFyVXhYeFNBQ3EwQUtvdWNMS0FPSHhmTThRaXdPTkxUT01DQlNqNU5qUDd1?=
 =?utf-8?B?WHNyQ3EwanVFZ3ppVlR3WGR4QytRK09HMEFZUit1UHpvQVJ3RWZ2cmlDWlRh?=
 =?utf-8?B?ZEpJY2ZPSVBSL1Vid29RSnVxTHRxRjViUGJUSGJhMmUxb2kvWU5JL3Fqdkc4?=
 =?utf-8?B?WTk0UnJJZURPV2Fuazk3bWNqWE5tMUROY2Y3dTNWbUFTUFlTR0E4NFZiRTZV?=
 =?utf-8?B?Yng5aGdmdHdjN1hrak96ZTNoNnJSMW93OEUvVVI4bkcrV1lwbHM5bHBZa3JW?=
 =?utf-8?B?VG93blpWOHM1cWtBUEZPYXZkclJ3V2gxYXg1cE1aT0F0VVM4U21RTk5sQzNV?=
 =?utf-8?B?QTVxdloxekcxUUNKUy9WRUh3ZG54R2dqcUtDNlh5VVd5Y0dRdUJpbnVSeGx5?=
 =?utf-8?B?by9SN1NMK1BkcUlzbnVBdVg3cEZDUzd6YThPOUovS0RpbTVuY0lsN1lFa3FR?=
 =?utf-8?B?Uk5VRmxPaEdWK1IrSzNSckUraDBZd2V4SFRCcFMvWEg4UXZsK1pLUVZOU1R4?=
 =?utf-8?B?VCs5NDg1SlJoTTB3QVZVSjlYZ2s5RWluZmlEbHREWVpUMkR1WjkzUVdkZ21s?=
 =?utf-8?B?cTQyYkwzVHBBL0hwRmlRR2c3VWpCQ3dIb2laWnFiNktKTkNaSFp6VG40clVh?=
 =?utf-8?Q?kz3gCNmp9+qeTxw5EeKNAFb1r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030b33f4-d2cc-41c4-35ec-08de11ac56db
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:48:22.5010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z2ooMvQE18fQES7wiwmmSL24Qa7kdpIxdYAX3xzFVAGzVo7GyCmWg3u6P/Gv5ZlcEwH0Gp6UwA5JkFcyH37gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

On 10/22/25 8:23 AM, Alex Deucher wrote:
> These should be MIT.  The driver in general is MIT and
> the license text at the top of the files is MIT so fix
> it.
> 
> Fixes: 92d5d2a09de1 ("drm/amdgpu: Introduce funcs for populating CPER")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4654
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index ef996493115fa..425a3e5643608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: MIT
>   /*
>    * Copyright 2025 Advanced Micro Devices, Inc.
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
> index bcb97d245673b..353421807387e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: MIT */
>   /*
>    * Copyright 2025 Advanced Micro Devices, Inc.
>    *

