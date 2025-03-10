Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2163FC282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 19:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E9D10E4D5;
	Mon, 10 Mar 2025 19:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9E2NjAo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070B910E4D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 19:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etn9Jg0aZfhb94dckUh6IoqzPHhxPL1jDckw9LAyZFRIHU1gzywx4CT8PVm/G4m6bDkgWvlOgX6HlmJnLiDFbmBeNty0ht6mwxqQM/xuLF83FBekguWs9Dh3AefSUZVG5cXSsFppK8p/ZHSxpDZIuYaLD8oK2bKBpn99Qi3lyeG+gQ4jlbKEWlX3rALT8otME+EBtVmgai/vYLpju9XB/wRUez/zandsP5S9Xf0BXg08+FjsptQFgrZdHhoxdhAnmebeuTz5Kgep3wtcH5w0mgsJn/RA0gLfvtPm/+2rOPO7cQLWB7WWfLqld3cY7D27kVAV4QhjlK7jl2dccIEz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irOxV/dGg/V7Ld+/azhzGhKezRS2Rc3YuojK2Gts1/A=;
 b=Jt2+PcQdZLEFCb4ST6JrMwSJZflvM/0EDclPZteEtrBD6cFvcaIL1UsAirp1TyocoJH6UT57fbAAgLvnyildxQgjBUK8RLPh7Yy+ACIqzppMZSYaEsOIUpXDKvEcE5sgWe3LyMlVjaw4ZiTxg64CzLcyLmwijFxTlgwteuVdx5wMsrU0yzlRrV2v8uTMLNDpUf/iTk+309pu+4e0VzSRDJidv2/pVJw7a3ai5gFtnAZ2qDJJPu7ul/ZDB5GNsHFZgTDNtFrqxW2kpuBNogFn7xpTKm1wPPDmStT8axTerncWTWaLlmWQsq08WogrcWgvoQ06w9iEMljenqamFlGleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irOxV/dGg/V7Ld+/azhzGhKezRS2Rc3YuojK2Gts1/A=;
 b=V9E2NjAokT6Ex4SEMYYqPtucT9QkMyp9nEiDe7gL1dwdrWkMU3gCPKPYfLCa4rNITmMfS5MCugHbPHKqBjBV0LA7Y9aaKeOnYyoMDI6PbQyVaczfGS1D4/eOB1G4/s01NyXytMQO/DIrvfIUotfW/sT+02a9C7PzQcQZukUSIT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 19:46:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 19:46:14 +0000
Message-ID: <846317ef-0db1-42e4-b2a3-ed02baad5263@amd.com>
Date: Mon, 10 Mar 2025 15:46:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org
Cc: zhenguo.yin@amd.com
References: <20250310030103.709524-1-Yifan.Zha@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250310030103.709524-1-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9982b396-4bd1-405d-11b8-08dd600c3761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFpQWTZ5T0NCQTZrdDF5VW1yV3BpN2Y0dG52eC9NeTlkU3FKdzd6VjlkZG90?=
 =?utf-8?B?UWo0SmlJcUtUMlRpTjB2WlB5Z1FFVFhTNWR2bTBBSjFBWlB0R3RjOFBPeXdR?=
 =?utf-8?B?VWRWZmhFcjh1dUlzWkNyeEJyUjVPTEpjZVhmOTY3K01xMmRySksrL3Jmd0dp?=
 =?utf-8?B?RVh0QlZvTlJrR1ZNL0JXeTB1STNOZTQwSVJWb3F3WkhXdit0dzMyZFNzM3ZO?=
 =?utf-8?B?ZXJLdmp3SW4vMkl2eFAyZWQxWENGYWhybk9pNmg5S0dUWnVtRndwR2wxNTdL?=
 =?utf-8?B?eWNFb1hVREpYSStLSWsvaUpwSXlMUnluRW5WeDgxNTArYzk0VVZzUTRQWElE?=
 =?utf-8?B?azFaQkJXTHhRZjlKU25qaW5QdXQ4NTdydFYyNmtmMnE1MCtaWjdaQXY1cGFL?=
 =?utf-8?B?MzRZZE1VVWJsejc2NEVmckErK1MyYy96dFJsMEQ4UmdGNnZ3SG1hdHZLN2VG?=
 =?utf-8?B?NjdYNmU0MW84bGxmWHpZYWpWcjBHL2NqWXJOMTk0d2NYQWtacUZNM25IK0xj?=
 =?utf-8?B?ZXBVS3FHZlptTnlBTGU3dldkaUpLS3ZReWhSWHdLbHRtaVB1cFdGQVdoYTh2?=
 =?utf-8?B?b28yQUhRWnBKNGVNQjdBZG5QZUd3dkpoMC9PakdUZG9PSTl2cERzdnQ0aEVD?=
 =?utf-8?B?anpKMmZtNkpjT0RKSG5QdnV1eEE1QlhITGVTTThneHVtR051d091OHRCelBP?=
 =?utf-8?B?dmpWcS9wOUJyUjBjZGQ0R094RXNRbUtOdGpxK3Q1MnpjQVdpREppMjdQKzJu?=
 =?utf-8?B?Mi9iWEdNN2xsZEVoK0pkYlRnK0s1bkJubFpNWTAwbW1VYzdRTUNWdHJNbXgy?=
 =?utf-8?B?S1ZJY3piYjhWamt4SjhkZkFPTEtWUXhKL3FrZVI4Y2J2WWVtVURIcG01dmFD?=
 =?utf-8?B?R0lmZld2R0JMZXlBdVAwR1pwTkQrZU84Q0ozQW5waHZDZlJSQ2U0YWVIV3Rn?=
 =?utf-8?B?NkxYY0hBMWdESVJFMFNYRUlzVGhLWEJvUUg4WUl1L2hMZDVIT0FRby84SWYy?=
 =?utf-8?B?Z2pHdlJCNXpoeVY3Q2tHNitUWEFTckdHMDV1VFR3OWgxTjhZOVZEKzFqb3A5?=
 =?utf-8?B?SkRVeWpZUW9jejVNZWRDaVpqZVJtamhQbHpJcmRjdlQrWk1FMVZQSjUzaVR1?=
 =?utf-8?B?dGsxSFVmZVFhQU9RbHkzQWl1aDBYaXN1VWNTQkx1VXdRU2xkYmZZQlpFc2w5?=
 =?utf-8?B?bjRBcnQ3a1NSWnIrSndNZ0taTEFLaEI1VEQ3MGR6YVdpNUtVSEhabXozNitr?=
 =?utf-8?B?Z2ZNa1c3ajBkSVc1TDRlZ29LYnloWEh6WU9NVCtYTlk3akdCQ0VxNUNkcVJS?=
 =?utf-8?B?TVlZOWRpNm1MenJEaXozUzI2SG90ZjZHZmFyWExWRTVvRDBBY1lBNE5XU3lI?=
 =?utf-8?B?UFhFaXMrdGwvZEc5YmxMdkFkK2VraEZiVGdpc3hucXA4Y2dhTTg5ZWpnamZv?=
 =?utf-8?B?dWJQbGZseUdhUlFSWnR6RFo5WDJRUmU2TWc3bTRPYUs4dkY0MDZYMnZJRHVz?=
 =?utf-8?B?c3pRZXgxd0sxMHVOZUpSOEJMNHBQTFoySnJCMDI4dTFDRmI1MnlZcEYrM25o?=
 =?utf-8?B?amtmOUhkK2RqRHo0Mk5TVEFDSUh3UGhnMElUMFVQMDYzWmdvM2NJS2NLZWVv?=
 =?utf-8?B?MHh2Qi8vRkJDWG1iMW90U1lmV0tIVk83djdHeGZiRHBwMURLRkdMazNsV0Zx?=
 =?utf-8?B?V1JsV0txam9tQndoaHJrclk4WFJPZ0M4eFphMll1TmpaSTk0aXNubFl3bjRy?=
 =?utf-8?B?aUZPM3FPVlpsMkp1bXd3V0txT3ZUeUU0cXR3QS9WWW9iMG9kQlhGa2ltR0Qz?=
 =?utf-8?B?N084K1J0bmVpRzZKQ0c4YzlzU0NRK25NUGZCU0w2RXJtTTUrT2kzWUYrVi93?=
 =?utf-8?Q?9HhBIKFK3XwdI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0VsMHdJdWFSQldiUFVuSlJ5VjNTU2R1MHN3elVvVXdiR0o0U0xOMExiYzRT?=
 =?utf-8?B?QnZ4ZVowMVFUbWI3SHZDaUFMUjRpMTU4RTRPQlc0YnhmSW1lNkFHY01lTnVh?=
 =?utf-8?B?aGxTT1ZnQitkM1M5cFRXWlhDMzlkcGpIZ01FL2pSbHd2azBkek9jQVN5MVpK?=
 =?utf-8?B?NUtaTXRONzUzdUpYSHRDbnFTUjI3ZTVlNjFhTWdHRlJneXB3LzhsdFRDTWg4?=
 =?utf-8?B?RWdmMllGTFdEckkrNTZiNVpCUllDL3NlTXlQaU94Mm1jZkJRNDlWUzQ0TlVo?=
 =?utf-8?B?NlVPb3Z0a29ueGd4ZklEeWJjY0ZDVnJIQjJqbCsva3JtSFBMZ2FDR1RZTHlw?=
 =?utf-8?B?Q2tySGl1R3VZN1BsSG1vU3Z3c2pCdGViMklDQVJzOEMyYjRqQVR3UDJtY0Zr?=
 =?utf-8?B?U2hZM0dmRnlsQ25seGlpdEFYY1g5VGgzSlBSd0N1WlF4MkhSVTRPa29iT2lp?=
 =?utf-8?B?MENSMERGVm5IVzB1OFhhYTU2YnREVHNSbjNHSkl1WEM1YS9YV3V6NkhkaVZB?=
 =?utf-8?B?dmJzWVUvR0E0N2ptMlQ1OXdFekZNL3BUUDlmNDBpaFlzK2lQcElhc2tiQ0Jy?=
 =?utf-8?B?UzNQT3FnakRsM2wxamViRms5cDNnRVdCRVZveVE0dURwaTBjREw0SjlCOUdk?=
 =?utf-8?B?eWJDa1JIZmVsKzI5L0UyRnhneU1FMlBKRE9yWkQ5M1JTdmdQZzdYVzh6dmNT?=
 =?utf-8?B?UncrK1pxaVk4cmpFZmdhMHpjUkYxVUJHNWl6SnJ3dXdtQUlQYkhzY211TlE5?=
 =?utf-8?B?RkNiL2RXbWRNbnliWWF0ckJCd1FqdGlJZ28rU2ErUVRVc0Z4YUdZRzVCb3h4?=
 =?utf-8?B?dzBzYjQxWGZCZU8vRmJqYmhlYmk0dXNmSzNaZEllbWpxZXphdXZwanVPbTNM?=
 =?utf-8?B?RDdzUHF1MGZyQk1ScmcwWXV4TVFRY2gxNVJjdUdBTHlXUWpVVld1WU16NVc4?=
 =?utf-8?B?a3lnaWxqb2ZVNS9VWDVod3dnOVg2R0pXZituYytZM1JBRldDWVpFSXp5NnZn?=
 =?utf-8?B?WEw1NHJrWEJUMkEwWlVLSXhSMUpTNTdNa2dnMjRQMTFGVFpIak9LclBFOVVH?=
 =?utf-8?B?emppS3oweExlZlRETzcyNFVzbWFuQ0VOcG1BMC80czFVS3B1UEFRTVI0Z3Rw?=
 =?utf-8?B?OVdnTXhZcGZBQm9BWGVVQ1gvbnBnTzN3OUM4VEJwR3FXbXN3UnFiSk5jMStS?=
 =?utf-8?B?Z0JrN0ViSEx6Q29QbVMzQ1MxNXVFVEd1aUJzQ0xaR0lFeVVhMjVZTnU5R3VH?=
 =?utf-8?B?WUxUdXUvUW80TTN1NVlzeUxhYWdVcnVzWDQ5Nmk2YzNPTjF5d0xEbWI2cjdy?=
 =?utf-8?B?MHk4bXYwUFJnV0JaZzlmNVZSaVhMUU5Ta2VmRGNDcW5VaVdOWlA5ZUsyVkRl?=
 =?utf-8?B?UFVoVXpSUFk1VG9RSU5lUDhZQlRvQWpCeVZBUG1qU3llUVJQRndsckgyQ3Bu?=
 =?utf-8?B?aHdDMlBjYmdXT0lJY093K0JmMWRmOERnRktJdVcyVXcxbzZCaHc2TDBWeGhB?=
 =?utf-8?B?c1NwU0tXK3RVZVNtMDRxVVRpSVFObGxKS2x0VVJNRktjMGFxWmp4bHdyMHpZ?=
 =?utf-8?B?WXl0S3ExVTB1QmhyVzZnMzJFd2dsUlVMUHlVTWVLWGd4T0c3OVc1eW1HTElN?=
 =?utf-8?B?cjBTQlQrb3llN0dVZXpOZ2hjSHdSTTJ1Q3I0M2tpMmN6UHh6OWdBQVZsb0hY?=
 =?utf-8?B?WVhydnBwRDJKc2V2Vm52ZTNpNVNRakdBOUlnNVlFMGpnVXVoTVduZWYrQlNn?=
 =?utf-8?B?N1lQdzdiK2Z1UXVGS1o3bXNITmVJS2JrN3VmYWhIeWZTSksyYlpzcktMaU1B?=
 =?utf-8?B?azRqRWxxRkg4VUtzWGp3YWdENllrMk5KbFN2c1FPNk5SYWZjaHBjNGZybEFB?=
 =?utf-8?B?Z1hlb05HVnRTWEhDbEVmQm1Mb1RHbnJwUU9sS2pDYURBSDZ6SXNsMTBlMzlj?=
 =?utf-8?B?c094MHN4Qjkxc01TSmNMOU9FQ0dTMGxpUG5wWDY5Z242SnliMzdqbU1OTE1R?=
 =?utf-8?B?THBGYkZXQVBWMnprQ09FWGw0amFFMzVMbjhVZ1hjNXphMGNYVElnRUlyQUhZ?=
 =?utf-8?B?Ykl4UWJsdWlKaWVFQUhtSmZvbHcyWE55THpwRmdHbSswN0V4ZGJmL21vWGxh?=
 =?utf-8?Q?0WQcqW6wTIuwQelNIbYpIaWCg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9982b396-4bd1-405d-11b8-08dd600c3761
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 19:46:14.3285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVT+CSKRuXs02wEKUVgLmpsa4yPKSnGK4Nu4qK2Snq5gSNMCClYHif1Ru0B64zo/vE4Es+ji6hxQg6CKUdygrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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


On 2025-03-09 23:01, Yifan Zha wrote:
> [Why]
> If reset is detected and kfd need to evict working queues, HWS moving queue will be failed.
> Then remaining queues are not evicted and in active state.
>
> After reset done, kfd uses HWS to termination remaining activated queues but HWS is resetted.
> So remove queue will be failed again.
>
> [How]
> Keep removing all queues even if HWS returns failed.
> It will not affect cpsch as it checks reset_domain->sem.
>
> v2: If any queue failed, evict queue returns error.
> v3: Declare err inside the if-block.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 885e0e9cf21b..2ed003d3ff0e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1221,11 +1221,13 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  		decrement_queue_count(dqm, qpd, q);
>  
>  		if (dqm->dev->kfd->shared_resources.enable_mes) {
> -			retval = remove_queue_mes(dqm, q, qpd);
> -			if (retval) {
> +			int err;
> +
> +			err = remove_queue_mes(dqm, q, qpd);
> +			if (err) {
>  				dev_err(dev, "Failed to evict queue %d\n",
>  					q->properties.queue_id);
> -				goto out;
> +				retval = err;
>  			}
>  		}
>  	}
