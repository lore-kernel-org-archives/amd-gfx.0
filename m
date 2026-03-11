Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756311062884
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 12:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C24510E1BC;
	Wed, 11 Mar 2026 12:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFs4mi9T";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CB810E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 12:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeftXkEC+6Qleh183S9b8AIXxZ41EfavLw16ckrUsiWYaWaE2ygqjiE4mSO0yzkaZc46sSbmJanQ8U4UsVDjSQ6bJxKvOzX97I/Yz85pZp0/k8CAkZm1R7L/e9UhVnj/i30NLfdEXHTKWTXMsqWDoT78F2cM4yRX0SAZlXDKgOcQFaRXdp2x+dOCedQlF0Xj0kyhfFyAyMP90kEvT9JgOeF72CJf4RdgNup7OeANBItn4Y8CHjNeB4EKVKWbdIL1fN1+pkY9BdKzL1x2Z5qpGJ37afavHUiTAexJwTzBXSTGIKrNx0RFC+KoaBCtTBCivWkxJWf53jXjNqj7smp/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F1xiW6EIA/X6JON1eazifdWW/VqiNotbbPHWxoHIAI=;
 b=Pwo23tK7c0OVOu8S7U8FEl6SOXqbbv3ytX6n53xAiXQWsTc6LJ6MkUfjblghcgGmDQvOOXgTjfHnS/LPWcJEgCcN9VmzO3B5LjjVsBxsrrSKpL0FpoxSehdTyUGm1de1mqZ3etwH6fkYNYJ7c8F3tN2FeRZPdBHDHiYOCUUL/KRlMQxOwHgeZGN8vVZl+QxsRS06X+nn5fxlQOHlJCIRIDhhE3h+TQdsjH7KMpMWnf4HJqddT6lMUz8ZK6XHkrI/GBb/BVGBvrVbJRmYJky6xILMTebeBJ803QVcEJ61NPO9j6hyrSLzc1pv7uZAhn8rrr0XnuJc5gDSh3MzWxmdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F1xiW6EIA/X6JON1eazifdWW/VqiNotbbPHWxoHIAI=;
 b=HFs4mi9TnPde0dtijrBrFaosLUB5aGX+rB7H4YbbXmR6ZLb64cXNRww6g4UyRwpacBLjhte/xzBRH+Y7yKGijVeZ+oXj/jF0HzQwT6RMgYXwSstM4ponudYEVaJdmY0CarKetPityqd++GwNJQ4csf7EqLEyr4SoufRvh8IGXwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:26:50 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 12:26:50 +0000
Message-ID: <533e3f43-d375-44a4-a449-10a8c19aee28@amd.com>
Date: Wed, 11 Mar 2026 17:56:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/amdgpu: fix adding eviction fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-6-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: d1108838-b620-4075-7be7-08de7f697854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: oUKksYPIMUQccaGVjKEqU7Im+eYKJ3owji0vFqgfruYNg3h/Li5zKrKTCw525GV5fA3GAEypd2DfSaSPyjFVjEORBWIv9iVMazsUXPFQrPbzXL7ZmZQ/vNjxUzhdOwjy1asf4O5Bq2fSl/s82weMQImTzLDuRAw8ewvVQdp/AZdQBIngJTc1UjOWOVY+2nO+iwohlwqk6lnLBcHM08FkHJZ+FAUp/rjovcgOd1s10AfViYQ2i94PfSgSYiuMVaDTViCjTPMvjQjwLzpfXcVaQzp6kXBIuQrvwNduPtkgzYr4PlFxm3JlTl7Mecw8dlUenhVKW/FtahtCS7leNDUyKX2TnDxwDSUd/Pq/k+6WnCEGAMG76D4DBJ7kCm9/SDGftji8hljHGUiYYC50PYljEnS39QfUhAEw+sF5iMk/wCc/LTyf8JWgaXowiuQEePQseMoaB4fxPC3eWA0/hI27UdBvaB5Mv2pYYCfi1/arUN1iTSuYBZcwO1XT4swU+e1lv10v1b0WBOLgVZJUbK8c892iYixpqXZvQaATYTrQD/3GtS5EqfTB8KVL/ijOws0jKf5zP8Ox0w0SPVx6twKp0L3E9vfEu0XQIkME33WDbdKV/SwRcuXopbPrALAQmrVwK3dkNNttMo+F2XpMuw0MYZGgpxIZHXNcloXv+SXtRIRNBG7u3nAQM+buKXBsnK8ErIzMTSYiMxF6vksW05+fO19UOAEKAYjXbrLAsKYxf4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1BTT3FDZlA5aGV0d3lsTG1rd0JHenVLRU1XaDN5Y1RSSWxDaHk2U0Y0MC9p?=
 =?utf-8?B?VEkxUDc1N1BHTVY1MEVWVzNaSndyVmFjL2oycW9hTlRtbmwwbDhVN2dXKy9w?=
 =?utf-8?B?UlJMTFFPWHlnclBXdzNHZHE4SW94ODRBTXRxWWl1eks4OXk0ZWt3bDJ0WUFq?=
 =?utf-8?B?VStweG5QTkpnaTBPeCtoSW5RWXhMY2dJVU9oOVFuMXZOL2pzU1Fxdys4Q1FP?=
 =?utf-8?B?T3lIU1F6SXFJUE95bk5JOHF0Y3JidHNvbmRtdnhMSU5vY1g0WU8reXp2TnNa?=
 =?utf-8?B?Y3U2bEVWQ1R1VDdlaXpDOVJ6TlJXZGhOZXllbkpBVGg1SXl1djlNRWFJdkwz?=
 =?utf-8?B?bGQ5cTlncTNLSEkyZTZRaHNGRDVoYVZCMk5kaEdMeUFGU0YvT25hQWdPVCt5?=
 =?utf-8?B?NkVlbEs1cUhNeEd0SmU3MU04TEx6SWxhb3pPOWtQWmduaGE0MjAydUdUWnVM?=
 =?utf-8?B?VHJ1akJNZFVUS0dVTmo4T2hTSkJrbzlRU2x2emtvNUZtTXNjcG9xR3hQZFhH?=
 =?utf-8?B?Y2lHTmNMaFYwL2xhOVcxay96MnBXUnFMcFF2cFZKUmVCT0pyQ1JPY05OcmVC?=
 =?utf-8?B?YU5SYXhsRXVKZ3VEU3p1UHRXNnRRZUEvazMwTXZNNGp0V1NOOUlDd2UwcjR5?=
 =?utf-8?B?S3BIbzh6bitKVnFnMXBnb2FYeFpId3FnVXI2U0ljMTd1dGUxK0xWTVJPUGlT?=
 =?utf-8?B?ZVlyRUZkME1jS0EzaGpaYnRlZlE3ejJQc1Fvc1Z4YTV2LzROV3QvQnNGLzI0?=
 =?utf-8?B?dWZpdDVWb2VIQWpaL040S1E0RU1COWFhUXZ4Mks2a0VsWDQ2b3JJSTV0V1FD?=
 =?utf-8?B?TXRNeFRuRWJQRHlXTWxBaDF6YVlPZSt3QUlXK2dycFNvVmM5Z1Btak9lMlJi?=
 =?utf-8?B?MXQxTDc5a3JhZzRNMjMrdy83SjRBaEc3b0VZaEgxNld5c3hyWlo4Y1NYR1dT?=
 =?utf-8?B?OFVGUFpOOXBnU2FXS0F3NHVwNlN3NVNwRldCV3lnRzQ4Q3BxTEhEMkRaWTdJ?=
 =?utf-8?B?Q0g3NjM4N3c0SWh1RVpnYU5ONy8wSmxLZzVqVlBPTzU4OHVidnVaeVBYQzJW?=
 =?utf-8?B?aWVRcFFGZERtYVhSR0k0L3BjZUhRb2dEVEpQOW9tclBYWDlmclU2TmkrVExG?=
 =?utf-8?B?MlpDYlFmYUJOSzZJTTFYaS9SY2hmZDhGd0syUkVJbTFhNWRJTXZRTm9pVzc3?=
 =?utf-8?B?Ry9BUWdWK1pmdkN1eXN3VjltK2lnWHpqaXVvQW4yQiszZFFuR1docnRsTlh3?=
 =?utf-8?B?dk1Kazd0NmkyM3NNZ20wRTBPQUE3QXpxRWlhRzFyaWh4SXVyMlE5WXREVWV6?=
 =?utf-8?B?ODgxblorWmxLM2JSYzZTMkV0WnlWejNieXEwK1Nlelh6Vyt1RmtVSmhHK2h3?=
 =?utf-8?B?VCtrY1krenZHMmFDQjdIQ3lvdXgxS3FucXJIRVQwTW8xTXZ1d2ZjTGZhT1ox?=
 =?utf-8?B?N1RPeWNWMGpKam5LQ2EwZmtOdDVjcWRsKzQ1a3lxVXlpNmhDUzViUkZJU1hH?=
 =?utf-8?B?ci9HY05BTlZPWEoxWjFBS2Q1NG9QeG80VTk4MWFKOWNJSnhVbnB0MjgzN0pn?=
 =?utf-8?B?cmdVcWgySE1WOXplR01uQi9ubTVZRGR6T2RUeXg4ZmtqNWNwbG5XaUwzT3ha?=
 =?utf-8?B?MlZWdFkxTVUrWmRQT1ZmbS9uT1NpcHdDYTk1czR4YWRTZGlYaUxhWDNQZlFj?=
 =?utf-8?B?WWtMckxSTHFhVXY3TXlqWFFwaHpjZ28xTFJ6NjNTMEhQS095SzEvNkNteksz?=
 =?utf-8?B?T2sxTnBQWTRrM0FoQjd6aWloanFVRDJJcnVhbWxzRG00VWJpMVFDaWZTM0Uz?=
 =?utf-8?B?OEdGdytheG9ja29JK0d6ZU90VDVISHdYNUh2S2tWTStJbHh4SUxLc1FiTTJt?=
 =?utf-8?B?K1pxWmlvMUF2T0pSK0NzbFYvcUg2L0Q5WVJkdTc1b2I0Wko5dmo5cnhMRDNs?=
 =?utf-8?B?akVpT3JtdWNqV0xNUTJwbStJQmlRWEU5RGROcjQ4Q3NWNVNEeDE4Nk5jYVFF?=
 =?utf-8?B?aFJMQkJycTJZdVpja2tBM0VTQUNrUHhPYk1BZWJuNU5BSmhPUFJBbWdGaEEr?=
 =?utf-8?B?VEFkZ0FjL1BiR3hHQ2NBU0Q0SDhVei9GeFdrdFhDSzFkWWZtajR5VzZjd3Rx?=
 =?utf-8?B?NnZqcGVYU1BLdGxQK0J6MDZyNTJReFdNN3NhOTFLVDl2ZFhoNE9ZNTFURElC?=
 =?utf-8?B?ekUxbEJJT0VncCtveCtiVmNLUWFyd1ZtcHh2RHcxcHNISWVIWldZSnVUZHBM?=
 =?utf-8?B?ZVo2bElOM0I0U3VFQ3orVkRGY2paZldkQkJnRVhBS3lRbjE4Kzl4QVpzNzVK?=
 =?utf-8?B?ME9URHRzL2FHbW80WVFmbVQ0YUw2UkFtWXVXYXJ0cFFCNDJ4L0dIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1108838-b620-4075-7be7-08de7f697854
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:26:50.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIXUpDZIySHaczyEq9z+sAb1FaGd/2K909g8JmXvRobd1ittpQy/9Y2gti7FJJ1qt9q0t869KeEdWyLKXYLTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 12:43 am, Christian König wrote:
> We can't add the eviction fence without validating the BO.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 19 ++++++++++++++++---
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  9 ++++++---
>   3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index ef4da6f2e2a3..6598823ec619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -82,14 +82,27 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   }
>   
> -void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				 struct amdgpu_bo *bo)
> +int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				struct amdgpu_bo *bo)
>   {
>   	struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> +	struct ttm_operation_ctx ctx = { false, false };
>   	struct dma_resv *resv = bo->tbo.base.resv;
> +	int ret;
> +
> +	if (!dma_fence_is_signaled(ev_fence)) {
> +
> +		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +		if (!ret)
> +			dma_resv_add_fence(resv, ev_fence,
> +					   DMA_RESV_USAGE_BOOKKEEP);
> +	} else {
> +		ret = 0;
> +	}
>   
> -	dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
>   	dma_fence_put(ev_fence);
> +	return ret;
>   }
>   
>   int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index 132a13a5dc1c..2a750add4e7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -58,8 +58,8 @@ amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   	return ev_fence;
>   }
>   
> -void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -				 struct amdgpu_bo *bo);
> +int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				struct amdgpu_bo *bo);
>   int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>   			 struct drm_exec *exec);
>   void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e28abfd04867..88a21400ae09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -258,12 +258,15 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   
>   	amdgpu_vm_bo_update_shared(abo);
>   	bo_va = amdgpu_vm_bo_find(vm, abo);
> -	if (!bo_va)
> +	if (!bo_va) {
>   		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
> -	else
> +		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
> +		if (r)
> +			goto out_unlock;
> +	} else {
>   		++bo_va->ref_count;
> +	}
>   
> -	amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>   	drm_exec_fini(&exec);
>   
>   	/* Validate and add eviction fence to DMABuf imports with dynamic
