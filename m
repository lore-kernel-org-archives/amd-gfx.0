Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C45FCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 13:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AE810E17A;
	Wed, 14 Oct 2026 13:09:37 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD6610E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 13:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuUH79PbC2ZAiIfQQ4TwBoIV03AUz7s0XdqunNMDGUxsbTvtKE8S2d5hsV/RYK3VpiaCRT9PMJu268DfRpdKuYFUJ38uk9gOVgCK5JdceoNVb9xyTftMKuAppegkXFX/voHIrve8DM+SehI7p+TZdEIu9qzh07ne+1G7pGJaV+tCkO0kmhLG3vjJrkoR9OFjrU2DvW8baZp0XKR+yCShV5E6OYp4j0Ql4uScVcpy0qnvkmjAusrglFi5DTEf2G4WACNqlv/ZkNF61VKt3tq/fAdie8/N60ArazQo2Km5b1VnEiuYGqEBZCa7yLZZPdxAn/gfP6Y/9DamYC3TgGWQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=784cfUZD4v/jUgdAZ+wFIIzH5cdQlk19/eN/cvyUK4I=;
 b=GrSKDNeHvLXnQSTF0fr3jxY7Qtjx30gFY77f3+0sauUJeh566hbrAHbwxi71WMFUBjJ3on7C4nyUCFhBSYVM3vJP/7Bij9Ob0n+7k5hEdKZKhut9oF2bdMYzis88iyNU6dxbSrlHpiLZ/bFh8fx3co7Q96pcxqb64sHWf0igpvZlVce8cQLWNK89nb5sDMmdli0zmSCppY4nFO5P5Q1EGLb4k9IGdcIDmm6WAGjbdHIV2DifdgYH96h2dzkW/+kChAVwvQ5gJKw1Zr6li1ovLqepMv2tW9DkExABRwp9rQZJ3P2yQuAPbFqWzrVQ39zPgxTVjgh3xZmNIvLcwPLa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=784cfUZD4v/jUgdAZ+wFIIzH5cdQlk19/eN/cvyUK4I=;
 b=hS8d94wFBHb2MVRkNoxOxXRNbnA9nzJ3uPnpPUnU7h+QbO/+lsZ2HryKbahYRA2T11VkSygI3G6vxobe2+0Gv+jtOhdQDWJiX5CJeIXEWkyGFVX6/m4o1R2kvbCH0WiUqXpph1DcU8bTmF3kYy8Zk1IcIr+qFe3axAjQ+KdK0RM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9696.namprd12.prod.outlook.com (2603:10b6:610:2b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 13:09:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 13:09:25 +0000
Message-ID: <10756114-2103-4f5e-a49b-484f4c0a516e@amd.com>
Date: Wed, 14 Oct 2026 15:09:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: wait for tlb flush before freeing BO
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <857c0091-681a-4f09-b875-50f3a4c4b91c@amd.com>
 <40949c1b-35e3-412c-9e0a-fc50e95f16e8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <40949c1b-35e3-412c-9e0a-fc50e95f16e8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2b6723-0909-468e-c2ec-08df29f45ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|5023799004|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: KsaXy7brKGO/c1ZbRGzqID14fJGbPamEUS6PTPrjhZ1pgBupUnJTs8YtQ5MLzvyd1Y3ctayci+bk2GW4jt9jV5fCjjrd6mDOSR11GphRmLBxhDbv0l4iB2vZFk37TNUGN5dTN+XkxU+KUNEHSfzd5W7wnnV3JAO5aFooy93Z5F3zDydHtQjC+0rlOoxyE9KNXOrMKlBa4bqiG7KSdMkoA//qgVcepOSm/knafm06Xae4iKYcivxtg/2F01bQJymFIfCxuGq7OjQscNquZ6KbEGhPKb0ttLlg3eEve0d9MuhAROwKFrm5FSbBE1EZ8bggQN6ET9SfBcWx9OIaS99EfDVJ1/3zfonqlZod8xfP/F1dbIG+PElMXh+nwrOPCVKL7oq6pjsA70kl79wkZp/F+/1aFDO84sGU9RC2AZbNOcYCpX/s+tdDSt5SJNsJlJpwCPDQet63AE+hm7svPIwfUyxCoSRENaG4bbH1eeaI5LwYKD/Gn2/zu6GHC8gt6c7tK539IAwAsWdtAFw2/5dQyKpog/Tmn/UM+ddHJP2LMaZCafDwTJ+WYDD4NFyJKCV/61QekGTOBe0d5vI3zTo4lq9oDgJkT6M3slaGURAfeBbh0Ww4BwBZq/RUggFIdZ9HR5F15IqcQf0TtjEr2JaDIzeA3WVft90X19CQ0ZHI2l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFFdThFVDNDaDgxRFd3a1J6UGZoSTlTZzV4aHhLY0NXUmtlQVlUQk5lNStt?=
 =?utf-8?B?dTFGaVU1N3JBVDVsVUJYMVJKUE5Kbk1nZUZQMEVYajdiV2hwREJ4OVE2YzJn?=
 =?utf-8?B?SGNySlBqNXdQVUxqZHJmZ3pPSEZaeHpSa0crazB2MWV0b0JCb0ZIQXpFTysz?=
 =?utf-8?B?M1dWYXY2VGdyRmVyQVp5Nk51UnJyZi9oR1FybzlidkV0TFRoRkhRK083Rnly?=
 =?utf-8?B?cGJqZXczWEFEakUvSWJwMWY1MmRMRDJObGwyTmVRbE11QkFiZmxDSXZPN05L?=
 =?utf-8?B?WjlwQ2Q4TTVOa25LdlB6bmpqZHE2MnE0a2NjRE9JZzI5ZzV1YW5NeEVSSXFB?=
 =?utf-8?B?T0hTSjI3alQ1NmxTQWg1aWFBanBPSVZ0NWFuWTRXNXE5a1Rhc2NHZ0VDWFpD?=
 =?utf-8?B?a2IxSzVXOTFrSTdSTVYrcXRyU2F6WC96Yk0rSVlHU3hReHFqNFdTMUFnVlo1?=
 =?utf-8?B?bWdrWmxaZkErKzdraFRuWkZCMUxaelU0djJDajRSRkVua3V4V2tpQWMxTkpp?=
 =?utf-8?B?V0hjMmthdDJTTjVGZ3MxMUhHQkdsYWRiM1FKcWxjam5LTk52MER1MEVZK1k5?=
 =?utf-8?B?OWNwanZlTjczS1MzSHN6T3VaRDFSamIyZVNSY080bmlrTE81Yll4UEF4akQv?=
 =?utf-8?B?RkRuc1d2TTl6ZGx6cFY2YkJ6MFVNY1B4ZGRZY2JyRm51azMyam1aTkNQT0Nm?=
 =?utf-8?B?Y0ZOUGlaaDgyRDFNZU83Nk4wQ1NDb25TOW42U25pWEp4azNWbmpkUENFTmdL?=
 =?utf-8?B?cTJUM0J5SHhWSGxpKzJMVkNqekhMUi8wU3F0aVpNRkoydzQwUFpEUUF3RUQ4?=
 =?utf-8?B?aDVOMlpwVUhhS1pERXNhSHNoYklnaEFEbHg0YndCYVFObC9IUlRjNldBckxZ?=
 =?utf-8?B?SWRyQ3Z6Qk0rN1lhenhlaTZ2Y3VzWTl3MnVOTHBMUWR4UjZjUXNaZ0JlaVpy?=
 =?utf-8?B?OTFrR3VaMVBtTXVCV1lUWUFOMEROYVd5VkdtQ0trWlpuRnpvMnY5bzVTaTJH?=
 =?utf-8?B?MTdrNUQvcmFYRll6dmNQZFhoaTZuS1VMQWN2UzBWV24rUnBHTWtheHMvcUVX?=
 =?utf-8?B?U2JYWmlOQ3EwK0IyWGRaaEJKb1NYeEErazd2ODhiTlI2aE13Tm1qODJsOVU5?=
 =?utf-8?B?NzFCeG1mTjN4SDN4NXBmM1BFNnptdXhOOUlNYXc4ZWh4dEwzZ0IyR0xVT1Nz?=
 =?utf-8?B?dXErZjBiS1FocTV6TENhZHMrRENtUW9ZU2htZEdsL0V5ekREY0MzRXZaSnp3?=
 =?utf-8?B?TFRBcDFWT0V2aUVVN0pFalUzUU14OFcySjdyYlRpZTBYMHh1QVg3UGhja3lr?=
 =?utf-8?B?WVh5R1ZESnphbjZwVVJRSEljUXRBa0dybGhQWmlhREFJaGtRaUNYS2hGYUpp?=
 =?utf-8?B?TjhsM3ppbnZCOXVjaTYyb242TEMxMWVDQ3R1eTFFZVlhcXlTUUNPTHdLRDA3?=
 =?utf-8?B?V2t2cTFUYWVwK1V0OU1QSzBVRThpSG4wWEh0R25SVzdaSG85K245Yk1CVnAw?=
 =?utf-8?B?TzJDK2hkbHEyUkZjYWlNblBWZU9mUkMzTDZEejJ5b1NUeFEyU0tqMFFITk1B?=
 =?utf-8?B?NkhldmJ1dVIvbWo3Tjd6VmpLd2lrSDk2Q3lQdERMRmdSWnIvOU9ITnZVY3RD?=
 =?utf-8?B?MzJlakRwQlhmSDR5dUEvNUxwME5uc1B3Rmx4cGR2cHUwWWhUSlhyME5ZdEtt?=
 =?utf-8?B?dkZrUkkyaVNTRmRiVkRjTUVabmFia2ZzVlVYVUR4ZGVxbWxDaXdWMG9jRjhR?=
 =?utf-8?B?Z21WMitqZnJaaGh4UGg4Y3pBc2NIQ1lZWmpoWXNvd09YYUhCdHBJNy9vdVkr?=
 =?utf-8?B?Sy9UTWNaMjlwYld0Ync0aFMxNjNpR1BXRE1Rb1Jtay9NNHJRalRPSSt1L3Mx?=
 =?utf-8?B?ZXBvVmpsYkdEM1pPZHdrZTMrdXYxNloybmg4WUo0U3MrVjJyMU1aU3F2Y3cz?=
 =?utf-8?B?Vm5zUndHZzhHTzNxcmtldjhObDhWdlJDZDNteWRZelR3Z3lLNUpYRldNTi80?=
 =?utf-8?B?YXpIbjBuQUMvK2lkZUdVbWFrekYvdHExaTJiZmd3MjBMeldwWEpncGVPa3Bx?=
 =?utf-8?B?WGd6MTQrcDZSeUxsendJOU92T1liZjhBVE1MM2EzSW94Uk9ZNk0vemFZeXVG?=
 =?utf-8?B?OFRFSHZKUlpZQ0FLcWxWaDZKajMxWlhCc2Z0VnU1clhUc0FPenVZUGlDVi80?=
 =?utf-8?B?VEVpRkl1TUVpdS9TYU1TWHpvZldkZUNhQmsva1ZBRkE0bXJqM0FHNGJCT2NE?=
 =?utf-8?B?M29DTk9DT0dnTVA5Wm9yNlA5SVptMUxySTdTOXEzR29IYlYyQWVKcUNzZUtm?=
 =?utf-8?Q?wK1WebKGkgkNbRorKc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2b6723-0909-468e-c2ec-08df29f45ee1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:09:25.2158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZb0DcYUIrj4RbRpT/h4adM8LPIsiUMmRpycYVqI4IV8kA+3e5npVRex4AHjWVkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9696
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

On 10/14/26 14:46, Benjamin Cheng wrote:
> On 2026-10-14 03:17, Christian König wrote:
>>
>> On 10/14/26 04:21, Benjamin Cheng wrote:
>>> On gem object close, we previously only attached the fence of its own
>>> clear_freed() call to the BO's resv. If an unmap of this BO happened
>>> prior to the close call, clear_freed() would be invoked, leaving
>>> vm->freed empty, and no meaningful fence to be attached to the resv on
>>> close. Because of that the memory may be freed before the TLB flush is
>>> complete, and give a running userq potential access to a stale
>>> address translation.
>> Good catch.
>>
>>> Fix it by tracking the last TLB fence of each VM and attaching it to the
>>> BO on close.
>>>
>>> Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
>>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>>>  3 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8dbd7bb77305..7484c52e5850 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -360,6 +360,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>>  
>>>  	amdgpu_vm_bo_del(adev, bo_va);
>>>  	amdgpu_vm_bo_update_shared(bo);
>>> +	if (!dma_fence_is_signaled(vm->last_tlb_flush_complete))
>> Drop that extra check, it is actually harmfull.
> 
> I will drop it in the next revision, but could you explain why it's harmful? (Sorry, still somewhat new to dma_fence semantics).

The dma_resv_add_fence() function can handle signaled fences perfectly fine, but when you skip that the code path is only exercised in rare cases.

>>
>> You also need to increase the amount of reserved fence slots.

AH, good point! Yeah don't do that.

The fence slots you need must be pre-allocated by drm_exec, amdgpu_bo_fence() is just an ancient wrapper we should probably remove.

Regards,
Christian.

> 
> 
> amdgpu_bo_fence already does that.
> 
> 
>>
>>
>>> +		amdgpu_bo_fence(bo, vm->last_tlb_flush_complete, true);
>>>  	if (!amdgpu_vm_ready(vm))
>>>  		goto out_unlock;
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 7d3659ef11e5..c5411933a76c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1097,6 +1097,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>>  	if (!params->unlocked && vm->need_tlb_fence) {
>>>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>>  
>>> +		dma_fence_put(vm->last_tlb_flush_complete);
>>> +		vm->last_tlb_flush_complete = dma_fence_get(*fence);
>> I already added that in another patch, looks like amd-staging-drm-next is not up to date.
> 
> 
> I guess it's last_tlb_inv from "drm/amdgpu: fix TLB invalidation fence handling"? I'll rebase against that and use it if there are no other concerns.
> 
> 
>>
>> Let me double check that.
>>
>> Regards,
>> Christian.
>>
>>> +
>>>  		/* Makes sure no PD/PT is freed before the flush */
>>>  		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>>  				   DMA_RESV_USAGE_BOOKKEEP);
>>> @@ -2648,6 +2651,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  	vm->last_update = dma_fence_get_stub();
>>>  	vm->last_unlocked = dma_fence_get_stub();
>>>  	vm->last_tlb_flush = dma_fence_get_stub();
>>> +	vm->last_tlb_flush_complete = dma_fence_get_stub();
>>>  	vm->generation = amdgpu_vm_generation(adev, NULL);
>>>  
>>>  	mutex_init(&vm->eviction_lock);
>>> @@ -2693,6 +2697,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  	dma_fence_put(vm->last_update);
>>>  	dma_fence_put(vm->last_tlb_flush);
>>>  	dma_fence_put(vm->last_unlocked);
>>> +	dma_fence_put(vm->last_tlb_flush_complete);
>>>  	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>>>  	amdgpu_vm_fini_entities(vm);
>>>  
>>> @@ -2839,6 +2844,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>  	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
>>>  	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
>>>  	dma_fence_put(vm->last_tlb_flush);
>>> +	dma_fence_put(vm->last_tlb_flush_complete);
>>>  
>>>  	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>>>  		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index ddcdc7256ef0..b9932c5e066f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -331,6 +331,7 @@ struct amdgpu_vm {
>>>  	/* Last finished delayed update */
>>>  	atomic64_t		tlb_seq;
>>>  	struct dma_fence	*last_tlb_flush;
>>> +	struct dma_fence	*last_tlb_flush_complete;
>>>  	atomic64_t		kfd_last_flushed_seq;
>>>  	uint64_t		tlb_fence_context;
>>>  

