Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC6BC3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 13:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408BA10E91D;
	Fri,  2 May 2025 13:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="orvzfBXi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8753C10E919
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 13:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViV3sIzRdvd05lMO1qmzWAzUzCTugMHbMNvQFhfXVqZg2Um53IaUaiwp4dkuCqM1Wt5WTzAy7dfRcJ6oyIbiv7NZyJHgSR4/HsXt1dEHMF/uCEnIXGkrIUed+yT9XBmBdQ3+lqnq2aDmz9O3AY1iyr0+OyyblPUtPN2oIZl98qNuuBlZE0pjthRSH5Ot0m7j6UUIrRfOpXaiyEukRU5owOaLNZ04MZyZGJoLcK3kH9t9IsTtGAA5RnSHsf30qVszXAn1o2n3aLslxoSvED+d5kJb9VDscmO3ueKd5GtWyf/RUWtBca1cGGAlhQxM7ThpAGjzn4o0GLj0fZx3rL2jPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvRUA4/V2PpZpjzamfEw3S4m4yauAgKnuoQheI4pJfg=;
 b=YPGJzkeLJazXfUm2URZuSNSBsbOgjzDRnTnvvIqSC0KXP6qewXmYr9i4Tg5Sj1oEbXJ13m+N8ltfq8JkLkt97cNSd9gCmDZd/m3jm7YauwbzXqjPuUseWZTNnDjwC3EJQrAlWIemXC7KeJCuyvweTyLJj5iTUCyIHP9JofglPjlGnd8dsjnez1vdAF1szDBMV4J6eaDWorunQDuITSgLqedlkLfhc1RHHAURRCYijbWEUyDz9P3UbdAqiFyNL6I/KokKSHb8HkVcuU1XQRva0wPZadSqMdnYxytvCACHzneF4SExNdHfRFkAJQkkftRQBQAR6dBSMBVKVzo26e5rNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvRUA4/V2PpZpjzamfEw3S4m4yauAgKnuoQheI4pJfg=;
 b=orvzfBXiFv2zMmlBIiltuoCzEnXT15tId3J2sMsKY1h3Mt1lGl/q0AvKgTE5Ka8wKJV8e2wX/8fRmo7Tf+JpjKQ7GGYtaoeqXy/eZUEaig2EY7EXXAzF57egDy9DqZVQ5CyBxqzVHHfD//odC9mCyYx6sg/iOXlQQPPgyNuLUFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 13:02:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 13:02:06 +0000
Message-ID: <53cbf863-5a80-4f3d-9613-b50addc9a977@amd.com>
Date: Fri, 2 May 2025 15:02:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu/userq: Fix DEBUG_LOCKS_WARN_ON(lock->magic
 != lock)
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
 <20250409054831.2411-4-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250409054831.2411-4-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 317938c7-2622-4f88-3e7f-08dd89798a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmFNSWRUYzlkdTRYRjloMk5tZ2F0eGc1ZDYzK2FWUSs1OTA2U1ZDOVdnSVNB?=
 =?utf-8?B?SWEyN1g0dGI5M0Nlcjk2ZVVSZlVIZmNVYU56VnFuY2tLM3NIdGs3SWZLZW8x?=
 =?utf-8?B?YVRMbFVzSG10YzlmS2dzMk1BZDlEa2VpQ2NvRC8wMlhVcjRNMTloQlNSdCtN?=
 =?utf-8?B?SXpVQitTWHI5ZnR1c3VyQTZnVTNEQ1o2SkNDY0F4VzRwdVYyUDM4RzJGSHVh?=
 =?utf-8?B?L1dRemNBRUdrRU5sTWYvSTNsSktVbjVtUWY3KzFJdWpBNTlGVHovOVZ2NzNW?=
 =?utf-8?B?NVVQN1kyalcvbkpaWi9rcng5UWZuVGhKa2wvRTBDZ0xGdTFIemNTVDR5c0dx?=
 =?utf-8?B?K3lMUGQxeVlXRUpPbW1DdGxWNUYzcjUwc0NQbzJ1NWc2YndTVFA3dENPK2s2?=
 =?utf-8?B?bVdWeXkwUFJrMkV6d2IxZFRUZjlsMkZhRVIvSUl6V0V2K3RyelphbGhhbFV6?=
 =?utf-8?B?MUhvVXpISmNKYm5mK0pPcXBMZTRqQzhKVXBHR0dzejJHUjZzdmFpWWtlUlk4?=
 =?utf-8?B?VTlhMUhWNGxtUjVLTCtReTdxbnVjL215bWV4M3VjbFVYMWVBdDY4VExlZldk?=
 =?utf-8?B?aTlxaGl2dWdwdHNLWVQ2MTBTSkVpZ2tMS0pHeTZDNVRtR0JjNWJCVjk2QU9R?=
 =?utf-8?B?NDFHanpCSlhBakRIM0dodmdQeFgxSHd2cDZEdzVhVUs3WnpuUGJXazVETVF3?=
 =?utf-8?B?RG5LK1R3RmVFMS9pQnV5OVh3K3ZETnErOFJXMXRCbW80d1NXS3N1Y0tVVDcx?=
 =?utf-8?B?TnFLdUs3TVErMVhaS01UaTl0RVJDR0Y2WW9BSlJtVTZmaVBBbzAyZVYvS1d4?=
 =?utf-8?B?N3NTRUxMV3ZYQ0hwT1FEMXpqVWJDem1YQ1ZMS1BmYUFxeEpmYzMwZEx4bFFJ?=
 =?utf-8?B?TjQzYlNscHZqYUxXQlJNVW5GaG92RS9ScS9zNU1WM2tla3pJQmUyaCtOTnlN?=
 =?utf-8?B?TllUTXFzV0dvekJQL3kvbXAzMWNNeEo0ZXpJN3B1U1VFR2U2UUxaT2c5WWMw?=
 =?utf-8?B?RzRIaUx0b3pUQ0NtNXNhQUFXMUFDKzlpS1pQSllOMVZHTkMzZ1p4eEl6T01T?=
 =?utf-8?B?ekxZYlVGQ044aUdWaVpNWUh1cVZFTXdpVEtzV3F5MTdjMm4rKzJrbjVSTkpQ?=
 =?utf-8?B?SDBxTmlrTHRsMzNYbkVHWnBDeE1uNG9YWmovZDRFY1hJNENxd1pSS09Id2lW?=
 =?utf-8?B?d29Md0Y0TEtIMFhEUEtsOWZOZEJSU1RRMWVLWktzRDhrZnBtOEZ5cEJJL3ZO?=
 =?utf-8?B?M2QwMVZHZXlpbVVxbFdwT2gzZmdEd3lOUE41S3NIZEV1U3hwaUE0cU9BZUJz?=
 =?utf-8?B?UXhmU0h3ZVgwb3UyOXpMaFROVWxvK1FkS3p5Sm9VUTU1Qjl4Z1dwOS9idEwx?=
 =?utf-8?B?ektMRnJ0d0dVTnh2OXc3T25Wcys1ditpUno2MVJJU0g5RmhJV0FkZmkrSVJS?=
 =?utf-8?B?Q0FTaUdReE1aMSthbGVaNitDK2J4QkJrSGFMcVROenRRQU1RV3puWVBTditM?=
 =?utf-8?B?V2RkNTlIN2tueTdRVVJBMFJzLzhVMmZJSTNPc2xxdGl2TEVQdnZJcndIL0Fj?=
 =?utf-8?B?YkVvTlp1MUNlei9oUVdBUWxibXVkNGdHcHNBZGxNT2tqOTg0eFNpVHJzMXl4?=
 =?utf-8?B?eHNMQTAvYzZnNG1OT1JDeXVwZ0pRbmRUdXZtRU9kcW9sWlFsUm9HdDZPMEhK?=
 =?utf-8?B?bFpnYkUzTmFjM1ZVZUpFZ0lCOVVBWi9HeGN4WkgwRG5idWQ4bzRNN1gwdmV5?=
 =?utf-8?B?ZXVCNzBiUXgyRlhZNHA0VE0wOER4aTM2OXpQUmx6M3JLeVVNMWhtN0RYV3Fa?=
 =?utf-8?B?QnNRWnQyc25wU3ZiVi8xRDAvOE1WV2VCd1NnZjZHN05sZVdvSi9uRkVkYzlY?=
 =?utf-8?B?U1RKTTkrOVU5NVY0cmpVQmFhWHdtZGtHdmRubEE4RWNYMkNaMGZ1Z0pSVkhv?=
 =?utf-8?Q?uShFEYdoFCo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm14YkduZUJmUkxYZW95c2FycmVmaE1XNTdqbk1MTE1peEllMmNSZlNCQ3Er?=
 =?utf-8?B?TEEzRWRRNmVLaVBRWUQ4YU50eU81Z1pyV2ljU3lDaGlkVDlzK0hEUkxEcGFH?=
 =?utf-8?B?K2pJN0Z0ejJXalRJeVNTaXNlRDg1ODRxaDI1OW44SDJORjNvM2tpLzROSmV5?=
 =?utf-8?B?ZHZmUW9tKytockE2dmorQWo1V00wY3Z3cmZVRXJsSzluU0xvNGFVeHVWYXJS?=
 =?utf-8?B?dHhFTkJhL0xBRVNUdzIzZC9SUVlqbmM3NDV2OWl5eEdSN3d1QUNpMnlxY0tt?=
 =?utf-8?B?VkFRek1uSHMwb3YwT2sweGlVem42WEpqdk1EMmVGWW9VeUwzL3dSRVc4MFUv?=
 =?utf-8?B?WnRVUHFNL0ZSNFFPeHJEWGlZR3ZsaFJyeEt4Ny9TelFQTVk5NTBUb3ZVQWhS?=
 =?utf-8?B?NnR1K0IxbHd0MUxuY2MydUI5Y0FUcXA1UVh2aHA4SHdCa09YL3hkRWMrTjds?=
 =?utf-8?B?L1FIS05FWndmdHcxVWxBcjlFODhQbWY5Q3JLYkI5L21hQTJPampadE9lNkJN?=
 =?utf-8?B?bWpYNjd5a2hSMmQvTmxwWk9qMFZUSHlCVHUwQkJselJQSWZ2VG9uNURvS0Mv?=
 =?utf-8?B?UkQ4SmRNRzRuUkU5QmwvcnNoaC82blVUdGZiZE5oMjB6UmNaN3RIR2xoeHk3?=
 =?utf-8?B?SVdzcXJ4bTJtQTJoVldLSUJYdGIrWDhGQVJ6SXNnYWdWZGVUSDVmL2diNXN4?=
 =?utf-8?B?V3g2OFZiNVFTOEY0VytVRnc2RGVHcms3WlVVdGpIWEwzamRMWjVvSFRYZkMv?=
 =?utf-8?B?WFZYREU2ejNwVk9kdHA2VUtaS3hrWlB1U25qOFlyeXRjdjdEdHlpWU84Z3Vy?=
 =?utf-8?B?dDI0enVBQklBc0dicnllSWJuMEJZSlN5WnU0YWJVNmpSWE5rb2ovZGN1SnU0?=
 =?utf-8?B?N01RQXhvdnFHK2syWFdUMklHN3RwNzlrQTV3c2RPMlZzdWxLaVJDaDBzWXdJ?=
 =?utf-8?B?dUVvZDZzU1praUtBUmVFRVhsYjdkNTZVSDRpRlhvcHgrNGlxa1RwdWdYd2V0?=
 =?utf-8?B?R3RpNklVUlZEOXh6QWg3bEFXRVU0dE5nSUhLd1g2Ymx6RTZPTE9hWll3WVQ1?=
 =?utf-8?B?RG1SYjBmTkxUb0c2cXdnbmNZT1c1RWRBb2F6cjhtRnhaUEdGbjJyQWJyQWps?=
 =?utf-8?B?Y3FkRnRZMEdiMzc5WHR3enlBU2pGTStIZ3l2bmttZkRMNEpBNmc3QUJDTzFY?=
 =?utf-8?B?aUZ0Rng3c0h1VWJsVlNNOUlZUmFieExaYjVUZWEwVTRCWWdEaG5vV3QxaTFm?=
 =?utf-8?B?UWNmZFBrR3lHYWJ4WXJYWkI4cE9oVkJaajZjeHNEWjhSU284a3RMMmJZYkJM?=
 =?utf-8?B?eUhuOVdqamY5UmR0UTZGc2pCeGxkb2Zod2YxaDNZRE1uUmt1NkJTVHFyaGQz?=
 =?utf-8?B?Z2NObHRPMUg4Qnhha0hGZ2xpc2w5TCtaRFVpaVROTUl1amxFZkEvczNwWFdW?=
 =?utf-8?B?akRqRm42YUQ1MmQrY0Rpc3d4bmZVcDltZnROREJBcThBb0xEYjZqSDREaWRl?=
 =?utf-8?B?UmE3L3l0cHdib2J1SDJRYUJ1bXZ4RFpzRDRVSmpBeEo2ZWZLQnFZRTRKZFVk?=
 =?utf-8?B?SlVpT29WeTdlMHR4T2V4MFoyWGZ1TGlyWWNQbUxOc2NydVFsVUtrNGZvaHhQ?=
 =?utf-8?B?MENRWnIyOC9ob2FCTmpDQm8vZUU2OHExTC9DVkZOMUdWTjVsUlRsU1Fxampx?=
 =?utf-8?B?NERaT0lINlhKZFlwVlBUZFZ4Nmh0ZFIyYXRvN1M1aGVDM0w5V0FMZHExSGxD?=
 =?utf-8?B?UHhqdzcrekh2VlR5UDhnVlRwa2dvTDEzUjVSall0a1JRZmxUWnlxMm85bHdS?=
 =?utf-8?B?UzNYeE5QWHQxQjBYc3RkQnNTU09SUDJ5VW9ZTUw1RVd1ZHhJTThDTVJyNS9D?=
 =?utf-8?B?MCtUbWZGeTJ1STRsaHFNYXdTZURudkdRU0tLUDFmT09pRllzWTR0Q0NnNU9V?=
 =?utf-8?B?OWluQUVIZnFBWmc0T2R6bUZZSFFVTmw1L0s1VTgvUGQ1MzU0Z3pHNVdRYUFw?=
 =?utf-8?B?K2RUZktxV2RmMUNaUlpzZ2ZTNUdoTC8ranlCUzUzS0RnT1BTZHdaL1BpbDVj?=
 =?utf-8?B?RFZIckorVDJxMkNCWTZwYThSMS96bmc4TnkyQ1lsaHRPVVl0bGFnayttcG1H?=
 =?utf-8?Q?TBf4/O2n4Alz4swrPJxwPigBR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317938c7-2622-4f88-3e7f-08dd89798a1d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 13:02:05.9738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svXCZPVImgcIa8/1n3dyxM3bJvjHp1l4M+WS0fiy+uTkG7x4jEVj0GgCZKhnik9U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

On 4/9/25 07:48, Arunpravin Paneer Selvam wrote:
> Fix DEBUG_LOCKS_WARN_ON(lock->magic != lock) warning logs.
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd6eb7a3bc58..1d7e2b85f45a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1413,16 +1413,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	mutex_init(&fpriv->bo_list_lock);
>  	idr_init_base(&fpriv->bo_list_handles, 1);
>  
> +	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +	if (r)
> +		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
> +
>  	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>  	if (r)
>  		goto error_vm;
>  
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
> -	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> -	if (r)
> -		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
> -
>  	file_priv->driver_priv = fpriv;
>  	goto out_suspend;
>  

