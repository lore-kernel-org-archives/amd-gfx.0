Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F69C36018
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 19:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AFDC10E132;
	Wed,  2 Apr 2025 19:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OJfPb8vK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839F210E132
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 19:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPXLq6IYMixnXZCoaC8LYsw50ju9H9reqyQ0MjMKrnJcSnOxmj7vYQpr97I5tePOE2LavYqzU51WOaHnLkikgLLo2ZgvhHwAicYHsOkhK1+CyGVT16tQNXkSL2f4hfCVAxPrehCf1FKln5XzzEHwGXrkOakwpj8cowcrfA5MlRCRAeLgccEy1IL4gsASP1dOdI6ALDChBJTwV0IRWNYMQs36UOxoUt595eC6CJa3Dei9/tqK4m4V912/hugPZfVCbolDa9rYlCSXkOaMDdTbstisBWFBTuToeUBsZazvac6gjK2oFUF62OLaqAKPOQnOIN8U6PxhV1QaswaWNvKq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP48iNKyt6wDG+Av9Cjh74hO2+334kiNF9J1Dpv5ySU=;
 b=qFk5AYH0fF3d+h9g43VtIWCRMxRVoufcelJLyoZpVrgpMGay8TbtEauKS2vBMNlNjRYsCXiVe9cE8STiRMhEqdGEYQ7Lf6LSZgpVZYlL3Vr3jIKr+pMXNDqPvjHMtNjFs5wdr5EI/w0lEQDarhY87KIMRh/zgOwaOivo8mZvJ9Oe+3BhcwE4xmi8TgDCPuMNT0v1GcRSfUWxAkSQkXrSMG1c+5vVA5TtM/MpPUtXL7dw+7Earez8l/bPlZ9ZwEW9kZWgo3i6P3q1D97JcWCYdJgvewUiVnf3gcujPIdyTjJr1RK7ts1udvPYJATxUVxqNPXpeNktyjxwzxWo0d4Glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP48iNKyt6wDG+Av9Cjh74hO2+334kiNF9J1Dpv5ySU=;
 b=OJfPb8vKa527uf9M5ECyEijYq1SIDCZF3Idb0yLVJEdW+TEq/5DXGeJ7pR4IE+TGfwD8z+YAJvDHA/t3BmpxDK3sO/79WBACh8doP2BMk0oH1zQbwR9A8JHePZvVpJxp5GNrIoaCQ7243uSBFCerNTUBrcdesR2aBl+TiS4fAUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 19:48:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 19:48:35 +0000
Message-ID: <ea7f034a-924b-4c7e-b2f1-f66a611878c3@amd.com>
Date: Wed, 2 Apr 2025 14:48:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: optimize MES pipe FW version
 fetching
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250328130857.4071486-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250328130857.4071486-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a49341-0741-4072-ca6f-08dd721f5b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXFKOFE0OVVPdVZUTkl3QlQweUxEdFo4eHdoS2UyZ0N6dVdRZWs3MHNpN3VP?=
 =?utf-8?B?K2Noak5vUlhnRTRxdnZpandla2RBb2M4UmRUTzFLQXNldW0rZFFkWEYwZDNY?=
 =?utf-8?B?ZlI3ZGhEbW4rQTNMWml2blVkWDZva3VEUlUyNnF2VjZGS1JPcmFMd0t0Sllr?=
 =?utf-8?B?blNqMmVBSlhQSU9QMnVyTmo4Uk8zcUtqSWJUOVRnZzE5WEozS0w5cUFBUDZX?=
 =?utf-8?B?ZG4zM2VxUWVvSHhHeG1oc05tVGF4cWdUT01LcjhNWDdWcm9aRHZRcGxWYmdQ?=
 =?utf-8?B?NHAvZmFaY3d2M201MTh0L2wrYmsyYkZDZVNYcFpJMmhwUkQxY1J2U2g2YVFi?=
 =?utf-8?B?TExGaS9Jc2FKOThzS3Jwd2xjV3JCdEpJT2ZNZFN2b0tjcGZBVncxMi9iVmV6?=
 =?utf-8?B?R0lxSitLV2V6SHpyTXhhYitqZGRJelJQWm9JOW5SWWxwZGJyMVlyMnhWSURW?=
 =?utf-8?B?dWtmWjhDaHY5clNEcGFhRkREMzRzZ2ZIbWZ4UjVEVzJTbzlwalBkK21JZ0Zk?=
 =?utf-8?B?TkZQNnFLYVZuNTluVnRwUjREWFkreEtFRWNhRk03Uk83S2pWalJLaUQwUHR0?=
 =?utf-8?B?eWt1Y0lTNUxaS0YxNWZnVjRhL0JIMUFqbjlYRC9kaUFJZnNxeStzVlRST2xj?=
 =?utf-8?B?NERFTUJqL3Z4Rk40WkdKNlYvaVZFWTloWDN3a1U0Uy81eTNZL1ZKRFpPVHNZ?=
 =?utf-8?B?dVEwMGM3NmxhZ1VpOTR5Qy9oWEpwK1pzZC9IQ0hxblZjWmVUQWVXSVZ1T3BQ?=
 =?utf-8?B?L3hlK2wvbFphN2RwQURsZWZsdVo0QWlJd2NVSG1CNGw2Qlp6cmNSbHFXdHBB?=
 =?utf-8?B?UTFwWldGVCs1VVNRS0ZaV1RGWGo1RkNkUDNpRUM2cWdUaGFZNWdRUnIyUGN6?=
 =?utf-8?B?Z1hFby92dFRocmp5NzNzUUtKY1dLbVc4TVNqT3JzQUVYZkExREZUMWVqdFVZ?=
 =?utf-8?B?dnE1czljb05MT1pqcHRVWVgyZjlrQ3MyZ3gwbVJvSzcvdnROODRCYmRWYjRH?=
 =?utf-8?B?SkdrMXFuM0RrcXFZNHQ0YkxEeUMyNjFRU3RodEh6NnF0eHV6RnV2L2NKa3ov?=
 =?utf-8?B?Y1FvWStjVld2QTJIc1Z4MUtSaFpwNVRoODhJQ1lHYjR6UXdiMVROWDErWXIw?=
 =?utf-8?B?dDFMVkpjRHdRNElKMHRFY0k0NFdWeGFlc282U2lVZ2Y2K2duZWlvVVJGWFVu?=
 =?utf-8?B?SkxDQWpYQThIOUVnT0VobjFDU1E2QU9CNnEyaHNNVDNNeCs2elpTc3dzdjJD?=
 =?utf-8?B?NkhoRUZQSmNpQis4RW13d2tSWVhnbGZHSVg5ejQ5NzZGbVJGUWphbnRDa2pR?=
 =?utf-8?B?a3Zla05VaUwrSTVHZWxWb0RrZGxnMmpZUUg5VVJTNWR5bjhsdjdpckVrTmpR?=
 =?utf-8?B?TWRMNHUvaWtGSE5uYlpscEQ4bWd1SjlTMHRyYTdtV1B6WU00TGdNaW9yZjJ0?=
 =?utf-8?B?MlM1dU82b3F1ZFpjejU4aEFmZ2tjOVRhSkNJMGo1UStwSmptVmZSWVlwdlZm?=
 =?utf-8?B?OUFpd0ZHY3kwSTZvbTlpazEzcEFTZjFieTZubUtpcFBZU1h2VVRkSkRVc3hi?=
 =?utf-8?B?RlFka213RnBCckJJODVMMXpTendZY0Iva1BRcG1vRkduZFVmS0JvV3Ixamw4?=
 =?utf-8?B?WXl4TGc5dnJNREQvVzk2NzVqM25wQ2hNTkE4ZWNrKzZLbE1LbVNuUEZZVGhy?=
 =?utf-8?B?UDBiZk1RWFo0MjF3SzQ4R21reGtnOVl2WG1Kd2tNTEFrUzlxbnBMVEVaanM1?=
 =?utf-8?B?RVFGNUpNNE4zZ2tQSkJPWnV6WWZ3dFFuZjh1dWx6MmJwb3E5MmZ0Zis3QjI0?=
 =?utf-8?B?RXMyeUlOajBoVTRLQ01wdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1crbUNkbnBoWW1USGEwcGxmU0puR2xaRWFhMXJ0b1FzN0xzNFlGeTdBaVRV?=
 =?utf-8?B?blRsR2xtK3JNZDRza1h5THQ3SHZHK2xvV3JJWEJPTXhxWDBEcUtuUXh6SDlB?=
 =?utf-8?B?d085TGpMaXRLbE53aXl3UXlWYjJmMkJqWEdha3p6cUFZTUZYd2RISjdDdWtz?=
 =?utf-8?B?bG1na2MrZFo2YktiVmd0K1JYc05WR3ZsOEdiNW9rWmdJS1JCTGppR05GbG5y?=
 =?utf-8?B?UlJaenJ6SkdaV01YL1pZcTdtRU5kV2F3K1dCMkpmTnNRaUdFNGt4L3NOd3Zj?=
 =?utf-8?B?b3JGTTJ6VzJXelFFb2l4WWNXSFZiR1cyYjNERnJjTzNkR2VYNHI2Q0JWMjg5?=
 =?utf-8?B?V1NWTm1JbWVHZ0ZRS2EyZWZvVkNyTFJudW0rMkJlQUxVQ0t4WnV6OGFmQWZx?=
 =?utf-8?B?V2llVGFtTWMvZnd6Wnl1bDFkaUxwcFlPMXltZVdLZ3JMUmdlMFk5MmhJb3Bn?=
 =?utf-8?B?WDVGS2F3d0dPRW5LZ2hVVG0wZTJLSEp0SnJUSFJ3OCt2MnRJZzBETFdaTGFu?=
 =?utf-8?B?RjE4ZitmVjhENFBsUGpSQ0ZRYjU2RE5wWDFqa3ppejhKZWdJMUdYNVVXRTZl?=
 =?utf-8?B?QVdpL3R1QUlUT0pJbGJrYWNDMmRSaGFCVFpseVR6ZVlOa2Q2Q0FOZFJDWjc1?=
 =?utf-8?B?ZHVOS1FrWXpqcUJjN1lZaHhQdHd1Q1ltdVVpVjJDZFhBNWJBZlpsOGhDdmhI?=
 =?utf-8?B?aFZ5NmcvV2YzQUpwUGZRQlFJY3IzaUZZbmdIenFWQU5uL2JQTU9ES3ArUEtJ?=
 =?utf-8?B?WWVBQTZPYUNMUmF1UTU0M3V0YWxHQ3hUMjNsVHJSVE85bGVsc1lHajhCYy9B?=
 =?utf-8?B?ZktUZlRGK0NramZ4NjM2RzJFRVROcU9HTGNZNXNuTDZROHluRHFxM2xuZjlp?=
 =?utf-8?B?Sy9Gb1dVencxNjRzbGsrNm1reHozTnR2ajZnc2JDcVpvdU9oOUp6ZDdxZFFp?=
 =?utf-8?B?SjQyZzRGVG0xMWc1RFZjek1pa05saDlQSDFGYmd3bm1oaGxrRkdxeExvdnhp?=
 =?utf-8?B?T0xJaytQM1JWMHNYd2hkWlNycU1OWGs5dTdyK1NPbUxhL1BEd2JwSldQVjVo?=
 =?utf-8?B?QWgvRTJEZ0hsQ0Y3N0FIRXdnYVF2a1VFNmxkUHpvUHRxQ1RRalVJbk02bVpU?=
 =?utf-8?B?NW01MUtFWVhUckdmVzZWV05nQm1yOFRTOXB3QVhvWlVBUVhhNHYyOXpMWDls?=
 =?utf-8?B?anphV3V1dDIzNDA0ajhaNk1ZNHpBVkFJRk1Fbk40VWRFT1lhWE1WclMwaUFi?=
 =?utf-8?B?VlFwVXF5T0pOWE9oOWRWeThLNktZMjg5VmJKOE9SUUlQeVFvYk1Fd2g4UUJH?=
 =?utf-8?B?TVlxZTdtdUtmeFFKQ09Pa0tscW12emZNakZjaVhyVmtWWW5UUVIrTWFTNWh1?=
 =?utf-8?B?VlZGdHQyZjkzcTVWbnE2TjBVNFA4YWJuVkk0cXNXMDgvb1AzS1ZpU3RyN1gy?=
 =?utf-8?B?aUp0QTRuaWsvV1BpN3lCVTdJVTRYaFB6YXozOHY1c0hNdzNDdmczY3VXelBs?=
 =?utf-8?B?MHdySWVOa1prTHhwcStZWG5SeTN1TmtOLzlwUWZaKzc5cnRzcThEeWN4VU9W?=
 =?utf-8?B?NHhNaGU0ZzZhWC84YW1tdnVjVW4xTWx0ZitDaVh5VlZzY0FHWUNack5maDNl?=
 =?utf-8?B?RjdocGVhdTg1M2l3aDUybkJmTkRkQUxjdG5JQkFNbDdmSzh5cDRKempGMml1?=
 =?utf-8?B?ME1zZCsrRGw0RVlLTEJPcUpId3hFcHM1aDhsTS9BOWJsZmtKdE1MVE5kVzN4?=
 =?utf-8?B?R1BqeGZyaU1hUkNjUTdid1ZhK09WdEJ4eTZvZ2hoZ0I1SFhZYzAzcGhORDkx?=
 =?utf-8?B?K0hmcCtHdUpaVEVVTEh0eWdIcGJrQ2JZaVpQdldpTks3UEtnUy9xQUJoWUc0?=
 =?utf-8?B?VGptTnVGK05yY0QvMjRxSlA1Wm9sRk13RG44dlF6NHlVa3pQa3hBL1ZmMm81?=
 =?utf-8?B?QW5nMDNUNUVSMWE2ZWROd1E2RkhhOTRmclNrY0lZMUFxRW9zTXdIeFVnekN3?=
 =?utf-8?B?cXZpNUtBUzJzdXp5WFZmUGtTa0lUSEVBT2ZQb1hLUXRIUTIrNk4wYWVMSGxl?=
 =?utf-8?B?NzBZc3lMOW1ORWkvUXVlUW5FeEZ6RlpXOFIyL1NNZlh6cTNGSjIvdXlSNUFj?=
 =?utf-8?Q?caBkxYBWdNQelkDvQ8MiVS0Mz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a49341-0741-4072-ca6f-08dd721f5b05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 19:48:35.5148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxpSXzFPWnO/I7541OagjnNJYnd2UQI29y+NRP6puoR7OdoB+3fOczfGE3XxElxXpRrQNgkxqBX7edFt2asekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
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

On 3/28/2025 8:08 AM, Alex Deucher wrote:
> Don't fetch it again if we already have it.  It seems the
> registers don't reliably have the value at resume in some
> cases.
> 
> Fixes: 028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4083
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 16f8bc36afa07..06b51867c9aac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -895,6 +895,10 @@ static void mes_v11_0_get_fw_version(struct amdgpu_device *adev)
>   {
>   	int pipe;
>   
> +	/* return early if we have already fetched these */
> +	if (adev->mes.sched_version && adev->mes.kiq_version)
> +		return;
> +
>   	/* get MES scheduler/KIQ versions */
>   	mutex_lock(&adev->srbm_mutex);
>   

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
