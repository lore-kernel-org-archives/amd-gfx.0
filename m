Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B0CD98C8
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 07:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0354B10E782;
	Wed, 10 Jun 2026 07:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yfaTh2Mk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA7410E782
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 07:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1dd5xldZ6dQANTRvDjHIk0goW7SNgtGI5UT5vLVCWG6D4EbzL1BKb9oTWDUxQR4ytpj1uRnXIOOy355852Pq9fMxzMeBAzcC6U5sxVKKt4tcTNetGk8wPB0GP9OPv5kATeRH3RmB8uN2uvje+x3ZqsKAdRnjgfzdyUfd5qPIfQkzcJXP3Me1dsCcgy/FBdrb5JNPm8RiefnH71x4w+VlY/zqEsaG4iabkrv0rKOWThYNbmeDsXo2dW+rcs+up8i2FWC7W4y6ZJz4J/J1F50TlxubNN+8YnXeEV951unOp0Y93pJ1fjnBLGSr/xMy47apD13O2jWreQqdX5rRztHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldzRRQZqcjJzIGgmWd47GJzY0BwbVBv0L1p8yiIuQJw=;
 b=kGN2JC/Qxup7b0VnskHGBv3iSxyvXtt9ZL78LWlcXHGUJ0asV3AkjWOsJ3dyD8q2icFNejZcv2OWyY+pZJc5GwvsqkRvjhSKiEOEwGxuUiKlnxDw7v9gm5VqTXTPjvgHbw/mMYmYfej0dx+Il1S+WqdzXz9p2Mmlqv6hLs9X0dLM8q4mDZBZHMP4vZWFexKywJQ4l2DHPFVSEY+AC34ZR90IXEuuDIEQbiCLktUAsSlmZv96juGtV+rX6GTO96YKs03WruWfSTF2ZZjyYJb5FRB40p9aIMoIFj7uB7SO/Ra/eDC7b/EW/FfZFDAZS39Y+nIEfjJooLq0S3GKzu5b9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldzRRQZqcjJzIGgmWd47GJzY0BwbVBv0L1p8yiIuQJw=;
 b=yfaTh2Mko0nE2qynWJBvZVMQ/e4cLgy/xR0lycKiehJsb7dNPIohwsEpDNERiAlC/U6i0jxH1u69Ti1MXyVORfHm9ef9a7gO4JzLSxAEIlppqQa45gb/x26u89xGKIsuDDz3pkAsgAUeSmeE1v3cDyjCvCko/ZBkqKEuWitiFlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 07:53:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 07:53:12 +0000
Message-ID: <d891cd82-1a91-4a2a-852e-dc4f6d9687a0@amd.com>
Date: Wed, 10 Jun 2026 09:53:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/amdgpu: move suballoc defines into own header
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-2-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20260529114031.3714-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bc110f-15c1-44a3-6fca-08dec6c551fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|6133799003|3023799007|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Uyhpwda7dza7UUxskVvLYzfg2OruQu9ZjTxvgAgusf8kcHWpEeuYzYQrA2MRMFEN2eM3TzqO2xJhH21dZxvPAjy+Z2avLEFsQCmndYJ9nGbhgEDgDy/Bnb6JRHu5K4dB1LDr2rayqnIWAb8MT/ShCVH/dEhfF4kwx4Jpcsx/ez+bb2wXsSW6AR5NIp1UwEHWo2FTin9CCcNOMOAZgs2Dj3q00NTBj7Pxz/q+AsDTTg+FQ6tMn0ULpto3tkxd+KwKWRIjOtZSNcxoIpjJylQLFciFKOMhr4HLDFX0xaedrxI33mv52qqDDp7gkTYLf3PuI7XYPUdOcMXos0MWIAJfDMISI97qC9D163S7cxiB2r1jNgB2D+RphjGv8Z7pz8Y9KS9NWUPIGATBvD3CGWD/fjpCJIEfEgKT9AZp/rbmxJY0fG3Ek3SfHcUPaNlXMDk8Wd0jIu8nza640OdvlDRJNv5dMlS/XBsZ+R6nqA9aSV+EDtGMtNKQo5B6muMPeJXJki2klrfT5V09f+JzCSY1i9AjvBPDeGEC5oqI95Cx4Vv31eUJI634FvaXlLS/rqE5VeXYknWBAEzGA10lW7OTXXHQbwxGqKnKYKiYLuqVKeTIqClBvLNfIWrbtAN9G3uP2EPaNY0ebDNOHe1+yDwNW0hUleagmYTQNXgJUBHjHAU93vaQlDn+wusiIpmNYlth
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(6133799003)(3023799007)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2crTDk1aDdPWWYwY251TmZkTVNVcVJMU1NlTjhVdGNzT2pJcWI1dnNxWVJT?=
 =?utf-8?B?czRzSUhBSXBuVlFtUlN5NTRvWkYvQ254ZDlzUHlYMU1EellPWW9LTTc1bytm?=
 =?utf-8?B?RkhjNVk4anNvNUtrWlJSZzJQVWpKK2Y4Z0NrM0M4VzZZaERueFVMVlowcUcx?=
 =?utf-8?B?OTd4Z0E3NkdnanpxZitUTkdTK2gwaEdNTXpyMzNadWlwQU1wZnI0aGg5NFQ4?=
 =?utf-8?B?L0x0dk9EYXhnVzFGbjkwVm41NTQzWG9HOCtDN3BuZ1RROG53VFJNdTczTWxz?=
 =?utf-8?B?T1hIeEFWL0FKVTJST3JUTy9RRzNRYzJyV2NxSzlJdTBVaEdzTFJqcER3blc2?=
 =?utf-8?B?ZGtvNGo4SDFUNU83MkpFc3IySVNqZDFqZ0U3QmV6UEVjb3hhOVhEWE4rUmdk?=
 =?utf-8?B?ZHFoTFQxVExZVm43TmkzUndjZUk1eVZiTzNleTJ2L0REaWN1WDhDSitTRW9w?=
 =?utf-8?B?cS9UeUhnb3BwWnZWeUN6L0g4b3dtVFNyWUtETi9LZ2hBeUw4N0dqM2hacU5T?=
 =?utf-8?B?TWlKQ0VYanZ4ZjkwMUl6WHpuQ1V0bFdGdXZHSWQwaVBsNytkV0VEWDFoSjVZ?=
 =?utf-8?B?MHhsbURvM3VXaldxWFdONzdhUHBudVRQK3NwSTBhUWFKa3lyQmlrSDVVT2p4?=
 =?utf-8?B?YWFzZDRaRTZlMGRHaklMZGRrdmNpSDhLam5wa2hSRmZxcENKTS9memROS0p0?=
 =?utf-8?B?YU9KTk16NCs4ek91a1FnT043UERqYm9uVU9wRWNTTlVzNFFJZitQNUI1LzFz?=
 =?utf-8?B?V0E5M251UnhhL01Wa1BrRnhHM1RDMTEzWjNCQXF3b2poZVRiVWJxeVRpb2o1?=
 =?utf-8?B?U3psVmFEaU94ZVlZVU9wbmhSYWlWNXRJM2xtZVhVc2w0ZHdWb2xRRGx0WVph?=
 =?utf-8?B?SmZTZGFPaElwbnVwcXcrRjd5blJLTGhrS0wxNDJkMUo3Q0ZQOWt5cVhVV2h6?=
 =?utf-8?B?OHZEaDFLdGVlUE1uRVNDQVNiY3hPZWt6RFFqV0FEMlVuVmV0aVBhRmhMcDJx?=
 =?utf-8?B?S0JhVFBVZGVTcVl3TTZoekwrM1dsNFRJSWdXOUtVV0E2cEhHWVRWK1ZCalh5?=
 =?utf-8?B?MUY4VWREc251V0tZRktCaEkraDBtSGUvNDJaY1hMQ0FsU3JqSU9MSmdmUm85?=
 =?utf-8?B?RithNWlraFJzZWM0eUFycHR0SmV5UXlmb1R2anNuTFBOMGc4bmdncFNEREt3?=
 =?utf-8?B?SDJRZlFTZ21tYlVkdldsdEErVldBQkR3eTRmZCtJRk53YWpxc1RzUW9jbFZz?=
 =?utf-8?B?MU1vaXRvK0QvM1VjblhnK3dEQndBTmZSMjA4bW9CeHk1cnA2MlFydTJFakNz?=
 =?utf-8?B?b002VHFiZXdvdHZQVW45SjNtWFNzcjg5T0w0QXkrSEtYeWhPQy9OSFhYcDF4?=
 =?utf-8?B?M1d4UGx4WHVXVlJCWTI2Nk5nWjlwVDVDd1R0UHBaNUhaTkRBL2NIQjRzcnJa?=
 =?utf-8?B?dzY3dEhwTTQ4OFN3ZUxaYTBjUzlsU1JJdllJSkNNckNpRFBJaVBBWDNWSGQ0?=
 =?utf-8?B?MDFDNU0rUUFqUnNCY3lQelA2NWxDSmE5amRlV3BkQVZNcmxkaDMxaXVFVlgz?=
 =?utf-8?B?aWFrVjFtMVlpbHR6S21OUWZqbGRrVnlsY2NSQ0VZdGt2aHJFYnN1elI2a3Nv?=
 =?utf-8?B?ZjNacG1LQmhidHkwY2VJZExZSE1ITzROdXJlcW0xeFdoRWxFTGtXNTIyVlpj?=
 =?utf-8?B?YmJ2UUd5Qm42UXg3YWxGbzhmQXY1ZzhsdEZvZkhFMmpiZ3lPbHpGT2lhYkwr?=
 =?utf-8?B?RXlLVW0xR3FQaWVmMXpjeVUzK214MnAvSnNXYTRqWjRscUx3c0YzR2IwdWg2?=
 =?utf-8?B?NVM2SjlNanFFampwRHA0SUdIRE1MNEM4OE1Tdnl6NEg0b0V1eEs1ck5KQUNZ?=
 =?utf-8?B?c3h5U3VTandqbTJXM0dCcDJvN1FNVjBQMTB1WXo0ZmU0dS9uZUJBRzFCdFNP?=
 =?utf-8?B?NHhVQzd2VjE0WVcvVy9ndHJDcDdGVzdLQWt1NHFoYnhMVWlvSysrT240TlZR?=
 =?utf-8?B?czdmU2t4MUVFVTNwR3ZyM2dUQThEUFJESkdnTkdmUHAxN3lFYzZGejhXdlNK?=
 =?utf-8?B?R21KRE9mR212cTBBUHR3Vmt2TUgzWmkrcGpUT0lhaXFBem4zaEdaODhiMStr?=
 =?utf-8?B?ekh4blYyWmNDR29kdDFCKzVVSTJ4YkJTWWVwL1hnWXZWMXVUaDlQQWoyM1B1?=
 =?utf-8?B?N3FVdW8vTmdQbWVVSXlYTzJMcWd1aHJxcUtNcThZcEswYlpLb0NodUsyY0NZ?=
 =?utf-8?B?blAwNUZCQUFhQlcwOVVKOHB3MGdMbjlFeFAzR0c3MzFMK1pidnpnTjI1eStW?=
 =?utf-8?Q?68jsWoS8l8hZsNVpAh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc110f-15c1-44a3-6fca-08dec6c551fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:53:12.2220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYq8RHs2AhzN9mVNv4fd/JOSQ5OsJYdENbrTKdDu1NO21GzeDgayZSCYswvoIaLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

Can anybody give me a quick rb or ack on this patch alone?

An interim is working on some minor amdgpu.h cleanup and that is blocking him so I want to get it pushed to amd-staging-drm-next.

Thanks,
Christian.

On 5/29/26 13:24, Christian König wrote:
> Just some code cleanup, while at it remove outdated comment.
> 
> No functional change.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 32 +--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 40 -----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h     | 77 ++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..4b6c9d9e6773 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_eviction_fence.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_sa.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -386,37 +387,6 @@ struct amdgpu_clock {
>  	uint32_t max_pixel_clock;
>  };
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
>  /*
>   * IRQS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 4d68732d6223..ff11a0903499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -312,46 +312,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>  					    uint32_t domain);
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
>  bool amdgpu_bo_support_uswc(u64 bo_flags);
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

