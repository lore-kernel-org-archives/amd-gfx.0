Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6DED3517E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FD710E2BC;
	Wed,  1 Apr 2026 13:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpFj/vvT";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F99A10E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JivE+NsI74vmadlmdmBfjGqUyj4a1pdmA2K47SL/YHJ9YLPiB1jSb+impSQA7dyI24Knk6KNJU7P/oGLTTVI5hex4rjER3rdkQ+3GUukU+zHYMcsff6eZu70VVyXS49c32MltaNLDwCHCgyF6k6Lsr9Dk188ySwgERusR4oRzShO0oCSY/McZ7AqsJlx6nUg6JZHmqCrqFpNmCz42Ppp0YX4BHJhiFhZCiXMZc6czseN23MExN7PLBvWeW8iW+AM26GHNX6fd+w4IV9RZaboLGcBadtfrGBZ97dmztVh/AS8H0Oz8JK9d2EhqGEG1hNK3JS+FKu6Hxeff41VNRjeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y11DU6GM1Y92e9HSW5hvUj9HKTN6tGsBmfFNF7RPsWM=;
 b=t1Pb8eMW3M0LrB2KJlu7fFJ225U1T2jo6pvfXp81aPUL9VyLAHAq/PA394tkaj3qYsQjxgMa4zWUTfB/8rcFc2yM6PN2z1IJSc2dE/guZ4vs4X6+HPdCPLpNRL6GY1/dtNSHDxuxmIw2gsMjoWZ2z4wowjeiLIVeOuhNiVpNcLf9pyLlFTUINUmCUIH2I8iUrXHyvi+U1/HDL3rNMpvV8NecTT8cPPSiv/y/oNB8EcHrweTqHKOVSCL6N/JxwHu8LxBMeJpnpPyA5Q50G7swtE7e8Yvm08PfqI56L7e9s8j6ZVLXtHKhNNJTSwqlogps6Dbg8XZpz4dSOjfBuFGJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y11DU6GM1Y92e9HSW5hvUj9HKTN6tGsBmfFNF7RPsWM=;
 b=XpFj/vvT2VxbmTkD/ax8OzOlEmt2h+p5aas2Af7cgABABv24IdHasSd2pEjVxwvI32jUrJTjsZJT2uvzZUZdL2JFh7OwUsgRjr0cMQdxGNFPmJvr6Kq/Uoovl06MA/gW9uZLaZcCqrf8xMvhb/9RmnrkOY4Q4crj18iDICTEraA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHXPR12MB999220.namprd12.prod.outlook.com (2603:10b6:610:2fd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 13:28:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:28:51 +0000
Message-ID: <cd4ae4ec-6baf-4e00-9b15-d05fade58ef8@amd.com>
Date: Wed, 1 Apr 2026 15:28:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 4/5] drm/amdgpu/userq: call dma_resv_wait_timeout
 without test for signalled
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
 <20260331134654.2762805-5-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331134654.2762805-5-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHXPR12MB999220:EE_
X-MS-Office365-Filtering-Correlation-Id: dad9d503-5ace-46d5-1d69-08de8ff29ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ePCzqyWpg1chT9c59Xqsjf//rIxbKsN1svLGhnnclGGNmAi42iysuXpx6ir0aUVWKqb7QGo/bCLwkVrHi58OJI9bWUEhXiQ8NSKaEt777F97QWzMMnmK5a76kaFkbeVi57ytmbmnIbgD7r8fcsgfXorSd3qzJMr1dsti2NfCPvxEKclcT+mzKpp4APAfvG80oxihMrp0FgRM91y8xviICrm8bqxf9lDZ2340LzNle/X0x6dvbI5NJHwbtSnLHAEgcaeCPU2SvL9P7U49j1i4iShKTWj/VF9A5QgvsfZFnFCee3Zi47aSzqC51cxqSOz7i7eDrqIdcRnjZDgHTb6T8RXMdELmUmn3qPK0QMXGG6uplxYhHA6XZxa6AQDeO/rfXuW049uyFzQcKxVF4lHO0QBeQPHTRri/s1Pa+fPqq9sKZLhqW81aVihPXfgzQz7km72zoj42TXobki9AVhahh8NoRoYpk7YBru833I0Dqz8usZbclAi8UDR8bTE3GX0gMxDPZFgvLtMcFpcwuOePYH/dFZl3mtvt1vkmYXC1nLDnis+2pHa888HAK+mIQnlya8nFOxsZTkEq4FDjxw7zLDLtibCHqZV9aNOPS1NQeh45INR0L/9I7p1AohHcqf2t6hJBbJ0QMFwCbmlMCGb6vQLlQNjxfDPsELmrHue7jQcigCNpAuoWdi9oCO0aKaFKlq8H67XqC/Jp3r8WZGjFWiVcV5cCSDP2LeaNOXFvu+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHN6OFNDaUM1V2EwVDhXK09GdUJuVUIrTU10VVNqa01JbUdVd0tMbFYzMitD?=
 =?utf-8?B?NEY2MEFyY0plU3I5dnd5T2czU01BYlh0WGRtMHY1ejR1TnpzS2xXdEIzT2F4?=
 =?utf-8?B?L2xvNnFLTExpRzBGUzRTNzJDWS9naW40V01nbXJ0RWhzT0doRm9Ka3hKb0tq?=
 =?utf-8?B?SUhRKzdicnhZZ0gxY1ZVL3lRMGtTTFdzUzlaVm5GNnVaL0RQTnFsZWF1T2FU?=
 =?utf-8?B?TmlUWmg1aUJITkhRbGVIUWNrV1NhM2hXR1hsVWIwTUlZQS9oYjRjTTlRdWRs?=
 =?utf-8?B?ZGZlYXpnWXVQa1ZSaUU4Z2hOc1ozWUJqU2J4TDU5OFB1TTFUL24vOHJxQit2?=
 =?utf-8?B?UWpCSmFzcTUwUWdrbUY2SWZQMnc2cUF6UCswTTZjWXVXcEtaT0JZcUIwazhp?=
 =?utf-8?B?VnY2bHdZUW1kK1doTmhrc09lMW9OOXBPNXNjdHdpajV4VXNERWJXZXpOakds?=
 =?utf-8?B?U0FRV1M4blAxTkVXbkRCTGtQZEFzMXloVFVTcGdsS3A4L2wrMThsWE81WTFJ?=
 =?utf-8?B?c0Jka0taTUhyekowb2NDWFBpc0dFRUluYndvUElTenRvVFBVdzNTYy9xMGpI?=
 =?utf-8?B?NHR1Qk0zc2RIamxjT0pxNmoyakkrdmJTQ2JRSm1EdkFrQ042akhsRHpLWEZB?=
 =?utf-8?B?VVo2SW9lRm9SeUI5R2NiSTd0amx2bmFTblgvOVhEUVdFM0g2aW5Qem96QWli?=
 =?utf-8?B?MVpuS2Z6a2Y5N2pjKytrL3pCcG5YMFF5R2g2Y0ZCdkY3Qld6QXpHQjRaZTQ4?=
 =?utf-8?B?ZnltZ3JCbHlnd0pMeTBYeWdLYmk4T1lWWi9qb2dyMUFPNWx2eWJuTmtZQlA4?=
 =?utf-8?B?eWRUejRlRUFkYm85N2p0dWZKTUI1ZUpneWJIODBvY1VpaHZKNjJMRjhML2Vz?=
 =?utf-8?B?RFlRNFJqKzI1QmtaeWdJVnlSQTk3cWpMTGQvUUtPKy94S1pITjNwWmFKWjFU?=
 =?utf-8?B?ZmEyVXBkTXdEUTZaeDJrcXdXUVpRUktxWlEyL0swKzV2em91NDN6R0hPcXlR?=
 =?utf-8?B?WTJQTDU4MklvUzJtNGJobStBc0ZmZDUyUlVhMXVKOCsxeUYwWnFxU3JLeTNp?=
 =?utf-8?B?aTU1VDNHN3NBbWRFZjJ2ZytkRnJyYy9mMnV5S2N6ajdVUW9KUW9ZNDYxSXNq?=
 =?utf-8?B?TEFnRlBpd3RsVm5qaHd0RVdlQnFBWU5wQU1xcGZoWTNZQVcvaUdiQ1liQ1RB?=
 =?utf-8?B?VUNBNmlJM0hrRzhseUJacjJOZG4xRm0rNytOc3JQMWZpdEs3czdQRndBZDJr?=
 =?utf-8?B?aGcrWDdKK2lTSlZZeDdLLzdLcWthaHhTUm83M0prb0pjQys4T1l3S1Myd0hF?=
 =?utf-8?B?NGNTeW5lcDBmakx4Ty91VVFuekEwOGtnNkpvblFMZUZQV2NDeDRVd2w0L29y?=
 =?utf-8?B?VlZ6emRHK1NMZ3N2YVExL2JWZ0FrS2ZrN3N2VFhqaUpwK21PMC9qSnJtSkxB?=
 =?utf-8?B?MERVYWVuck1zNExONG11Z3JVY0dxcGZIMnQrLzVXT2h2YXk5cUxZMDYxUTFO?=
 =?utf-8?B?bk5DYVpYYjF0VjdvVTJiNXB5ME1sVTVrRkdLN25HaHFjTlpJSXMwSlNtU1Yy?=
 =?utf-8?B?TjR4VWFwQnEvaS9WVEQ2UTNRR2xoRnExQWJaV0pVVHRYWEpKcTZXejY3aWsx?=
 =?utf-8?B?MEQ2T1lWMUhFTnZDa1NkTFVsREhyNHFFeTRVcmw4c3JoVXZ2czVpN2VjMVNT?=
 =?utf-8?B?YTdyQlZxeldvUXhsMHIwM2RtVjZEbi9ER0YwTGFvR1NMYm9VWmRSazVqaTlt?=
 =?utf-8?B?WGFrZTM0WnJnK3VFeEJtcUFFK1NGZ2liZlpiWS9aTUJyNEM4QzlWRS9Saklq?=
 =?utf-8?B?TDVjOEhFNnorZXdjeEdEdzlWQ3VOd0ZIc2M5TjZNWGVnNml3UUxOVndqQk5T?=
 =?utf-8?B?WXhIUFVmNm9seDJrYlVvR2piY0pHcVFyL0RpZDVvbEYrTGkzZmVEZHl4djNm?=
 =?utf-8?B?ZUJYNi9SRDhxOE5tU1ByV2ZWK1hsZWo4ZTVCWHo2eXAwdDNpbkZkaFF5Unp3?=
 =?utf-8?B?TStVZ0tWTnFZK0JaK2tDMHJiRlNlYUlNQ01yZzRjTy9uSG9DeURMWDBmTkZB?=
 =?utf-8?B?N0MwK2xzL1F2VHRqQVpNQmVOQkFaN3JNbHJSUzZObDNqa0xCcmU2TWxPRHpQ?=
 =?utf-8?B?ekdFQW1ldEF5Y2dJUlpTVFdhOFdGS3dqa0R5RGs0eUIrVEVBMW80MUROY0Rj?=
 =?utf-8?B?ZHlVUFZBY0NJUmpWYmxSaUV0ME95YjgxOVVhMGFtZ0M5Q1RYcTNFTzZLTy9U?=
 =?utf-8?B?bXBBNTJ1RUhaa2JQTzNGS0JrL0tyZGJXakNaK0xpTnE2L2pXNUdnYWZWVkpU?=
 =?utf-8?Q?kWviUMby0fJd8GEMxT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad9d503-5ace-46d5-1d69-08de8ff29ceb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:28:51.1685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLyri7l5eIvjVKUnnSxqICTOQfYet6SQlFMn8vyTwWooVm5Cjp8KQ3ilNwoKq0d3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999220
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

On 3/31/26 15:46, Sunil Khatri wrote:
> In function amdgpu_userq_gem_va_unmap_validate call
> dma_resv_wait_timeout directly. Also since we are waiting
> forever we should not be having any return value and hence
> no handling needed.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++------
>  3 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5c1ed4d0edbe..31f45bd2732c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1462,17 +1462,16 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> -int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  				       struct amdgpu_bo_va_mapping *mapping,
>  				       uint64_t saddr)
>  {
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_bo_va *bo_va = mapping->bo_va;
>  	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
> -	int ret = 0;
>  
>  	if (!ip_mask)
> -		return 0;
> +		return;
>  
>  	dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
>  	/**
> @@ -1483,14 +1482,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	 * unmap is only for one kind of userq VAs, so at this point suppose
>  	 * the eviction fence is always unsignaled.
>  	 */
> -	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> -		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
> -					    MAX_SCHEDULE_TIMEOUT);
> -		if (ret <= 0)
> -			return -EBUSY;
> -	}
> -
> -	return 0;
> +	dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
> +				     false, MAX_SCHEDULE_TIMEOUT);
>  }
>  
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index a4d44abf24fa..d0c502268643 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -160,7 +160,7 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  				   struct amdgpu_usermode_queue *queue,
>  				   u64 addr, u64 expected_size);
> -int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  				       struct amdgpu_bo_va_mapping *mapping,
>  				       uint64_t saddr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 937a6dd3a4b5..cd27970844c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2003,12 +2003,8 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	 * during user requests GEM unmap IOCTL except for forcing the unmap
>  	 * from user space.
>  	 */
> -	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
> -		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
> -		if (unlikely(r == -EBUSY))
> -			dev_warn_once(adev->dev,
> -				      "Attempt to unmap an active userq buffer\n");
> -	}
> +	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0))
> +		amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
>  
>  	list_del(&mapping->list);
>  	amdgpu_vm_it_remove(mapping, &vm->va);

