Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EA3CA9EBE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 21:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B5710E546;
	Fri,  9 Oct 2026 21:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTifJ2gH";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B202210E546
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 21:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orR3FeqcIxU88SxRb2j9E15ZVhY1ahtLnv7nQx2a6veJlbJJemFt5YM1JA0Vq77QIrb56U3tpLrpyCYQ7qW6YnFCKmYUmQ3vRLIsxkiCd4MEcuh+zA+ALZjqvM4cF3PTrLHmOJPewNOYgdPCn9NtKNBHSBcv1tGySz92PN9QIiJ0f3Kef+sZvJXd1imwPhdYAm7CKT4YoXH5FML31l+qe5itsvMXTDqzZtPiWDNsznygVGj2JOHSvOZoo6fNEFy3t1B4xJd3onVzUKq7KcbkysszvLTpHmCec0SXkclnl4jmSHcw4M3JAUAeWm/6SsiZN8mf3e02xKAsfr4z61gP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw+ry2VODcGNW1jte4qOalc+KM/LY/I8z7A/z4MlFeI=;
 b=V/itEyzvNMVM36/geqUNjVm6uoxTu32d6xNM4SPr48+pd60c5CHiG6cO9Vq6m6IsUys2U9SkngwR6BZe3jqjna6AU6d1WGhBizPQJpTPJKJ9nZIs380OGAMFxvlx8Jun0SJnEdnYFlrwG9SsIbGS5s4UTgXblTSFeY/iYhF0TAJ8GM9XpV2/xxMsG9lEzEUFUeMyUuUer3a88X7WA1HG3u8uisOxaR9VQ8ngYyLBlVhQaHS/nDL1vR6KvxfznFZAnWYDGdHuOcf+eLdNY0PJe58AazUS7l7fYVDgkNRqYCEyJhDXJ535fPFgiOG6c6Dpo+NeNL1Zbvh0kIEeTus9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw+ry2VODcGNW1jte4qOalc+KM/LY/I8z7A/z4MlFeI=;
 b=DTifJ2gHgwqR/Szi3Si4mRBxYaYfXhnLRhjKJaYY5lls51XCEQzY4XywXnap08ZsOfvn9lTc17bq7ybI0uVIZblZgv7JWZ7CpDyR+mwszIJHqCThTr05TAdThbs+2LYxfJ17Li1daMMetAP6Nqm08Td0sIEo7U75d0A566iC1Zk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH4PR12MB626935.namprd12.prod.outlook.com
 (2603:10b6:610:507::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 21:23:07 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:23:07 +0000
Message-ID: <c4a5cbd4-41b1-4c1f-ba9c-77e41e117383@amd.com>
Date: Fri, 9 Oct 2026 17:23:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix TLB invalidation fence handling
To: christian.koenig@amd.com, David.YatSin@amd.com,
 amd-gfx@lists.freedesktop.org, Sunil.Khatri@amd.com, natalie.vock@gmx.de,
 Bincy.Mani@amd.com
References: <20261008124232.23825-1-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261008124232.23825-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::22) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH4PR12MB626935:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b7ca1e-e4d9-4118-85f1-08df264b82e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Hhl6bEiNiZOCrdAFJSuJJCU2elU0CxSx0lIQkFZ8PZ8kLL17dS29I1HFWQFibvYTXTUCh4axtuL5xp+jV2r+1X8OFF867PQkiCc+dTShd5q5ixfmhrhJTs64oe9vR6FZFMw2tGS+mzUEpKrfBpQ0NYEbv8uSo/lN2HnrQKTG1ivX1wQLggYUovodqTHASF/oUCLqlBGt0Spqs40QodGGvfLDlxILqvVjwNGQ8ED2pAOtK0+jbMBZABa0MvHbgq4hNO2oBf5511mnAs1Uj5FIB1njP6YiMNr8+nLR3PWW8drYbpaze5ktSWK3F0B7s8VQiEu6SsTaqoTw75ok/vtg/ShNi15iUz1BlDXL0vUN+FDHtKT2k0uovgsP1kPbe6a0Fm6R40exb0a5KvZ6cpS6HmZ+/66yxyfQPHgsb7pN5bDx9R1ZuC9y5sUYcx4PIe7aklRNabs3SlcM0wnwgqEMF9scel9d5ca6SEFS6dZWewfrtewZEFUtL/N0dMC1xe0FzjOWI3oGDNo5dsVv0LuRVcG1Xi6h5Z+c/jgYMT64AfBYhccNY4l/t5hY8vlJLMM+0SYdwBzm+GHauaFGwCG2ndAOBmpC5x0jFcc/x/7QEw6nzdV8/XN48Bl4cWnybu9wGABL9jgnBjbRJ1l+KM7aiBMHvI9LvCHocsPiHjaD8Is=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2QyVG13R2JkejJpajFrNkE3RUpTNVVCdjdLREJFYTAvdFBXMFVxdEE0eUU3?=
 =?utf-8?B?dWJ5MStxRHg4aFFTRU5JTHJSUVQ1RzFzMU11Umsxb0JITUVaQUt3MGhOeUxr?=
 =?utf-8?B?b3FIeWZUYlVqTTlPYmZiNzdJM0l2TWpSUUNzTHBLOS9pUEg2UW9uRGd5Qytt?=
 =?utf-8?B?ZGJIWWxBVHlBRGd2Z3FyVW42WFFyRnZoTVFKbysvN3lXT0xHQmVCQzJ0Njc5?=
 =?utf-8?B?V1dlTFBFbnVzOXdtSFRlVmZtQlJZTFBzeWZ0WjFKcDNYWlk3RjIyUkxtMUp3?=
 =?utf-8?B?OFhYRHk5REU3MGE3Vk5sSk4wNEZ4NFdDVEJEdzVwNVVZZmJWbGpWbVMzRncy?=
 =?utf-8?B?U1ZPMkJTcUtvc2xFQ2N0T3RkMSs5YnNkN0d0WHQ0dkgzWVRaeHNLSzJOcE1R?=
 =?utf-8?B?MmRyN2FGMmdXY25TUTdLcUdPL1dpd0FFNmdvcmVlNkxuT3gzM1RuK00xK1Bi?=
 =?utf-8?B?b2pPbHluUnZ3UllRWjdNcS9IbmY3ZkFqTkhRTWl0b3ZoeUJtcDNhMzh6QTRN?=
 =?utf-8?B?MVBQa0J5b2dqQWpIQ09zaDVWL1FxTE5KQjBYeVRWaU9aaURKby9EWkladDZ1?=
 =?utf-8?B?NWliZEJWR2VPUERZaHB5RWVVSm5mbmdzand3TFVIMEVVak9HZm12TC9oRmVI?=
 =?utf-8?B?WkNndTczRHFtRkxzZUxUdWVZVlBFS0hSd2FDWnN4aFR3bTlhdVllWXRzM2ht?=
 =?utf-8?B?SmV4ckI1eVBLbVBxaHlHU2tZU1ExTGNDVEV5NzdZWFdXdUh0UDFPNkk5ZzVj?=
 =?utf-8?B?cFdYYnE0RjlUMytUUkcyQjZtUGdieTJLT3gzY1poNXJWUTJWRk1ueTU5bUdV?=
 =?utf-8?B?TmNHL0lrdzNibmZLbVhBSGU3NGQrbDZJOGE2YjhSRUQvaC9nWFhKYi9qYVJP?=
 =?utf-8?B?bng4WStMVUJ2Mlg5RWxic091eVpJUEc2STVkWE5yWDlFcE1xRWpmOWYxUktQ?=
 =?utf-8?B?Q2RxV1BlZm1ySTdOYTBsc2ZHTSt4a2xoNU84cFZ2b05IcGdNS0RrcWFtTG4w?=
 =?utf-8?B?ZEtDL3A1Wnh4VTljQkF1Q1plMmJYb3ZGRkRRWEY1MDZSeWNiWFFDWTZPQnRu?=
 =?utf-8?B?TVNTTzRCUWRxL1dhVHhFZStOME13NXJWNjF2N2pFT3ZqVXN3OUQwZkRtbWx4?=
 =?utf-8?B?VFpSeXlqaUZSRk1uN2dQVHBCRk84ZWx6SWcvNk9Vc2thQWJyZUV1NGg0TXE0?=
 =?utf-8?B?Z2tadG9wWkUzVyt3RU5aeCtiZGdoSld0OTRsclJNVHVOMk5MOVJzdjRpa2Zx?=
 =?utf-8?B?azY2Z2V1TXBUK3dYVHZmYldsNGhRbUpmSmwxeWdsaksyVjJQTTZ6eXlBN0dk?=
 =?utf-8?B?UjNKWFh6bWhMSi9GdDhCcDRWeHlvWnZYRnVFazVLNEl5M0QwVWtGVW1MbEo1?=
 =?utf-8?B?bUFiSTZLcjk0U3Zkc2tsdFhoRk5iOVRkQ2pkZ21HMVlHQ2hKcEE0SWVFeEND?=
 =?utf-8?B?V1hHWmFXbXluN2tNM1BkeEhibi9Udjc1OE5XQWJuMGdBOHNURUlSWWpMdFJn?=
 =?utf-8?B?TzMySHNsYmdZNWs5T3Z2OGdIWXlqMExsTzdMV2x4RzhuTExzQWVIZEZ0dXox?=
 =?utf-8?B?QkFOeWs5a3c5UVpQdWRaQXJMYTlDdEZCWkVIdDBJN3NuN0x6S0VGeUpUSmNT?=
 =?utf-8?B?ZE9Bem9xSTY4VlZndk1PVG9WK3JUcHIwKzlLMmFTdzVmNTByQmxYblp0N1Zh?=
 =?utf-8?B?YXBNRmFML2J4TDZOS2lLbHBmYXY3RVZSelpGV3dORnAxRkNqTzR5Y2hTYmFy?=
 =?utf-8?B?dWJiQmowUEZpb3MzVXpIM0w5NXUxRWE5YXp2M0xMbWg3c3hHTHB5Mis1K3RM?=
 =?utf-8?B?eXhkSHpkdXlZdFdqOGlNeGxRc2p3NGd1QUpGM3A5eEYvOEpGbmlFMlFFc2tx?=
 =?utf-8?B?V01vMmxkdmlGU1cxM2l5SndONjFaQzVHWDhlWFlYa3YwUVBtRHhFUGFWbUFn?=
 =?utf-8?B?ZzVhU3BlVGJhdkUwa2t1dTZRbXRRaFVwS3UvWEExQ3pzMi9yS0g0RWdtdTcw?=
 =?utf-8?B?ZUwxN0pwa0NKMjBHQUNnblowOWk3NEJNQUZOa0RESjlOd2dEeFhPaFZnbnA2?=
 =?utf-8?B?VjlFN0lmQUxzd1E4WUxjRmFuWURsWnJqRThBNG9FV0tzb2lQR0JsRURTeU1H?=
 =?utf-8?B?WTZQYnloWjhnQzFKQ0E1L20vZWdqbXNTTktNanRocjNQZ3VzeHNyZURxUEFO?=
 =?utf-8?B?N011a1NMQ1FaalFZTnoyQlpYVjVhdTBpdUxYSS94dDJHdHJaYmdsaFVlNW9U?=
 =?utf-8?B?ZW5YZExkNHo0ZjUwMmczd3VmWmpUU0V6czVpaXM3endaYTh3RmtuRzIrcXNQ?=
 =?utf-8?B?emxreFZEcWd4c09uUUFZNFNZdXovYUVZM25USnVHSGExYXVocW8yQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b7ca1e-e4d9-4118-85f1-08df264b82e7
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:23:07.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKYoQi6rPtoVVmrOcAAN57iWAs9wWoMasNMmO2x8wX+u1c1o7DRzYTm6o4QzRLrcDTw8fnb6cK62lcaKlSm5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB626935
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

If I understand it correctly, you fixed this by tracking two different 
fences in amdgpu_vm: one that updates the sequence number, and one that 
signals when the TLB flush completes.


>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Why was cursoragent@cursor.com copied on this email? Anyway, the patch 
looks good to me.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 20 ++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 39 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 13 ++++---
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 21 +++++++---
>   4 files changed, 55 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 374f1322c3ee4..606725d0eb155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -843,18 +843,24 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   		/*
>   		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
>   		 * bo_va->last_pt_update and vm->last_update or otherwise we
> -		 * potentially miss the PDE updates.
> +		 * potentially miss the PDE updates or TLB invalidation.
>   		 */
>   		fence = dma_fence_unwrap_merge(vm->last_update,
> +					       vm->last_tlb_inv,
>   					       bo_va->last_pt_update);
> -		if (!fence) {
> -			/* As fallback in OOM situations */
> -			dma_fence_wait(vm->last_update, false);
> +		if (!fence)
>   			dma_fence_wait(bo_va->last_pt_update, false);
> -			fence = dma_fence_get_stub();
> -		}
> +
>   	} else {
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
>   	}
>   
>   	return fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7d3659ef11e53..f124320345ec4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1071,21 +1071,16 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    */
>   static void
>   amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> -		    struct dma_fence **fence,
> +		    struct dma_fence *fence,
>   		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
>   {
>   	struct amdgpu_vm *vm = params->vm;
>   
>   	tlb_cb->vm = vm;
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
> +					      amdgpu_vm_tlb_seq_cb)) {
> +		dma_fence_put(vm->last_seq_flush);
> +		vm->last_seq_flush = dma_fence_get(fence);
>   	} else {
>   		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>   	}
> @@ -1095,11 +1090,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
>   	 */
>   	if (!params->unlocked && vm->need_tlb_fence) {
> -		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
> +		amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
> +					   &vm->last_tlb_inv);
>   
>   		/* Makes sure no PD/PT is freed before the flush */
> -		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> -				   DMA_RESV_USAGE_BOOKKEEP);
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> +				   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
>   	}
>   }
>   
> @@ -1248,7 +1244,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_free;
>   
>   	if (params.needs_flush) {
> -		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
>   		tlb_cb = NULL;
>   	}
>   
> @@ -2647,7 +2643,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
> -	vm->last_tlb_flush = dma_fence_get_stub();
> +	vm->last_seq_flush = dma_fence_get_stub();
> +	vm->last_tlb_inv = dma_fence_get_stub();
>   	vm->generation = amdgpu_vm_generation(adev, NULL);
>   
>   	mutex_init(&vm->eviction_lock);
> @@ -2691,7 +2688,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   error_free_delayed:
>   	dma_fence_put(vm->last_update);
> -	dma_fence_put(vm->last_tlb_flush);
> +	dma_fence_put(vm->last_seq_flush);
> +	dma_fence_put(vm->last_tlb_inv);
>   	dma_fence_put(vm->last_unlocked);
>   	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>   	amdgpu_vm_fini_entities(vm);
> @@ -2834,11 +2832,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_bo_reserve(root, true);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> -	dma_fence_wait(vm->last_tlb_flush, false);
> +	dma_fence_wait(vm->last_seq_flush, false);
>   	/* Make sure that all fence callbacks have completed */
> -	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
> -	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
> -	dma_fence_put(vm->last_tlb_flush);
> +	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
> +	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
> +	dma_fence_put(vm->last_seq_flush);
> +	dma_fence_put(vm->last_tlb_inv);
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>   		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e478d3bda1ac..713a597027bbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -328,11 +328,12 @@ struct amdgpu_vm {
>   	struct drm_sched_entity	immediate;
>   	struct drm_sched_entity	delayed;
>   
> -	/* Last finished delayed update */
> +	/* Last TLB seq/fence */
>   	atomic64_t		tlb_seq;
> -	struct dma_fence	*last_tlb_flush;
> +	struct dma_fence	*last_seq_flush;
>   	atomic64_t		kfd_last_flushed_seq;
>   	uint64_t		tlb_fence_context;
> +	struct dma_fence	*last_tlb_inv;
>   
>   	/* How many times we had to re-generate the page tables */
>   	uint64_t		generation;
> @@ -561,7 +562,7 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   	 * sure that the dma_fence structure isn't freed up.
>   	 */
>   	rcu_read_lock();
> -	lock = dma_fence_spinlock(vm->last_tlb_flush);
> +	lock = dma_fence_spinlock(vm->last_seq_flush);
>   	rcu_read_unlock();
>   
>   	spin_lock_irqsave(lock, flags);
> @@ -576,9 +577,9 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>   				  uint32_t status,
>   				  unsigned int vmhub);
>   void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
> -				 struct amdgpu_vm *vm,
> -				 struct dma_fence **fence);
> -
> +				struct amdgpu_vm *vm,
> +				struct dma_fence *dep,
> +				struct dma_fence **fence);
>   void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
>   			       struct amdgpu_task_info *task_info);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index b0002c8983861..c91417e4df4ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -75,7 +75,19 @@ static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>   	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>   };
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
>   				struct dma_fence **fence)
>   {
>   	struct amdgpu_tlb_fence *f;
> @@ -86,16 +98,15 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>   		 * We can't fail since the PDEs and PTEs are already updated, so
>   		 * just block for the dependency and execute the TLB flush
>   		 */
> -		if (*fence)
> -			dma_fence_wait(*fence, false);
> +		if (dep)
> +			dma_fence_wait(dep, false);
>   
>   		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
> -		*fence = dma_fence_get_stub();
>   		return;
>   	}
>   
>   	f->adev = adev;
> -	f->dependency = *fence;
> +	f->dependency = dma_fence_get(dep);
>   	f->pasid = vm->pasid;
>   	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>   	spin_lock_init(&f->lock);
