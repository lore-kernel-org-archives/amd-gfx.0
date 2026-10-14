Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C8CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D8210E5BF;
	Wed, 14 Oct 2026 12:47:10 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9905910E53A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcmvUlmfNKMj54AdZYY4TEo51BZ0trI0VsPNQuCbFT9YIIqOCUlvikgKXukULYCP5SSFC+fVoXXQP0DdEz+WiwkvzPUEFkw6NO/YjZlZBrODymVlVesqIpVq2rWKa0bumkSSOgdD/UTN1OPk5s2YXrDPGu/aUsOrJu29JG0u2kA4lHVmsdOIEmggBTmu6O1Do2hSNNGpZ/JOQoWbhjK+ZTvrb7ACgjdX2U6RDh1cj7QrqASes8JNc/f1kHZTd9X4ewItUgT1G55OGPMx9eqO+p0ngFECxR1fqgQItbMRm00Mz12ypUYe9trIDvLIUz5ESJDB0SbVaE3zdg4lJyPbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUPai2fMTwuU4PjfTCwcN/RTbajjxE2FuzVhSCCw39E=;
 b=MEpeqHI+ESMLpUZ0sly4Dqoa/lvy8tc5XHCbgPgNqQ5iAA9SphXqy6oIPhoKDQsx792o5jtQurMQmslSYEbQ+oZedPa56Fx1fPyKMnjbqp3VEBYQzZr9LqG3ucgrcWBt/2lkmDVYkXcRMVEa+1J62XVsJ4BYzxWwpjwF8IsmVmlSkkL35Sxpc1Os/yCtlBzCeWD8qZ4mgl1Cb1ENxGPOthxnZtS3ljhCpraLhfxbCjsROdI2Ra2gOXW3k4g5263EGhs80t8zD54WFt4HQzIARVjONde+1Ohx7op3q3cN+CsCkcFXy/z6sXSfEEffhOW4OM7dDiFIyRC6H/QroDg2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUPai2fMTwuU4PjfTCwcN/RTbajjxE2FuzVhSCCw39E=;
 b=RCI4j/hypD/nvb6ZSKdopHrkie9rI7yshvSih4nHbzG+hHxO2JrqE6x6LgvPMzCuvow3uU6G1l//YjwqlNMGFPLdHCzJd+qF3wGdDRqI5S+m9tS5iPa3CntEUPiY3fdAyYUYD9O6jkXlMSLM1cZyD36RB3ntlUMgPXRvjeD+bVo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 12:47:00 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 12:46:59 +0000
Message-ID: <40949c1b-35e3-412c-9e0a-fc50e95f16e8@amd.com>
Date: Wed, 14 Oct 2026 08:46:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: wait for tlb flush before freeing BO
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <857c0091-681a-4f09-b875-50f3a4c4b91c@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <857c0091-681a-4f09-b875-50f3a4c4b91c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::26) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 0271d332-86b9-4574-2a1d-08df29f13cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|5023799004|4143699003|261009223027099003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: B47TGWkmw6itY8DJDdwpTBLa/TZAtTiM7CqJY9EchJTqoBERsrPH0r3+kymC8nnk9zHJ10AQwV+gTnGcdXvP8iovX/1tox4XumHUxufC4+0IgKXO2O+OK5oKBSohMh2GhKbob3hOjcMbXLgFALHCNfp/bgnLv+wH2ECcfBIB8ZF1tpsyXMKoUMvOhF82cuYHlcCLzFGHdI37iughOaiSo2lIgp6pejMhPnwbHB6R/onVtl5620ejce0e7Woik+jEq7CScTyg+ZtoyGikdPN/tMAV931T9rqGVDmHGemamHfG2YiK/Vlr1tq2Pdj+dMgITi03EnoNY8hRAHDjJYpfq+b3xGXlmwJAwTpS181R7FZFwbP1v03rdxxu1cVRcXhPO/jgDvkPQClvWFLh7cSAHp322okmF447Bd18fNF64iRsHlYyHkyEbrP2n50bcxu9m+xRfuuWlMm1loojppP8en+OacwtD4Fp2rwYRUaY/w1URBhPBDFGOUhMahBmZsNXLHOBuktabizOp/dTspqWDHvUzICGsnCrPj/gAjjO5CnDIo3Fjs7crgsusojXe+/yexnok7k4CYi+wmy1CJJUKygRhfBO9oi+x5w/+7/nYG8vOPo23GGOMGxPYCmysyUMF+0tmqEdHt+pjXe1t6JgaYDDF1GyBcyrS6x/n62VQOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(5023799004)(4143699003)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9MUlZmeDVucVptbFZuaklJTlVCRTFrcEhhd0dkTEZmVUtGSDltMnYvenpZ?=
 =?utf-8?B?WmJGRWU0cmdlcFBYeDRSeEJ3czI5Zis2Nlk0NjMwWEdjOEdiSUVPQ0s2UHhJ?=
 =?utf-8?B?VVJnN2dmOE05MkFSbTBhczdjQ2dJemFydEQ5NnFUblFIU1MxMWczU2dqTjF5?=
 =?utf-8?B?RFBBMzZQemwrdHdOOCsyd0xncTVOcnBWTCttZTdzbEVxQmlZUldQd05aT2x2?=
 =?utf-8?B?ZWFSUEo5QTVDbDRtVzM0YlZibkFZTUwzUWdHcVRjQkNwSFNmK29uNXJGNGtL?=
 =?utf-8?B?L3ZPKyt2UnJHa0JjWWVQZzJKakIvdlJ4bkJzRkloVnhlaG1FK0p6aDNBa3Zi?=
 =?utf-8?B?TzB6UDQvN3pkbHJpU3NmTUZPSmQ3Sk1WTWJuRWszek1jN2lib1lEaFpMbVJN?=
 =?utf-8?B?OTlSVUtOTnlraWwwOERXcERMMTJSVGhTVEhsblVKcHphSDJKTm5idnIzNElF?=
 =?utf-8?B?dGtnVDJTNUt2R21jRzBtZ1U2cENzR0ovcUNHQkRwTDBMaVdMQ25wWWdvWlVU?=
 =?utf-8?B?RXB2bTlielAxc3RlN0tYQUIveHA1ZzVTTStUL21ZelV0UjlhZ3lIYUd1Y0lo?=
 =?utf-8?B?K25Kd1g1V0VxVzlQS1dXUWt5VHBBdHZUR2hSc3VjaWk4RVpOaWJQb09hN3pm?=
 =?utf-8?B?d2RuM3FaUnlBZkFscnpJeXY4NEtNNUlEanROdkVKekp3WHhMWUF0RTdEc3lz?=
 =?utf-8?B?bVViOUhadEZIWkd3ZFBqakk1UjRXdVdNbWtHVGx1L3A4WnVMMEJqR1UwVVpK?=
 =?utf-8?B?VEpLTGs1Rnd2bWNwanZCQzd4SkoreEFPazdwZ3BoVjh6c0F3TTNFYjl0bTQ4?=
 =?utf-8?B?SXFKWTFGNm1xYXZiNktUOStjZnZNZUdjTEtQR0tKaUFtN3VJeE5ZMEMrSk12?=
 =?utf-8?B?QXluMnRjZzh2VVNxVjJ3c0twT0hzbG9KRUMyc2tudU91R0VBcmdrYXRueVp6?=
 =?utf-8?B?TllwZWVtaHBjUDB5cFJsZWluL24xbmV2NnRJN0NHZ0lVaENFTnQrcGZFdW5i?=
 =?utf-8?B?Sjhsc1dWeUo4ZG9Nek1hZjFuOVA3bitBZVFmQXFSMHFxMjUrTVVHcXpSTWxM?=
 =?utf-8?B?eU0wQUlaN2Q3cWh4QWlsMGZLRE1hVmNwUjJ0aWVoWDBOdXJsQlg3QlBsRXJH?=
 =?utf-8?B?bTZRZ0d1RjF2d2p2MDBmM1pFSDVUbThtUytYOStUMitKTm5DZjVDYW9BQlho?=
 =?utf-8?B?NWZnd3NlSFAzZmlMNUpteUg4THZPcFRicXA2RWM2MS9JWHNZZnV4MGdjSDdq?=
 =?utf-8?B?aHloTEN3dUxGeDRjQWpDaFVZcXg1eU13bDF2ZDlqWTlpQzY1T2UybmhPcEgy?=
 =?utf-8?B?WnRua0p1VkgxOU4yckJ5Zkd3RXhPL1hrNlg5Z2E1SWI2SnVKY0VtNGtHNXNO?=
 =?utf-8?B?eVZTZEJ1a1k5VHg0RWRnQmhmaTgzVXk2R1hOaytoM29Gb0thMUpBMXAvNTN5?=
 =?utf-8?B?a2xkTW9xOXdLKzdoSmorQkpZMFVUb3FTSCszNGpWL3hEOExTUDZmZmdrUDkw?=
 =?utf-8?B?cDFXYU82NzhTY3EyL1Jab1pxYkFuTDZya3p2dHkzWW8ralJFSGFoVHk1Q2x2?=
 =?utf-8?B?YWlLZ252MVkxRm13bFJkZ09sd1VOM2N0bW1Ya2pjOXNyNUhMcHBzZHZmMjVp?=
 =?utf-8?B?aWdpNENXdmlkeFVhTnJaQnJTM2NGNDRaRjMxRU5Wb1ZJbEUzRngxMU43NVh4?=
 =?utf-8?B?Y0g4cEFUdzFHY0FmRmtjZjNveEtLdWFxV01yOEFTcW9DN0dUZEprMkw2V0pN?=
 =?utf-8?B?NTg2SHRBRUlYMSt6dkJ3eGRpc2Rxb3k4VjhWK0U3VXJKOHFUa2F6V3VPMWVU?=
 =?utf-8?B?Y3Yxa3JvcjV0Tmg4WmxxL3loYWN5dWRPSEh1MzhDWk42eDRWaXZTUzZZWVZV?=
 =?utf-8?B?eklFV2JTcmQyY093WlJlUWNjT2RaVFZtUWl0NXl1cG5mTUpWTUVuN1hrTkx0?=
 =?utf-8?B?SFhpc3VueHBxbjBsTDZjYjczVGdCdlZkcVJFOGpXQXE1VVhKOTJISy9HOFIr?=
 =?utf-8?B?bHB5WWV5dm5sRGNnYnB3WTVvU29WZmlyZmpPYUJzc3orVEZEdlRoQkdiOUY4?=
 =?utf-8?B?OEpldU9PY05hbkdHQ0FMNUNvZGNyeXJ0dVBMekRLQWl5L2h4U2EvbjNsZGty?=
 =?utf-8?B?N3o0bUR2T3BMbzFGakZacWdFR1Qvcm5YOHd2MG5ueFN2czVJd2QwYkN5dm5M?=
 =?utf-8?B?T1IwZHlGV1gxcllaNkNnR2ZhRGg1SE1WWUdRL09vdGswbGl2N2ZIUFZqZURj?=
 =?utf-8?B?dXZvZk1xbkVock96VlAxOFJibFo0ck5KNEljOEY4RjR3c0JtNGFUU2E0bFFq?=
 =?utf-8?B?K3U0d0lLQ2VpcFBCL3hJR2IxMWhtUEh3eGNNMDd1bkZRNTFQeXl5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0271d332-86b9-4574-2a1d-08df29f13cdc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:46:59.6380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gy0ZIcatfdErPGv9HVRuYghP9dRvp+wK+6CLsNv2ukiicVWxHqYo5WzS4y+rCSnjKKqXxmy3GgEUp7OBPcuDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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

On 2026-10-14 03:17, Christian König wrote:
>
> On 10/14/26 04:21, Benjamin Cheng wrote:
>> On gem object close, we previously only attached the fence of its own
>> clear_freed() call to the BO's resv. If an unmap of this BO happened
>> prior to the close call, clear_freed() would be invoked, leaving
>> vm->freed empty, and no meaningful fence to be attached to the resv on
>> close. Because of that the memory may be freed before the TLB flush is
>> complete, and give a running userq potential access to a stale
>> address translation.
> Good catch.
>
>> Fix it by tracking the last TLB fence of each VM and attaching it to the
>> BO on close.
>>
>> Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 ++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 8dbd7bb77305..7484c52e5850 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -360,6 +360,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>  
>>  	amdgpu_vm_bo_del(adev, bo_va);
>>  	amdgpu_vm_bo_update_shared(bo);
>> +	if (!dma_fence_is_signaled(vm->last_tlb_flush_complete))
> Drop that extra check, it is actually harmfull.

I will drop it in the next revision, but could you explain why it's harmful? (Sorry, still somewhat new to dma_fence semantics).


>
> You also need to increase the amount of reserved fence slots.


amdgpu_bo_fence already does that.


>
>
>> +		amdgpu_bo_fence(bo, vm->last_tlb_flush_complete, true);
>>  	if (!amdgpu_vm_ready(vm))
>>  		goto out_unlock;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7d3659ef11e5..c5411933a76c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1097,6 +1097,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>  	if (!params->unlocked && vm->need_tlb_fence) {
>>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>  
>> +		dma_fence_put(vm->last_tlb_flush_complete);
>> +		vm->last_tlb_flush_complete = dma_fence_get(*fence);
> I already added that in another patch, looks like amd-staging-drm-next is not up to date.


I guess it's last_tlb_inv from "drm/amdgpu: fix TLB invalidation fence handling"? I'll rebase against that and use it if there are no other concerns.


>
> Let me double check that.
>
> Regards,
> Christian.
>
>> +
>>  		/* Makes sure no PD/PT is freed before the flush */
>>  		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>  				   DMA_RESV_USAGE_BOOKKEEP);
>> @@ -2648,6 +2651,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  	vm->last_update = dma_fence_get_stub();
>>  	vm->last_unlocked = dma_fence_get_stub();
>>  	vm->last_tlb_flush = dma_fence_get_stub();
>> +	vm->last_tlb_flush_complete = dma_fence_get_stub();
>>  	vm->generation = amdgpu_vm_generation(adev, NULL);
>>  
>>  	mutex_init(&vm->eviction_lock);
>> @@ -2693,6 +2697,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  	dma_fence_put(vm->last_update);
>>  	dma_fence_put(vm->last_tlb_flush);
>>  	dma_fence_put(vm->last_unlocked);
>> +	dma_fence_put(vm->last_tlb_flush_complete);
>>  	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>>  	amdgpu_vm_fini_entities(vm);
>>  
>> @@ -2839,6 +2844,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>  	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
>>  	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
>>  	dma_fence_put(vm->last_tlb_flush);
>> +	dma_fence_put(vm->last_tlb_flush_complete);
>>  
>>  	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>>  		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index ddcdc7256ef0..b9932c5e066f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -331,6 +331,7 @@ struct amdgpu_vm {
>>  	/* Last finished delayed update */
>>  	atomic64_t		tlb_seq;
>>  	struct dma_fence	*last_tlb_flush;
>> +	struct dma_fence	*last_tlb_flush_complete;
>>  	atomic64_t		kfd_last_flushed_seq;
>>  	uint64_t		tlb_fence_context;
>>  
