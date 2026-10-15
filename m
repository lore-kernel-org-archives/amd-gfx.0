Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64BFCC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 13:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3567110EB89;
	Thu, 15 Oct 2026 13:05:13 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A8B10EB89
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 13:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdp+4w6M5vfhDIp0LbYZYfgkXu3vugtSHqWV4lD44DHcb86T7X5mjqmFA0yfX7M2jpyLajj3P/zAsMkdflQnKRQNADexLp+y6V4QgQ46aa5yhKrP6RezEwuUu3PfA8C3C8d9ncj8TL084NYPMcNM1UAufxZTCbi3CltctemEjgIkD4tKghCcEkTkDyDdoeqX94VPWH4B9IwczB92P1+lP0atIDN8xtbFcxuPiH7lrK4Lc4AsHBgEtiiyANFcLuI/HLzEOd7SCXZj0iiNpBOAccBLON/lbbr+dBzTqFUNgRMQzjWD1WDRO7baLVkruNBDWwyC/3KmwVCYTvPheErEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmolU4FfcNp2abF0a1n7ZniHFRAng2kSsncAhkJzZAE=;
 b=tzj69zjGRWlZT2UVt6wNGsXX3KSK9P4lKlQ9I6eJGy3M3TKaM2Jk3qPGAtmHSMyy3XwcpOeOgsVqi5XRF+UTOk0UcH5lOXITlYn5YlC2JdCmYpI4PnyR86F43uIGF6p7iaxi30qbJRiJHgUGKR13wcSjQtt/PdmmoTgKizqEcGABZ2IM6V44pLtLsa4YcpuCGs3wDBHgD5vx1w2skiTUkl9IqGrshUZ/037yG6AAp2256SP4YZSxsY68leL/SAwdyJ9K8JzLDEl9AV6W2iLhGOkvzrcpmxHmKYV9tmyRlNgpVYVq0rbdTR2AVLjgSDVotnIzhPIH4jvOdQOb4MPXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmolU4FfcNp2abF0a1n7ZniHFRAng2kSsncAhkJzZAE=;
 b=BbvYhBmeWKSOjH1uprT5adTzcBBEvAwCqKUf4pvtq495O9wn17yC0XwX/3A7T2D5x7xS3ynwYeZy7z3K86HVD+MXq1gqxDSMay5UgXQMN3iIe5RAHJIjvlKXisCC4zXBfLKIllaMoKVucQv2vgyALCdytvbxINlQlnqL8VSYlDI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 13:05:00 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 13:05:00 +0000
Message-ID: <b225bc76-d405-4955-8a88-b82b47c7512e@amd.com>
Date: Thu, 15 Oct 2026 09:04:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix TLB invalidation fence handling
To: amd-gfx@lists.freedesktop.org
References: <20261008124232.23825-1-christian.koenig@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261008124232.23825-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0227.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::9) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: d86ad095-6a7e-4142-b89c-08df2abceb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|261009223027099003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Dur/T+1odyv5zucHDxwK3Z2+bCh87uhl1GelwtKMR254ycGR8ikAeruHGfGmtvlNydq0co5bzuyFQt4ZbjHQFV6ummlWfDo5oTPwCrlMliZP2UmUdspJHWGjzZakW7kYyrvtirNJHQ6GXZiryMqCHQ7XH3JHosMInIkuz6xZEn8L4k9IRF4nWW2EsaZklWHhFJd46QYa3lcItjyFtg9n/mF1bUEWbF0K+Nsp2DM3cJjql0ubCl5PDm5y9yB7ZzajEYhPM0Op/MQcTw70+44Tq6S/4z5CUUqr6AdZ7oJivfTQmdCwrfRQizwGe4lZ/K3xmFCP0lt3RRvuA1uHlsY7NBtf97ejADvbcxYMTGdguTa/mj67i9swC0rb8LVBgseWula47IPA0nC/ny8MGWtedkurqXOSuOccoXs2opf/Frk/CT7QGO40rtsbGP+idTpJ4Slx1WNoUMivo3uMhCgvT0+ArOWFfMveKm1/A2U847Ew3ABbW5mdFbswo+qFPCFxMMfqAsHaRhp+31ERkj7M52wtMBsns8qc2I0xEnl1XhAliKJoGJqyWipoCJkMcl3MTsogNSEAI7p7e465EwAWoK6UNihfQS8Df7OwIBml2m3ndxESCd3nIV+ZzfmsWozMpnOa9r0TTXvXiegKmIZckelQ55Leqs2TAsNyO4N75PI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRvbkxaWVNqMjJ3VWRKVU9MVDE1a2dQU2RJbkFkNlpVQWZlemhzcXV3R1Br?=
 =?utf-8?B?dmJMbVFIVkd4R1d5OTZlSWtrZ3dtUnJLUXRhSzZuMmVrUS9nYVVqWHFvd1dr?=
 =?utf-8?B?MzdTMG90Nkg1RGVzUXU2MmZ0V092dmw1V2FNbmxJWFBsQ3NEdlpuWjh2TnJZ?=
 =?utf-8?B?V2FYS294SUsyMTRQV1hFNUcxOHhGSUphSll5bkpOWDNCMEJOYmx0N3lDb1U2?=
 =?utf-8?B?WGtlUzNLSFI2aVNLZ3NFcXBFOXZWaVlqRHFFRGFmM2dFMHpNRUwveElBOVpG?=
 =?utf-8?B?UFVGd1FlNUF3bHNmSGlnUXRsRXlGZjFFRm1UaHNScWJKRTJKbkRkc3hRMG9q?=
 =?utf-8?B?bXNGZE9mTUxjb2ZDbEtaM2UrNHQ2bGIxRWk1VXNwVU9BMlgxSG9vcWlTaERr?=
 =?utf-8?B?Y0pZM0VoczR3OTRnbGhTSXZJUk9NQjZlWUFTZTV2NmhTUEViYTNKQWpveGFS?=
 =?utf-8?B?L1RHMDZhM1p2L0RQK0U3dGRYeitNSW1WMkEvOUlQOURlVWJnLzNCaU5BOHVu?=
 =?utf-8?B?UjhkcEFpeWQxdU5SMFpuZG93dzV1NndHT2E4M1h6YXM4RmZoc3hUMVFObjFT?=
 =?utf-8?B?UWozL2tsOWFhWlN1R2plWU96WjJoc2YwbFdsa1VQK3hQZFJzcW9meUdpZkVW?=
 =?utf-8?B?OUU2N1R3WnZRRzdOR04yMUNVRVRzUTAyaDI2aUU5Z21LU0Q2QldQSk04L1Bh?=
 =?utf-8?B?ckZVQmpZSDVnLzhnU2ZvSWgyN2F0UGdMRkM1SkFLVk9adHgwRGs4Wm04Q2I5?=
 =?utf-8?B?YUZYU3FWSHFwYTRuZ1pPc2hScEM5R0ZRRUJEVDVKd2NhWlFaeHhrS2NvRkhZ?=
 =?utf-8?B?bUxJcS9ndSt2aUREVHBnVnN2UTUyKzlISWMvMmtXeVNsM0ZzMWxLc3hLMjd5?=
 =?utf-8?B?SlNOYmMxYzB1T0xUT1Yxc0FpMEFldlhCdUZVMHcva1ZHckthMjhuUzZqaXF1?=
 =?utf-8?B?YWpCek5Mc1FNRXFEWGxjS2Y5bnhKak8yZm81ck9obU9SWXZidkJoMm1ibXI5?=
 =?utf-8?B?T1Q2eDhWamV3VW9uSm43SkQyR0ZtL2hwcFZnSzJINGNlQXRzaUhZcXhPdGNQ?=
 =?utf-8?B?Zis0OWFPUE43dlBheHh2TDFrTW9rZWRJNHNxbGYyVVQ3enpuYURIdzdkMUJ1?=
 =?utf-8?B?Z0tkNzU4SjBpZy9JdXc1aWVEYmpvU3p1VWdDUGJ2NWRienpWa2hWUkFNRDBz?=
 =?utf-8?B?SHNrZ2NQMjgyLytHd3pQVVhaRHpFMnhGalZDWmU2UFdlZVdJUkRUbytzek90?=
 =?utf-8?B?ZEhRUExmN2EyNW4xSUNtRytwK053OFZVMUMvN2FBS2t3Tnp3Vk9DMkozVlhz?=
 =?utf-8?B?MUF0MS9VK3FLaXRGbWUxQkVUQjlkNTYzUU5HMUFETWtQSjdRWVBOa2NSZDZZ?=
 =?utf-8?B?S2hKZ0JlL0YxNWJkOEV5K3MxeUI3KzdIY3ZPeEpnSVBmZWFqUEVTbmxLd2FZ?=
 =?utf-8?B?S0RDUkxPdFdhazVCQnFLVXM5VmswT0MrNDdKWVhsSENia1o4ZGNHczZZMTFl?=
 =?utf-8?B?UEZBWTVueG9mU0RFczJqTmREdFFkZVZBb3l6WExwYWV0TE9XaE81T3JxTjJm?=
 =?utf-8?B?bjJZM1F3dGd6YUwrM0V2OUtIN2lpQXNaY3hkQWdxbGlha2wwU1BnSnlzaUsy?=
 =?utf-8?B?YURBMXcyWGZ0eHRpMWN3QTNpYkgyU2Z2QkpKTlU3VXFFMk5nMk4vdnozbHhh?=
 =?utf-8?B?S1hhQUQwNDRHUFJtYVk4eDQza1prajcyL2dIWlFEeEtpZzYycExxb2t6RDhQ?=
 =?utf-8?B?ejRXalIxblJZOHgrYzgzaHlvdlNVRStHZXBZL0VVa2ZNQUhoWWdSaXJjRnlP?=
 =?utf-8?B?TWFCZGJCbGt0Uk03czlqUFUwTnBYQmpDS1QrZlQvOUtySHpubmhlWGczWnhn?=
 =?utf-8?B?bVdheVR5aXVnNldQV2FkVnlFQkNZSWVPVjhyMU1CNVIrSWtsY2N1RkZsMHBT?=
 =?utf-8?B?OVBWYmtQdEI4amVBVCs5VHNYUlV6YVRLMTZoYVRORXBiMENwUzZ6dEtZNU9a?=
 =?utf-8?B?TXFXdzRSUWsvODI3LzhjT0dOWGRWQVpWcC9NVHN3TlM1ZUZpWm03VnpmS0k1?=
 =?utf-8?B?dWpia3RzTzRxQUpNS3dWVVU0ZFlQTzFZUUVBK0JMYkcvRVZVSS9lV3lqd09H?=
 =?utf-8?B?ZEt3MktxS0QvUG9FZVUrWGhLT3EzWTdxQVlTbndFWG55NWpwenZaUlJ2enls?=
 =?utf-8?B?Q3NBNnY4ZkkyaXczcGxjY1RGekFZaWFONEI0MUpWbUpZalkvWGNBdVR3LzNI?=
 =?utf-8?B?TFoxb3gxYUFmay9Xd0FZWnVJcldJOFlJckZzajk5Z1pvbXozYVgrd01TcWxw?=
 =?utf-8?B?TFBwc2pXUGtySG9qRkh4Yi9hS25abHc3KzJKZjRqaGxFRHN1MXpDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86ad095-6a7e-4142-b89c-08df2abceb36
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:05:00.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jW6Sr5/GmHCtbMspsZPdYhmUVOfyzfU9KbV2mM4hjDxKKYa/AO9N2NqqOSBEiS5Onnxw3YvzF634WismGBlkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
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


On 2026-10-08 08:42, Christian König wrote:
> After each unmap it might be necessary to invalidate the TLB to flush out
> VM changes to the HW and make it visible to executing work.
>
> We tracked that as part of the vm->last_update fence, but as pointed out
> by David it can be that this is overwritten by PDE updates when we have a
> combined unmap/map operation.
>
> In that case userspace doesn't correctly wait for the TLB invalidation to
> finish leading to all kind of problems (sq_int, page faults etc...).
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 20 ++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 39 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 13 ++++---
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 21 +++++++---
>  4 files changed, 55 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 374f1322c3ee4..606725d0eb155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -843,18 +843,24 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  		/*
>  		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
>  		 * bo_va->last_pt_update and vm->last_update or otherwise we
> -		 * potentially miss the PDE updates.
> +		 * potentially miss the PDE updates or TLB invalidation.
>  		 */
>  		fence = dma_fence_unwrap_merge(vm->last_update,
> +					       vm->last_tlb_inv,
>  					       bo_va->last_pt_update);
> -		if (!fence) {
> -			/* As fallback in OOM situations */
> -			dma_fence_wait(vm->last_update, false);
> +		if (!fence)
>  			dma_fence_wait(bo_va->last_pt_update, false);
> -			fence = dma_fence_get_stub();
> -		}
> +
>  	} else {
> -		fence = dma_fence_get(vm->last_update);
> +		fence = dma_fence_unwrap_merge(vm->last_update,
> +					       vm->last_tlb_inv);
> +	}
> +
> +	if (!fence) {
> +		/* As fallback in OOM situations */
> +		dma_fence_wait(vm->last_update, false);
> +		dma_fence_wait(vm->last_tlb_inv, false);
> +		fence = dma_fence_get_stub();
>  	}
>  
>  	return fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7d3659ef11e53..f124320345ec4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1071,21 +1071,16 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>   */
>  static void
>  amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> -		    struct dma_fence **fence,
> +		    struct dma_fence *fence,
>  		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
>  {
>  	struct amdgpu_vm *vm = params->vm;
>  
>  	tlb_cb->vm = vm;
> -	if (!fence || !*fence) {
> -		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -		return;
> -	}
> -
> -	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
> -				    amdgpu_vm_tlb_seq_cb)) {
> -		dma_fence_put(vm->last_tlb_flush);
> -		vm->last_tlb_flush = dma_fence_get(*fence);
> +	if (!fence || !dma_fence_add_callback(fence, &tlb_cb->cb,


Shouldn't this be if (fence || !dma_fence_add_callback(...))? Otherwise the tlb_seq never gets incremented.


> +					      amdgpu_vm_tlb_seq_cb)) {
> +		dma_fence_put(vm->last_seq_flush);
> +		vm->last_seq_flush = dma_fence_get(fence);
>  	} else {
>  		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>  	}
> @@ -1095,11 +1090,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
>  	 */
>  	if (!params->unlocked && vm->need_tlb_fence) {
> -		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
> +		amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
> +					   &vm->last_tlb_inv);
>  
>  		/* Makes sure no PD/PT is freed before the flush */
> -		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> -				   DMA_RESV_USAGE_BOOKKEEP);
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> +				   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
>  	}
>  }
>  
> @@ -1248,7 +1244,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		goto error_free;
>  
>  	if (params.needs_flush) {
> -		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
>  		tlb_cb = NULL;
>  	}
>  
> @@ -2647,7 +2643,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	vm->last_update = dma_fence_get_stub();
>  	vm->last_unlocked = dma_fence_get_stub();
> -	vm->last_tlb_flush = dma_fence_get_stub();
> +	vm->last_seq_flush = dma_fence_get_stub();
> +	vm->last_tlb_inv = dma_fence_get_stub();
>  	vm->generation = amdgpu_vm_generation(adev, NULL);
>  
>  	mutex_init(&vm->eviction_lock);
> @@ -2691,7 +2688,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  error_free_delayed:
>  	dma_fence_put(vm->last_update);
> -	dma_fence_put(vm->last_tlb_flush);
> +	dma_fence_put(vm->last_seq_flush);
> +	dma_fence_put(vm->last_tlb_inv);
>  	dma_fence_put(vm->last_unlocked);
>  	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>  	amdgpu_vm_fini_entities(vm);
> @@ -2834,11 +2832,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	amdgpu_bo_reserve(root, true);
>  	dma_fence_wait(vm->last_unlocked, false);
>  	dma_fence_put(vm->last_unlocked);
> -	dma_fence_wait(vm->last_tlb_flush, false);
> +	dma_fence_wait(vm->last_seq_flush, false);
>  	/* Make sure that all fence callbacks have completed */
> -	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
> -	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
> -	dma_fence_put(vm->last_tlb_flush);
> +	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
> +	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
> +	dma_fence_put(vm->last_seq_flush);
> +	dma_fence_put(vm->last_tlb_inv);
>  
>  	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>  		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e478d3bda1ac..713a597027bbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -328,11 +328,12 @@ struct amdgpu_vm {
>  	struct drm_sched_entity	immediate;
>  	struct drm_sched_entity	delayed;
>  
> -	/* Last finished delayed update */
> +	/* Last TLB seq/fence */
>  	atomic64_t		tlb_seq;
> -	struct dma_fence	*last_tlb_flush;
> +	struct dma_fence	*last_seq_flush;
>  	atomic64_t		kfd_last_flushed_seq;
>  	uint64_t		tlb_fence_context;
> +	struct dma_fence	*last_tlb_inv;
>  
>  	/* How many times we had to re-generate the page tables */
>  	uint64_t		generation;
> @@ -561,7 +562,7 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>  	 * sure that the dma_fence structure isn't freed up.
>  	 */
>  	rcu_read_lock();
> -	lock = dma_fence_spinlock(vm->last_tlb_flush);
> +	lock = dma_fence_spinlock(vm->last_seq_flush);
>  	rcu_read_unlock();
>  
>  	spin_lock_irqsave(lock, flags);
> @@ -576,9 +577,9 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>  				  uint32_t status,
>  				  unsigned int vmhub);
>  void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> -				 struct amdgpu_vm *vm,
> -				 struct dma_fence **fence);
> -
> +				struct amdgpu_vm *vm,
> +				struct dma_fence *dep,
> +				struct dma_fence **fence);
>  void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
>  			       struct amdgpu_task_info *task_info);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index b0002c8983861..c91417e4df4ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -75,7 +75,19 @@ static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>  	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>  };
>  
> -void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +/**
> + * amdgpu_vm_tlb_fence_create - create a TLB invalidation fence
> + * @adev: the amdgpu device
> + * @vm: the vm to use
> + * @dep: the dependency to wait for
> + * @fence: the resulting fence
> + *
> + * Creates a TLB invalidation fence which signals when all the VMIDs assigned to
> + * the PASID of the VM are invalidated.
> + */
> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> +				struct amdgpu_vm *vm,
> +				struct dma_fence *dep,
>  				struct dma_fence **fence)
>  {
>  	struct amdgpu_tlb_fence *f;
> @@ -86,16 +98,15 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>  		 * We can't fail since the PDEs and PTEs are already updated, so
>  		 * just block for the dependency and execute the TLB flush
>  		 */
> -		if (*fence)
> -			dma_fence_wait(*fence, false);
> +		if (dep)
> +			dma_fence_wait(dep, false);
>  
>  		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> -		*fence = dma_fence_get_stub();
>  		return;
>  	}
>  
>  	f->adev = adev;
> -	f->dependency = *fence;
> +	f->dependency = dma_fence_get(dep);
>  	f->pasid = vm->pasid;
>  	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>  	spin_lock_init(&f->lock);
