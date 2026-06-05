Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8B9CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 09:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AD710E5DF;
	Fri,  5 Jun 2026 09:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAXwdhj/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD6411A63C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 09:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVInmhO3UR3gWyfoJvi4qvHKQshEYTSjJGp8+1nhjg2uk2vNcUa6cSU9r9I29ss65iwj9MlYvPtLkUV6ETVK3SbVF9CJspVsvpRLPVdTPXbZ3oG3xNZa2EGSd3I9WC+CCUAI+op2NSXOdSWmnE5lnXjYHjvLYuxfDdID8ZIjyQs7vDy7GrC6Buydj+FgjQ0CmoELG3+/KT0VQIc4iYbmWsYfEpU6Yi9VKtfMlCY3hGGkRSnh40mvP6c+wypiBjiw9ttvSOHFtSvVBoZWOfrPMJjydXC81Y5vK7jhXNs1MYq+/eRL3q4pU/eNZS02sbJf+aZxlbed1zPzJOrLEcaGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQts4GjgUrEu4agMTj/6HN7cIi2ke/n0WEdUbP0d4nk=;
 b=aT2lgcAsB0Yncf0ueKlTHDet6haHi8xE7CdwChvi9ri50LuLqcPIq7VdwQ3eNi3sPA0p9ZXB1BYyIDoCM8eWhrKL/LQakrNU1N18Y4TA3WZu3bHEKEE2MNHDAP7C1/L317ouAVzuHbrX4j0FF4KMfgPOxdkjYV7oMcQg+/6n8YzOuc+uQHCUdHP6dcMFW2e5sxCRgec8wi6f7lZS5lbif9HU3xAwit19SdyGSxZ+cVhAT5S2dcG4U20uttqY+5dQ5IZ0NIz0OCVpPSBCtmQeZbkiC+vXRu3rl0m2ss9faIUFGZ2EoijJMvVt6gIANM7O61+M8JS88f8+YZnQyyTHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQts4GjgUrEu4agMTj/6HN7cIi2ke/n0WEdUbP0d4nk=;
 b=EAXwdhj/tGY+wkbeJsY+iN/6iQMQVGpSi9gUqYfR6yCpivYREjbRcEUMwxT1IQh1osc0AKPjNp8KGykE09JkqZ4Cc6PeLIFJWemrAA1neplH+GhwXjFbKmoJZITBLvkV4Fc7Nm1x34ANcRqsEZ4ZqfUH87MDPWSW65lsW11cLqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 09:21:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:21:27 +0000
Message-ID: <fcb12fbc-8629-4867-befa-17009d2e37a2@amd.com>
Date: Fri, 5 Jun 2026 11:21:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: "Kuehling, Felix" <felix.kuehling@amd.com>, natalie.vock@gmx.de,
 honghuan@amd.com, Alexander.Deucher@amd.com, Philip.Yang@amd.com,
 timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
 <4644fc6d-81cb-48d0-b899-a9a4ec4caf46@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4644fc6d-81cb-48d0-b899-a9a4ec4caf46@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:208:32a::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ed5b29-caa3-447e-a032-08dec2e3d1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|3023799007|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: OW+G63zCSPU0rZkbUNyaaJgX/N56rZrfPG1Jh2hult5g06Em6JKgQTmESS3Wn89/sm/3g4M/lo8kAr13zNmtrjyhY/8F7aAYPuPO6TIXKThx4ahoIUHaOZ0l8aXvAPJRROhs5AwUHkmvykv/jvccF9CClHa9BVdK0vkNZ8qXIKsi9mU7KUYdJetm6DDuiEqzAC+mtZdn9FbdU6aiweZTIJ2/KxgYupE35lf/EfHLtYXXq5pnKUOL52G0+RiHs+8FBmbYFhpXx87V3W8vuqlMbo8QfOONlAOYMBk/bQcgb625mteEnnHRoMvQL0TliSBTs6lxgNtcbGzHu3jkmZ4HD3HSzCJZSCwZPGXGGlfv53V3Au43CxbAAQ2U2NHKxeSN0IV7fXMdupTl0PgnY8qky1HKUzAu18iWJdkcyDV5Pe9Y3z7+Jc9iZrH1ZIxKYYcPtMnWXQVab9VjpbJBYlZBFwIjBaR6oRZSbwgz4FapPftsxyjlmcpHL6tRFxuxiToAXBfmBQYDGBsK8g/PIuND4UUGfHAk71cuQzVrzv8nb3j53peoSajoTYkQjztvLRxdTstZfWQ3IOfUbNzY0YyiglVscX7K1wnSRqLKKY2vq5FwGsPi6wo25fHIWGg7b7b+ZGqKRp0QDugYLhwwGIP++JYc112HaeIcqBnPmYKWsnJmV49egKtUxz4QvaWFmo/r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpWZGFzdkF1WkFoTDdSUG83N3o1SDl3ZW1OL0hCeVo2a2JZbXBTZlhWdmhE?=
 =?utf-8?B?dUVmdXpQR3RvT2tQYml5UDJTS2Z0NE5iQkYxazByYUlzQm01YUhxd3FYNWV2?=
 =?utf-8?B?V2R0MmN0YlhLRm9UZzdhOE4yNTZZd204SHltSFdkME9kQjdiQVRHaTM4UFh6?=
 =?utf-8?B?R2U2UGIrNHhkektLTGxGU25iYWNTQXJsZ01iT0R0MUQ2aU1STGVCdm1kemRM?=
 =?utf-8?B?U2pIYzE4aXB6RlpUeHA4MXczMzVRQUJhNTN5bVBrWTdlMlhuSmRpZmxycy9t?=
 =?utf-8?B?R05EYXFQZU1rdHBQY21WNXRUMDdWbnpVS3VVczJQNTlyUGJGcFhqbE03VENq?=
 =?utf-8?B?K2JaTTlaM3hsZkgvWlRSVzUvWExXSTFraitJS0Fic1VRbnM5WXFqdm1SSHhB?=
 =?utf-8?B?Tk1OY0xqTFhFMUdML2l6anM0MWV4UmRubXBQTU9kUitaMnQzOVFyU0NjdDBG?=
 =?utf-8?B?aGFXdDBDUjNmcjNRcFd4T2oxSk4rSml5NmlzOTZVRjNHK3hRZ0ZNWXhzcXJ1?=
 =?utf-8?B?QkpDWGVuR0xuYjdMVmRhOWhEcHJFZ3FlcE9MSVBKSkV3MFRVY3pTb0NVMjJE?=
 =?utf-8?B?dUhoU0NJcUR2c0RFNllJTVF2ZFlVQVllbEl2NUV1T0ZYRjZNUFNnZVZsZmdR?=
 =?utf-8?B?U2labUwyTGpCV0d4Wmovci9FdksxakFNN2VWVWRmWEN0b2w1cW8rWGFIMTYz?=
 =?utf-8?B?Sk9NVlQvS0tmZ1ltUGFndXNNVzQzVE5EQUlJajVwRGVTRlM3MUVFSFdENTBZ?=
 =?utf-8?B?Q3RxQ0V1MDlKdER1c1VNNDJtS3ZLTVZqTWcyZ2pWNFlpQ0c5a1JlQUlDYlVh?=
 =?utf-8?B?T25Maml6dlFnNFNQZk9nQ2xyVkFyb0o4Y0ZHZXcwb2xrZFhXM0RINlNKbWd6?=
 =?utf-8?B?SitDTHVsUGpaUVJLM3RuR2RWcHZUYlM0M2ptVlptNjFVREFlNjdyWUkzamNo?=
 =?utf-8?B?ZUdxOEoybytSWjRsMWhZSW1HdjhPeUZwaEw5SWlDOE5ucGVTTmRQQ1hxYnAw?=
 =?utf-8?B?eTI0R1FyUC9aU0oxMjg2QWZESi9NTWk4NE5wNHUrZmdrQ3hqcVNvYkt2UmM0?=
 =?utf-8?B?YlExOEFGOVE5SmYzbjdCbWY4MklxYmdyUDVhWmh6ZndDanJJdnROZE1oWllR?=
 =?utf-8?B?SHp5bjB3Zm8xYTJrOTJOTi9EL2xxL2dPbW11YTEwZFdqK0pWamZXajJ3a0JO?=
 =?utf-8?B?TjRYQlo5YW54KzNSWFZnUk4zdFRYcVJ3aUxzNTY0bHExcS9IYTBqWnhlRE9L?=
 =?utf-8?B?cTdQMUR3cFgwZGJmeGEzQ1VtUWRnS3ZwaFRWT0FKUFMvcXFMN1N6Qyt1Q0ll?=
 =?utf-8?B?czVELys3VkhMaXZxdThucFUvQlRqd0ZxeDdsckRpZ3JvNFdnMW9nVDVOMEJF?=
 =?utf-8?B?WlFzMGVlZmJmc1lmc0UrdFZrc1JITlRRUFZTMUlkdUdJM1g2aXJyakdQQ2Rw?=
 =?utf-8?B?S2Rtc3JSYUZHZ0E0bDJORHhrSWpFdmFLM0ZBWG9qWnkvM1FRYWc3U1J4Skl5?=
 =?utf-8?B?b3dvbnNBLzRJRGZucUd2dHY5WGMxNVcrZ0FpcHNldnBZbEdlci9aTHg5ZUp4?=
 =?utf-8?B?WmxXQXc4R0dadGF1NTlLNkhYRnZOZ0g3WWZTemlwL25XZUxrU1R5MHdCVjJU?=
 =?utf-8?B?NVRYMmNIVmxXcDZFdklJVGw4SHN2a1RQMmt2T3RPN2RwTVVQay92Y092d0Ew?=
 =?utf-8?B?R2l1SUs1cW84dmFyZjdrZS9IeU11cFdHKzdud3BEci95UzJZNktqK3JBbUJl?=
 =?utf-8?B?cXRXQ3ozOTZ4VlRuOFZaWUtDYlVSeGIwMUF0Zm5oSDg2SGJYQkJLM2VjMFBR?=
 =?utf-8?B?SXQ3eiszeXk4RlV4Z2Zid1B0akdMUzVZZ1R0dUpRQ01DSUZVUDVYa21rTFhv?=
 =?utf-8?B?RFRLT3lmVXZ1U1NvR0FQQldXYnZtUTlNMjA1OWhLOEF1eWZOM3pLM0RGUG1n?=
 =?utf-8?B?bUNqWUc3d0RWYUY2d2lMSHVuU1p4VFg4dnBYaXdzcFErMkxvNXJOWjJRcG5t?=
 =?utf-8?B?N1V6NUZ4VlEvRzdVOTdGdDhTSEdsVm9IREhrSHowaHpoM3hhdjZpcjRsbS9z?=
 =?utf-8?B?eE4xU1loR2JTLzN6NFZvNmw2aEdmRmx5ZnVKZWUxYXBBNzgxclBxK2Z1SVBw?=
 =?utf-8?B?Rk1NcjlZZDhuUDFQMFBQNFJ1eXZQbGFMOUEyMzlJN3kzZ1pLNTVzVkdSSnM5?=
 =?utf-8?B?WHk1WGRlNEVQNWRaY3EzR0hVTW5JWlppZHhJOXMrcTQ1TURLbTZiV3AzbnFB?=
 =?utf-8?B?UWcxY2NpQ3YwZTAxem52aDVOQmdVVzJIdDNXaWVJd0VxYW01S2FJK2pocnFa?=
 =?utf-8?Q?Xvj/uP63HuZsNvV3u2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ed5b29-caa3-447e-a032-08dec2e3d1db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:21:26.9238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqEoVkCnPLalj4GsB8Oc0bwt7mF8xlApGYLAx2+6zmlXn4p5o/wctbBt3WptEa7k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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

On 6/3/26 19:54, Kuehling, Felix wrote:
...
>> +    r = vm->update_funcs->prepare(&params, sync,
>> +                      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
>> +    if (r)
>> +        goto error_free;
>> +
>> +    amdgpu_vm_update_leaves(&params, start, last, 0, flags);
>> +
>> +    r = vm->update_funcs->commit(&params, fence);
>> +    if (r)
>> +        goto error_free;
> 
> So this wraps amdgpu_vm_update_leaves with all the stuff that's necessary to actually execute the page table update.

Yes, exactly that.

> I don't understand how amdgpu_vm_update_leaves works without this when you call it directly from amdgpu_vm_handle_fault (in patch 6).

It does mostly the same, but not 100%.

> Shouldn't you use amdgpu_vm_unmap_range there instead?

No, the main difference is that calling amdgpu_vm_update_leaves() from the fault handler needs to bypass the normal sequencial handling of VM updates.

Background is that this is a band aid for a dma_fence based submission to avoid a full GPU lockup and instead just continue even when the rendering is incorrect.

> And if that's true, then maybe you can use the name amdgpu_vm_update_leaves for this instead.

I'm certainly open for better naming.

Maybe we should call the function in amdgpu_vm_pt.c amdgpu_vm_pt_update_leaves() and the higher level function in amdgpu_vm.c just amdgpu_vm_update_leaves() ?

Thanks for the review,
Christian.


> 
> Regards,
>   Felix
> 
> 
>> +
>> +    amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>> +    amdgpu_vm_pt_free_list(adev, &params);
>> +    tlb_cb = NULL;
>> +
>> +error_free:
>> +    kfree(tlb_cb);
>> +    amdgpu_vm_eviction_unlock(vm);
>> +    drm_dev_exit(idx);
>> +    return r;
>> +}
>> +
>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>                 struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>   {
>> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>             trace_amdgpu_vm_bo_update(mapping);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
>> -                       !uncached, &sync, mapping->start,
>> -                       mapping->last, update_flags,
>> -                       mapping->offset, vram_base, mem,
>> -                       pages_addr, last_update);
>> +        r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
>> +                    mapping->start, mapping->last,
>> +                    update_flags, mapping->offset,
>> +                    vram_base, mem, pages_addr,
>> +                    last_update);
>>           if (r)
>>               goto error_free;
>>       }
>> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>               struct amdgpu_bo_va_mapping, list);
>>           list_del(&mapping->list);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, true, false,
>> -                       &sync, mapping->start, mapping->last,
>> -                       0, 0, 0, NULL, NULL, &f);
>> +        r = amdgpu_vm_map_range(adev, vm, true, false,
>> +                    &sync, mapping->start, mapping->last,
>> +                    0, 0, 0, NULL, NULL, &f);
>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>           if (r) {
>>               dma_fence_put(f);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 3e86a2a470f0..561f2873d2ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>>                   uint32_t xcc_mask);
>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> -               bool unlocked, bool flush_tlb, bool allow_override,
>> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +            bool flush_tlb, bool allow_override,
>> +            struct amdgpu_sync *sync, uint64_t start,
>> +            uint64_t last, uint64_t flags, uint64_t offset,
>> +            uint64_t vram_base, struct ttm_resource *res,
>> +            dma_addr_t *pages_addr, struct dma_fence **fence);
>> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                  struct amdgpu_sync *sync, uint64_t start,
>> -               uint64_t last, uint64_t flags, uint64_t offset,
>> -               uint64_t vram_base, struct ttm_resource *res,
>> -               dma_addr_t *pages_addr, struct dma_fence **fence);
>> +               uint64_t last, uint64_t flags,
>> +               struct dma_fence **fence);
>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>               struct amdgpu_bo_va *bo_va,
>>               bool clear);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 6f5415d5a1bc..ac3f3e31e2e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>                   struct amdgpu_vm_update_params *params)
>>   {
>>       struct amdgpu_vm_bo_base *entry, *next;
>> -    bool unlocked = params->unlocked;
>>         if (list_empty(&params->tlb_flush_waitlist))
>>           return;
>> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>       /*
>>        * unlocked unmap clear page table leaves, warning to free the page entry.
>>        */
>> -    WARN_ON(unlocked);
>> +    WARN_ON(params->unlocked);
>>         list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>>           amdgpu_vm_pt_free(entry);
>> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>           uint64_t incr, entry_end, pe_start;
>>           struct amdgpu_bo *pt;
>>   -        if (!params->unlocked) {
>> -            /* make sure that the page tables covering the
>> -             * address range are actually allocated
>> -             */
>> -            r = amdgpu_vm_pt_alloc(params->adev, params->vm,
>> -                           &cursor);
>> -            if (r)
>> -                return r;
>> -        }
>> +        /* make sure that the page tables covering the
>> +         * address range are actually allocated
>> +         */
>> +        r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
>> +        if (r)
>> +            return r;
>>             shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>>           parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
>> -        if (params->unlocked) {
>> -            /* Unlocked updates are only allowed on the leaves */
>> -            if (amdgpu_vm_pt_descendant(adev, &cursor))
>> -                continue;
>> -        } else if (adev->asic_type < CHIP_VEGA10 &&
>> -               (flags & AMDGPU_PTE_VALID)) {
>> +        if (adev->asic_type < CHIP_VEGA10 &&
>> +            (flags & AMDGPU_PTE_VALID)) {
>>               /* No huge page support before GMC v9 */
>>               if (cursor.level != AMDGPU_VM_PTB) {
>>                   if (!amdgpu_vm_pt_descendant(adev, &cursor))
>> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>           mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>>           pe_start = ((cursor.pfn >> shift) & mask) * 8;
>>   -        if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
>> -            /*
>> -             * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
>> -             * only clear one entry. Next entry search again for PDE or PTE leave.
>> -             */
>> -            entry_end = 1ULL << shift;
>> -        else
>> -            entry_end = ((uint64_t)mask + 1) << shift;
>> +        entry_end = ((uint64_t)mask + 1) << shift;
>>           entry_end += cursor.pfn & ~(entry_end - 1);
>>           entry_end = min(entry_end, end);
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 37b5166e9a14..d0ea20dea3e1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>           return -EINVAL;
>>       }
>>   -    return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
>> -                      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>> -                      fence);
>> +    return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
>> +                     init_pte_value, fence);
>>   }
>>     static int
>> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>                pte_flags);
>>   -        r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
>> -                       NULL, gpu_start, gpu_end,
>> -                       pte_flags,
>> -                       (last_start - prange->start) << PAGE_SHIFT,
>> -                       bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>> -                       NULL, dma_addr, &vm->last_update);
>> +        r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
>> +                    gpu_start, gpu_end, pte_flags,
>> +                    (last_start - prange->start) << PAGE_SHIFT,
>> +                    bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>> +                    NULL, dma_addr, &vm->last_update);
>>             for (j = last_start - prange->start; j <= i; j++)
>>               dma_addr[j] |= last_domain;

