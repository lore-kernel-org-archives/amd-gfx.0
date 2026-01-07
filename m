Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCFDCF6C11
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 08:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A063D10E084;
	Wed,  7 Jan 2026 08:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kXFpEa4L";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013013.outbound.protection.outlook.com
 [40.107.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2249A10E084
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 08:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5jUbISo5L0Z104IczXy/KFOdu1GflXHotE8AgHQH79y2p3z4CsoJarkyg382i9DQQPB5SSikNQ8X5d82tPE87GozWNdBGLV1hWN/BXSLy+cZrRLQ4tCGqpJKkSp2WnqxAzTj3rN37neF64whfL5O1ExNc+sLvh0Q8KBPJESV79WBsfGRVMFJLqJREDvaRUFowkT+0KI6Ew48QVFqja6S8zw2jsTQRu0HasX3sJp+qMwAHtzdJWylPVl1WG3GvNGHTV5a/iYJ3LcKFcGkACqrBlyOKRwGjIFgZrSGKUzgqBunN0EV3iIvtctC7Idpk/d+qpu+FZG8ZT9c4zddbIVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIxNVgMCrL1eaCGcfLzV35hVONDM7wAfrYHPheXuvvE=;
 b=s502TbBGHOEit3PQGdCIxtbHzB6v+KSMvbAilqSy3FNqQjL6MIVqhX20Px4cai0H/aT0XCaWI3iKrn2bHobI4VQ1aIUq4hCAI2+/WybOqw6m75y+TsilasQ26t8La5lBcUfptLCgmezZ4it5ic3sSUnw8ssX/SmvBZw3F+pvbU71YoPSWBfbO5LTD3qjUdXfJBlCNl908/qUyMVHU6lYmYtqkURQkawAmI9owgMFiQC0avKaSD1rh9xOIuIRxK8ep8rCjuraCoJjNEdKNbr2NzcW2Owlco7Ght1OYyts/XF8hPd4Iy55vY+0l/Jyp69/j57PFD2KwX95n5YQ1ijO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIxNVgMCrL1eaCGcfLzV35hVONDM7wAfrYHPheXuvvE=;
 b=kXFpEa4LyUXl6RxNpUxXKnDrqLyw8Kx+tSdRqLz78rXyeaUtpkFW6k+TcL24oxA7Ge5uIgpmTtu6/EcV0EzplqIYvOuNrtryOUlH21busTpdl+REoSjCYMgOEXFCv7cp635OryBsrRx8Hz8FMjN5edKUWWEIE/K4vYKZVB0WFuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 08:57:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 08:57:38 +0000
Message-ID: <629c7353-30a2-4e9b-8d65-b2c0365014d6@amd.com>
Date: Wed, 7 Jan 2026 09:57:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] drm/amdgpu: Remove a few holes from struct
 amdgpu_ctx
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-6-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: b164af15-10c7-4760-23cf-08de4dcacefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVJXSnhLTksvTFlmbG1ZZ0NVdG5WSWc1UUF1Z2NhRFVFaDlaNWgxNUpNKzI2?=
 =?utf-8?B?Mk5KVFBkbG0wR2phVlBZV25wVWdJVWsxMG5OR3Exem9sUnpDelkxellCTElN?=
 =?utf-8?B?WlFoN0szMS9SYVFNQVJnZjBsdWtkbFNIWFJUbjE3anhKOHBCT1ZDZ3orREcr?=
 =?utf-8?B?T1dueFNUTGRpYWlCSjZKanBkOTBLaktlM2RCSHIyemNYZjdiU0swYkVDT09S?=
 =?utf-8?B?UlRvc09XTUlYUUlzeGN5VXVRbk1MSmdsN1BHY29TK0pIbUE4SnhXTDJtSTlE?=
 =?utf-8?B?ZnBlczg3ZHVpODhSNG1SUFhJdGJsSEFmdnZuM1M5eUlDZUFianpGVDBuNCsy?=
 =?utf-8?B?c3JLT2xiYXZSWEphdHFGMjVodnJ0NUlYRmxLbDZ1Z3ZIRi9vZnliVXArcFk1?=
 =?utf-8?B?WFZZSVUrYVBJaTZXQkphbG1qNWN3Q0xqK2R2ZitCWlNZeHYydGU0ZE53OFVH?=
 =?utf-8?B?RFVGdmVqek9ZUFZTbDMydDZVRGxNcWp1NFNXYWMvNHdGMVpzNzNrd20wdk5S?=
 =?utf-8?B?eEx4Y001RDlqck5pb21NTXFsTDhDUmp5S0pzdGkzSExLdWNGSHhpTlVtSzRG?=
 =?utf-8?B?RVl4TTZpMVBWaTBDR0RHa2JyOXhqYXZzRFMwNU0vSDE0RE9za0lOWFdoSUps?=
 =?utf-8?B?emxheEVMa3RKNWhBRGFiRlFEMTZXbXFkdzZ5cVo5ZVNhMVJmMHZ3clRoL3BZ?=
 =?utf-8?B?OHBaaHZlWEZOTWZJc0RHVk9jK0ZaZTRaQzI1N0tTUEpyQ2oxcTNLa3BvRXRN?=
 =?utf-8?B?QUxkbW5pT3c2dGdlVm82bHllZ3BvQURGMk9uUVdiWjBWVXNFQVBSUDFOb0hX?=
 =?utf-8?B?YmxLT1ovSE45YjJxeDRRUzVYSDgxV3lJdHZqNnM0Znk1bXFFdHZTNFd2VEhT?=
 =?utf-8?B?UXdwTUJTRHpqS1RCZ3BvM25ZaUFQbERrS2llcFRRTkMxUytzNlMrSGxrWDE4?=
 =?utf-8?B?dmJWTEdsR1lJSlowbEhwWVE0YUwyQTNyaHp6MkkzQWRaRVF3cFBUUWRDckNm?=
 =?utf-8?B?T2VxTG1wMjhIVTRkRTJLeUVORGNXVkplNnhNN3BKSDhPUHkzN2xJUTJ1dGN3?=
 =?utf-8?B?WkNSRkRPYVlDZnlVRk1HNFpreXdSNHpNK05SbktzWGZxRG9DeFhWY2FJd2lC?=
 =?utf-8?B?ekZPOHozR1plcUFFZFhuY1FFZVVWRmJYbHhPTUhpUmw4dnZnckNWdFhra0hi?=
 =?utf-8?B?UGdodWlLZUxSY2MybnY4bTl2eDdkQUR0R2E4K2xYN201UXlReDgyQ08yakNX?=
 =?utf-8?B?TWJhTnlqY3d5V3p2dHRGRlZWSjdCc2JVVWNiRUtmOG9yaENnenc1cXhDVmJ3?=
 =?utf-8?B?OWUrbi95RGhoL1R0S2VuZ3JCdjF0Tkw0UFRaQ2tzc2dWbTgvcVlScG1kWDkx?=
 =?utf-8?B?c2pNZVRxa0NocTdEOTlhYXYvc1VqS1dhVEdzajk2RHdlOHIxQ1RVdFFtc0Nv?=
 =?utf-8?B?bzlNVU5KODIxYjl6Mm1kV09YT3ZwOGJnWUZVZU4xaHpUVjFPUlpuNVRJZjQ2?=
 =?utf-8?B?UlphV1pJNDhuSmJpZGdSUXIzVDFXa0NtUE1jejM2c2NidzFKQnljOEV4WVBm?=
 =?utf-8?B?cWhaQTRBK0VHaytXc2tQNEpEZDRrSXpUcWdHaURlVVZIMTQwd1FLZDNmWnVW?=
 =?utf-8?B?YlZ2amFacHp1K2dHR0tCK2pEZDA2WTl6a002aUNZYkdmbU96VmhOWW95QVRX?=
 =?utf-8?B?S2JOb1hENlo4NytKS2FpVGVBTDRyZExET0JUVlpzWGIxOXl6ci9ublVaTHB0?=
 =?utf-8?B?dTdIRHp0S2xGTkFabTd3NklkcUErSFh0YkV3aWVxQkJ2YWtSbmNtYUtLTHRS?=
 =?utf-8?B?TDdrZ1E5T0Q0UTVnLzV6Q3hacVFMUktaU2dBQXY3UHN4dmF3NU5SeXlkQm5F?=
 =?utf-8?B?UkdCRWhNNVdCalJOdjF2QVM1R296TDVRb2ZPUm5sWGU2ODc1bDNBejhRZGp6?=
 =?utf-8?Q?ze0dlr1yWYtLWHJkEywoVcspFJOH2Kda?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1zWVZobTRGUmhva1E3WDFSbWJqR01TdHpDZUZoRy90dDJ0NWgzbG8rWlc0?=
 =?utf-8?B?MmVEL0NhelZSbGcwMHlWdlFsSDV2b2hhY2lVWXFBVmJpUDdzZ2xNTXRCWTVM?=
 =?utf-8?B?WFJYb1BqTVB2YmJkaW51ZEtLVmtKSFVyQm5qRDN5NmtJanZOWnNNZ3l5OUVX?=
 =?utf-8?B?aG8wZUw3RzhmRFBXcm1SbnorNGl1ZzZOa01FaTdDWGJSNUlVR2V5cTNUWmxk?=
 =?utf-8?B?ZTJiTXVOM1g0dk0yTEgvTnh6ZzIydVFmcU0xM01JS2NwTGFtOG1sSGJ2V2Z1?=
 =?utf-8?B?SkttNWUrM1cyNEdwV1Y2VUYyWEc4eklSeWxLN1lYZGt5VFBRb09sdXdEMzZu?=
 =?utf-8?B?SnBPdk5KUWkwNjVsNjBHSmF4bWxvbmg5SHFBV01xYnR2eVRPRUhKZEhNOXFx?=
 =?utf-8?B?emJKc0htMjhRUGVhUnNhOHlucjllRlh0SDFTbGdMdlp5UzhldnpxUzl2MDRI?=
 =?utf-8?B?YkZDSFJMeDB6TUlMSnAzNHFQTzJ6clhKcklBRWlpeDVCVm1YMmdVSE1KNXNh?=
 =?utf-8?B?cHlxckpWRGhGcHhHSkJRdUdjUXFwNVB5ZFMyMHpxTVdtem5vcmQ4b0Y2eVcy?=
 =?utf-8?B?UjFmNWFJQmtUWUsrZ2xscWZsbGMxaG50Z1RBa29aZkNLdnBHU0ladTdyQkdU?=
 =?utf-8?B?ZXptZWV5dDNKNmNGUG9WWjl1ME5STWFZR1RzTk95RklpWmlHRDJWcGd1eGpx?=
 =?utf-8?B?U3gzWEU4M2JGcnI1NDRjOGIyVWFZS1I5aXNrWm0zN1o0Z1Z3R0x0MWZrNnhI?=
 =?utf-8?B?TlFjR0RnWFBWbmsvei9HUDRHbUV4Mm8xQW1KMnhSMUQvQmxIREI0UDFubHdP?=
 =?utf-8?B?TE5CbzBoTHBkMGMxVHNmcWwxRmdYTFIxU0NNeVIzcnlIYytrbWplaWFCUHdr?=
 =?utf-8?B?aEZsVDRMb3JuSS8xRUFmdE1mZVNCaXpYUHpaMlkwKzRjTThUOEdGd28vMnFY?=
 =?utf-8?B?NnV4UmE0Y29kWUpxV0RMRDFKaXhRcHBpQnV1U1FGbFU3S3FmcVZmRHdvVkVn?=
 =?utf-8?B?T3ZMcXViWlNkQ0Zrc0c4empTalN4dlVDZnBrL2xKYzUxVFBuTnYrUUVsTXE4?=
 =?utf-8?B?bUVHVS9JUW1SdEl5bVJMZEEzZktQeDd3Nml4L3p2OVU1M1d4TmpSUUhrUlc2?=
 =?utf-8?B?VmFxOXp6dnlJNkJTQWp0R2x1YWFlWEQxTzRaaWsxKytiMTdHQWowSGdYa0x0?=
 =?utf-8?B?Z2p5TU1ydWdtcFR3Q24wdmJiWHFvclZQZFFLMHhRMGNaMWtLSGtmUWpmaVVv?=
 =?utf-8?B?dzZLWFU2R2NXRElrNkxueHUrVkpoZTI4MkJwTGltNkZpejQ2eDZhZlhlNExh?=
 =?utf-8?B?TTJ6OXRDdVFLMDVGdjNDQmp6WXlvK2RlMEgzSE1OYlBDaDdnZkhSSjF0MU1h?=
 =?utf-8?B?d3FFd0FnZ2dOVHYxVGprRmx5WCtib1paRkZFZkN4cHlkdTVWeEoxY0xUdzc2?=
 =?utf-8?B?NmtBV0wwZ0dLUWNZOXZWZ1R1SUVlNndyeGl1dm1QdVZMbERBQUJRTlpXcURv?=
 =?utf-8?B?T2VVZy9tL3pvK0lTSmRaenkza0doWDlKYlpQZCtqSUFZRGNTSWdGMi9IU0RC?=
 =?utf-8?B?ZWJVTGN0TnBLNUNsa09TbVJ4bjRwZFNzb1Q3SUNOY1gvZnROaERXNTloMnlH?=
 =?utf-8?B?OVJGUjV1bUhScDFMMVFHc0UzTzV4R0JmSjF6enVaZnJReHpUUWd2UHJjMmU2?=
 =?utf-8?B?cGE5QnpLWStYT0pvMUpCdysvU29QMHVPNDhFY2J0bjl1czJ3RFdUU25pSXlE?=
 =?utf-8?B?YjBYdlV4UFBmY0NkUmxPb29Ga1ZvQzBtQmxXRDFkTjBJWnRrMUNIa2hFZ2hI?=
 =?utf-8?B?d3cwdC9BRWRHVXdiUmRoZnR2UkRqdHZDQ1FnTDRuNk1rTnN3WnVMeWN0aFVO?=
 =?utf-8?B?c1lGK0lURWpNTVB4NmQyaXRpMUJZNnNKcFVGZm8rdDhZZVpaRWovSkRJSUNF?=
 =?utf-8?B?eHg2WUxYWUpjQ21jQ2RzdXg5aWJWUkRMM05SL1JUT2NIcnI0Q2FzNjNBQUpz?=
 =?utf-8?B?L3B4OVNQRGI5SGJvR2lUdEtyb09CRVdpWThuVWxIVWZJSndKZnJWMjFDNmFl?=
 =?utf-8?B?VkpvMmJRMHZ0SUdnV2FxUHdpYWR1Y2hvR2gwTmpjQWp5MWpyamJKbWJtN3dQ?=
 =?utf-8?B?SkZKU0FkcW91dWJ0QXBvT2ZMUVdYRnBFSi9RMjJ5MGpKVHo1WEFyL3dNK1Q1?=
 =?utf-8?B?cE1kaU0xcnVuSFdUV3dOVVJDS3Q3am5BVTJONFYwR2NjMTM4OFJ3cE56VTRs?=
 =?utf-8?B?RHd4M2wzZmZnVjF2bHFncVlsazhzZU93endtcHJJR2NmRThwNWU2RDRTb01s?=
 =?utf-8?B?QXFIZzh6dUtWeWZURTNLVDNEWjFDWW1zSkpqblIrZ20zNGJaYzFkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b164af15-10c7-4760-23cf-08de4dcacefb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 08:57:38.6037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lffQTYgHqKvgY7k9aRfwF14ByliZEdXD4nve3ljf5oJNiEVLweC30WZZRZ4qG7Ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

On 12/19/25 14:41, Tvrtko Ursulin wrote:
> Re-order the struct members a bit to avoid some holes:
> 
>  /* size: 408, cachelines: 7, members: 15 */
>  /* sum members: 393, holes: 4, sum holes: 15 */
>  /* last cacheline: 24 bytes */
> 
>  /* size: 400, cachelines: 7, members: 15 */
>  /* sum members: 393, holes: 1, sum holes: 7 */
>  /* last cacheline: 16 bytes */
> 
> While doing so we notice a duplicate but will address than in the
> following patch.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 090dfe86f75b..aed758d0acaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -44,20 +44,20 @@ struct amdgpu_ctx_entity {
>  
>  struct amdgpu_ctx {
>  	struct kref			refcount;
> -	struct amdgpu_ctx_mgr		*mgr;
> +	spinlock_t			ring_lock;
>  	unsigned			reset_counter;
>  	unsigned			reset_counter_query;
> -	uint64_t			generation;
> -	spinlock_t			ring_lock;
> -	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
> -	bool				preamble_presented;
>  	int32_t				init_priority;
>  	int32_t				override_priority;
> +	uint32_t			stable_pstate;
>  	atomic_t			guilty;
> +	bool				preamble_presented;
> +	uint64_t			generation;
>  	unsigned long			ras_counter_ce;
>  	unsigned long			ras_counter_ue;
> -	uint32_t			stable_pstate;
> +	struct amdgpu_ctx_mgr		*mgr;
>  	struct amdgpu_ctx_mgr		*ctx_mgr;
> +	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>  };
>  
>  struct amdgpu_ctx_mgr {

