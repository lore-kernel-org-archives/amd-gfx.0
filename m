Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80D0CC6B24
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 07:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E4310FB63;
	Wed, 14 Oct 2026 07:17:58 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2271810FB63
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 07:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaYmKNdE5sf5H5eQfDc/b3Cs2dz/sgI1il09XlBq5QZpuKVHGv2lr89Qnjq6jMyrb4uToG7W/QgaIoMNX9xiLNpRmxfPIEtYLYSxTpVCyKGRbls8Mi2ezR6h5Vw1v/XHavIwEzIXQkrcO+z3pC3bCHLeV1r02D3g9X+0N8noo+ByUh3XVSyRY99O4WJfIahFH6aFiYU83MJoGbCQObc0GyeqHWQQhOmmaOexMJzYKmodd/5JEqpmyaPejxw10jhgZeGtYMHQhzYVG8hNSTcNMki3mIa9s7CXvzpnjaOO88SYGkPsXmD5HBI3MPjubbQv+8A9rwoIoPnRzm5tM0ujaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIZ8jauhubi/jwpw8apEAOiA58EiMA+0LkHtZisY9bI=;
 b=fRHUHrHOzCuo5IkztW0Zkj6QpvdnTXHYY6vEoGrDPxw0OwfR92C2J8vIEKOQO3JOFx9ci1S4JkqhLa2Vcj5yYZj67rVgqMd5rBjF0efqusG7EonDtUGksrp2VDIFLRcDhYyEVGCXhlUavWlRqd6P6vVPoG/yX5XB6fFOzkm4oi0GyO5v4h9pyLpjH2OOibSgY+0338rshWhXgH70c+kn11FZS7jL0RG597l7HDwbFWQGkYpoFvKgTq03ZUEF2qzP4F9yW9iFtiA4GeO0F9pqWE9C0gmI0UhKghzXgtQF3O+JMeFEiTKY9W1iKyazy1zYmPo6X74j/WO+u81ICvdL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIZ8jauhubi/jwpw8apEAOiA58EiMA+0LkHtZisY9bI=;
 b=ZSgAOv7v23/FhHjr41dJ1mYtKqgmvgHw2j2gurZLpgmvCZWCvSBt5yGSKmszkdaWCXmrulsdtnDDsw7QMlDPx8YOviv9SCUq24gAlmQ2Zqw5WLdnnRdDEKCUoDVHJSTN+KwlGNPu9P5DpSB54jA/jq3Y3spXwd/TpmZWWqvkfcA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 07:17:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:17:47 +0000
Message-ID: <857c0091-681a-4f09-b875-50f3a4c4b91c@amd.com>
Date: Wed, 14 Oct 2026 09:17:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: wait for tlb flush before freeing BO
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261014022107.2511834-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: b7daa961-f450-41c1-df8a-08df29c33fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Skis3dhfhNVcXQaEsqY5ZSjtr6MgmyP26DyENEAxNYFFefnqLpjdxIuQmFi2dDr76RH3JkKxwAjKUXwE0uriJ+liB/z3k2fYmuLjKi1e8MO5/iAAvyNEPHkgDN7Z0pgKrvDbGmv3GTCbFtEd+3y2kfm1tw3npoGg+AEGFQggl4/MyuYwGM5ASotCCIdPziRcHUKvKvkVSPIAYEzqFt3F/5h2XGAd852QyzvLhPJrg0VagSpKN2LMrCMiJ2c2KTsd/fVyamUpbAzRMausBgOJEte4b/+fKl7rcVsOpsxVMdNAPHiA32ZUWcqN3QZWD0XaCmHFfja/oCtY2KEHWh4mbQu0R3hvL2XI5AO+VyreBOwVaCubmWttbHaVnVvd9RlhxL8b6EI59fiV4/agIRUOgXpfJX99Er1pzCQeWYJ5ba3FFMoDwenOzfIq6wVkMOUwTMdve90LsA/r1cuLy2kX76Qgq1bBg7ZCctDr4PGmhGvWcIZWfY7nqj9QzyhPh0dWNEUJttxmA8s9AkBMlp5l47lrY1fwYd7kCh40ZPRFvNZlWCky1PhZGptuJOXdAC7S5STbqtov6/CLfa/+Y2YiTibTuVqITHstqBcpPQQgRbxcA4W19RmHpz/DFhUoMtaDrp33LZKHmxLOVGcNTmmk41lmJq09qaBNjI6p9RQsqrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJIbnc4eXJ2dVo5MEd1MEtwcW9rMDJuQXByWGV0MWg1dEhtSURFYk1kbG1S?=
 =?utf-8?B?aVZBZ0M4RzdvZ3pnRHdXR01NVlRQbjczdXJTOUpHTGFUbkhBV3B3eG0waExW?=
 =?utf-8?B?Mi9yNXYzKzB4WmlPdDM1M0cweHg2Z0gyVWlxVU9GaVNpNytMS2x0MmdKVnB3?=
 =?utf-8?B?S1BBaWN2ZHNtWmx4c2EzeGYrd0FadEZqbGxScmtuUHcrYXFWWUhEVUozeWhS?=
 =?utf-8?B?c2xDMmN3bnFSZGRsSWlWbTJnOHZYdGN6bUhCSGVMWk02Q0FPYUFMZEtVS29y?=
 =?utf-8?B?ek9acDNmancxWFkxRlRyaGd4YmpEMDZCeis2L1k5VE1iWXhxUzFYRTNvcDFh?=
 =?utf-8?B?Q3JrZndJTDl6R0JiVDRzcy9YU1l1cjA3aFhKVjlEaHIrcHN2bjRBNTcrUzlw?=
 =?utf-8?B?K21HbXF2MmNyN1plOWtaR0RiOWtvcEw0eVVKUzUyYkpOY0IzK3JuTXBHdjVQ?=
 =?utf-8?B?U2Z2N0JhaEwxbGZMNEdNR01ySWNzdDRuT3Rjb2IyL2paWHBHWGYyT1BWcy9R?=
 =?utf-8?B?ckNkMkRTbU9MVlRab3RRZUdCMmdMTGgwWE9ESjhiWlUzODNvZThjWkpDOWdK?=
 =?utf-8?B?bnR1bnJQQ3l0Y3RHM2Y1eGxuMVZxeDdEbVVtU290WmZxb2lmeksvVXhHdjN1?=
 =?utf-8?B?K09hcFR5OFdiU0ZPeGpPdDlvYkFyQmNDSlJOUHE1ZWxwQ2Qvc2NML0tkN0NJ?=
 =?utf-8?B?aVJvMmZJUXU4YWtBU0h0VmxlY21CYjBwc1M4S0JzQUdtcVcyNlR1cnF6ZkFK?=
 =?utf-8?B?VEVrWGFEeHpCWEJMS2FuVk42aDdCVFc4N3J4aThLRUs2ckRxU1cvMTZiM3NJ?=
 =?utf-8?B?NWhraWYvOHFjQmlGeWJBSkpHc0RUUkpLQSs0U2Q2cUovZkhPSk5qTTlxZ3pM?=
 =?utf-8?B?bkFvbVZHeTZPcXZRRk9pcjVLMEpyeWhWZjdlNTV6UHlweDhOV0ZmVDFTclFX?=
 =?utf-8?B?eWttdmhVY3JQMGdnVDdMNFlxT3RxT3h6Q2ZsOWZVL25sL1RreVlPNjlxaTA2?=
 =?utf-8?B?U0E5dTZZVmdIbDBvL3VkY1VoN2FvcVJobjJsN0xEQ3NRUEZjNWg1S0IyQzF5?=
 =?utf-8?B?MEdyWnFKY3h3OFplUWlONEhyQkRMczBsQXl1MjV3SlI5b3MvRTFDVjFnTHFM?=
 =?utf-8?B?UEVCVUVWekhYYk1yTlB5cmozV1hDRFd2clV1ci9zdWpsY2d1K1lXMFlKVTB5?=
 =?utf-8?B?RDRpdnh0SnZqbmJYRStzc0RIblFKQy9WKzFXcmRIb0x2VlBuajU3bFNESXhs?=
 =?utf-8?B?Z1pZaStxMmZLcEE1b1lnZXZqNXR5eUpaQ2dmU3pnUEdZMFdPTWlFZTVlcmFs?=
 =?utf-8?B?VG1WUW0vWDV1ZVcxSEFSby8vTnpxRndmVHBoQTBUUy9wSVgxeVFCelIvLzk4?=
 =?utf-8?B?WktHZmtkcDNzS3hSSTg5OGN0VHpIc1I2UDZWZ29pek16bUVXSWRqL3p1d0hl?=
 =?utf-8?B?L2Z6SXZZQnRpTU9CUlJFdWR1WHRFMzlySWxYNFBIQ2dBK1lFK0w5U3BhTkc2?=
 =?utf-8?B?T3ZoOCsxejNRNlAzcVR1UUVNa0ZDSDZvSWY5RFU5cDBIK01UbkMzQzQ2QkFQ?=
 =?utf-8?B?SWRDcGVtQWhxSWV6K0xHdFNkNFhRSG1NT0JteTVtZkxWa29ZVEFxNEVRRU1a?=
 =?utf-8?B?OFZrcGxyOW4vVHRxRzN1TEFibEhYUkNGN2RvWDVlVDc2MWtPL3dWZ0d1elZX?=
 =?utf-8?B?SFdFRWlXVlBjcCtoZ25ma0RSdUtZaGI5YmUxSytlWTI0NFNocHNadEJNQkQ3?=
 =?utf-8?B?VmVZQ1o1SXl2VnI4YmZ0Z3hGalBKRTVlSXBwVlpaTHBIdDY1NlI3N0I0SFJU?=
 =?utf-8?B?c3FYN0lLckY1blI2RWNHRDNGaVBteGJjdlBlUWlzNmI5aFAvTEtRcGN5ek9L?=
 =?utf-8?B?OEY2eWM5aHVQV3Y3R3RxU2FJYWFQZ2p4VWZ0ZTlFa3kxNmZ0dDZGSjNBWkQz?=
 =?utf-8?B?SGZYNUpEWENsNkVUT2N1ZUFqYXQvdVJXTThhalNRcjBBQlY3WFVML09memZL?=
 =?utf-8?B?T254d1FUQkpySjdCY3Y3c1VvWEkyQXd5bUJwV2tTalVOaml1d1Z6NkNCUkU5?=
 =?utf-8?B?ZzlXTkRoVzN4V3Jzb2JnemprMjBwRmZzSUlLZEJEeThWMlBrWjBXaS9YUTg3?=
 =?utf-8?B?aFZRQllUbjNTQlE3WEZvTjVmVVY2cUxaTitEY09qajd3NDFVZXBZZ2FRSDEz?=
 =?utf-8?B?WmZnbEVWMlVxM29LbHNpR2Jwc2RLWGhUZFZLblk1Z2o3eVJoZVN6MTZHa00z?=
 =?utf-8?B?bGlOazNjYjBMTlZmeTdFZE9Xd0RGRjB5cUcwT0dkUjdiZ1lKdy83Wk03dUk0?=
 =?utf-8?Q?cmHyXImNbuvrq/h2+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7daa961-f450-41c1-df8a-08df29c33fae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:17:47.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGnE49MI3EbjYOKWz8AEetJX2xi4LUcUPWDaMivyn5fH3TVK2yoMe8bGBO8OxIKp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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



On 10/14/26 04:21, Benjamin Cheng wrote:
> On gem object close, we previously only attached the fence of its own
> clear_freed() call to the BO's resv. If an unmap of this BO happened
> prior to the close call, clear_freed() would be invoked, leaving
> vm->freed empty, and no meaningful fence to be attached to the resv on
> close. Because of that the memory may be freed before the TLB flush is
> complete, and give a running userq potential access to a stale
> address translation.

Good catch.

> 
> Fix it by tracking the last TLB fence of each VM and attaching it to the
> BO on close.
> 
> Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8dbd7bb77305..7484c52e5850 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -360,6 +360,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  
>  	amdgpu_vm_bo_del(adev, bo_va);
>  	amdgpu_vm_bo_update_shared(bo);
> +	if (!dma_fence_is_signaled(vm->last_tlb_flush_complete))

Drop that extra check, it is actually harmfull.

You also need to increase the amount of reserved fence slots.


> +		amdgpu_bo_fence(bo, vm->last_tlb_flush_complete, true);
>  	if (!amdgpu_vm_ready(vm))
>  		goto out_unlock;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7d3659ef11e5..c5411933a76c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1097,6 +1097,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	if (!params->unlocked && vm->need_tlb_fence) {
>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>  
> +		dma_fence_put(vm->last_tlb_flush_complete);
> +		vm->last_tlb_flush_complete = dma_fence_get(*fence);

I already added that in another patch, looks like amd-staging-drm-next is not up to date.

Let me double check that.

Regards,
Christian.

> +
>  		/* Makes sure no PD/PT is freed before the flush */
>  		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>  				   DMA_RESV_USAGE_BOOKKEEP);
> @@ -2648,6 +2651,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->last_update = dma_fence_get_stub();
>  	vm->last_unlocked = dma_fence_get_stub();
>  	vm->last_tlb_flush = dma_fence_get_stub();
> +	vm->last_tlb_flush_complete = dma_fence_get_stub();
>  	vm->generation = amdgpu_vm_generation(adev, NULL);
>  
>  	mutex_init(&vm->eviction_lock);
> @@ -2693,6 +2697,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	dma_fence_put(vm->last_update);
>  	dma_fence_put(vm->last_tlb_flush);
>  	dma_fence_put(vm->last_unlocked);
> +	dma_fence_put(vm->last_tlb_flush_complete);
>  	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>  	amdgpu_vm_fini_entities(vm);
>  
> @@ -2839,6 +2844,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
>  	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
>  	dma_fence_put(vm->last_tlb_flush);
> +	dma_fence_put(vm->last_tlb_flush_complete);
>  
>  	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>  		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddcdc7256ef0..b9932c5e066f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -331,6 +331,7 @@ struct amdgpu_vm {
>  	/* Last finished delayed update */
>  	atomic64_t		tlb_seq;
>  	struct dma_fence	*last_tlb_flush;
> +	struct dma_fence	*last_tlb_flush_complete;
>  	atomic64_t		kfd_last_flushed_seq;
>  	uint64_t		tlb_fence_context;
>  

