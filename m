Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEA11075275
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D22710E917;
	Thu, 19 Mar 2026 08:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHRXshGa";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8372610E919
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weA6JAhXdWVOwQssBOj4T58pO0X90/AdCjmyqjlQ7P3ZJ2ELXndizTs+sDbt7mzHiDK9XFLU15Z0NvaZYWM8r6Z6JHHDjgwTfGDwxCR9YPrP9XnzkpoFA0GWLhsw82xazXLznYYRjJR9miMvc8Dqs1PKwwNbRwnM71KQ6Z9yujun2OuHJfZEwPboyGAs9idZrVyMOE5qfebnaW+ORH87q1ZbyWx+A8I6g7WUpx8P4wT8vCfyOEDVi/Gde0t/pdqIISF6W5fvyTVItz/VQNt8jb0HIK7GOHl++5OFNxOLzmXhxf16WXnJGbFIHZcjKT6AWoPWMTOkC2u7KJMU2uX++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSm3c6qWnBEDGJnTuXgA6UYgBidX212GMtCxkwVRpbE=;
 b=ppwgs90eWlpLlH05h2BzEIISk5PH4tbqX80mPabRqeg43mFo9NBghlSxjpNIbAJtAZDHjk9i0tD3uHr7yIhkbPuBfoJNiDaELVu2AG7fj+++j4loZ5iVTvoTU+qReslAWCGOy7hv3DujrETQlqbJzhZEr3uQ154g9AKOb+7jTCDRF13O+6ycWOnnkE40wTQfVWwN6M8CaiCxIoV2/ySevG8+TMMDjNUCcKPoPCJCU3nBF/jgDbSlEqlkNa43zS8B4pVguQZFed+Aa1SEL5sf7fyEuzdovrrY5zjzX750BqhOYz9U2MLXulJU2tv6kdZ3fHlDLYDUMr01On46/UKTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSm3c6qWnBEDGJnTuXgA6UYgBidX212GMtCxkwVRpbE=;
 b=gHRXshGaeLlERcSqBTfLCBftujiImyKD04lqfj6G0AIp979L8olEjuASdtfp5hCF6WfGv77CpB8feDsSNDexOrqannGH2YS9jU8i4hm1L/waekHnhy/1w2x0chwZ7RZtLSuBYIXRAoRX9fQYv7+UggULORLiQ8AM6SM/SqNc0vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:42:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:42:02 +0000
Message-ID: <fadc98c8-8413-484f-b797-fe506f12dc25@amd.com>
Date: Thu, 19 Mar 2026 09:41:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: fix the tlb flush fence leak
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260319082150.3324177-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 20402b75-d684-444d-5b58-08de85936420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: zj7CRo5pg4hmvEEuJvWpGpARwytaVoQMcRlzGp5zep0IpxKJkyZpEffEaTN/VD4EwjyRgVAryPlRBOKRuYr5tWETB9y86oTmBurMPrjzlm7y9G2wtSbjChiJ3JnodWclnxiGUwTrrnLZYv0tzYQkz70FDKRHNl9l9p9FS+XZSetKoMUyF23TLD9YvtCAnpWmenk7lVg55xTbT1Y1fhmhjcKkcW+rrGNnG51AvP+CSR3ump3E1l0xlm9gcuNYzDUhKf1LJ03z/S68KGQ4QmQBgHv39GBJkzqkd9AKtGldj01WIbR+kqYXxklC8myeaboKSZAIVhy5yKPvBo0SkWjcxdByl7tlnO+lJXtlCcvyy81z9zZ2D1p8uIgP04EGZM4xmKaoXir0sduxR+hFdz+rE5+Re2MfrlUdUpxmqlfGIHlrajNx1e+FUA29TqwwME/zkyOPgQrxIQsE3cIXNVU1ysQ+Yri3l/gsvy8r2WV+8kBt/m8VcAP6cSNZMpuKl7yUAh7au4YL11Q3WzbnQ1TZTDZOIg8/Vi3t2ZDhRrqqQG8nZJbsxj7X8f5dbOjlulpI5XP7PjNgGnBskAUgNP1ScaVKpBMFz0lRgINSuGOZup0jn9njvSubune8zGE76EbVWbDe4jJKF8c/NRptYHbJyfMplDzonJcufRg/44R4gVgQN1uogv3CL2UyqpJ9Ks5ezHfCToJgL0qh0JEtMTDjoMMSMGy4oRBEGZjxazm8fak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V091SFRPWVlDeUJiTTZ2bW00QkgveXl4Q0ZIRk1yWTRCa0NRbHBCREdtQTNM?=
 =?utf-8?B?cU5BRWJGUkMwdjAydVFaNkN3VjFuMmtmdVRuRjUzaDR2RUNNamFaaVdHbVJi?=
 =?utf-8?B?d2pVYm1vQmFtL0pNZTR2Z2lNYzl5elFuQnFSbWNkNzM2WXZTT3ZvNFpNUlQy?=
 =?utf-8?B?ZjdkZmlGZjZ6TUtkM1YvOWRkV1oyR0xkK3ZUMk8rblZFbGEweTMvczF0OEZW?=
 =?utf-8?B?YjdadHlMUjByY3lxM1dqejB2UWgyVHJKQ3JrR09yUlpCSXJ2TkhybStzMS91?=
 =?utf-8?B?c2M4YURsN3hRVmxTUTRuWFZHRGFaNWNob1VkWWJnZGlNZDI0Vk9tbnJFeld3?=
 =?utf-8?B?cDRINWhVUTB3b2kwTXd0aEVOeVQyak93RVU4Yml6amhNV3NoVGxnZmVGRU1N?=
 =?utf-8?B?SkpXVGZVRmVDZnZpMlhJbm53bGxKbTRMTEhvcllJdjI0WkZiQ1htSFJkR2kr?=
 =?utf-8?B?NFEydGcvT2hYVGM2cWtpdnZ1bmpnejJuMkxxZHRrRHQyUk9PTWljR3BtWmZn?=
 =?utf-8?B?ZGpxYU5XdDdkWG9TVU5pTHFOV1RXaHIvNXVrU0dqbUQ3Q093TTFkMlhwbVB4?=
 =?utf-8?B?amFZVjI5Z0g1UEt5cm4vMzZxdy8rcjBtc3dCWm9CUHEwU0dXL1BNSitCVWwy?=
 =?utf-8?B?bjJHVGQ0K21aZDdGZ2xqWjVGRytUL3ZpRG1mN1FDOGZ0aUhWc3RMblhVSGFK?=
 =?utf-8?B?N2hiMlpOcXZDRUdPOFNLelBFOGllallVYlZhVkRuL0l1ZzNweUdKK0JzOW5B?=
 =?utf-8?B?dHdKa1RLMFh3ZXZhOEZRdWx5ekhDb3hXUE5WVndyUWJ5OU9oUExPbmx6Qk5j?=
 =?utf-8?B?S2VkYU5UOTZINGs4Sm5XRVBvbXFwbFRLZXJsOFZvY3djUUpLd2hPdnUxbi9X?=
 =?utf-8?B?RElUNWNjRHVCZ2M4L25tTjM1NUZQU1BEUS9haWFLbXE2MzhlUVlNejBpNVNi?=
 =?utf-8?B?M1BQR1dyWGE4SWd0eUpmYXNyWUQ0QUlwcjZnUnZpZi9sSHo2akxranFnWk9o?=
 =?utf-8?B?dk1Gb2pDTmZTQ0lSb29ZUm1DOTg0OVFCY3JqUXNiWTZ1eGFZWGJyRE1xeTNx?=
 =?utf-8?B?ZUIwSm9jTldZRE5TR2UwTUs1UWFNL3VnazZGVjRIN25aTjVsa1VjampvOFZC?=
 =?utf-8?B?bFNYckR5Y24xTnZPakxPRlJXUU5RYTFFNzJNbmo4VkV0MTZXQmFETmQ3bW9r?=
 =?utf-8?B?aDlTUG9KckNOWHBpOHJxaHNocnBLQVFvSVZodHFaT2ZvTkw3V0RQM3dKUm5T?=
 =?utf-8?B?UUEyOVloMFpvTGxlRzIzZVQ2eUhBZWg0ZzhWL0pZM0pLSmNWSlBMaytOSXNq?=
 =?utf-8?B?eEtIVDNwNkNDZDNjNzhEcWNaZUVhNVVtM0d3bzdHbTIxY0s0M1d3clBxckxY?=
 =?utf-8?B?TGk3S0xKdktYVGs5RTJTRndEdEhWNGxCMldLbExscEZUUjlONWV2eEdtU3JL?=
 =?utf-8?B?QTVXVU5Ia0ZHNGpRNDZocUxzYms1RmRLQXJKOW93ajRQdXJtODg2SGo2TzRh?=
 =?utf-8?B?dnVpcHVlbzVWVjc5WEdkU1lDUU9IY1djR2FuTnc2Q2ZDdkNZMVJVWUlLbWUw?=
 =?utf-8?B?TVpsWVdoVGoyMm5PWUJsNUxvRTBRMVhMVHJRN3NtV1NIQzlzcHJJYTBtZlFw?=
 =?utf-8?B?dUVWODR2SjI0N0M5TWM1UkxwNWhzSSt2b3FTY21CNnF6OXFSa2lFdWpjRUdy?=
 =?utf-8?B?a2gzMFZTMlYwaWpsY0JEU1c0N0hMNHlrOHU3NDhmM0ZydTlSVjI3ZHMrZmdl?=
 =?utf-8?B?VWlSSDgxTDZRUXp5ZUZFdnE1QVJ5a28rTngvTjZXaDAwL3N0UGs1aE1uWEpG?=
 =?utf-8?B?SDVyMzBNRG5JRnVGTnNGOXhiTm0rQXF3RTNZTVh2RUlzaXRHNmNQbWxqQVl5?=
 =?utf-8?B?VGt5VndKTkYyTU42RnNVN0kxeVN3V2JldXZLd2hWUElyTnQyUkVLaGdqOFIx?=
 =?utf-8?B?VlpEUEtyY0U4YjNXNVFCVjRISUZoU2svMlRHSlhXdUtnTVNnSWpabHlEWmNx?=
 =?utf-8?B?NHFieVVJeEdKQnZaYUYzanJvOWp0NWQyUDVCRGZtMGplKy9XM2t6ZGtMYTdJ?=
 =?utf-8?B?NFZyTTlZSGRXeDRHS3VGWHNsajRpejgycS9vWWkycnAyemZSK1VXQnNmU0wx?=
 =?utf-8?B?dkVuWGh1UXpzTEc5eEZMU2F2ejF0cHFMbFh3T1Q4NE92Z24xK25tR3ZZNE9S?=
 =?utf-8?B?NkV3a1kvTWZRZnJRQWt3SXFJUGdnZEF1Y3EvZVU5d0Uxcm4wendJYTFFT1V5?=
 =?utf-8?B?YkRwb1VZTEJXNUZxMWhONnRnckcwMHFjekVxQmJaU1M0aU1zNlJQZEg3TllD?=
 =?utf-8?Q?h5baMweeuZ6dWwXRaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20402b75-d684-444d-5b58-08de85936420
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:42:02.2348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfXZaxgSIdNBSToTI2Ktc5qax5EwEQjPagpnWT7rWyF+fzcP4Z+hBZFaDGQKGdBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
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



On 3/19/26 09:21, Prike Liang wrote:
> The TLB flush fence leaked during walking over
> the free mapping list. Meanwhile, the TLB flush fence
> is referenced by root BOs reservation which is a false
> leak and we should mark it.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7ef0cb6bcbda..1cd4c4217b02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1560,6 +1560,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  		goto error_free;
>  
>  	while (!list_empty(&vm->freed)) {
> +		struct dma_fence *old_f = f;
> +
>  		mapping = list_first_entry(&vm->freed,
>  			struct amdgpu_bo_va_mapping, list);
>  		list_del(&mapping->list);
> @@ -1572,6 +1574,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  			dma_fence_put(f);
>  			goto error_free;
>  		}
> +		dma_fence_put(old_f);

That is incorrect as far as I can see, you are dropping the fence without acquiring a reference.

>  	}
>  
>  	if (fence && f) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 5d26797356a3..93b72289e7df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/dma-fence.h>
>  #include <linux/workqueue.h>
> +#include <linux/kmemleak.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> @@ -106,6 +107,10 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>  	/* TODO: We probably need a separate wq here */
>  	dma_fence_get(&f->base);
>  	schedule_work(&f->work);
> -
> +	/* The TLB fence is referenced by dma_resv and
> +	 * the resv ref is the remaining ref, so that's
> +	 * a false positive leak.
> +	 */
> +	kmemleak_not_leak(f);

That is just utterly nonsense. kmemleak is perfectly capable to detect the pointer in the dma_resv object.

Regards,
Christian.

>  	*fence = &f->base;
>  }

