Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFEFD2ED08
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2622110EA55;
	Wed,  1 Apr 2026 13:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oZtn/zaj";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307D410EA55
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6rVxgzP1YjD5V5uSgLlD2Yp5sH2dyUxsOH7TMhcqA6lV8bdV8JyiMkKHkqbdxZKBGaFyN0J9MWW2UXqc0u9DJWOXpOZVf0T7VmOeA9W9TXnNBlef6HHhyRoslP/AorC5UHJW4KR4DOus4xnJG2ykvWEdU/1LGFKY33PrR1Z7DroLV8ijxMPO0P84Pa1vipAPvn3cABM7vVGSZAd+9bVXUrjotxH9i4pzCSxs6VA6AtGS7iGuQ/amG1BU1t51n5NXUaKTPBr1diRVzne5nbHP1CxLZuH0bZc6F/Z3AdHu5itLndrA5bfgUz1C9wXkPIivuOBYTX2837A7vdRzaGVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXjT4V4r2WAJGaJPj0R2EMgK3PhCNgLOCJ/5Fq9PfIc=;
 b=p5Kix5kQCDoGvMhseXNOr503+lvbiTBzEaUGqbx/CKduGMRHay3hBbQ8DdDDcVAPV6wLxzw9Ld3NZRO6u/lE5urO7On8Sv6uQeywx4y4wixBabHR9GLTBmkSxrVU5X4chiZZn6dHE/XX3mYVg59NiUQ2kRgIHZemviuj6a+hLMf+EIhxdzJykF7FV1YipaeyqsuGyOLxp12BWlwRltHz3Op9WWWpFDV7vKlbercF+HodVj3P9I4BCNYm2PlkflqeyxFh579kumaW9jTAfWpr10e71xRlnqhPIxQbk43nKBemKO6Y/3GyN1hSYMLtcEqgBlPVsIGRKY53jHOdWGe6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXjT4V4r2WAJGaJPj0R2EMgK3PhCNgLOCJ/5Fq9PfIc=;
 b=oZtn/zaj+ckT8HeiRmUI1ZKA0CxZaHKG48nzU8oLCzsQmLaSfnhQX7tm3a2p4uiFcFYr8X3Lqm5JupOhmynMQAilaUP8y19YbRikHAeClRx5xHN5H1L4TKJgMOJ3irGMTIZvQdS/wKPTskAYhsIcW1UAmbqb7n5qkCGxupe/ZcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 13:41:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:41:56 +0000
Message-ID: <e5dc9c66-170f-41d0-920a-396ac94c6660@amd.com>
Date: Wed, 1 Apr 2026 15:41:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260401100508.3397962-1-Prike.Liang@amd.com>
 <20260401100508.3397962-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260401100508.3397962-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0264.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed977a4-b605-401e-7c6a-08de8ff47138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: zhYvS5RNnmQaoxhEP0OwnTOJ95d5glepQOhSPYYIMwlYgPDlIQ/F7gaAt/07uP0XUGYBt+KIgPQU+hr2ukp3OXRjJYgIX4fxg9T4WA2oOrohxblfktyGO7qlg1r/HAdGG8TsD8slebft8YofbOPZPVOC3k/rTbM1sC4td+rB836pp/5kSzSQdVKUI0LJ+QF5RkPcshpBv/5g8PCReqBGLvLkIw7jkAf2uLspt3yRL3KliE8oVdH4Gh1IOLhBIZQRv9w423gh2629Pzcl432TK20u0NnUUAEnGvMFTGcyTu2XWfFCBPm6kJArHbzGPY06rH2kT1QO1Veu1ehu/zapq36pCKzqlrT6x4dohKutNOCjug5h/UDojXw/W2PZO9kPNQWubVWirtphoghmobC60g2NmyA57L2t7O3mHxnTLMHatExMtBrZM99BRMJSUAYBfANtaZgGpNXM4wgXyJVpYIjZ3Ha/ERENaAg+5M0mZsigjHCvTvk8Kzapb65GtFmCWBYSxOmzLe3i7pDKp+apWK3j+GXR7GJABcmQz64zIu2wWqMZoRCaf9GsxI9zLFPZLm28402ElL4WLZxEa2qEwqnU3l8bzDgkyh/IMZGFKpX1BEX1lo1Urr2N7gOM2czG9yhZ5J2p1swj8zXcEpQrEhvVb+TJkt8NBE5D6UbllFWLg2VCBJwPoHpsiNEng3vh/fWAplFDEy4RNfoCVGM3muzAoGNSg8okHa64U1V2T74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mks4Rm9rdE1qZkZYc2pVYzJNQ3NSMmdQbEZRN2EvR0U0bGRxZ25Nc3gzczhO?=
 =?utf-8?B?WlF6bDBYakdab1Y0THZZcm40bjdQOGxnZWRKa004aThVdG1TZEFnUlZha1VE?=
 =?utf-8?B?TmpZVkZsUEhwN3FlVWdUem9LODhxLytuV0ZDcXNpSnJMSWxvZmwwQnl4Z0dG?=
 =?utf-8?B?SW1lS25ncXpQcmpQUFNFUzMreVBJYU1JakVGTkZCOGFPMm5QcWwwSm9TMDdO?=
 =?utf-8?B?U2prVlhDQmgwdnNpSEcrMklkWG5NNklQNWVGWkt0Y3dXZGY5WEFKbTRXN2po?=
 =?utf-8?B?QW5vcjJEd254QVZIcnA2QXV3T2lLdHJ0UVNOMjJKdkoxanRBQm85NmdvM1c3?=
 =?utf-8?B?YmdQUWRxK1pOMkRvT1JTMW1BL0kyNjJnZWtxcmFybCtobzc4THZJNTg2VGVQ?=
 =?utf-8?B?Y203Q2h4R3hkVUpNQkQ3YUlIRXM3MEh2dEhEWXVZbjY1alhQT2lGNSttL2FY?=
 =?utf-8?B?UjhPcGRIcHUyNXFTZ09YTnBoUkRnMlBuelhOMEtia3RZaDFwSVpxTHVvaUdX?=
 =?utf-8?B?cGZFb1RhUUJtUDFIc1Fxa0dmemJlV0Zibk4rUjh3L1JVTU5jS3lLMkovNmZC?=
 =?utf-8?B?ZG0vb1kvRi9zWGFtcC9ucnFqazk0cGZKMHFXUlpTTFBKRldld2JNN3hnTmZP?=
 =?utf-8?B?MnEvdUlGQVkxdUxEU1F0ZVNMWW5jZjlLZVR3NHdBTnBNZ1lqZndRNXArZTFy?=
 =?utf-8?B?Mk5FODM1R202U1lHZ3k2ZnZWSUZSN0U0WGtadmF0eGRnNlY2cmZkbFA2UjBq?=
 =?utf-8?B?Q0g4bDc1ZkFtQ1RQYWpHemhMSWp1bFVrb0tkRGJETmo1b3daa1JtUTRycGRi?=
 =?utf-8?B?d29BU2ZyNTJUc3hCbFF1ZjFQTEN3SFd6UUJBdlpOc1F5djQxWFFQcHl4Z1I3?=
 =?utf-8?B?bXVsQ2RIZlNXRm9lZzF4czJZUG5Lem9JTDc2WWhtUlRqaWpGVW9rc2xkd2lD?=
 =?utf-8?B?UjU0VFpKN3J1S0dMWUdrYlF6QmlOOFViTVRWd1luV01qOVd1dmlzRk5SZW55?=
 =?utf-8?B?dDVIaVg3QU04cVFMZ2ovZFpxa2RaZHI1aFU2SzlPR2ZaNTIvOVFHWEJnTmhB?=
 =?utf-8?B?SUJUbCszTXlJR1JlZWtUWDZMUVczV3lmcjBRUXlNNU5mUFVmcEV2Z0RrczFJ?=
 =?utf-8?B?Smw1MlhJTUYyZFVONHljR0h5Y1ZqVW1BTHpFdnRqZDVNMWJvVkUrVTNGQnFY?=
 =?utf-8?B?TW5oV0NyR1NubEdnMkhrWGtMSW5UdEtaZkVTbzVsclBPcU05dGR0eTZuR0R4?=
 =?utf-8?B?RzBBYnJwS2lCQkZNV2NYUFFoKzlzSHNTR2hBWVo4TllBNkNrN0pSTHBuc3JF?=
 =?utf-8?B?STlsVVpFb3BQTXBESnV2alh4cDBVcnZvNFJ4YTFDUlBVUVpFdlpCV0RVc1Z4?=
 =?utf-8?B?ZHJPMm1LUjFucVdpMHh4d1YyTTIwU25HUmFyWVFzTWdzeWJiYVBDMzBHZWxU?=
 =?utf-8?B?ZjNDaWQ3bEdIU01oMFVpOVhUMEdRektoUTVoQUQ1K2g0MUFOMWJ2NmZhWjJn?=
 =?utf-8?B?RlBqcHRUMDNyV0NQeHFEcDBlUkZqTVBXQjJlWndzbGlUbTJVbi9uOFpTZjVW?=
 =?utf-8?B?LzF0S3daT2RnUHRZd2ZkZ1IzbldNSjJNNjlYVTNQSlRqbHlCSHJDL01BY1Mw?=
 =?utf-8?B?STlWZk1oTE0wL2E4Q1ZCNEhnZGQ2Y3A3UHljNmVLZjYzTnVzT1l3OUp4M3JV?=
 =?utf-8?B?Njg3UjBRRGlIV2svNk0xbzRjbm1JWGRCSDhFRVZFUDJJbkZBbm5hNXl2K1A0?=
 =?utf-8?B?U2ROd2RySFRJL0RXN0YySENpWEVaOHh0NE9YYUN2eFd3SGUwTFAzYzd2OFNG?=
 =?utf-8?B?dkNIcWw2RWw4YnpoMmxTWmI2YWIrYTgvQkVKUUE5Vzd6L3J3Zlk5Rm5Xbjd2?=
 =?utf-8?B?bFJyd3VXS29hU1c1SDFSZURsbjBic3lOZ0hNanJXYncvNjRVektHaDlCZkI0?=
 =?utf-8?B?dEpoSEFVUllzOXVEdEpGblBVUmczeXJGeGVZbk9tekVWNmxkUEwxUnhudDhR?=
 =?utf-8?B?ZkE4T2VEK1JsdzFQVXk4NWZRVDIwa0pjU09KdmJSWGtoZHNIU1BoTVdSZWRy?=
 =?utf-8?B?aitQelpybWtXNDJHSkNtQlFTNVNmMHA4T0VkdGo2UE9weERhOWtzT281UXlS?=
 =?utf-8?B?VHpBT2ZjQUlRUERWVW8wRkVXSjUzWjN6TS9hNlpKNjExdHBCVWdQSUY2QXBk?=
 =?utf-8?B?elY5VmRMTlNIS1VtVysvTWJxTVhSVWpGbFE3WnRua3ZwZmIyMHZMTTRYNHBD?=
 =?utf-8?B?SFdjbHg4TVcyaVBZTDQzWHpsdm8wTEFYY1FKMU1LbTd0WE9UNHdGWk1RR3ht?=
 =?utf-8?Q?wCs6TRp8pzcHRWBzWh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed977a4-b605-401e-7c6a-08de8ff47138
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:41:56.8822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGxOFMIZW9Y9zN2Rxn6YxRb3FUxJxGLfEjvt9ze6MinXc3+0xZf1OwV6TfBE3G4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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

On 4/1/26 12:05, Prike Liang wrote:
> amdgpu_userq_fence_driver_free() is now responsible only for releasing
> per-queue ancillary state (last_fence, fence_drv_xa) and no longer
> touches the ownership reference, making each function's contract clear.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

We should start to add kerneldoc to functions like amdgpu_userq_fence_driver_alloc(), but technically that patch now looks correct to me.

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
> v2: Get the userq fence driver from amdgpu_userq_fence_driver_alloc()
>     directly and dropping the userq fence driver reference after removing
>     userq_doorbell_xa entry.(Christian)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h |  2 +-
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c4841df80bf8..4f9f2e266562 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -458,9 +458,10 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	/* Drop the userq reference. */
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	uq_funcs->mqd_destroy(queue);
> -	amdgpu_userq_fence_driver_free(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> +	amdgpu_userq_fence_driver_free(queue);
> +	queue->fence_drv = NULL;
>  	queue->userq_mgr = NULL;
>  	list_del(&queue->userq_va_list);
>  	kfree(queue);
> @@ -799,7 +800,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	queue->doorbell_index = index;
>  	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> -	r = amdgpu_userq_fence_driver_alloc(adev, queue);
> +	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
>  		goto free_queue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 87560c1251d8..3be80a82788a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -78,11 +78,15 @@ amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
>  }
>  
>  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
> -				    struct amdgpu_usermode_queue *userq)
> +				    struct amdgpu_userq_fence_driver **fence_drv_req)
>  {
>  	struct amdgpu_userq_fence_driver *fence_drv;
>  	int r;
>  
> +	if (!fence_drv_req)
> +		return -EINVAL;
> +	*fence_drv_req = NULL;
> +
>  	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
>  	if (!fence_drv)
>  		return -ENOMEM;
> @@ -103,7 +107,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  	fence_drv->context = dma_fence_context_alloc(1);
>  	get_task_comm(fence_drv->timeline_name, current);
>  
> -	userq->fence_drv = fence_drv;
> +	*fence_drv_req = fence_drv;
>  
>  	return 0;
>  
> @@ -134,10 +138,10 @@ void
>  amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  {
>  	dma_fence_put(userq->last_fence);
> -
> +	userq->last_fence = NULL;
>  	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>  	xa_destroy(&userq->fence_drv_xa);
> -	/* Drop the fence_drv reference held by user queue */
> +	/* Drop the queue's ownership reference to fence_drv explicitly */
>  	amdgpu_userq_fence_driver_put(userq->fence_drv);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index d76add2afc77..d56246ad8c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -64,7 +64,7 @@ void amdgpu_userq_fence_slab_fini(void);
>  void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>  void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
> -				    struct amdgpu_usermode_queue *userq);
> +				    struct amdgpu_userq_fence_driver **fence_drv_req);
>  void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>  void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);

