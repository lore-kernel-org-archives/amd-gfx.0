Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A84CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 16:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866D810E4A6;
	Wed, 10 Jun 2026 16:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSyk1kRP";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C0C10E4A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 16:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL78YCdU1FKUFPJcHpqJt+JJiOl/Wo0VlRuzCMC94iaWULMGfsP+hcpyE8HJ2zgxg+N3b5bXOFEEL5OMUV36r7N9mev61dIsCQHVA030gULh+MNtSRAlfByjGFN18bKEP5Kk9/GOVIM5/pn7W8B9wDgCfslIGPRdhNYCj4mECjH/JRYCj6Hg02C6PXwgV+qrVsggXPdYRJW06VFy3fXLMvmhMufip+2XnCLNZl9m8jNZyZVIA7fP+GBng2bd+60dAWoWI2o4JCZLzPUHV++EZ2RJoViF9fP4WsIkUT6wJn66yHuNjDzEzXjWnioMBPynE4HSrQXvqr5BFyZzLX1sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4PMxKo0qSJN5VSu7Bb4h6n7uRELy0oRuXxfrWTuiwU=;
 b=YJsRUhHoEtsKC+44YEnnh73nMqegjo7O70YM3+2SPkP23DfduKgnka3neshPLB+4uvgrRX2LYBcjwHkKxvXp1fEthbc/jDA/yN4KeWFJJjC0n5L0/fcibTw63FeG5+03roxbuUT60J7i7Zb+pzL6nBaXrA3tw05EF7hOgby9yMWYDSAonjjOGyIOkNZR/DjwGmj21T6SrOm3C+SHb9GB4faVqEqpkk7KywK5gFRcScaZCr7MPmQ2JhOrFT8sh80TjlQ//EpaX7MU9nrXMS/Cnm2z51XVK58cmVikkiYyM1OXVu9KooyGdr1Te732K2v+73UG6vLq4S/Q9affsfi7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4PMxKo0qSJN5VSu7Bb4h6n7uRELy0oRuXxfrWTuiwU=;
 b=LSyk1kRPedrnXag/9j0gaFr18ov1PCGFE3MJtF2LgFn1Z4/Nzob5iNr1AYvY4r3qkf8HxQCweCJGl28HU1Rx/0+6F2jTynTB0MO80lpQDPTjXyB6Y+bFR50Vbpz/VBnb9RWcAisazxh6ZGPWqKJyQQRaYnflD+t4S8gv8SwyjM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 16:14:13 +0000
Received: from PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16]) by PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 16:14:13 +0000
Message-ID: <34bc0c5a-40bf-400d-972d-0e835d19da01@amd.com>
Date: Wed, 10 Jun 2026 12:14:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/amdgpu: move suballoc defines into own header
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-2-christian.koenig@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260529114031.3714-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0200.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::29) To PH8PR12MB8432.namprd12.prod.outlook.com
 (2603:10b6:510:25b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB8432:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5892dd-98bd-4c79-159e-08dec70b4fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tQ6i584XvOmt94Sj5ifs18eE+6OkphxMnjNaouD3y9rMskIM4ZH4TUAsbhBIClFu5iotWZEJJkXVBQvnbrZ/dyA/ARC/kcfraurqi3No0VuhYRlOI/jqKuy7uTWf1NRZk3EMGj9/CM7UnMl3+G4ExDjWDzUTFsE3uwY8SmsKKwqaqI8BQ3p1XQBeC4iJgXd0djeRolfSmMMELZ4+1pJhESI9FI+NvEXLa+klnvtF/V2DtyObhJpRKimxQ2pJ2+annUencZSgChK4qKpBM0+YkNtJ8oWFWzLwSkyk2GGg4mW1yL7nERL48zOO1zWOtV0cn3L1sWO3ED4rSzXZPVHNHHksPLFm5OqJH9nV9kGxOFJC7Kr817vueVA909A5O+zs0VMkJmYL9ZVQfuiKQeDZFAhTskz1DdSWRLIC+537WCrLDn0q+rl85o7IU5Y4YMQb1EeBA8Tq8Qn8m43fqVYJdYx5e04FS80Zj9mvSQlzqrAYbx9C6sh4WU9cJm7VI8L/wtczpISyqklA992kKu1NNZ/90oA0zT6HBO7pMGBkE50i+lhDCBYIoGW4oGk8yfnEWD5eySfrwWu3e0TnYx7ASG5XmTClFiBNt/Gg3+glnwn6qYMRrMG9AculK/Sq8DAY1Pdwwr2QH0ERbzeE4lvBdQInxBjDt4xeJ//752suobTlDS5Fjr9IUcsdAWGNezBM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB8432.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhDTkYzbUQ3QmNTZ0E3bE5BNzVTUVBhTlJqYXVxcUNzMVJHYm8yc3pqMzZC?=
 =?utf-8?B?aDRCTTREL2JnTUFTRHFqSTQzdXdoTlJ3eWF2alo4bytlWDFkUkJ1c2ZyQXRr?=
 =?utf-8?B?eFVBUE10Sm0vTk1nU3VrMk9wSEtjZ1k2RTFDNEZiSFBrUTRIeVlkMVF5VXBG?=
 =?utf-8?B?a2MzaWxFT1NpK014MVZ2ZEhDYWNrOFJ0MCs3R0Q5ZnNDYW9ucFR1NmR0NzNa?=
 =?utf-8?B?S0lzQ3JKQzl3Z0tnUWpPdThpcWJsQWo2SjdZcDFvdVF2em12emxjaWMzZXFP?=
 =?utf-8?B?SXp0S2VEVUhlOHdvTmUwU2ZoLy91Z2g2RmRwQjRYNUoxcGVFRXd5NGFWcm5Y?=
 =?utf-8?B?ZnNyTHB1ZUcrTnJpQ2pKanpvVkN4UUJOc3VwTitld0UrVkpnRXQ4K3B2SllW?=
 =?utf-8?B?UTA1NlZ2dVFoU0orT1ltaDdPSVlkZXROQnZ5OWFpVDNvaUp2UXpxNW5Qd2Yr?=
 =?utf-8?B?aTBDK29aYm5VNm5Qd1l2OGVSZ2RoMjcyZ2h0RE93TTlqSXR0bVdrYkRLMVAz?=
 =?utf-8?B?bitWMWpTTWo0a3BUbjVDVDc2UUFVU2lQMHFwQzN4d0JGZ3ptT2ZHRE9YRlVK?=
 =?utf-8?B?RzVKT1hETzNiU0tkaTJlWDFiaHk5WGhCRXdkZ1hQUUpaMVhuek1Gelp1cnc3?=
 =?utf-8?B?SjdlT1NaWXphL09GSkVPMlMxODFncDVtRjh6V2hCcG83Ni92c1JhUzJYMWFa?=
 =?utf-8?B?eE1jWTRmRlg0RTlBSmlMZGcySEk3aFJKRTJXeDhkRFhBQTZpdkg3V0pZeC9V?=
 =?utf-8?B?L2swMkxHNEthbHpxVXIrOEh5M2U0TUpuY1BLeWF3MFVzaWxTN25rOTExVXQ5?=
 =?utf-8?B?NVV1b3dzTEZSeHpkeWJ4M1dwUDlRYVhPRjZuNkpEYnBhU3NoWHdDelI2dk1G?=
 =?utf-8?B?dzJxNFVRY2w5a2x2cW9DVlpnT2pyMzdkVlcxa2Z5Y29hbmg5UmcvYUw0TE9L?=
 =?utf-8?B?TjJFNFUvL3AzdjRpaVdkMC9MeHpPRjRoQTZ1RHpFbHhMK1hVWXpMSVdEbXNv?=
 =?utf-8?B?VUx0dnByK080aWhLcmZ0dk5HcFBUT3A5VkZISmxOMnV2dXl3dEZ4cUo5NlpP?=
 =?utf-8?B?andGSmowdnYyVHgxcFZGM25JbWtpMFlhSVVxa0QxVFVGR0NXb1VnbE1JeWNx?=
 =?utf-8?B?WGQzZkpTUXdCcVJlV3Z5cm5PL0ZhbEVPWDlXTWN3Z1hPQWhGRFFyQzI3N1E2?=
 =?utf-8?B?dTlubTg1YnUrSTZ6dVp4aHBnVGtBVmsrSklQV1loejdEQkJRcGo0ZkFuaURk?=
 =?utf-8?B?cDIrdzh5d1lqRFQ0VWdzS25yaGJ3RlNJays2WW1LaE5PZFN0aXIzL3JmMlRa?=
 =?utf-8?B?aEd4N09LWkRwckRlNXZlMTRSWlhlNGVtclRDOWxWTjQ2TXBzQmluTEMvOXJt?=
 =?utf-8?B?bE0rSmxiU255R0EwOHBrRnNBQnlnWDJsWDFBYUszV21rV3p5VU5NeGtqNXN4?=
 =?utf-8?B?VGQxakY4U01PY084TDA5MHlrT0xLRGFVR1E0MldqTk8yeDcxc2JqTW5KLzJM?=
 =?utf-8?B?cU1XT3lmMFVUcUpWSzl3SS9BeTUxeGQ0dlZQVi8zVFFWK1M5YjcyYmxhODR0?=
 =?utf-8?B?M3doVnJieFdrWkwzRXVoNlRHbjE1ZFZtUGVGTDJwVHV0eFZIQm4xTTdHN2d5?=
 =?utf-8?B?V0lqODYvU0wxejM3NXZoNGI1OXQzSDA2eXZGdHJ0YWQ4TXhxblZONFpOczdp?=
 =?utf-8?B?dE1POTNXcHpGTHh4MTlLUlBFbm1sdG5yY0xlZGZsVjFubmRQenV4ZGVxMSsv?=
 =?utf-8?B?bWl3NGlhbmU2cFFpa2lhUWxtSy9BcDhGSjZ0a244WnJsTkk5dlBOYmc1d2pB?=
 =?utf-8?B?QkR6d3NpTCtzTm05K0k5MDhwaFBucVVLMXRVTy9wZDFoTVRBUStqVzBDd05j?=
 =?utf-8?B?UGhMdW9XUld1Z0RCSTZuR0NBSE1nU2d1RDhkeGIxdmYxMUdqWldQR2szc1NR?=
 =?utf-8?B?Y3MxYjVHbnVzSWdBZXoxVUtVU3BzRHYvSkswK1k2UlFVWEZsTEhaZjBZQUcy?=
 =?utf-8?B?ZDJWcEN2WkkrbVRpSnI5VW14SnZIcGUveVpGNndiZEZUUHAwTkw4c25EVGFz?=
 =?utf-8?B?U2pGcTNiSEx2SXQ3N2xPTnQyQWFYb3dEdyswTThOdSsray9mbjJxeDNOdVRJ?=
 =?utf-8?B?cWpOSzEwV3VHazhObnZIVWxHK1MzWk9DcmxSZ1RrQ0VvT1dndjRBaFBoQkh4?=
 =?utf-8?B?Q2pqSjlSRjg3SzNHTGpwbSszVVdGTlFiQzE3eUEvMTJMQVVvRGJES0JsTTln?=
 =?utf-8?B?MHhEUDY3VXdMRXhFcFhieG4yM1N0bXVGREhwbk5xa29McGdzSXk0UWNrbnpZ?=
 =?utf-8?B?YnFYbEFRYUJLd3VQczRZUVNiN1c4MXJnZDY1QVcrbmhBTDZpL3NoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5892dd-98bd-4c79-159e-08dec70b4fd7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB8432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 16:14:13.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAgI6ZP1CSBn4PzKtaouW/cfvQxMQTWIc1uouSju0gHVhbkdXRBkoMGQPEEu+V9X5DWCAeKOk5oFHUZevbT9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079
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

On 2026-05-29 07:24, Christian König wrote:
> Just some code cleanup, while at it remove outdated comment.
>
> No functional change.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 32 +--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 40 -----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h     | 77 ++++++++++++++++++++++
>   3 files changed, 78 insertions(+), 71 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..4b6c9d9e6773 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>   #include "amdgpu_userq.h"
>   #include "amdgpu_eviction_fence.h"
>   #include "amdgpu_ip.h"
> +#include "amdgpu_sa.h"
>   #if defined(CONFIG_DRM_AMD_ISP)
>   #include "amdgpu_isp.h"
>   #endif
> @@ -386,37 +387,6 @@ struct amdgpu_clock {
>   	uint32_t max_pixel_clock;
>   };
>   
> -/* sub-allocation manager, it has to be protected by another lock.
> - * By conception this is an helper for other part of the driver
> - * like the indirect buffer or semaphore, which both have their
> - * locking.
> - *
> - * Principe is simple, we keep a list of sub allocation in offset
> - * order (first entry has offset == 0, last entry has the highest
> - * offset).
> - *
> - * When allocating new object we first check if there is room at
> - * the end total_size - (last_object_offset + last_object_size) >=
> - * alloc_size. If so we allocate new object there.
> - *
> - * When there is not enough room at the end, we start waiting for
> - * each sub object until we reach object_offset+object_size >=
> - * alloc_size, this object then become the sub object we return.
> - *
> - * Alignment can't be bigger than page size.
> - *
> - * Hole are not considered for allocation to keep things simple.
> - * Assumption is that there won't be hole (all object on same
> - * alignment).
> - */
> -
> -struct amdgpu_sa_manager {
> -	struct drm_suballoc_manager	base;
> -	struct amdgpu_bo		*bo;
> -	uint64_t			gpu_addr;
> -	void				*cpu_ptr;
> -};
> -
>   /*
>    * IRQS.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 4d68732d6223..ff11a0903499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -312,46 +312,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   					    uint32_t domain);
>   
> -/*
> - * sub allocation
> - */
> -static inline struct amdgpu_sa_manager *
> -to_amdgpu_sa_manager(struct drm_suballoc_manager *manager)
> -{
> -	return container_of(manager, struct amdgpu_sa_manager, base);
> -}
> -
> -static inline uint64_t amdgpu_sa_bo_gpu_addr(struct drm_suballoc *sa_bo)
> -{
> -	return to_amdgpu_sa_manager(sa_bo->manager)->gpu_addr +
> -		drm_suballoc_soffset(sa_bo);
> -}
> -
> -static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
> -{
> -	return to_amdgpu_sa_manager(sa_bo->manager)->cpu_ptr +
> -		drm_suballoc_soffset(sa_bo);
> -}
> -
> -int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
> -				     struct amdgpu_sa_manager *sa_manager,
> -				     unsigned size, u32 align, u32 domain);
> -void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
> -				      struct amdgpu_sa_manager *sa_manager);
> -int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
> -				      struct amdgpu_sa_manager *sa_manager);
> -int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> -		     struct drm_suballoc **sa_bo,
> -		     unsigned int size);
> -void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
> -		       struct dma_fence *fence);
> -#if defined(CONFIG_DEBUG_FS)
> -void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
> -					 struct seq_file *m);
> -u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
> -#endif
> -void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
> -
>   bool amdgpu_bo_support_uswc(u64 bo_flags);
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> new file mode 100644
> index 000000000000..8c85c80fc119
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_SA_H_
> +#define AMDGPU_SA_H_
> +
> +#include <drm/drm_suballoc.h>
> +
> +struct amdgpu_device;
> +struct amdgpu_bo;
> +
> +struct amdgpu_sa_manager {
> +	struct drm_suballoc_manager	base;
> +	struct amdgpu_bo		*bo;
> +	uint64_t			gpu_addr;
> +	void				*cpu_ptr;
> +};
> +
> +static inline struct amdgpu_sa_manager *
> +to_amdgpu_sa_manager(struct drm_suballoc_manager *manager)
> +{
> +	return container_of(manager, struct amdgpu_sa_manager, base);
> +}
> +
> +static inline uint64_t amdgpu_sa_bo_gpu_addr(struct drm_suballoc *sa_bo)
> +{
> +	return to_amdgpu_sa_manager(sa_bo->manager)->gpu_addr +
> +		drm_suballoc_soffset(sa_bo);
> +}
> +
> +static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
> +{
> +	return to_amdgpu_sa_manager(sa_bo->manager)->cpu_ptr +
> +		drm_suballoc_soffset(sa_bo);
> +}
> +
> +int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
> +			      struct amdgpu_sa_manager *sa_manager,
> +			      unsigned size, u32 align, u32 domain);
> +void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
> +			       struct amdgpu_sa_manager *sa_manager);
> +int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
> +			       struct amdgpu_sa_manager *sa_manager);
> +int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> +		     struct drm_suballoc **sa_bo,
> +		     unsigned int size);
> +void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
> +		       struct dma_fence *fence);
> +#if defined(CONFIG_DEBUG_FS)
> +void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
> +				  struct seq_file *m);
> +u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
> +#endif
> +void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
> +
> +#endif
