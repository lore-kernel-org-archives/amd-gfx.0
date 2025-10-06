Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEA5CCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED6710E434;
	Mon,  6 Oct 2025 16:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Y/M4c9q";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F0310E42D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH++MSxLmHduAmJM7fJm3bcrago85RHZaZQ+PIB2xUDIZ1Y+C2jtvMg1PdnsUXtJ9pGoy0LFNfoDxzI6CHYinaSzbn6GWX7lTbQOiQySOS60G1035OLXbtYBP+HitFkoA7P4r6ihZKZmAujxJJWeqVLrKcHnGw7Ugz1ORtO5VCK66J2Af7pXgLPaj644IW0Gz2qGJqADW12e0TxNvnVLcgf3MdfcXbj/Qf351t8nwIYChnJoxvDbkNPmON7tDBkAj6V6qwIH0s91N62JY9/3YSZkwSaXVeTGZDx930VYxg8aq11vn44qeRcSYcZB+3iG1CbNP3wIQ5FSa0QfV9RR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQGOjMACB6aBekipqDWOTAsDYovNAsGsXJJQN/UAo84=;
 b=B5RVMfXWdITrBgmpeIpCymlY0Tp0CSymgLbs0U3OlJMs5rILMaoWahdb+B005wB6LoLlz1aRHyTFSLkwXJ8l8CqsxFCBqZPpxd7k7gC5CQdYuI80cC+GgfxtrBGHSCIJHFhQMUxPFkfFTJKUMi/ZPkYliSX5HShtW6j3zyW4Zy2icMMEJO7LGTL5VCQLzA/deegnCjnfRmEFI6t+mZjgFMQ5D8JAuNgbW+9Ys8lTA0bGY9E0Fj/uMmCaWDPnEMIlyElVqJrSzEku3zbleT2B996mbWmVrD6exqR07Og3xSfur1FPGCtgK4L9Wo9GaCjwYJ8OKIG8NbvbaQqaXX/O9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQGOjMACB6aBekipqDWOTAsDYovNAsGsXJJQN/UAo84=;
 b=5Y/M4c9qp48/YdpwoVh3VAJg2q9HQCPHUNl0G70ahDYB+kkw4wnXD4XLu2QEy3WhnAq/3FSMdcjAFHAqu52TBpNGRd5/49lOFNG9u4m0mcMPQ3ELbP6y8TXCvCgxtgrxYbZMcGjZ/F9dYD/JmVw1BC1640kNBwRi3NF3K5xxLtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 6 Oct
 2025 16:41:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:41:13 +0000
Message-ID: <2a9d9931-9967-433e-854f-33f2c888c9e8@amd.com>
Date: Mon, 6 Oct 2025 11:41:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm/amd: Stop overloading power limit with limit
 type
To: "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>
References: <20251006163138.17489-1-mario.limonciello@amd.com>
 <20251006163138.17489-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251006163138.17489-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 7047cf9f-549c-4ad9-7bb9-08de04f72920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEw4MjJ6RUcrWUxPcnZrU1dpeU1WWE1Lak5TTTZRWVk2emFLWDEwclIzUFp3?=
 =?utf-8?B?QjZ4WE9FR0lLWXFYS1JTTjlnRHZzU25xWHErU3VxYlU1UFYxc3NsZXRXUWVs?=
 =?utf-8?B?alRzb0xMSVljSzBqRlo0WGZOQW5aUFlJNVk5QXpFdEZXTFY1dDlJK01BSmcv?=
 =?utf-8?B?NlprTFgvREorcDFoVHBISGZOYmI4Mkh1YXpIQU1LOFRUVi9EKzA5TWtUb2lB?=
 =?utf-8?B?L3p5NDgyVkQzZUhuTFBzU09rOEp0MEdhbk9VOHhiWTRiaXZTSFZUR25BWDAz?=
 =?utf-8?B?aE5xeGJjS0VjVzMwM2ZIVkhQUHU4MDA2eFVxUFlpU1NwRUNmdXd5Qk1lQWtj?=
 =?utf-8?B?UTBJK0kyUWNwY2MyYndlYXJzRXhYNisrdjV2bGFkTmF4aEt1QURVVUJzd0Zv?=
 =?utf-8?B?ZWV1MzBtNWJnMTdkWERiczMvd2hXRVg5ZS96UHZ2TlpXaTRENTZkc3JGTzFh?=
 =?utf-8?B?L0daelBGdjlHamFOYmhGM25wVEl3YWt3TGdRaWk3WTV0UlFjb3g2NjljeXZw?=
 =?utf-8?B?T3grNVZCSWpSUlVPY0ttWjFMYzBOWWdhOE1xTjMrM2JNNzYxWGxUN0hVcVpm?=
 =?utf-8?B?cWtNRUJjQW5mTStjRjlZMTV4aG9HTnNhZ2hJS0oyVFpzNEFzZ0V4c3hERmhV?=
 =?utf-8?B?aUNEMkxUTFJkTTdpM3VDbVJBUUhNK0V2OFd1OVRzdUovQTY2VExtUXpQakVq?=
 =?utf-8?B?Y3BQVlhKMkZqSzA0VGduWC9zdlZhUFhOanZrL3UrSDZTMW01djVYdzZ5bFN1?=
 =?utf-8?B?LzRqcHNCNGg0KzU0Qk1ucVQvUWhucnRJWGpRQmJBWGFGcENxNzVNOUJGM3Uz?=
 =?utf-8?B?NHRreDY1NU5KdldpZjR3QzZ0bDNteVc4ZDlFZWxFNytMOE45NWlRMUVlTUJ5?=
 =?utf-8?B?RlNJdTZlZWdMaTRQZ3FrSFl1ZDVOUmo2VnZsYkFHRDZCWGdGZmxSeEd6NDBV?=
 =?utf-8?B?YSt2WDhWVGF1UFhkaXJZK2hTVkxLRWh1ajdQOU9aUGI3VnJaZ0lMbmo2ZVNI?=
 =?utf-8?B?VW9wL2FWNk9hMjdacU1NS0g4RUllaEV1aEd3N0pyVC9FNXJURk56S3pIc09x?=
 =?utf-8?B?eVM1dEVONHN1VnRjVXRQdWVmU2lvazZ3a3JWemVvaU4xdXFGYUJqWUZyRDZ3?=
 =?utf-8?B?QVc1QTJnbTZsR0tXR0txaS9zN3cvcTBCWVFVdlpYYUY3Z0NveG02bXlBRHBX?=
 =?utf-8?B?SmVKRmpwV0VsMmhiaG01THlZZzRrM1ZENk41Qk5ldUJkY1ArWldRYkZ4VGJp?=
 =?utf-8?B?d0lRMHJWait0cFpvOWF0UWVmRnY2dW5Fb08rTFlrT3ViRmxpSTF6d01nYW5J?=
 =?utf-8?B?UEI1bjBBTkhYcStnbnVCbzBUbHEzM0tGK3E4R1JUdFNLdXBZb3VuTFpUcUdw?=
 =?utf-8?B?Vng0VzJiSXhsK0tyaGJ0TUdHdHVqMkFtUXVsaWQxbEt0QUErcDgxZGVVUmtZ?=
 =?utf-8?B?ZEJiM0M0aCtaWHBMSHFRR2RMclR0Yngxb003d3lOaXZWSVdoSWZPMzVicjBS?=
 =?utf-8?B?djdJZGRXcEhpd1JSd0ZmMWdYbnBYVUE4OGJFRzhMc2J6b3pRNm8xODJCRHp0?=
 =?utf-8?B?SjFMT1FmcWllays3Q2V4c2Mxd1d4OXZabjNVdlliVk5VK1AyUnRhREltamxW?=
 =?utf-8?B?OWd1Vmdib1NJM1Q4VkpnMTZxekRrbUZxVEpiVDBxUVgwbDZGOUJmVDJGTnh0?=
 =?utf-8?B?dkt2bkdnZTNuMUV6VXFrVHVFdnp4TjZzUExsUFB0SGplamtwclMyQXlrVG1Z?=
 =?utf-8?B?L05aY3NkNEQvaXEzNmsrV3NKVmg1WkdQcjVBUWhYT1FLMHhQZnIwOVhhb3pJ?=
 =?utf-8?B?cGVtTlJCaXY5OHBjTFRETkR6VDFyWTVsdWxkcWkvbU1Ta1NGVWdiczJvQzdT?=
 =?utf-8?B?c2VhcUMwN1ZjU3BHNnNoZFFwQmRIZFAxSmcybjJJRGhSR2Jzd0kwSGZqQkp0?=
 =?utf-8?Q?VGDkSePGNCibqotZ1+6VDjIpJUKxzeao?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lqYUpkRk92RndENllhMDRLMlNvc2s0MXFGSm9rR0FQN05WSDhSSFBqbTdK?=
 =?utf-8?B?WTNkSkY0ZmJjU0hqZHVLa21lM1J3aWQzSzBUV2c3L3NUTDJMZE5jZ1gzSjlB?=
 =?utf-8?B?Y01tRlU4anpPTm9yNGoyZFV6WnZtV3dSb2JDQkZWQzFnaFA4V050T3FVTXlI?=
 =?utf-8?B?a2FWMEozYndwdkRVKzB4SkZMcnJkdVdHNmlMK0Y3RTAyQmY4TkZQWGJWZFB3?=
 =?utf-8?B?YmVzeFJpeE1LS1d1YTZBN3BjMmZSRjcwR09OOXE0dnlQZ1pQNGkxNmhoS0Q0?=
 =?utf-8?B?L1FaK01DY25iMEsxZUlUS2dpUzlzU2hyaStkM2cxVGFzYVJmRWpGSjdKTHJp?=
 =?utf-8?B?QnhRbkR2R0xHeGNieXNTLytlRlhwUmJSQjNUM2J0TERZcU90ZnBrQk5hU0JN?=
 =?utf-8?B?dkJ1N2o4UUxHNlh0cDJhRVlRM3hCU3AvRjBiMklzZGkvYWVsbks3STN6Slov?=
 =?utf-8?B?Vzhrek5xbUZ2NkwrTUlMRlBQZmdDTENPeHNZeUlCaDAvQitTWnRhUE9waFRC?=
 =?utf-8?B?aU5rUUc5N2FWQlorYmV3clUvejJmWXZ0ZjJycGNJMThSTlBBSFlPYXlpMnd6?=
 =?utf-8?B?bnJsQ2U1OC95VzhwT1dEOEZSdjNzb0Y5eFJDRjNIV2ZXSXN5Qzl0eFVOeENt?=
 =?utf-8?B?ampwSllyZXBlclo0NU05TnRYWll6L1MxeVVtdThRL0hQcU5tTENLeUtVZ1BM?=
 =?utf-8?B?TGZsUHlyOThyejdURDRyaHMreGJqYnZ2dm45anVpNHpHY0UzZHJqTHVJSnVs?=
 =?utf-8?B?UWRxK2RQMXFqb2ZpU2pRVlYrMHdEaHBkdDZxL2N4Q2V5RXZsUlNUV1J5YWor?=
 =?utf-8?B?Z2d2eGdqbkJqNmdNalBzQ3R2eG9WRVJ0VzdKVWNhdnJlZ3I3UkxmbEp6YWQ5?=
 =?utf-8?B?aHJ4anUrS3ptbDZka255VHB1WnhyV0plQ1lTZk51VkN6dmxiRGU3a0ZMTm14?=
 =?utf-8?B?U1JBUHYwWFgyOUxsMkRHSmJQZXh0R2Ftc1NpSFIybE1obmtYSHk1VWVUMDMx?=
 =?utf-8?B?SmE3ekdBYlMvako3T3R3UUZRWU5hZHFWWGh2UlEzNEV6VGR5aGVqeGsyU1Fy?=
 =?utf-8?B?UWZ0ZnhaRGhaaDg3WHR6UUJiRGRkTmRiUzEzaEllVXloZ3pJcGNtYTMzcFRp?=
 =?utf-8?B?NFBhRklJYXl4b09XY0JIaGJNYzc2VndEY05icVRQMFhLZkNUYUwxREVvblds?=
 =?utf-8?B?ekVCNjFjRkpKRkJ6YU1MeXc2elhuZXJxUFJEMDFodmxJME1WQVdiMUxWRWZY?=
 =?utf-8?B?YThtUU81QXZzOFdINDRDNEZRTXBON0h2V2ZxN2FjKzdUUDJFVVFXZ0RVaGxr?=
 =?utf-8?B?VEJBUnNmTW9HRndQb25QS1JLc3lheXpjK3c5cmp2SUZuL29lYnBKT252TXpG?=
 =?utf-8?B?RFBHdE9ML0FmSVFFUDRNU3dTbXFjWXdmRGI1cW9iMFFmc29mTlJsOUxjU1pr?=
 =?utf-8?B?Y010RjRtOU40ZUVLMFNOekVnTnhSbDVLWmVrdnpBbGdhMDZJWDVKM2ZYN2ZZ?=
 =?utf-8?B?Rnk5M2RwVTJQZzlLbUlMR2ZoSUhZWE02aXhXM0pPSlE4VTgwR2hPdk8rKzY4?=
 =?utf-8?B?bUgvcExJVnhqa0VLeVdrME1TbFJqRUx0bUk3cWwzYndiMktvamxwU29RKzhh?=
 =?utf-8?B?WlU1K2VOQ2JERFp2bmRTcm51R2ZyS2ZNZ3pJcHUrYi9Za3AybXN4OGxmTkpF?=
 =?utf-8?B?SDJzT0I4a0FsZGVLaUQ1WG9md3pVbzF3SGhXTzVDaDNERWsxTURmdzk5dllx?=
 =?utf-8?B?bjVrN0cyRUJ5OStySG1heldiY2RGT0RkRjNlZWpqSWdURTZjTEFBcXdMdWw5?=
 =?utf-8?B?N3NDbE1zRGtYVGdDZGs0Zk8vczBLcm4xckVVU1JmR09jN1V1V2xaVWNvZzNW?=
 =?utf-8?B?dW9Yd0NLcTJHMjFsNEVQaTlrK084RHR0K2lvdTIyMUhMZHRFcUk4eFgwcVlW?=
 =?utf-8?B?c1ZhNzBCcGlpdE5paWhYUGZCL0JOOENTVlpUNTY3K0I4Y1pUTmpwTys5S3Nx?=
 =?utf-8?B?NlZYa0FRYnRwcXVURXlHVXcreEorSVVuVmI1M3Q2cWJ2T2NNSk5tR2hZalla?=
 =?utf-8?B?bUJzbnBHQ1NHVkt3VlIrellWRnpQOVpVNW5ObmFObkZLWm1NT2Y0Vk1VbVl1?=
 =?utf-8?Q?OkwyXwAEFsWFjiok3aGouFrlc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7047cf9f-549c-4ad9-7bb9-08de04f72920
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:41:12.8921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgAu1Bjak9iBXubqTYGUCxg61H2O0YAyHEPyQTyViobDSecAdQNSo5UHqJSCzFRqi7hb4f6fpkhcv4aW/1psEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
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



On 10/6/2025 11:31 AM, Mario Limonciello wrote:
> When passed around internally the upper 8 bits of power limit include the limit type.
> This is non-obvious without digging into the nuances of each function.
> Instead pass the limit type as an argument to all applicable layers.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Just realized that I missed moving a hunk from patch 3/5 to this one 
with the split.

❯ git diff
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c4459dc553f0..1c5f37cd5b75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -510,7 +510,7 @@ static void smu_restore_dpm_user_profile(struct 
smu_context *smu)

         /* set the user dpm power limit */
         if (smu->user_dpm_profile.power_limit) {
-               ret = smu_set_power_limit(smu, 
smu->user_dpm_profile.power_limit);
+               ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, 
smu->current_power_limit);
                 if (ret)
                         dev_err(smu->adev->dev, "Failed to set power 
limit value\n");
         }
@@ -2258,7 +2258,7 @@ static int smu_resume(struct amdgpu_ip_block 
*ip_block)
         adev->pm.dpm_enabled = true;

         if (smu->current_power_limit) {
-               ret = smu_set_power_limit(smu, smu->current_power_limit);
+               ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, 
smu->current_power_limit);
                 if (ret && ret != -EOPNOTSUPP)
                         return ret;
         }

> ---
> v2:
>   * split into two patches
> ---
>   drivers/gpu/drm/amd/include/kgd_pp_interface.h   | 2 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 3 ++-
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 3 +--
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h          | 2 +-
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++----
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 -
>   7 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 2b0cdb2a2775..87814c2b526e 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -454,7 +454,7 @@ struct amd_pm_funcs {
>   				bool gate,
>   				int inst);
>   	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
> -	int (*set_power_limit)(void *handle, uint32_t n);
> +	int (*set_power_limit)(void *handle, uint32_t limit_type, uint32_t n);
>   	int (*get_power_limit)(void *handle, uint32_t *limit,
>   			enum pp_power_limit_level pp_limit_level,
>   			enum pp_power_type power_type);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 518d07afc7df..5d08dc3b7110 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1616,6 +1616,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
>   }
>   
>   int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> +			       uint32_t limit_type,
>   			       uint32_t limit)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> @@ -1626,7 +1627,7 @@ int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
>   
>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->set_power_limit(adev->powerplay.pp_handle,
> -					limit);
> +					limit_type, limit);
>   	mutex_unlock(&adev->pm.mutex);
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index b5fbb0fd1dc0..6bdf185c6b60 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3390,13 +3390,12 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>   		return err;
>   
>   	value = value / 1000000; /* convert to Watt */
> -	value |= limit_type << 24;
>   
>   	err = amdgpu_pm_get_access(adev);
>   	if (err < 0)
>   		return err;
>   
> -	err = amdgpu_dpm_set_power_limit(adev, value);
> +	err = amdgpu_dpm_set_power_limit(adev, limit_type, value);
>   
>   	amdgpu_pm_put_access(adev);
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 65c1d98af26c..3bce74f8bb0a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -553,7 +553,7 @@ int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
>   			       enum pp_power_limit_level pp_limit_level,
>   			       enum pp_power_type power_type);
>   int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
> -			       uint32_t limit);
> +			       uint32_t limit_type, uint32_t limit);
>   int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);
>   int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *adev,
>   						       struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index fb595a70bbd1..76a5353d7f4a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -952,7 +952,7 @@ static int pp_dpm_switch_power_profile(void *handle,
>   	return 0;
>   }
>   
> -static int pp_set_power_limit(void *handle, uint32_t limit)
> +static int pp_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   	uint32_t max_power_limit;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index fb8086859857..c4459dc553f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -68,7 +68,7 @@ static int smu_handle_task(struct smu_context *smu,
>   static int smu_reset(struct smu_context *smu);
>   static int smu_set_fan_speed_pwm(void *handle, u32 speed);
>   static int smu_set_fan_control_mode(void *handle, u32 value);
> -static int smu_set_power_limit(void *handle, uint32_t limit);
> +static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit);
>   static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
> @@ -2958,16 +2958,14 @@ int smu_get_power_limit(void *handle,
>   	return ret;
>   }
>   
> -static int smu_set_power_limit(void *handle, uint32_t limit)
> +static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit)
>   {
>   	struct smu_context *smu = handle;
> -	uint32_t limit_type = limit >> 24;
>   	int ret = 0;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> -	limit &= (1<<24)-1;
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
>   		if (smu->ppt_funcs->set_power_limit)
>   			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 2c9869feba61..81077a3969e9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2399,7 +2399,6 @@ static int vangogh_set_power_limit(struct smu_context *smu,
>   		smu->current_power_limit = ppt_limit;
>   		break;
>   	case SMU_FAST_PPT_LIMIT:
> -		ppt_limit &= ~(SMU_FAST_PPT_LIMIT << 24);
>   		if (ppt_limit > power_context->max_fast_ppt_limit) {
>   			dev_err(smu->adev->dev,
>   				"New power limit (%d) is over the max allowed %d\n",

